/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.repairer;

import dao.NotificationDAO;
import dao.OrderDAO;
import dao.PartDAO;
import dao.ServiceDAO;
import dao.UserDAO;
import dao.WorkDAO;
import entity.Notification;
import entity.NotificationSetting;
import entity.Order;
import entity.Part;
import entity.Service;
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
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import util.SendMailService;

/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name = "OrderRepairServlet", urlPatterns = {"/order_repair"})
public class OrderRepairServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private ServiceDAO serviceDAO = new ServiceDAO();
    private PartDAO partDAO = new PartDAO();
    private WorkDAO workDAO = new WorkDAO();

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
            out.println("<title>Servlet OrderRepairServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderRepairServlet at " + request.getContextPath() + "</h1>");
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
        try {

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null || !user.getUserRole().equals("repairer")) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            String status = request.getParameter("status");
            String searchQuery = request.getParameter("search");
            ArrayList<Order> orders;

            if (searchQuery != null && !searchQuery.isEmpty()) {
                orders = workDAO.searchOrdersAssignedToRepairer(user.getId(), searchQuery);
            } 
            if (status != null && !status.trim().isEmpty()) {
                orders = workDAO.getOrdersByStatusAssignedToRepairer(user.getId(), status);
            } else {
                orders = workDAO.getOrdersByStatusAssignedToRepairer(user.getId(), "received");
            }

            request.setAttribute("orders", orders);

            Vector<Service> allServices = serviceDAO.getAllService();
            ArrayList<Part> allParts = partDAO.getAllParts();

            request.setAttribute("allServices", allServices);
            request.setAttribute("allParts", allParts);

            request.getRequestDispatcher("/views/repairer/order_management.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/views/repairer/order_management.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");

        try {
            int orderId = Integer.parseInt(orderIdStr);

            if ("updateServices".equals(action)) {
                handleUpdateServices(request, response, orderId);
            } else if ("updateParts".equals(action)) {
                handleUpdateParts(request, response, orderId);
            } else if ("updateStatus".equals(action)) {
                handleUpdateStatus(request, response, orderId);

                //NOTIFICATION CAP NHAT TRANG THAI DON HANG
                UserDAO userDAO = new UserDAO();
                NotificationDAO notificationDAO = new NotificationDAO();
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("user");

                //                        NOTIFICATION
                List<User> users = userDAO.getAllUser();
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
            response.sendRedirect(request.getContextPath() + "/order_repair");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/views/repairer/order_management.jsp").forward(request, response);
        }
    }

    private void handleUpdateServices(HttpServletRequest request, HttpServletResponse response, int orderId) throws Exception {
        Order currentOrder = orderDAO.getOrderById(orderId);

        if (currentOrder.getOrderStatus().equals("done")
                || currentOrder.getOrderStatus().equals("returned")) {
            request.getSession().setAttribute("error", "Không thể cập nhật dịch vụ cho đơn hàng đã hoàn thành sửa chữa hoặc đã trả xe");
            response.sendRedirect(request.getContextPath() + "/order_repair");
            return;
        }
        String[] selectedServiceIds = request.getParameterValues("serviceIds");

        ArrayList<Service> currentServices = currentOrder.getServices();

        ArrayList<Integer> currentServiceIds = new ArrayList<>();
        for (Service service : currentServices) {
            currentServiceIds.add(service.getId());
        }

        if (selectedServiceIds != null) {
            for (String serviceIdStr : selectedServiceIds) {
                int serviceId = Integer.parseInt(serviceIdStr);
                if (!currentServiceIds.contains(serviceId)) {
                    orderDAO.addServiceToOrder(orderId, serviceId);
                }
            }

            for (Integer existingId : currentServiceIds) {
                boolean stillSelected = false;
                for (String selectedIdStr : selectedServiceIds) {
                    if (existingId == Integer.parseInt(selectedIdStr)) {
                        stillSelected = true;
                        break;
                    }
                }
                if (!stillSelected) {
                    orderDAO.removeServiceFromOrder(orderId, existingId);
                }
            }
        } else {
            orderDAO.removeAllServicesFromOrder(orderId);
        }
        updateOrderPrice(orderId);
        request.getSession().setAttribute("message", "Cập nhật dịch vụ thành công!");
    }

    private void handleUpdateParts(HttpServletRequest request, HttpServletResponse response, int orderId) throws Exception {
        Order currentOrder = orderDAO.getOrderById(orderId);

        if (currentOrder.getOrderStatus().equals("done")
                || currentOrder.getOrderStatus().equals("returned")) {
            request.getSession().setAttribute("error", "Không thể cập nhật phụ tùng cho đơn hàng đã hoàn thành sửa chữa hoặc đã trả xe");
            response.sendRedirect(request.getContextPath() + "/order_repair");
            return;
        }
        String[] selectedPartIds = request.getParameterValues("partIds");

        ArrayList<Part> currentParts = currentOrder.getParts();

        ArrayList<Integer> currentPartIds = new ArrayList<>();
        for (Part part : currentParts) {
            currentPartIds.add(part.getId());
        }

        if (selectedPartIds != null) {
            for (String partIdStr : selectedPartIds) {
                int partId = Integer.parseInt(partIdStr);
                if (!currentPartIds.contains(partId)) {
                    orderDAO.addPartToOrder(orderId, partId);
                }
            }

            for (Integer existingId : currentPartIds) {
                boolean stillSelected = false;
                for (String selectedIdStr : selectedPartIds) {
                    if (existingId == Integer.parseInt(selectedIdStr)) {
                        stillSelected = true;
                        break;
                    }
                }
                if (!stillSelected) {
                    orderDAO.removePartFromOrder(orderId, existingId);
                }
            }
        } else {
            orderDAO.removeAllPartsFromOrder(orderId);
        }

        updateOrderPrice(orderId);
        request.getSession().setAttribute("message", "Cập nhật phụ tùng thành công!");
    }

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response, int orderId) throws Exception {
        String newStatus = request.getParameter("newStatus");
        Order currentOrder = orderDAO.getOrderById(orderId);
        String currentStatus = currentOrder.getOrderStatus();

        // Define the allowed status progression
        Map<String, List<String>> allowedTransitions = new HashMap<>();
        allowedTransitions.put("received", Arrays.asList("fixing"));
        allowedTransitions.put("fixing", Arrays.asList("done"));
        allowedTransitions.put("done", Arrays.asList("returned"));
        allowedTransitions.put("returned", Collections.emptyList());

        // Check if the transition is allowed
        if (currentStatus == null || !allowedTransitions.containsKey(currentStatus)) {
            request.getSession().setAttribute("error", "Trạng thái hiện tại không hợp lệ: " + currentStatus);
            return;
        }

        if (newStatus != null && !newStatus.trim().isEmpty()) {
            boolean success = orderDAO.updateOrderStatus(orderId, newStatus);
            if (success) {
                request.getSession().setAttribute("message", "Cập nhật trạng thái thành công!");
            } else {
                request.getSession().setAttribute("error", "Không thể cập nhật trạng thái");
            }
        }
    }

    private void updateOrderPrice(int orderId) throws Exception {
        Order order = orderDAO.getOrderById(orderId);
        double newPrice = 0.0;

        for (Service service : order.getServices()) {
            newPrice += service.getPrice();

            if (service.getParts() != null) {
                for (Part part : service.getParts()) {
                    newPrice += part.getPrice();
                }
            }
        }

        for (Part part : order.getParts()) {
            boolean isPartOfService = false;
            for (Service service : order.getServices()) {
                if (service.getParts() != null && service.getParts().contains(part)) {
                    isPartOfService = true;
                    break;
                }
            }
            if (!isPartOfService) {
                newPrice += part.getPrice();
            }
        }
        orderDAO.updateOrderPrice(orderId, newPrice);
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
