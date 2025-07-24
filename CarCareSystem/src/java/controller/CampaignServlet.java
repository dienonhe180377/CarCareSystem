package controller;

import dao.CampaignDAO;
import entity.Campaign;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

public class CampaignServlet extends AuthorizationServlet {

    private static final Logger LOGGER = Logger.getLogger(CampaignServlet.class.getName());
    private CampaignDAO campaignDAO;

    Date currentDate = new Date(System.currentTimeMillis());

    @Override
    public void init() {
        campaignDAO = new CampaignDAO();
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

        User user = (User) userObj;
        String role = user.getUserRole().toLowerCase();

        // Nếu role là "marketing" thì cho phép
        if("marketing".equals(role)){
            return false; // khong unathozied
        }
        return true;
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
                deleteCampaign(request, response);
            } else {
                showCampaignList(request, response);
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
                    addOrUpdateCampaign(request, response, false);
                case "edit" ->
                    addOrUpdateCampaign(request, response, true);
                case "delete" ->
                    deleteCampaign(request, response);
                default ->
                    showCampaignList(request, response);
            }
        } catch (Exception ex) {
            handleError(request, response, "Lỗi xử lý POST", ex);
        }
    }

    private void showEditForm(int id, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Campaign> campaigns = campaignDAO.getAllCampaigns();

            Campaign campaignToEdit = campaigns.stream()
                    .filter(c -> c.getId() == id)
                    .findFirst()
                    .orElse(null);

            if (campaignToEdit == null) {
                request.setAttribute("errorMessage", "Không tìm thấy campaign để sửa");
            } else {
                request.setAttribute("campaign", campaignToEdit);
                request.setAttribute("isEditing", true);
            }

            request.getSession().setAttribute("mainCampaignList", campaigns);
            request.setAttribute("campaigns", campaigns);
            request.getRequestDispatcher("Campaign/Campaign.jsp").forward(request, response);

        } catch (Exception ex) {
            handleError(request, response, "Không thể hiển thị form sửa", ex);
        }
    }

    private void showCampaignList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Campaign> allCampaigns = campaignDAO.getAllCampaigns();
        request.getSession().setAttribute("mainCampaignList", allCampaigns);
        request.setAttribute("campaigns", allCampaigns);
        request.getRequestDispatcher("Campaign/Campaign.jsp").forward(request, response);
    }

    private void addOrUpdateCampaign(HttpServletRequest request, HttpServletResponse response, boolean isEdit)
            throws ServletException, IOException {
        try {
            int id = isEdit ? Integer.parseInt(request.getParameter("id")) : 0;
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            boolean status = request.getParameter("status") != null;
            Date startDate = Date.valueOf(request.getParameter("startDate"));
            Date endDate = Date.valueOf(request.getParameter("endDate"));

            String error = validateCampaign(name, startDate, endDate, id, isEdit);
            if (error != null) {
                request.setAttribute("errorMessage", error);
                showCampaignList(request, response);
                return;
            }

            Campaign campaign = new Campaign(id, name.trim(), status, description, startDate, endDate);
            if (isEdit) {
                campaignDAO.updateCampaign(campaign);
                request.setAttribute("successMessage", "Cập nhật campaign thành công");
            } else {
                campaignDAO.addCampaign(campaign);
                request.setAttribute("successMessage", "Thêm campaign thành công");
            }

            showCampaignList(request, response);

        } catch (IllegalArgumentException ex) {
            LOGGER.log(Level.WARNING, "Sai định dạng ngày: ", ex);
            request.setAttribute("errorMessage", "Định dạng ngày không hợp lệ");
            showCampaignList(request, response);
        } catch (Exception ex) {
            handleError(request, response, "Lỗi khi thêm/sửa campaign", ex);
        }
    }

    private void deleteCampaign(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            campaignDAO.deleteCampaign(id);
            request.setAttribute("successMessage", "Xóa campaign thành công");
        } catch (Exception ex) {
            request.setAttribute("errorMessage", "Không thể xóa campaign");
            LOGGER.log(Level.WARNING, "Delete failed: ", ex);
        }
        showCampaignList(request, response);
    }

    private String validateCampaign(String name, Date start, Date end, int id, boolean isEdit) {
        if (name == null || name.trim().isEmpty()) {
            return "Tên không được để trống";
        }
        if (start.after(end)) {
            return "Ngày bắt đầu phải trước ngày kết thúc";
        }

        if (end.before(currentDate)) {
            return "Ngày kết thúc phải sau thời gian hiện tại";
        }

        List<Campaign> campaigns = campaignDAO.getAllCampaigns();
        for (Campaign c : campaigns) {
            if (c.getName().equalsIgnoreCase(name.trim()) && (!isEdit || c.getId() != id)) {
                return "Tên campaign đã tồn tại";
            }
        }
        return null;
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String message, Exception ex)
            throws ServletException, IOException {
        LOGGER.log(Level.SEVERE, message, ex);
        request.setAttribute("errorMessage", message);
        showCampaignList(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Campaign Management Servlet";
    }
}
