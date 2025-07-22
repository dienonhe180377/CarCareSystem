package controller;

import dao.CampaignDAO;
import entity.Campaign;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class CampaignListServlet extends HttpServlet {

    private CampaignDAO campaignDAO;

    @Override
    public void init() {
        campaignDAO = new CampaignDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Campaign> campaigns = campaignDAO.getAllCampaigns();
            request.setAttribute("campaigns", campaigns);
            request.getRequestDispatcher("Campaign/CampaignList.jsp").forward(request, response);
        } catch (Exception ex) {
            request.setAttribute("errorMessage", "Lỗi khi tải danh sách chiến dịch");
            request.getRequestDispatcher("Campaign/CampaignList.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Chỉ hiển thị danh sách campaign";
    }
}
