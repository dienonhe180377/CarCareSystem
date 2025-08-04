/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.marketing;

import dao.EmployeeFeedbackDAO;
import dao.NotificationDAO;
import dao.OrderDAO;
import dao.UserDAO;
import dao.WorkDAO;
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
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
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
                orders = orderDAO.getOrdersByStatus("pending");
            } else if ("done".equals(action)) {
                orders = orderDAO.getOrdersByStatus("done");
            } else if ("paid".equals(action)) {
                orders = orderDAO.getOrdersByPaymentStatus("paid");
            } else if ("miss".equals(action)) {
                orders = orderDAO.getOrdersByStatus("missed");
            } else if ("complete".equals(action)) {
                orders = orderDAO.getCompletedOrders();
            } else {
                orders = orderDAO.getAllOrders();
            }

            if (request.getSession().getAttribute("user") != null) {
                User user = (User) request.getSession().getAttribute("user");
                if ("manager".equals(user.getUserRole())) {
                    UserDAO userDAO = new UserDAO();
                    List<User> repairers = userDAO.getUsersByRole("repairer");
                    request.setAttribute("repairers", repairers);
                }
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
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        try {
            Order order = orderDAO.getOrderById(orderId);
            if ("confirmPayment".equals(action)) {
                if ("unpaid".equals(order.getPaymentStatus())) {
                    String paymentMethod = request.getParameter("paymentMethod");
                    boolean paymentSuccess = orderDAO.updatePaymentStatus(orderId, "paid");
                    boolean statusSuccess = orderDAO.updateOrderStatus(orderId, "returned");
                    if (paymentSuccess && statusSuccess) {

                        //Notification xác nhận thanh toán
                        UserDAO userDAO = new UserDAO();
                        NotificationDAO notificationDAO = new NotificationDAO();
                        HttpSession session = request.getSession();
                        EmployeeFeedbackDAO feedbackDAO = new EmployeeFeedbackDAO();
                        User user = (User) session.getAttribute("user");

                        List<User> users = userDAO.getAllUser();

                        //Check Customer
                        for (int i = 0; i < users.size(); i++) {
                            if (users.get(i).getEmail().equals(order.getEmail())) {
                                orderDAO.updateOrderUser(orderId, users.get(i));
                            }
                        }

                        for (int i = 0; i < users.size(); i++) {
                            String message = "Đơn hàng số" + orderId + "đã được cập nhật trạng thái";
                            if (users.get(i).getUserRole().equals("manager") || users.get(i).getUserRole().equals("repairer")) {
                                NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                                if (notiSetting.isEmail() && notiSetting.isOrderChange()) {
                                    SendMailService.sendNotification(users.get(i).getEmail(), message);
                                }
                                int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Order Change");
                            }
                        }

                        if (orderDAO.getOrderById(orderId).getUser() != null) {
                            String message = "Đơn hàng đã được hoàn thiện và thanh toán";
                            NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(orderDAO.getOrderById(orderId).getUser().getId());
                            if (notiSetting.isEmail() && notiSetting.isOrderChange()) {
                                SendMailService.sendNotification(orderDAO.getOrderById(orderId).getUser().getEmail(), message);
                            }
                            int addNoti = notificationDAO.addNotification(orderDAO.getOrderById(orderId).getUser().getId(), message, "Order Change");
                            message = "Vui lòng để lại nhận xét để giúp dịch vụ chúng tôi cải thiện cho lần sau";
                            notificationDAO.addNotification(orderDAO.getOrderById(orderId).getUser().getId(), message, "Feedback");
                            Order orderForRating = orderDAO.getOrderById(orderId);
                            int repairerId = feedbackDAO.getRepairerIdByOrderId(orderId);
                            feedbackDAO.addRepairerFeedback(orderForRating.getUser().getId(), repairerId, orderId, 0, "", false);
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

                        request.getSession().setAttribute("message", "Đã đổi thanh toán thành công!");
                    } else {
                        request.getSession().setAttribute("error", "Đổi thanh toán thất bại!");
                    }
                }
            }
            if ("reschedule".equals(action)) {
                String newDateStr = request.getParameter("newAppointmentDate");
                java.sql.Date newAppointmentDate = java.sql.Date.valueOf(newDateStr);

                boolean success = orderDAO.rescheduleOrder(orderId, newAppointmentDate);
                if (success) {
                    request.getSession().setAttribute("message", "Đã đổi lịch hẹn thành công!");
                } else {
                    request.getSession().setAttribute("error", "Đổi lịch hẹn thất bại!");
                }
            }
            if ("confirmReceived".equals(action)) {
                try {
                    if (!"pending".equals(order.getOrderStatus())) {
                        request.getSession().setAttribute("error", "Chỉ có thể nhận xe với đơn hàng ở trạng thái chờ");
                        response.sendRedirect(request.getContextPath() + "/ordermanagement");
                        return;
                    }

                    String receivedDateStr = request.getParameter("receivedDate");
                    java.sql.Date receivedDate = java.sql.Date.valueOf(receivedDateStr);

                    int repairerId = Integer.parseInt(request.getParameter("repairerId"));

                    boolean statusUpdated = orderDAO.updateOrderStatus(orderId, "received");
                    if (!statusUpdated) {
                        throw new Exception("Không thể cập nhật trạng thái đơn hàng");
                    }

                    WorkDAO workDAO = new WorkDAO();
                    int workId = workDAO.createWork(orderId, repairerId, receivedDate);

                    if (workId <= 0) {
                        throw new Exception("Không thể tạo công việc mới");
                    }

                    //NOTIFICATION NHAN XE
                    UserDAO userDAO = new UserDAO();
                    NotificationDAO notificationDAO = new NotificationDAO();
                    HttpSession session = request.getSession();
                    User user = (User) session.getAttribute("user");
                    List<User> users = userDAO.getAllUser();
                    //                        NOTIFICATION

                    for (int i = 0; i < users.size(); i++) {
                        String message = "Đơn hàng số" + orderId + "đã nhận được xe";
                        if (users.get(i).getUserRole().equals("manager") || users.get(i).getUserRole().equals("repairer")) {
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

                    request.getSession().setAttribute("message", "Nhận xe thành công!");

                } catch (Exception e) {
                    request.getSession().setAttribute("error", "Lỗi khi nhận xe: " + e.getMessage());
                    e.printStackTrace();
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
