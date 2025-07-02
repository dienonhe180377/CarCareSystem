package controller;

import dao.BlogDAO;
import dao.CampaignDAO;
import dao.DBConnection;
import entity.Blog;
import entity.Campaign;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class BlogListServlet extends HttpServlet {

    private CampaignDAO campaignDAO;

    @Override
    public void init() {
        campaignDAO = new CampaignDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DBConnection dbConn = new DBConnection();
            BlogDAO blogDAO = new BlogDAO(dbConn.getConnection());

            List<Blog> blogs = blogDAO.getAllBlogs();
            List<Campaign> campaigns = campaignDAO.getAllCampaigns();

            request.setAttribute("blogs", blogs);
            request.setAttribute("campaigns", campaigns);
            request.getRequestDispatcher("Blog/BlogList.jsp").forward(request, response);

        } catch (Exception ex) {
            request.setAttribute("errorMessage", "Không thể tải danh sách blog");
            request.getRequestDispatcher("Blog/BlogList.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Chỉ hiển thị danh sách blog";
    }
}
