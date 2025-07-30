package controller;

import dao.CampaignDAO;
import entity.Campaign;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig(maxFileSize = 5242880)
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
        if ("marketing".equals(role)) {
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
            String img = handleFileUpload(request, "imageFile", "campaign");
            String thumbnail = handleFileUpload(request, "thumbnailFile", "thumbnail");

            if (isEdit) {
                if (img == null) {
                    img = request.getParameter("currentImg"); // Hidden field từ form edit
                }
                if (thumbnail == null) {
                    thumbnail = request.getParameter("currentThumbnail"); // Hidden field từ form edit
                }
            }

            if (img == null || img.trim().isEmpty()) {
                img = "image/campaign.png";
            }
            if (thumbnail == null || thumbnail.trim().isEmpty()) {
                thumbnail = "image/campaign-default.png";
            }

            String error = validateCampaign(name, startDate, endDate, id, isEdit);
            if (error != null) {
                request.setAttribute("errorMessage", error);
                showCampaignList(request, response);
                return;
            }

            Campaign campaign = new Campaign(id, name, status, description, startDate, endDate, img, thumbnail, null);
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

    private String handleFileUpload(HttpServletRequest request, String partName, String prefix)
            throws IOException, ServletException {
        try {
            Part filePart = request.getPart(partName);
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();

                // Validate file type
                if (!isValidImageFile(fileName)) {
                    throw new ServletException("File không phải là ảnh hợp lệ");
                }

                // Tạo tên file unique
                String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                String newFileName = prefix + "_" + System.currentTimeMillis() + fileExtension;

                // Đường dẫn lưu file
                String uploadPath = getServletContext().getRealPath("/image");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Lưu file
                filePart.write(uploadPath + File.separator + newFileName);

                return "image/" + newFileName;
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Lỗi upload file: ", e);
        }
        return null;
    }

    private boolean isValidImageFile(String fileName) {
        if (fileName == null) {
            return false;
        }
        String extension = fileName.toLowerCase();
        return extension.endsWith(".jpg") || extension.endsWith(".jpeg")
                || extension.endsWith(".png") || extension.endsWith(".gif");
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
