package controller;

import dao.FeedbackDAO;
import dao.NotificationDAO;
import dao.ServiceDAO;
import dao.PartDAO;
import dao.UserDAO;
import entity.Feedback;
import entity.Notification;
import entity.NotificationSetting;
import entity.Service;
import entity.Part;
import entity.User;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;
import java.util.Vector;
import java.util.ArrayList;
import java.util.regex.Pattern;
import util.SendMailService;

@WebServlet(name = "ServiceServlet_JSP", urlPatterns = {"/ServiceServlet_JSP"})
@MultipartConfig
public class ServiceServlet_JSP extends HttpServlet {

    private static final Pattern VALID_DESC_PATTERN = Pattern.compile("^[\\p{L}0-9 ]+$");

    // Phân quyền: KHÔNG phân biệt hoa thường!
    private boolean isAdmin(String role) {
        return role != null && "admin".equalsIgnoreCase(role);
    }

    private boolean isManager(String role) {
        return role != null && "manager".equalsIgnoreCase(role);
    }

    private boolean isMarketing(String role) {
        return role != null && "marketing".equalsIgnoreCase(role);
    }

    // Thêm, sửa: admin, manager, marketing được
    private boolean canAdd(String role) {
        return isAdmin(role) || isManager(role) || isMarketing(role);
    }

    private boolean canEdit(String role) {
        return isAdmin(role) || isManager(role) || isMarketing(role);
    }

    // Xóa: chỉ admin, manager
    private boolean canDelete(String role) {
        return isAdmin(role) || isManager(role);
    }

    private boolean isValidName(String name) {
        return name != null && name.trim().length() >= 3 && name.trim().length() < 30;
    }

    private boolean isValidDescription(String desc) {
        return desc != null
                && desc.trim().length() >= 3
                && desc.trim().length() < 30
                && VALID_DESC_PATTERN.matcher(desc.trim()).matches();
    }

