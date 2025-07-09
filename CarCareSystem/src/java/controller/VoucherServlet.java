package controller;

import dao.VoucherDAO;
import dao.CampaignDAO;
import dao.ServiceDAO;
import entity.Voucher;
import entity.Campaign;
import entity.Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class VoucherServlet extends AuthorizationServlet {

    private static final Logger LOGGER = Logger.getLogger(VoucherServlet.class.getName());
    private VoucherDAO voucherDAO;
    private CampaignDAO campaignDAO;
    private ServiceDAO serviceDAO;

    @Override
    public void init() {
        voucherDAO = new VoucherDAO();
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

        entity.User user = (entity.User) userObj;
        String role = user.getUserRole().toLowerCase();

        // Nếu role là "user" thì không cho phép
        return role.equals("user");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (isUnauthorized(request)) {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("Bạn không có quyền truy cập trang này.");
            return;
        }
        
        String service = request.getParameter("service");
        String editId = request.getParameter("editId");

        try {
            if (editId != null) {
                int id = Integer.parseInt(editId);
                showEditForm(id, request, response);
            } else if ("delete".equalsIgnoreCase(service)) {
                deleteVoucher(request, response);
            } else {
                showVoucherList(request, response);
            }
        } catch (Exception ex) {
            handleError(request, response, "Lỗi xử lý GET", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (isUnauthorized(request)) {
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("Bạn không có quyền thực hiện thao tác này.");
            return;
        }
        
        String service = request.getParameter("service");

        try {
            switch (service.toLowerCase()) {
                case "add" ->
                    addOrUpdateVoucher(request, response, false);
                case "edit" ->
                    addOrUpdateVoucher(request, response, true);
                case "delete" ->
                    deleteVoucher(request, response);
                default ->
                    showVoucherList(request, response);
            }
        } catch (Exception ex) {
            handleError(request, response, "Lỗi xử lý POST", ex);
        }
    }

    private void showEditForm(int id, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Voucher> vouchers = voucherDAO.getAllVouchers();
            List<Campaign> campaigns = campaignDAO.getAllCampaigns();
            List<Service> services = serviceDAO.getAllService();

            Voucher voucherToEdit = vouchers.stream()
                    .filter(v -> v.getId() == id)
                    .findFirst()
                    .orElse(null);

            if (voucherToEdit == null) {
                request.setAttribute("errorMessage", "Không tìm thấy voucher để sửa");
            } else {
                request.setAttribute("voucher", voucherToEdit);
                request.setAttribute("isEditing", true);
            }

            request.setAttribute("vouchers", vouchers);
            request.setAttribute("campaigns", campaigns);
            request.setAttribute("services", services);
            request.getRequestDispatcher("Voucher/Voucher.jsp").forward(request, response);

        } catch (Exception ex) {
            handleError(request, response, "Không thể hiển thị form sửa", ex);
        }
    }

    private void showVoucherList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Voucher> vouchers = voucherDAO.getAllVouchers();
        List<Campaign> campaigns = campaignDAO.getAllCampaigns();
        List<Service> services = serviceDAO.getAllService();
        
        request.setAttribute("vouchers", vouchers);
        request.setAttribute("campaigns", campaigns);
        request.setAttribute("services", services);
        request.getRequestDispatcher("Voucher/Voucher.jsp").forward(request, response);
    }

    private void addOrUpdateVoucher(HttpServletRequest request, HttpServletResponse response, boolean isEdit)
            throws ServletException, IOException {
        try {
            int id = isEdit ? Integer.parseInt(request.getParameter("id")) : 0;
            String name = request.getParameter("name");
            int campaignId = Integer.parseInt(request.getParameter("campaignId"));
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            String description = request.getParameter("description");
            int discount = Integer.parseInt(request.getParameter("discount"));
            boolean status = request.getParameter("status") != null;
            Date startDate = Date.valueOf(request.getParameter("startDate"));
            Date endDate = Date.valueOf(request.getParameter("endDate"));

            String error = validateVoucher(name, startDate, endDate, discount, id, isEdit);
            if (error != null) {
                request.setAttribute("errorMessage", error);
                showVoucherList(request, response);
                return;
            }

            // Get campaign and service objects
            Campaign campaign = campaignDAO.getAllCampaigns().stream()
                    .filter(c -> c.getId() == campaignId)
                    .findFirst()
                    .orElse(null);
            
            Service service = serviceDAO.getAllService().stream()
                    .filter(s -> s.getId() == serviceId)
                    .findFirst()
                    .orElse(null);

            if (campaign == null || service == null) {
                request.setAttribute("errorMessage", "Campaign hoặc Service không tồn tại");
                showVoucherList(request, response);
                return;
            }

            Voucher voucher = new Voucher(id, name.trim(), campaign, service, startDate, endDate, description, discount, status);
            
            if (isEdit) {
                voucherDAO.updateVoucher(voucher);
                request.setAttribute("successMessage", "Cập nhật voucher thành công");
            } else {
                voucherDAO.addVoucher(voucher);
                request.setAttribute("successMessage", "Thêm voucher thành công");
            }

            showVoucherList(request, response);

        } catch (IllegalArgumentException ex) {
            LOGGER.log(Level.WARNING, "Sai định dạng dữ liệu: ", ex);
            request.setAttribute("errorMessage", "Định dạng dữ liệu không hợp lệ");
            showVoucherList(request, response);
        } catch (Exception ex) {
            handleError(request, response, "Lỗi khi thêm/sửa voucher", ex);
        }
    }

    private void deleteVoucher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            voucherDAO.deleteVoucher(id);
            request.setAttribute("successMessage", "Xóa voucher thành công");
        } catch (Exception ex) {
            request.setAttribute("errorMessage", "Không thể xóa voucher");
            LOGGER.log(Level.WARNING, "Delete failed: ", ex);
        }
        showVoucherList(request, response);
    }

    private String validateVoucher(String name, Date start, Date end, int discount, int id, boolean isEdit) {
        if (name == null || name.trim().isEmpty()) {
            return "Tên không được để trống";
        }
        if (start.after(end)) {
            return "Ngày bắt đầu phải trước ngày kết thúc";
        }
        if (discount < 0 || discount > 100) {
            return "Discount phải từ 0 đến 100";
        }

        java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());
        if (end.before(currentDate)) {
            return "Ngày kết thúc phải sau thời gian hiện tại";
        }

        List<Voucher> vouchers = voucherDAO.getAllVouchers();
        for (Voucher v : vouchers) {
            if (v.getName().equalsIgnoreCase(name.trim()) && (!isEdit || v.getId() != id)) {
                return "Tên voucher đã tồn tại";
            }
        }
        return null;
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String message, Exception ex)
            throws ServletException, IOException {
        LOGGER.log(Level.SEVERE, message, ex);
        request.setAttribute("errorMessage", message);
        showVoucherList(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Voucher Management Servlet";
    }
}
