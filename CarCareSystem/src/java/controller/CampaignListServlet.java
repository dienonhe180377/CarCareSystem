package controller;

import dao.CampaignDAO;
import dao.UserVoucherDAO;
import dao.VoucherDAO;
import entity.Campaign;
import entity.User;
import entity.Voucher;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

public class CampaignListServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CampaignServlet.class.getName());
    private CampaignDAO campaignDAO;
    private VoucherDAO voucherDAO;
    private UserVoucherDAO userVoucherDAO;

    Date currentDate = new Date(System.currentTimeMillis());

    @Override
    public void init() {
        campaignDAO = new CampaignDAO();
        voucherDAO = new VoucherDAO();
        userVoucherDAO = new UserVoucherDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String service = request.getParameter("service");
        String id = request.getParameter("id");
        try {
            if (id != null || "detail".equalsIgnoreCase(service)) {
                showCampaignDetail(request, response);
                return;
            }
            List<Campaign> allCampaigns = campaignDAO.getAllCampaigns();
            List<Campaign> activeCampaign = allCampaigns.stream()
                    .filter(c -> c.isStatus())
                    .filter(c -> !c.getStartDate().after(currentDate))
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("claimVoucher".equals(action)) {
            handleClaimVoucher(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void handleClaimVoucher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = null;

        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // ✅ Đã đăng nhập → xử lý logic lấy voucher như cũ
        try {
            int voucherId = Integer.parseInt(request.getParameter("voucherId"));
            int campaignId = Integer.parseInt(request.getParameter("campaignId"));
            
            // Kiểm tra voucher còn không
            Voucher voucher = voucherDAO.getVoucherById(voucherId);
            if (voucher == null) {
                session.setAttribute("errorMessage", "Voucher không tồn tại!");
                response.sendRedirect("campaignlist?service=detail&id=" + campaignId);
                return;
            }

            if (voucher.getTotalVoucherCount() == 0) {
                session.setAttribute("errorMessage", "Voucher đã hết!");
                response.sendRedirect("campaignlist?service=detail&id=" + campaignId);
                return;
            }
            // Thực hiện lấy voucher
            if (userVoucherDAO.claimVoucher(user.getId(), voucherId, voucher.getVoucherCode())) {
                session.setAttribute("successMessage", "Lấy voucher thành công!");
            } else {
                session.setAttribute("errorMessage", "Không thể lấy voucher. Vui lòng thử lại!");
            }
            response.sendRedirect("campaignlist?service=detail&id=" + campaignId);

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid number format in handleClaimVoucher", e);
            session.setAttribute("errorMessage", "Thông tin không hợp lệ!");
            response.sendRedirect("campaignlist");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in handleClaimVoucher", e);
            session.setAttribute("errorMessage", "Có lỗi xảy ra khi lấy voucher!");
            response.sendRedirect("campaignlist");
        }
    }

    private void showCampaignDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int campaignId = Integer.parseInt(request.getParameter("id"));
            Campaign campaign = campaignDAO.getCampaignById(campaignId);

            if (campaign != null) {
                List<Voucher> campaignVouchers = voucherDAO.getVoucherByCampaignId(campaignId);

                HttpSession session = request.getSession(false);
                Map<Integer, Boolean> userClaimedVouchers = new HashMap<>();

                if (session != null) {
                    User user = (User) session.getAttribute("user");
                    if (user != null) {
                        // Kiểm tra từng voucher xem user đã claim chưa
                        for (Voucher voucher : campaignVouchers) {
                            boolean hasClaimed = userVoucherDAO.hasUserClaimedVoucher(user.getId(), voucher.getId());
                            userClaimedVouchers.put(voucher.getId(), hasClaimed);
                        }
                    }
                }
                Map<Integer, String> serviceNames = new HashMap<>();
                for (Voucher voucher : campaignVouchers) {
                    String serviceName = null;
                    int serviceId = voucher.getServiceId();
                    if (serviceId > 0) {
                        serviceName = voucherDAO.getServiceNameById(serviceId);
                    }
                    serviceNames.put(voucher.getId(), serviceName);
                }

                request.setAttribute("campaign", campaign);
                request.setAttribute("campaignVouchers", campaignVouchers);
                request.setAttribute("serviceNames", serviceNames); // ✅ Map để JSP dùng
                request.setAttribute("userClaimedVouchers", userClaimedVouchers);
                request.getRequestDispatcher("Campaign/CampaignDetail.jsp").forward(request, response);

            } else {
                request.setAttribute("errorMessage", "Không tìm thấy campaign với ID: " + campaignId);
                doGet(request, response);
            }

        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "ID campaign không hợp lệ: " + e.getMessage());
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
