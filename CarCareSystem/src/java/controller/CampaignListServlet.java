package controller;

import dao.CampaignDAO;
import entity.Campaign;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

public class CampaignListServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CampaignServlet.class.getName());
    private CampaignDAO campaignDAO;
    Date currentDate = new Date(System.currentTimeMillis());

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
                showCampaignDetail(request, response);
                return;
            }
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

    private void showCampaignDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");

        if (idStr == null || idStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Thiếu id campaign");
            doGet(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Campaign campaign = campaignDAO.getCampaignById(id);
            if (campaign != null) {
                request.setAttribute("campaign", campaign);
                request.getRequestDispatcher("Campaign/CampaignDetail.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Không tìm thấy campaign với ID: " + id);
                doGet(request, response);
            }

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "ID campaign không hợp lệ: " + idStr, e);
            request.setAttribute("errorMessage", "ID campaign không hợp lệ");
            doGet(request, response);
        } catch (Exception ex) {
            handleError(request, response, "Không thể hiển thị chi tiết campaign", ex);
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
        return "Chỉ hiển thị danh sách campaign";
    }
}
