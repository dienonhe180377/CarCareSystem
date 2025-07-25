package controller;

import dao.InsTypeDAO;
import dao.NotificationDAO;
import dao.UserDAO;
import entity.InsuranceType;
import entity.Notification;
import entity.NotificationSetting;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.SendMailService;

@WebServlet(name = "InsTypeServlet", urlPatterns = {"/instype"})
public class InsTypeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
//NOTIFICATION
        UserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        NotificationDAO notificationDAO = new NotificationDAO();
//NOTIFICATION
        InsTypeDAO dao = new InsTypeDAO();
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        // Lấy user từ session
        User currentUser = (User) request.getSession().getAttribute("user");
        String role = (currentUser != null) ? currentUser.getUserRole() : "";
        boolean canEdit = "manager".equals(role);

        if (action.equals("list")) {
            String keyword = request.getParameter("keyword");
            int page = 1;
            int pageSize = 5;
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            Vector<InsuranceType> list;
            int totalRecords = 0;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = dao.searchInsuranceTypeByName(keyword.trim());
                totalRecords = list.size();
                page = 1; // Khi tìm kiếm chỉ hiển thị trang đầu
            } else {
                totalRecords = dao.getTotalInsuranceTypeCount();
                list = dao.getInsuranceTypeByPage(page, pageSize);
            }
            int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);

            request.setAttribute("list", list);
            request.setAttribute("keyword", keyword);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("role", role);
            String view;
            if (currentUser == null) {
                // Chưa đăng nhập → khách
                view = "InsuranceType/InsuranceTypeCustomer.jsp";
            } else if ("admin".equals(role) || "manager".equals(role)) {
                view = "InsuranceType/InsuranceType.jsp";
            } else {
                // Đăng nhập với tư cách customer
                view = "InsuranceType/InsuranceTypeCustomer.jsp";
            }

            request.getRequestDispatcher(view).forward(request, response);

        } else if (canEdit && action.equals("add")) {
            String submit = request.getParameter("submit");
            if (submit == null) {
                request.getRequestDispatcher("InsuranceType/addInsuranceType.jsp").forward(request, response);
            } else {
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                String priceStr = request.getParameter("price");
                String error = null;

                // Regex: chỉ cho phép chữ cái, số, khoảng trắng cho name và description
                String validPattern = "^[a-zA-Z0-9\\sÀ-ỹ.,]+$";
                double price = 0;
                try {
                    price = Double.parseDouble(priceStr);
                } catch (Exception e) {
                    error = "Giá phải là số!";
                }

                if (name == null || !name.matches(validPattern)) {
                    error = "Tên không được chứa ký tự đặc biệt!";
                } else if (description == null || !description.matches(validPattern)) {
                    error = "Mô tả không được chứa ký tự đặc biệt!";
                } else if (price <= 0) {
                    error = "Giá phải lớn hơn 0!";
                } else if (dao.isInsuranceTypeNameExists(name)) {
                    error = "Bảo hiểm đã tồn tại!";
                }

                if (error != null) {
                    request.setAttribute("error", error);
                    request.setAttribute("name", name);
                    request.setAttribute("description", description);
                    request.setAttribute("price", priceStr);
                    request.getRequestDispatcher("InsuranceType/addInsuranceType.jsp").forward(request, response);
                } else {
                    InsuranceType type = new InsuranceType(name, description, price);
                    dao.addInsuranceType(type);

                    //NOTIFICATION ADD INSURANCE
                    String message = "Bảo hiểm " + name + " vừa được thêm vào hệ thống";

                    List<User> users = userDAO.getAllUser();
                    for (int i = 0; i < users.size(); i++) {
                        if (users.get(i).getUserRole().equals("manager")) {
                            NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                            if (notiSetting.isEmail() && notiSetting.isInsurance()) {
                                SendMailService.sendNotification(users.get(i).getEmail(), message);
                            }
                            int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Insurance");
                        }
                    }
                    ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(user.getId());
                    NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(user.getId());
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

                    if (!notiSetting.isCategory()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Category")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isSupplier()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Supplier")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isParts()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Part")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isSettingChange()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Setting Change")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isCarType()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Car Type")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isCampaign()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Campaign")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isBlog()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Blog")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isVoucher()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Voucher")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    session.setAttribute("notification", notifications);
                    session.setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION

                    response.sendRedirect("instype?action=list");
                }
            }

        } else if (canEdit && action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            InsuranceType type = dao.getInsuranceTypeById(id);
            request.setAttribute("type", type);
            request.getRequestDispatcher("InsuranceType/updateInsuranceType.jsp").forward(request, response);

        } else if (canEdit && action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String error = null;

            String validPattern = "^[a-zA-Z0-9\\sÀ-ỹ.,]+$";
            double price = 0;
            try {
                price = Double.parseDouble(priceStr);
            } catch (Exception e) {
                error = "Giá phải là số!";
            }

            if (name == null || !name.matches(validPattern)) {
                error = "Tên không được chứa ký tự đặc biệt!";
            } else if (description == null || !description.matches(validPattern)) {
                error = "Mô tả không được chứa ký tự đặc biệt!";
            } else if (price <= 0) {
                error = "Giá phải lớn hơn 0!";
            } else if (dao.isInsuranceTypeNameExistsForOtherId(name, id)) {
                error = "Bảo hiểm đã tồn tại!";
            }

            if (error != null) {
                InsuranceType type = new InsuranceType(id, name, description, price);
                request.setAttribute("error", error);
                request.setAttribute("type", type);
                request.getRequestDispatcher("InsuranceType/updateInsuranceType.jsp").forward(request, response);
            } else {
                InsuranceType type = new InsuranceType(id, name, description, price);
                dao.updateInsuranceType(type);

                //NOTIFICATION EDIT INSURANCE
                
                String message = "Bảo hiểm " + name + " vừa được sửa";

                    List<User> users = userDAO.getAllUser();
                    for (int i = 0; i < users.size(); i++) {
                        if (users.get(i).getUserRole().equals("manager")) {
                            NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                            if (notiSetting.isEmail() && notiSetting.isInsurance()) {
                                SendMailService.sendNotification(users.get(i).getEmail(), message);
                            }
                            int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Insurance");
                        }
                    }
                    ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(user.getId());
                    NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(user.getId());
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

                    if (!notiSetting.isCategory()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Category")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isSupplier()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Supplier")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isParts()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Part")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isSettingChange()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Setting Change")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isCarType()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Car Type")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isCampaign()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Campaign")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isBlog()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Blog")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isVoucher()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Voucher")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    session.setAttribute("notification", notifications);
                    session.setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION
                
                response.sendRedirect("instype?action=list");
            }
        } else if (canEdit && action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteInsuranceType(id);

            //NOTIFICATION DELETE INSURANCE
            
            String message = "Bảo hiểm Id " + id + " vừa bị xóa khỏi hệ thống";

                    List<User> users = userDAO.getAllUser();
                    for (int i = 0; i < users.size(); i++) {
                        if (users.get(i).getUserRole().equals("manager")) {
                            NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                            if (notiSetting.isEmail() && notiSetting.isInsurance()) {
                                SendMailService.sendNotification(users.get(i).getEmail(), message);
                            }
                            int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Insurance");
                        }
                    }
                    ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(user.getId());
                    NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(user.getId());
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

                    if (!notiSetting.isCategory()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Category")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isSupplier()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Supplier")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isParts()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Part")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isSettingChange()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Setting Change")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isCarType()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Car Type")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isCampaign()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Campaign")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isBlog()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Blog")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isVoucher()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Voucher")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    session.setAttribute("notification", notifications);
                    session.setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION
            
            response.sendRedirect("instype?action=list");

        } else {
            // Không có quyền, chuyển về danh sách
            response.sendRedirect("instype?action=list");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(InsTypeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(InsTypeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
