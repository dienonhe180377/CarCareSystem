/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.order;

import dao.NotificationDAO;
import dao.OrderDAO;
import dao.UserDAO;
import entity.Notification;
import entity.NotificationSetting;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import util.SendMailService;

/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name = "OrderServlet", urlPatterns = {"/order"})
public class OrderServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            String fullName = user != null ? user.getUsername() : request.getParameter("fullName");
            String email = user != null ? user.getEmail() : request.getParameter("email");
            String phone = user != null ? user.getPhone() : request.getParameter("phone");
            String address = user != null ? user.getAddress() : request.getParameter("address");

            String carType = request.getParameter("carType");
            String description = request.getParameter("description");
            String appointmentDateStr = request.getParameter("appointmentDate");

            String paymentStatus = "unpaid";
            String priceStr = "0";
            String orderStatus = "pending";
            String paymentMethod = "cash";

            double price = 0.0;
            try {
                price = Double.parseDouble(priceStr);
            } catch (NumberFormatException e) {
                // Xử lý nếu không parse được (giữ giá trị mặc định là 0.0)
            }

            java.sql.Date appointmentDate = java.sql.Date.valueOf(appointmentDateStr);
            java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());

            LocalDate localAppointmentDate = appointmentDate.toLocalDate();
            LocalDate localCurrentDate = currentDate.toLocalDate();
            LocalDate oneDayBeforeCurrent = localCurrentDate.minusDays(1);

            if (localAppointmentDate.isBefore(oneDayBeforeCurrent)) {
                throw new IllegalArgumentException("Ngày hẹn không được trước ngày hiện tại.");
            }

            OrderDAO dao = new OrderDAO();

            int orderId = dao.createOrder(fullName, email, phone, address, appointmentDate,
                    price, paymentStatus, orderStatus, paymentMethod, carType, description);

            if (user != null) {
                dao.updateOrderUser(orderId, user);

                //NOTIFICATION ORDER MOI
                UserDAO userDAO = new UserDAO();
                NotificationDAO notificationDAO = new NotificationDAO();

                //                        NOTIFICATION
                List<User> users = userDAO.getAllUser();
                for (int i = 0; i < users.size(); i++) {
                    String message = "Người dùng " + user.getUsername() + " vừa thêm đơn hàng mới";
                    if (users.get(i).getUserRole().equals("manager") || users.get(i).getUserRole().equals("repairer")) {
                        NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                        if (notiSetting.isEmail() && notiSetting.isOrderChange()) {
                            SendMailService.sendNotification(users.get(i).getEmail(), message);
                        }
                        int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Order Change");
                    }
                    if (users.get(i).getId() == user.getId()) {
                        message = "Bạn đã thêm một đơn hàng mới";
                        NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                        if (notiSetting.isEmail() && notiSetting.isOrderChange()) {
                            SendMailService.sendNotification(users.get(i).getEmail(), message);
                        }
                        int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Order Change");
                    }
                }
                ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(user.getId());
                NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(user.getId());
                if (!notiSetting.isProfile()) {
                    for (int i = notifications.size() - 1; i >= 0; i--) {
                        if (notifications.get(i).getType().equals("Profile")) {
                            notifications.remove(i);
                        }
                    }
                }

                if (!notiSetting.isOrderChange()) {
                    for (int i = notifications.size() - 1; i >= 0; i--) {
                        if (notifications.get(i).getType().equals("Order Change")) {
                            notifications.remove(i);
                        }
                    }
                }

                if (!notiSetting.isAttendance()) {
                    for (int i = notifications.size() - 1; i >= 0; i--) {
                        if (notifications.get(i).getType().equals("Attendance")) {
                            notifications.remove(i);
                        }
                    }
                }

                if (!notiSetting.isService()) {
                    for (int i = notifications.size() - 1; i >= 0; i--) {
                        if (notifications.get(i).getType().equals("Service")) {
                            notifications.remove(i);
                        }
                    }
                }

                if (!notiSetting.isInsurance()) {
                    for (int i = notifications.size() - 1; i >= 0; i--) {
                        if (notifications.get(i).getType().equals("Insurance")) {
                            notifications.remove(i);
                        }
                    }
                }

                session.setAttribute("notification", notifications);
                session.setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION
            }

            request.setAttribute("currentOrderId", orderId);
            request.setAttribute("appointmentDate", appointmentDate);
            request.getRequestDispatcher("/views/order/success.jsp").forward(request, response);
            return;
        } catch (Exception e) {
            if (e.getMessage() != null && !e.getMessage().isEmpty()) {
                request.setAttribute("message", "Lỗi: " + e.getMessage());
            }
            request.getRequestDispatcher("/views/order/order.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
