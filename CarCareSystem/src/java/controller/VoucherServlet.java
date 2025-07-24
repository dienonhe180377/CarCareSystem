package controller;

import dao.CampaignDAO;
import dao.ServiceDAO;
import dao.VoucherDAO;
import dao.UserVoucherDAO;
import entity.Campaign;
import entity.Service;
import entity.Voucher;
import entity.User;
import entity.UserVoucher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.regex.Pattern;

/**
 *
 * @author NTN
 */
public class VoucherServlet extends AuthorizationServlet {

    private VoucherDAO voucherDAO;
    private UserVoucherDAO userVoucherDAO;
    private CampaignDAO campaignDAO;
    private ServiceDAO serviceDAO;

    @Override
    public void init() {
        voucherDAO = new VoucherDAO();
        userVoucherDAO = new UserVoucherDAO();
        campaignDAO = new CampaignDAO();
        serviceDAO = new ServiceDAO();
    }

    private boolean isUnauthorized(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return true;
        }

        Object userObj = session.getAttribute("user");
        if (userObj == null) {
            return true;
        }

        return false; // Đã login thì được phép truy cập
    }

    // Chỉ admin, marketing, manager được quản lý voucher
    private boolean canManageVouchers(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }

        Object userObj = session.getAttribute("user");
        if (userObj == null) {
            return false;
        }

        User user = (User) userObj;
        String role = user.getUserRole().toLowerCase();

        return role.equals("admin") || role.equals("marketing") || role.equals("manager");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (isUnauthorized(request)) {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("Bạn cần đăng nhập để truy cập trang này.");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        // Nếu KHÔNG phải admin/marketing/manager, chỉ cho phép xem voucher của mình
        if (!canManageVouchers(request)) {
            if ("userVouchers".equals(action) || action == null || "list".equals(action)) {
                showUserVouchers(request, response);
                return;
            } else if ("userDetail".equals(action)) {
                showUserVoucherDetail(request, response);
                return;
            } else {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("Bạn không có quyền truy cập chức năng này.");
                return;
            }
        }

        // Chỉ admin/marketing/manager mới được truy cập đầy đủ
        try {
            switch (action) {
                case "list":
                    showVoucherList(request, response);
                    break;
                case "addByUser":
                    showAddByUserForm(request, response);
                    break;
                case "addPublic":
                    showAddPublicForm(request, response);
                    break;
                case "addPrivate":
                    showAddPrivateForm(request, response);
                    break;
                case "detail":
                    showVoucherDetail(request, response);
                    break;
                case "delete":
                    deleteVoucher(request, response);
                    break;
                case "userVouchers":
                    showUserVouchers(request, response);
                    break;
                default:
                    showVoucherList(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            showVoucherList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (isUnauthorized(request)) {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("Bạn cần đăng nhập để thực hiện thao tác này.");
            return;
        }

        // Chỉ admin/marketing/manager mới được thực hiện POST
        if (!canManageVouchers(request)) {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("Bạn không có quyền thực hiện thao tác này.");
            return;
        }

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "addByUser":
                    processAddByUser(request, response);
                    break;
                case "addPublic":
                    processAddPublic(request, response);
                    break;
                case "addPrivate":
                    processAddPrivate(request, response);
                    break;
                default:
                    showVoucherList(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            showVoucherList(request, response);
        }
    }

    private void showUserVoucherDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int voucherId = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            // Kiểm tra user có voucher này không
            List<UserVoucher> userVouchers = userVoucherDAO.getUserVouchersByUserId(currentUser.getId());
            boolean hasVoucher = userVouchers.stream()
                    .anyMatch(uv -> uv.getVoucher().getId() == voucherId);

            if (!hasVoucher) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("Bạn không có quyền xem voucher này.");
                return;
            }

            Voucher voucher = voucherDAO.getVoucherById(voucherId);
            request.setAttribute("voucher", voucher);
            request.getRequestDispatcher("Voucher/VoucherDetailUser.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("ID voucher không hợp lệ.");
        }
    }

    private void showVoucherList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Voucher> vouchers = voucherDAO.getAllVouchers();
        request.setAttribute("vouchers", vouchers);
        request.getRequestDispatcher("Voucher/Voucher.jsp").forward(request, response);
    }

    private void showAddByUserForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = userVoucherDAO.getAllUsers();
        List<Service> services = serviceDAO.getAllService();
        List<Campaign> campaigns = campaignDAO.getAllCampaigns();
        request.setAttribute("users", users);
        request.setAttribute("services", services);
        request.setAttribute("campaigns", campaigns);
        request.getRequestDispatcher("Voucher/AddVoucherByUser.jsp").forward(request, response);
    }

    private void showAddPublicForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Service> services = serviceDAO.getAllService();
        List<Campaign> campaigns = campaignDAO.getAllCampaigns();
        request.setAttribute("services", services);
        request.setAttribute("campaigns", campaigns);
        request.getRequestDispatcher("Voucher/AddVoucherPublic.jsp").forward(request, response);
    }

    private void showAddPrivateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Service> services = serviceDAO.getAllService();
        List<Campaign> campaigns = campaignDAO.getAllCampaigns();
        request.setAttribute("services", services);
        request.setAttribute("campaigns", campaigns);
        request.getRequestDispatcher("Voucher/AddVoucherPrivate.jsp").forward(request, response);
    }

    private void showVoucherDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int voucherId = Integer.parseInt(request.getParameter("id"));
        Voucher voucher = voucherDAO.getVoucherById(voucherId);
        List<String> owners = userVoucherDAO.getVoucherOwners(voucherId);

        request.setAttribute("voucher", voucher);
        request.setAttribute("owners", owners);
        request.getRequestDispatcher("Voucher/VoucherDetail.jsp").forward(request, response);
    }

    private void showUserVouchers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            List<UserVoucher> userVouchers = userVoucherDAO.getUserVouchersByUserId(user.getId());
            request.setAttribute("userVouchers", userVouchers);
        }

        request.getRequestDispatcher("Voucher/VoucherList.jsp").forward(request, response);
    }

    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int voucherId = Integer.parseInt(request.getParameter("id"));

        if (voucherDAO.deleteVoucher(voucherId)) {
            request.setAttribute("successMessage", "Xóa voucher thành công!");
        } else {
            request.setAttribute("errorMessage", "Không thể xóa voucher!");
        }

        showVoucherList(request, response);
    }

    private void processAddByUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] userIds = request.getParameterValues("userIds");
        if (userIds == null || userIds.length == 0) {
            request.setAttribute("errorMessage", "Vui lòng chọn ít nhất một người dùng!");
            showAddByUserForm(request, response);
            return;
        }

        Voucher voucher = createVoucherFromRequest(request);
        String validationError = validateVoucher(voucher);

        if (validationError != null) {
            request.setAttribute("errorMessage", validationError);
            showAddByUserForm(request, response);
            return;
        }

        if (voucherDAO.addVoucher(voucher)) {
            for (String userIdStr : userIds) {
                int userId = Integer.parseInt(userIdStr);
                userVoucherDAO.addUserVoucher(userId, voucher.getId(), voucher.getVoucherCode());
            }
            request.setAttribute("successMessage", "Thêm voucher thành công!");
            showVoucherList(request, response);
        } else {
            request.setAttribute("errorMessage", "Không thể thêm voucher!");
            showAddByUserForm(request, response);
        }
    }

    private void processAddPublic(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Voucher voucher = createVoucherFromRequest(request);
        String validationError = validateVoucher(voucher);

        if (validationError != null) {
            request.setAttribute("errorMessage", validationError);
            showAddPublicForm(request, response);
            return;
        }

        if (voucherDAO.addVoucher(voucher)) {
            List<User> allUsers = userVoucherDAO.getAllUsers();
            for (User user : allUsers) {
                userVoucherDAO.addUserVoucher(user.getId(), voucher.getId(), voucher.getVoucherCode());
            }
            request.setAttribute("successMessage", "Thêm voucher công khai thành công!");
            showVoucherList(request, response);
        } else {
            request.setAttribute("errorMessage", "Không thể thêm voucher!");
            showAddPublicForm(request, response);
        }
    }

    private void processAddPrivate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] roles = request.getParameterValues("roles");
        if (roles == null || roles.length == 0) {
            request.setAttribute("errorMessage", "Vui lòng chọn ít nhất một vai trò!");
            showAddPrivateForm(request, response);
            return;
        }

        Voucher voucher = createVoucherFromRequest(request);
        String validationError = validateVoucher(voucher);

        if (validationError != null) {
            request.setAttribute("errorMessage", validationError);
            showAddPrivateForm(request, response);
            return;
        }

        if (voucherDAO.addVoucher(voucher)) {
            for (String role : roles) {
                List<User> usersWithRole = userVoucherDAO.getUsersByRole(role);
                for (User user : usersWithRole) {
                    userVoucherDAO.addUserVoucher(user.getId(), voucher.getId(), voucher.getVoucherCode());
                }
            }
            request.setAttribute("successMessage", "Thêm voucher riêng tư thành công!");
            showVoucherList(request, response);
        } else {
            request.setAttribute("errorMessage", "Không thể thêm voucher!");
            showAddPrivateForm(request, response);
        }
    }

    private Voucher createVoucherFromRequest(HttpServletRequest request) {
        Voucher voucher = new Voucher();

        voucher.setName(request.getParameter("name"));
        voucher.setDescription(request.getParameter("description"));
        voucher.setVoucherCode(request.getParameter("voucherCode"));
        voucher.setDiscountType(request.getParameter("discountType"));
        voucher.setDiscount(Float.parseFloat(request.getParameter("discount")));
        voucher.setServiceId(Integer.parseInt((request.getParameter("serviceId"))));
        voucher.setCampaignId(Integer.parseInt((request.getParameter("campaignId"))));
        String maxDiscountStr = request.getParameter("maxDiscountAmount");
        if (maxDiscountStr != null && !maxDiscountStr.trim().isEmpty()) {
            voucher.setMaxDiscountAmount(Float.parseFloat(maxDiscountStr));
        }

        String minOrderStr = request.getParameter("minOrderAmount");
        if (minOrderStr != null && !minOrderStr.trim().isEmpty()) {
            voucher.setMinOrderAmount(Float.parseFloat(minOrderStr));
        }

        voucher.setStartDate(Date.valueOf(request.getParameter("startDate")));
        voucher.setEndDate(Date.valueOf(request.getParameter("endDate")));
        voucher.setStatus(true);
        return voucher;
    }

    private String validateVoucher(Voucher voucher) {
        if (voucher.getName() == null || voucher.getName().trim().isEmpty()) {
            return "Tên voucher không được để trống!";
        }

        if (voucher.getVoucherCode() == null || voucher.getVoucherCode().trim().isEmpty()) {
            return "Mã voucher không được để trống!";
        }

        if (!Pattern.matches("^[a-zA-Z0-9]+$", voucher.getVoucherCode())) {
            return "Mã voucher chỉ được chứa chữ cái và số, không có dấu cách hoặc ký tự đặc biệt!";
        }

        if (voucherDAO.isVoucherCodeExists(voucher.getVoucherCode())) {
            return "Mã voucher đã tồn tại!";
        }

        if (voucher.getStartDate().after(voucher.getEndDate())) {
            return "Ngày bắt đầu phải trước ngày kết thúc!";
        }

        if (voucher.getDiscount() <= 0) {
            return "Giá trị giảm giá phải lớn hơn 0!";
        }

        if ("PERCENTAGE".equals(voucher.getDiscountType()) && voucher.getDiscount() > 100) {
            return "Giảm giá theo phần trăm không được vượt quá 100%!";
        }

        return null;
    }
}
