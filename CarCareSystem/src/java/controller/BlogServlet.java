package controller;

import dao.BlogDAO;
import dao.CampaignDAO;
import dao.DBConnection;
import entity.Blog;
import entity.Campaign;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import entity.User;

public class BlogServlet extends AuthorizationServlet {

    private static final Logger LOGGER = Logger.getLogger(BlogServlet.class.getName());
    private CampaignDAO campaignDAO;
    DBConnection dbConn = new DBConnection();

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

        // Nếu role là "customer repairer warehouse manager" thì không cho phép
        if("marketing".equals(role)){
            return false;
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
                deleteBlog(request, response);
            } else {
                showBlogList(request, response);
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
                    addOrUpdateBlog(request, response, false);
                case "edit" ->
                    addOrUpdateBlog(request, response, true);
                case "delete" ->
                    deleteBlog(request, response);
                default ->
                    showBlogList(request, response);
            }
        } catch (Exception ex) {
            handleError(request, response, "Lỗi xử lý POST", ex);
        }
    }

    private void showEditForm(int id, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            BlogDAO blogDAO = new BlogDAO(dbConn.getConnection());

            List<Blog> blogs = blogDAO.getAllBlogs();
            List<Campaign> campaigns = campaignDAO.getAllCampaigns();

            Blog blogToEdit = blogs.stream()
                    .filter(b -> b.getId() == id)
                    .findFirst()
                    .orElse(null);

            if (blogToEdit == null) {
                request.setAttribute("errorMessage", "Không tìm thấy blog để sửa");
            } else {
                request.setAttribute("blog", blogToEdit);
                request.setAttribute("isEditing", true);
            }

            request.getSession().setAttribute("mainBlogList", blogs);
            request.setAttribute("blogs", blogs);
            request.setAttribute("campaigns", campaigns);
            request.getRequestDispatcher("Blog/Blog.jsp").forward(request, response);

        } catch (Exception ex) {
            handleError(request, response, "Không thể hiển thị form sửa", ex);
        }
    }

    private void showBlogList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        BlogDAO blogDAO = new BlogDAO(dbConn.getConnection());

        List<Blog> blogs = blogDAO.getAllBlogs();
        List<Campaign> campaigns = campaignDAO.getAllCampaigns();

        request.getSession().setAttribute("mainBlogList", blogs);
        request.setAttribute("blogs", blogs);
        request.setAttribute("campaigns", campaigns);
        request.getRequestDispatcher("Blog/Blog.jsp").forward(request, response);
    }

    private void addOrUpdateBlog(HttpServletRequest request, HttpServletResponse response, boolean isEdit)
            throws ServletException, IOException {
        try {

            BlogDAO blogDAO = new BlogDAO(dbConn.getConnection());

            int id = isEdit ? Integer.parseInt(request.getParameter("id")) : 0;
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            int campaignId = Integer.parseInt(request.getParameter("campaignId"));
            boolean status = request.getParameter("status") != null;
            Date createDate = isEdit ? Date.valueOf(request.getParameter("createDate")) : new Date(System.currentTimeMillis());
            Date updatedDate = new Date(System.currentTimeMillis());

            String error = validateBlog(title, campaignId, id, isEdit);
            if (error != null) {
                request.setAttribute("errorMessage", error);
                showBlogList(request, response);
                return;
            }

            // Lấy campaign từ database
            Campaign campaign = campaignDAO.getAllCampaigns().stream()
                    .filter(c -> c.getId() == campaignId)
                    .findFirst()
                    .orElse(null);

            if (campaign == null) {
                request.setAttribute("errorMessage", "Campaign không tồn tại");
                showBlogList(request, response);
                return;
            }

            Blog blog = new Blog(id, title.trim(), campaign, content, createDate, updatedDate, status);
            if (isEdit) {
                blogDAO.updateBlog(blog);
                request.setAttribute("successMessage", "Cập nhật blog thành công");
            } else {
                blogDAO.addBlog(blog);
                request.setAttribute("successMessage", "Thêm blog thành công");
            }

            showBlogList(request, response);

        } catch (NumberFormatException ex) {
            LOGGER.log(Level.WARNING, "Sai định dạng số: ", ex);
            request.setAttribute("errorMessage", "Dữ liệu đầu vào không hợp lệ");
            showBlogList(request, response);
        } catch (IllegalArgumentException ex) {
            LOGGER.log(Level.WARNING, "Sai định dạng ngày: ", ex);
            request.setAttribute("errorMessage", "Định dạng ngày không hợp lệ");
            showBlogList(request, response);
        } catch (Exception ex) {
            handleError(request, response, "Lỗi khi thêm/sửa blog", ex);
        }
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            BlogDAO blogDAO = new BlogDAO(dbConn.getConnection());

            int id = Integer.parseInt(request.getParameter("id"));
            blogDAO.deleteBlog(id);
            request.setAttribute("successMessage", "Xóa blog thành công");
        } catch (Exception ex) {
            request.setAttribute("errorMessage", "Không thể xóa blog");
            LOGGER.log(Level.WARNING, "Delete failed: ", ex);
        }
        showBlogList(request, response);
    }

    private String validateBlog(String title, int campaignId, int id, boolean isEdit) {
        if (title == null || title.trim().isEmpty()) {
            return "Tiêu đề không được để trống";
        }

        if (campaignId <= 0) {
            return "Vui lòng chọn campaign";
        }

        BlogDAO blogDAO = new BlogDAO(dbConn.getConnection());
        List<Blog> blogs = blogDAO.getAllBlogs();
        for (Blog b : blogs) {
            if (b.getTitle().equalsIgnoreCase(title.trim()) && (!isEdit || b.getId() != id)) {
                return "Tiêu đề blog đã tồn tại";
            }
        }
        return null;
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String message, Exception ex)
            throws ServletException, IOException {
        LOGGER.log(Level.SEVERE, message, ex);
        request.setAttribute("errorMessage", message);
        showBlogList(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Blog Management Servlet";
    }
}
