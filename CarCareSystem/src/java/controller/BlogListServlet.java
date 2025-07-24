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
import java.util.stream.Collectors;
public class BlogListServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(BlogServlet.class.getName());
    private CampaignDAO campaignDAO;
    DBConnection dbConn = new DBConnection();
    
    @Override
    public void init() {
        campaignDAO = new CampaignDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String service = request.getParameter("service");
        String id = request.getParameter("id");
        try {
            if(id != null || "detail".equalsIgnoreCase(service)){
                showBlogDetail(request, response);
                return;
            }
            BlogDAO blogDAO = new BlogDAO(dbConn.getConnection());

            List<Blog> blogs = blogDAO.getAllBlogs();
            List<Blog> activeBlog = blogs.stream()
                    .filter(b -> b.isStatus())
                    .collect(Collectors.toList());
            List<Campaign> campaigns = campaignDAO.getAllCampaigns();
            request.setAttribute("blogs", activeBlog);
            request.setAttribute("campaigns", campaigns);
            request.getRequestDispatcher("Blog/BlogList.jsp").forward(request, response);

        } catch (Exception ex) {
            request.setAttribute("errorMessage", "Không thể tải danh sách blog");
            request.getRequestDispatcher("Blog/BlogList.jsp").forward(request, response);
        }
    }

    private void showBlogDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");

        if (idStr == null || idStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Thiếu ID blog");
            doGet(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            BlogDAO blogDAO = new BlogDAO(dbConn.getConnection());

            Blog blog = blogDAO.getBlogById(id); // Sử dụng method đã thêm

            if (blog != null) {
                request.setAttribute("blog", blog);
                request.getRequestDispatcher("Blog/BlogDetail.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Không tìm thấy blog với ID: " + id);
                doGet(request, response);
            }

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "ID blog không hợp lệ: " + idStr, e);
            request.setAttribute("errorMessage", "ID blog không hợp lệ");
            doGet(request, response);
        } catch (Exception ex) {
            handleError(request, response, "Không thể hiển thị chi tiết blog", ex);
        }
    }
    private void handleError(HttpServletRequest request, HttpServletResponse response, String message, Exception ex)
            throws ServletException, IOException {
        LOGGER.log(Level.SEVERE, message, ex);
        request.setAttribute("errorMessage", message);
        doGet(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Chỉ hiển thị danh sách blog";
    }
}
