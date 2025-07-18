/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.order;

import dao.OrderDAO;
import entity.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import util.SendMailService;

/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name="OrderTrackingServlet", urlPatterns={"/ordertracking"})
public class OrderTrackingServlet extends HttpServlet {
   
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
            out.println("<title>Servlet OrderTrackingServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderTrackingServlet at " + request.getContextPath () + "</h1>");
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
//        processRequest(request, response);
        request.getRequestDispatcher("/views/order/tracking.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String nextStep = "email";
        String message = null;
        String error = null;

        try {
            if ("request-otp".equals(action)) {
                String email = request.getParameter("email");
                session.setAttribute("email", email);
                
                // Generate and send OTP
                String otp = String.format("%06d", (int) (Math.random() * 1000000));
                session.setAttribute("otp", otp);
                
                boolean sent = SendMailService.sendOTP(email, otp);
                
                if (sent) {
                    nextStep = "otp";
                    message = "Mã OTP đã được gửi đến email của bạn";
                } else {
                    error = "Gửi OTP thất bại. Vui lòng thử lại";
                }
                
            } else if ("verify-otp".equals(action)) {
                String userOtp = request.getParameter("otp");
                String sessionOtp = (String) session.getAttribute("otp");
                String email = (String) session.getAttribute("email");
                
                if (sessionOtp != null && sessionOtp.equals(userOtp)) {
                    // Retrieve orders by email
                    OrderDAO orderDAO = new OrderDAO();
                    List<Order> orders = orderDAO.getOrdersByEmail(email);
                    
                    session.setAttribute("orders", orders);
                    nextStep = "orders";
                    message = "Xác thực thành công!";
                } else {
                    nextStep = "otp";
                    error = "Mã OTP không đúng. Vui lòng thử lại";
                }
                
            } else if ("reset".equals(action)) {
                session.removeAttribute("email");
                session.removeAttribute("otp");
                session.removeAttribute("orders");
            }
        } catch (Exception e) {
            error = "Lỗi hệ thống: " + e.getMessage();
            nextStep = "email";
        }

        session.setAttribute("step", nextStep);
        session.setAttribute("message", message);
        session.setAttribute("error", error);
        response.sendRedirect("ordertracking");

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
