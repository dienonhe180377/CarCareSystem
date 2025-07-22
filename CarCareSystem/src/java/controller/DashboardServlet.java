package controller;

import dao.DashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra quyền admin
        jakarta.servlet.http.HttpSession session = request.getSession();
        entity.User currentUser = (entity.User) session.getAttribute("user");
        if (currentUser == null || !"admin".equals(currentUser.getUserRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy tham số khoảng thời gian (range)
        String range = request.getParameter("range");
        LocalDate fromDate = null;

        if (range != null) {
            switch (range) {
                case "1":
                    fromDate = LocalDate.now().minusDays(1);
                    break;
                case "7":
                    fromDate = LocalDate.now().minusDays(7);
                    break;
                case "30":
                    fromDate = LocalDate.now().minusDays(30);
                    break;
                default:
                    break;
            }
        }

        DashboardDAO dao = new DashboardDAO();

        int totalCustomers = dao.getTotalCustomerCount();
        int totalOrders = dao.getTotalOrderCount(fromDate);
        double totalOrderRevenue = dao.getTotalOrderRevenue(fromDate);
        int totalInsurance = dao.getTotalInsuranceCount(fromDate);
        double totalInsuranceRevenue = dao.getTotalInsuranceRevenue(fromDate);

        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalOrderRevenue", totalOrderRevenue);
        request.setAttribute("totalInsurance", totalInsurance);
        request.setAttribute("totalInsuranceRevenue", totalInsuranceRevenue);
        request.setAttribute("range", range);

        request.getRequestDispatcher("Dashboard/dashboard.jsp").forward(request, response);
    }
}
