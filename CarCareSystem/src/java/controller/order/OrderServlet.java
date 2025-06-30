/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.order;

import dao.OrderDAO;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;




/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name="OrderServlet", urlPatterns={"/order"})
public class OrderServlet extends HttpServlet {
   
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
            out.println("<title>Servlet OrderServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderServlet at " + request.getContextPath () + "</h1>");
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
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String fullName = user != null ? user.getUsername() : request.getParameter("fullName");
        String email = user != null ? user.getEmail() : request.getParameter("email");
        String phone = user != null ? user.getPhone() : request.getParameter("phone");
        String address = user != null ? user.getAddress() : request.getParameter("address");
        
        String carTypeIdStr = request.getParameter("carTypeId");
        if (carTypeIdStr == null || carTypeIdStr.trim().isEmpty()) {
            request.setAttribute("message", "Vui lòng chọn loại xe.");
            request.getRequestDispatcher("/views/order/order.jsp").forward(request, response);
            return;
        }

        int carTypeId = Integer.parseInt(carTypeIdStr);
        
        String appointmentDateStr = request.getParameter("appointmentDate");
        String paymentStatus = request.getParameter("paymentStatus");
        String[] serviceIds = request.getParameterValues("serviceIds");
        String[] partIds = request.getParameterValues("partIds");

        
        try {
            appointmentDateStr = appointmentDateStr.replace("T", " ") + ":00";
            Timestamp appointmentTimestamp = Timestamp.valueOf(appointmentDateStr);

            if (appointmentTimestamp.before(new Timestamp(System.currentTimeMillis()))) {
                throw new IllegalArgumentException("Ngày hẹn phải sau thời gian hiện tại.");
            }

            double price = 0.0;
            String orderStatus = "Chưa xác nhận";

            OrderDAO dao = new OrderDAO();
            int orderId = dao.createOrder(fullName, email, phone, address, carTypeId,
                                          appointmentTimestamp, price, paymentStatus, orderStatus);

            if (serviceIds != null) {
                for (String sid : serviceIds) {
                    if (sid != null && !sid.trim().isEmpty()) {
                        dao.addServiceToOrder(orderId, Integer.parseInt(sid));
                    }
                }
            }

            if (partIds != null) {
                for (String pid : partIds) {
                    if (pid != null && !pid.trim().isEmpty()) {
                        dao.addPartToOrder(orderId, Integer.parseInt(pid));
                    }
                }
            }

            request.setAttribute("message", "Đặt lịch thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Lỗi: " + e.getMessage());
        }
        request.getRequestDispatcher("/views/order/order.jsp").forward(request, response);
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
