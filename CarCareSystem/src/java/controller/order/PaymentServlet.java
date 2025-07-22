/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.order;

import dao.OrderDAO;
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

/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name="PaymentServlet", urlPatterns={"/payment"})
public class PaymentServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet PaymentServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        processRequest(request, response);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            request.setAttribute("message", "Thiếu thông tin đơn hàng");
            request.getRequestDispatcher("/views/order/payment.jsp").forward(request, response);
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdParam);
            OrderDAO dao = new OrderDAO();
            Order order = dao.getOrderById(orderId);
            if (order == null) {
                request.setAttribute("message", "Không tìm thấy đơn hàng với ID: " + orderId);
                request.getRequestDispatcher("/views/order/payment.jsp").forward(request, response);
                return;
            }
            
            boolean hasPermission = false;
        
            if (user != null) {
                hasPermission = order.getEmail().equalsIgnoreCase(user.getEmail());
            } else {
                Integer sessionOrderId = (Integer) session.getAttribute("currentOrderId");
                hasPermission = sessionOrderId != null && sessionOrderId == orderId;
            }
        
            if (!hasPermission) {
                request.setAttribute("message", "Bạn không có quyền thanh toán đơn này");
                request.getRequestDispatcher("/views/order/payment.jsp").forward(request, response);
                return;
            }
            
            boolean success = dao.updatePaymentStatus(orderId, "Đã thanh toán");
            
            if (success) {
                request.setAttribute("currentOrderId", orderId);
                request.setAttribute("appointmentDate", order.getAppointmentDate());
                request.setAttribute("totalPrice", order.getPrice());
                request.setAttribute("paymentStatus", "Đã thanh toán");
                
                request.getRequestDispatcher("/views/order/success.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Cập nhật thanh toán thất bại");
                request.getRequestDispatcher("/views/order/payment.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("message", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/views/order/payment.jsp").forward(request, response);
        }
    }
    
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
