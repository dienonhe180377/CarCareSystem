package controller;

import dao.ServiceDAO;
import entity.Order;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name="OrderDetailServlet", urlPatterns={"/orderDetail"})
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            String orderIdRaw = request.getParameter("orderId");
            if (orderIdRaw == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số orderId");
                return;
            }

            int orderId;
            try {
                orderId = Integer.parseInt(orderIdRaw);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "orderId không hợp lệ");
                return;
            }

            HttpSession session = request.getSession(false);
            User loginUser = (session != null) ? (User) session.getAttribute("user") : null;
            if (loginUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            ServiceDAO dao = new ServiceDAO();
            Order order = dao.getOrderDetail(orderId);
            if (order == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đơn hàng");
                return;
            }

            String role = loginUser.getUserRole();
            boolean isOwner = (order.getUser() != null) && (order.getUser().getId() == loginUser.getId());
            boolean isManager = "manager".equalsIgnoreCase(role);
            boolean isRepairer = "repairer".equalsIgnoreCase(role);

            // Quyền: manager, repairer, hoặc chính chủ đơn hàng (customer)
            if (!(isManager || isRepairer || isOwner)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xem đơn hàng này");
                return;
            }

            request.setAttribute("order", order);

            if (isManager || isRepairer) {
                request.setAttribute("role", role);
                request.getRequestDispatcher("orderDetailStaff.jsp").forward(request, response);
            } else {
                // customer (chủ đơn hàng)
                request.getRequestDispatcher("orderDetailUser.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống: " + ex.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị chi tiết đơn hàng cho manager, repairer, customer; kiểm tra phân quyền, forward tới JSP phù hợp";
    }
}