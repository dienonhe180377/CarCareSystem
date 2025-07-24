package controller;

import dao.CampaignDAO;
import entity.Campaign;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

public class CampaignListServlet extends HttpServlet {

    private CampaignDAO campaignDAO;
    Date currentDate = new Date(System.currentTimeMillis());
    
    @Override
    public void init() {
        campaignDAO = new CampaignDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Campaign> allCampaigns = campaignDAO.getAllCampaigns();
            List<Campaign> activeCampaign = allCampaigns.stream()
                .filter(c -> c.isStatus())
                .filter(c -> !c.getEndDate().before(currentDate))
                .collect(Collectors.toList());
        request.setAttribute("campaigns", activeCampaign);
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