    private boolean isValidPrice(String priceStr) {
        try {
            double price = Double.parseDouble(priceStr);
            return price > 0 && price < 1_000_000_000 && price == Math.floor(price);
        } catch (NumberFormatException ex) {
            return false;
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ServiceDAO dao = new ServiceDAO();
        PartDAO partDAO = new PartDAO();
        String service = request.getParameter("service");
        if (service == null) {
            service = "listService";
        }

        // Lấy user từ session (user có thể null với previewService)
        User currentUser = (User) request.getSession().getAttribute("user");
        String role = currentUser != null ? currentUser.getUserRole() : null;
//NOTIFICATION
        UserDAO userDAO = new UserDAO();
        NotificationDAO notificationDAO = new NotificationDAO();
//NOTIFICATION
        try {
            switch (service) {
                case "deleteService": {
                    if (!canDelete(role)) {
                        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xóa dịch vụ.");
                        return;
                    }
                    int seid = Integer.parseInt(request.getParameter("id"));
                    dao.deleteService(seid);

                    //NOTIFICATION DELETE
                    String message = "Dịch vụ id = " + seid + " vừa bị xóa khỏi hệ thống";

                    List<User> users = userDAO.getAllUser();
                    for (int i = 0; i < users.size(); i++) {
                        if (users.get(i).getUserRole().equals("manager")) {
                            NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                            if (notiSetting.isEmail() && notiSetting.isService()) {
                                SendMailService.sendNotification(users.get(i).getEmail(), message);
                            }
                            int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Service");
                        }
                    }
                    ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(currentUser.getId());
                    NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(currentUser.getId());
                    if (!notiSetting.isProfile()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Profile")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isOrderChange()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Order Change")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isAttendance()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Attendance")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isService()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Service")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isInsurance()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Insurance")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    request.getSession().setAttribute("notification", notifications);
                    request.getSession().setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION

                    response.sendRedirect("ServiceServlet_JSP?service=listService");
                    break;
                }
                case "updateService": {
                    if (!canEdit(role)) {
                        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền sửa dịch vụ.");
                        return;
                    }
                    String submit = request.getParameter("submit");
                    List<Part> allParts = partDAO.getAllParts();
                    if (submit == null) {
                        int id = Integer.parseInt(request.getParameter("id"));
                        Service ser = dao.getServiceDetail(id);
                        List<Integer> selectedPartIds = dao.getPartIdsByServiceId(id);
                        request.setAttribute("service", ser);
                        request.setAttribute("allParts", allParts);
                        request.setAttribute("selectedPartIds", selectedPartIds);
                        request.setAttribute("role", role);
                        request.getRequestDispatcher("jsp/UpdateService.jsp").forward(request, response);
                    } else {
                        int id = Integer.parseInt(request.getParameter("id"));
                        String name = request.getParameter("name");
                        String description = request.getParameter("description");
                        String priceStr = request.getParameter("price");
                        String oldImg = request.getParameter("imgOld");

                        if (priceStr != null) {
                            priceStr = priceStr.replace(",", ".").trim();
                        }

                        String errorMsg = null;
                        if (!isValidName(name)) {
                            errorMsg = "Tên dịch vụ phải từ 3 đến 29 ký tự!";
                        } else if (!isValidDescription(description)) {
                            errorMsg = "Mô tả phải từ 3 đến 29 ký tự và không chứa ký tự đặc biệt!";
                        } else if (!isValidPrice(priceStr)) {
                            errorMsg = "Giá dịch vụ phải là số nguyên dương nhỏ hơn 1.000.000.000!";
                        }
                        if (errorMsg != null) {
                            double price;
                            try {
                                price = Double.parseDouble(priceStr);
                            } catch (Exception ex) {
                                Service oldService = dao.getServiceDetail(id);
                                price = oldService.getPrice();
                            }
                            Service ser = new Service(id, name, description, price, oldImg);
                            List<Integer> selectedPartIds = dao.getPartIdsByServiceId(id);
                            request.setAttribute("error", errorMsg);
                            request.setAttribute("service", ser);
                            request.setAttribute("allParts", allParts);
                            request.setAttribute("selectedPartIds", selectedPartIds);
                            request.setAttribute("role", role);
                            request.getRequestDispatcher("jsp/UpdateService.jsp").forward(request, response);
                            return;
                        }

                        double price = Double.parseDouble(priceStr);

                        jakarta.servlet.http.Part filePart = request.getPart("img");
                        String imgPath = oldImg;
                        if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                            String uploadDir = getServletContext().getRealPath("/img");
                            File uploadDirFile = new File(uploadDir);
                            if (!uploadDirFile.exists()) {
                                uploadDirFile.mkdirs();
                            }
                            String filePath = uploadDir + File.separator + fileName;
                            filePart.write(filePath);
                            imgPath = fileName;
                        }

                        Service se = new Service(id, name, description, price, imgPath);
                        dao.updateService(se);

                        String[] partIdsParam = request.getParameterValues("partIds");
                        List<Integer> partIds = new ArrayList<>();
                        if (partIdsParam != null) {
                            for (String pid : partIdsParam) {
                                partIds.add(Integer.parseInt(pid));
                            }
                        }
                        dao.updatePartsForService(id, partIds);

                        //NOTIFICATION UPDATE
                        String message = "Dịch vụ " + name + " vừa được cập nhật";

                        List<User> users = userDAO.getAllUser();
                        for (int i = 0; i < users.size(); i++) {
                            if (users.get(i).getUserRole().equals("manager")) {
                                NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                                if (notiSetting.isEmail() && notiSetting.isService()) {
                                    SendMailService.sendNotification(users.get(i).getEmail(), message);
                                }
                                int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Service");
                            }
                        }
                        ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(currentUser.getId());
                        NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(currentUser.getId());
                        if (!notiSetting.isProfile()) {
                            for (int i = notifications.size() - 1; i >= 0; i--) {
                                if (notifications.get(i).getType().equals("Profile")) {
                                    notifications.remove(i);
                                }
                            }
                        }

                        if (!notiSetting.isOrderChange()) {
                            for (int i = notifications.size() - 1; i >= 0; i--) {
                                if (notifications.get(i).getType().equals("Order Change")) {
                                    notifications.remove(i);
                                }
                            }
                        }

                        if (!notiSetting.isAttendance()) {
                            for (int i = notifications.size() - 1; i >= 0; i--) {
                                if (notifications.get(i).getType().equals("Attendance")) {
                                    notifications.remove(i);
                                }
                            }
                        }

                        if (!notiSetting.isService()) {
                            for (int i = notifications.size() - 1; i >= 0; i--) {
                                if (notifications.get(i).getType().equals("Service")) {
                                    notifications.remove(i);
                                }
                            }
                        }

                        if (!notiSetting.isInsurance()) {
                            for (int i = notifications.size() - 1; i >= 0; i--) {
                                if (notifications.get(i).getType().equals("Insurance")) {
                                    notifications.remove(i);
                                }
                            }
                        }

                        request.getSession().setAttribute("notification", notifications);
                        request.getSession().setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION

                        response.sendRedirect("ServiceServlet_JSP?service=listService");
                    }
                    break;
                }
                case "addService": {
                    if (!canAdd(role)) {
                        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thêm dịch vụ.");
                        return;
                    }
                    String submit = request.getParameter("submit");
                    List<Part> allParts = partDAO.getAllParts();
                    if (submit == null) {
                        request.setAttribute("allParts", allParts);
                        request.setAttribute("role", role);
                        request.getRequestDispatcher("jsp/InsertService.jsp").forward(request, response);
                    } else {
                        String name = request.getParameter("name");
                        String description = request.getParameter("description");
                        String priceStr = request.getParameter("price");
                        if (priceStr != null) {
                            priceStr = priceStr.replace(",", ".").trim();
                        }

                        String errorMsg = null;
                        if (!isValidName(name)) {
                            errorMsg = "Tên dịch vụ phải từ 3 đến 29 ký tự!";
                        } else if (!isValidDescription(description)) {
                            errorMsg = "Mô tả phải từ 3 đến 29 ký tự và không chứa ký tự đặc biệt!";
                        } else if (!isValidPrice(priceStr)) {
                            errorMsg = "Giá dịch vụ phải là số nguyên dương nhỏ hơn 1.000.000.000!";
                        } else if (dao.getServiceByName(name) != null) {
                            errorMsg = "Tên dịch vụ đã tồn tại, vui lòng chọn tên khác!";
                        }
                        if (errorMsg != null) {
                            double price;
                            try {
                                price = Double.parseDouble(priceStr);
                            } catch (Exception ex) {
                                price = 0;
                            }
                            Service ser = new Service(0, name, description, price, "");
                            request.setAttribute("error", errorMsg);
                            request.setAttribute("service", ser);
                            request.setAttribute("allParts", allParts);
                            request.setAttribute("role", role);
                            request.getRequestDispatcher("jsp/InsertService.jsp").forward(request, response);
                            return;
                        }

                        double price = Double.parseDouble(priceStr);

                        jakarta.servlet.http.Part filePart = request.getPart("img");
                        String imgPath = "";
                        if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                            String uploadDir = getServletContext().getRealPath("/img");
                            File uploadDirFile = new File(uploadDir);
                            if (!uploadDirFile.exists()) {
                                uploadDirFile.mkdirs();
                            }
                            String filePath = uploadDir + File.separator + fileName;
                            filePart.write(filePath);
                            imgPath = fileName;
                        }

                        Service se = new Service(0, name, description, price, imgPath);
                        int newServiceId = dao.insertServiceAndReturnId(se);

                        String[] partIdsParam = request.getParameterValues("partIds");
                        List<Integer> partIds = new ArrayList<>();
                        if (partIdsParam != null) {
                            for (String pid : partIdsParam) {
                                partIds.add(Integer.parseInt(pid));
                            }
                        }
                        dao.insertPartsForService(newServiceId, partIds);

                        //NOTIFICATION ADD
                        String message = "Dịch vụ " + name + " vừa được thêm vào hệ thống";

                        List<User> users = userDAO.getAllUser();
                        for (int i = 0; i < users.size(); i++) {
                            if (users.get(i).getUserRole().equals("manager")) {
                                NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                                if (notiSetting.isEmail() && notiSetting.isService()) {
                                    SendMailService.sendNotification(users.get(i).getEmail(), message);
                                }
                                int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Service");
                            }
                        }
                        ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(currentUser.getId());
                        NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(currentUser.getId());
                        if (!notiSetting.isProfile()) {
                            for (int i = notifications.size() - 1; i >= 0; i--) {
                                if (notifications.get(i).getType().equals("Profile")) {
                                    notifications.remove(i);
                                }
                            }
                        }

                        if (!notiSetting.isOrderChange()) {
                            for (int i = notifications.size() - 1; i >= 0; i--) {
                                if (notifications.get(i).getType().equals("Order Change")) {
                                    notifications.remove(i);
                                }
                            }
                        }

                        if (!notiSetting.isAttendance()) {
                            for (int i = notifications.size() - 1; i >= 0; i--) {
                                if (notifications.get(i).getType().equals("Attendance")) {
                                    notifications.remove(i);
                                }
                            }
                        }

                        if (!notiSetting.isService()) {
                            for (int i = notifications.size() - 1; i >= 0; i--) {
                                if (notifications.get(i).getType().equals("Service")) {
                                    notifications.remove(i);
                                }
                            }
                        }

                        if (!notiSetting.isInsurance()) {
                            for (int i = notifications.size() - 1; i >= 0; i--) {
                                if (notifications.get(i).getType().equals("Insurance")) {
                                    notifications.remove(i);
                                }
                            }
                        }

                        request.getSession().setAttribute("notification", notifications);
                        request.getSession().setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION

                        response.sendRedirect("ServiceServlet_JSP?service=listService");
                    }
                    break;
                }
                case "detailService": {
                    String idParam = request.getParameter("id");
                    if (idParam == null) {
                        response.sendRedirect("ServiceServlet_JSP?service=listService");
                        return;
                    }
                    int id = Integer.parseInt(idParam);
                    Service se = dao.getServiceDetail(id);

                    FeedbackDAO feedbackDAO = new FeedbackDAO();
                    List<Feedback> feedbackList = feedbackDAO.getFeedbackByServiceId(id);
                    request.setAttribute("feedbackList", feedbackList);
                    if (se == null) {
                        request.setAttribute("error", "Không tìm thấy dịch vụ.");
                        request.getRequestDispatcher("jsp/error.jsp").forward(request, response);
                        return;
                    }
                    request.setAttribute("service", se);
                    request.setAttribute("role", role);
                    request.setAttribute("totalPrice", se.getTotalPriceWithParts());

                    if (role == null) {
                        request.getRequestDispatcher("jsp/serviceUserDetail.jsp").forward(request, response);
                    } else if (isAdmin(role) || isManager(role) || isMarketing(role)) {
                        request.getRequestDispatcher("jsp/ServiceDetail.jsp").forward(request, response);
                    } else if ("customer".equalsIgnoreCase(role)) {
                        request.getRequestDispatcher("jsp/serviceUserDetail.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("jsp/serviceUserDetail.jsp").forward(request, response);
                    }
                    break;
                }

                case "buyService": {
                    String[] selectedIds = request.getParameterValues("selectedServiceIds");
                    if (selectedIds == null || selectedIds.length == 0) {
                        request.setAttribute("error", "Vui lòng chọn ít nhất một dịch vụ để mua.");
                        Vector<Service> list = dao.getAllService();
                        request.setAttribute("data", list);
                        request.setAttribute("role", role);
                        request.setAttribute("pageTitle", "Service Manager");
                        request.getRequestDispatcher("jsp/serviceUser.jsp").forward(request, response);
                        return;
                    }
                    // Xử lý lưu đơn mua hàng vào DB ở đây (có thể tạo bảng Order/OrderDetail)
                    // Ví dụ: orderDAO.addOrder(currentUser.getId(), selectedIds);
                    response.sendRedirect("order.jsp");
                    break;
                }
                case "previewService": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Service se = dao.getServiceDetail(id);

                    request.setAttribute("service", se);
                    request.setAttribute("totalPrice", se.getTotalPriceWithParts());
                    request.getRequestDispatcher("jsp/ServicePreview.jsp").forward(request, response);
                    break;
                }
                case "listService": {
                    int page = 1;
                    int pageSize = 6;
                    try {
                        String pageParam = request.getParameter("page");
                        if (pageParam != null) {
                            page = Integer.parseInt(pageParam);
                            if (page < 1) {
                                page = 1;
                            }
                        }
                    } catch (Exception ex) {
                        page = 1;
                    }
                    String searchName = request.getParameter("name");
                    int totalRecord = dao.countAllServices(searchName);
                    int totalPage = (int) Math.ceil(totalRecord / (double) pageSize);

                    Vector<Service> list = dao.getServicesPaging(page, pageSize, searchName);

                    request.setAttribute("data", list);
                    request.setAttribute("pageTitle", "Service Manager");
                    request.setAttribute("tableTitle", "List of Service");
                    request.setAttribute("role", role);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("totalPage", totalPage);

                    String view;
                    if (isAdmin(role) || isManager(role) || isMarketing(role)) {
                        view = "jsp/ServiceJSP.jsp";
                    } else {
                        view = "jsp/serviceUser.jsp";
                    }
                    RequestDispatcher dispatch = request.getRequestDispatcher(view);
                    dispatch.forward(request, response);
                    break;
                }
                default:
                    response.sendRedirect("ServiceServlet_JSP?service=listService");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Internal Server Error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "ServiceServlet_JSP";
    }
}
