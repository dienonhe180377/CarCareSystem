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
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String orderIdParam = request.getParameter("orderId");
        
        try (PrintWriter out = response.getWriter()) {
            if (orderIdParam == null || orderIdParam.isEmpty()) {
                out.print("{\"success\":false,\"message\":\"Thiếu thông tin đơn hàng\"}");
                return;
            }
            
            int orderId = Integer.parseInt(orderIdParam);
            OrderDAO dao = new OrderDAO();
            Order order = dao.getOrderById(orderId);
            
            if (order == null) {
                out.print("{\"success\":false,\"message\":\"Không tìm thấy đơn hàng\"}");
                return;
            }
            
            // Kiểm tra quyền truy cập
            boolean hasPermission = checkPaymentPermission(user, session, order);
            if (!hasPermission) {
                out.print("{\"success\":false,\"message\":\"Bạn không có quyền thanh toán đơn này\"}");
                return;
            }
            
            
            boolean success = dao.updatePaymentStatus(orderId, "Đã thanh toán");
            
            if (success) {
                out.print("{\"success\":true,\"redirectUrl\":\"success.jsp?orderId=" + orderId + "\"}");
                
                session.removeAttribute("currentOrderId");
            } else {
                out.print("{\"success\":false,\"message\":\"Cập nhật thanh toán thất bại\"}");
            }
            
        } catch (Exception e) {
            response.getWriter().print("{\"success\":false,\"message\":\"Lỗi hệ thống: " + e.getMessage() + "\"}");
        }
        
    }
    
    private boolean checkPaymentPermission(User user, HttpSession session, Order order) {
        if (user != null) {
            return order.getEmail().equalsIgnoreCase(user.getEmail());
        } else {
            Integer sessionOrderId = (Integer) session.getAttribute("currentOrderId");
            return sessionOrderId != null && sessionOrderId == order.getId();
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
        processRequest(request, response);            
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
