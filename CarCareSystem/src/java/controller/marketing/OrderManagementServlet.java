/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.marketing;

import dao.NotificationDAO;
import dao.OrderDAO;
import dao.UserDAO;
import entity.Notification;
import entity.NotificationSetting;
import entity.Order;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.sql.*;
import java.util.List;
import util.SendMailService;

/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name = "OrderManagementServlet", urlPatterns = {"/ordermanagement"})
public class OrderManagementServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

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
            out.println("<title>Servlet OrderManagementServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderManagementServlet at " + request.getContextPath() + "</h1>");
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
//        processRequest(request, response);
        orderDAO.checkAndUpdateMissedAppointments();
        String action = request.getParameter("action");
        String searchQuery = request.getParameter("search");

        try {
            ArrayList<Order> orders;

            if (searchQuery != null && !searchQuery.isEmpty()) {
                orders = orderDAO.searchOrders(searchQuery);
            } else if ("unconfirmed".equals(action)) {
                orders = orderDAO.getOrdersByStatus("Chưa xác nhận");
            } else if ("unpaid".equals(action)) {
                orders = orderDAO.getOrdersByPaymentStatus("Chưa thanh toán");
            } else if ("paid".equals(action)) {
                orders = orderDAO.getOrdersByPaymentStatus("Đã thanh toán");
            } else if ("miss".equals(action)) {
                orders = orderDAO.getOrdersByStatus("Lỡ hẹn");
            } else {
                orders = orderDAO.getAllOrders();
            }

            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/views/marketing/ordermanagement.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/views/marketing/ordermanagement.jsp").forward(request, response);
        }
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
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");

        try {
            int orderId = Integer.parseInt(orderIdStr);

            if ("reschedule".equals(action)) {
                String newDateStr = request.getParameter("newAppointmentDate");
                java.sql.Date newAppointmentDate = java.sql.Date.valueOf(newDateStr);

                boolean success = orderDAO.rescheduleOrder(orderId, newAppointmentDate);
                if (success) {
                    request.getSession().setAttribute("message", "Đã đổi lịch hẹn thành công!");
                } else {
                    request.getSession().setAttribute("error", "Đổi lịch hẹn thất bại!");
                }
            } else if ("confirmReceived".equals(action)) {
                Order order = orderDAO.getOrderById(orderId);
                java.sql.Date now = new java.sql.Date(System.currentTimeMillis());
                java.sql.Date appointmentDate = new java.sql.Date(order.getAppointmentDate().getTime());

                if (!appointmentDate.after(now)) {
                    boolean success = orderDAO.updateOrderStatus(orderId, "Đã Nhận Xe");

                    //NOTIFICATION NHAN XE
                    UserDAO userDAO = new UserDAO();
                    NotificationDAO notificationDAO = new NotificationDAO();
                    HttpSession session = request.getSession();
                    User user = (User) session.getAttribute("user");

                    //                        NOTIFICATION
                    List<User> users = userDAO.getAllUser();
                    for (int i = 0; i < users.size(); i++) {
                        String message = "Đơn hàng số" + orderId + "đã nhận được xe";
                        if (users.get(i).getUserRole().equals("manager") || users.get(i).getUserRole().equals("repairer")) {
                            NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                            if (notiSetting.isEmail() && notiSetting.isOrderChange()) {
                                SendMailService.sendNotification(users.get(i).getEmail(), message);
                            }
                            int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Order Change");
                        }
                        if (users.get(i).getId() == user.getId()) {
                            message = message = "Đơn hàng số" + orderId + "đã nhận được xe";
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

                    if (!notiSetting.isCategory()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Category")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isSupplier()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Supplier")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isParts()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Part")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isSettingChange()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Setting Change")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isCarType()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Car Type")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isCampaign()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Campaign")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isBlog()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Blog")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isVoucher()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Voucher")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    session.setAttribute("notification", notifications);
                    session.setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION

                    if (success) {
                        request.getSession().setAttribute("message", "Cập nhật trạng thái thành công!");
                    } else {
                        request.getSession().setAttribute("error", "Cập nhật trạng thái thất bại!");
                    }
                } else {
                    request.getSession().setAttribute("error", "Chưa đến ngày hẹn, không thể xác nhận nhận xe!");
                }
            }

            response.sendRedirect(request.getContextPath() + "/ordermanagement");

        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/views/marketing/ordermanagement.jsp").forward(request, response);
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
