/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.order;

import dao.OrderDAO;
import dao.PartDAO;
import dao.ServiceDAO;
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
        String paymentMethod = request.getParameter("paymentMethod");
        String[] serviceIds = request.getParameterValues("serviceIds");
        String[] partIds = request.getParameterValues("partIds");

        
        try {
            java.sql.Date appointmentDate = java.sql.Date.valueOf(appointmentDateStr);
            java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());

            if (appointmentDate.before(currentDate)) {
                throw new IllegalArgumentException("Ngày hẹn phải sau hoặc bằng ngày hiện tại.");
            }

            double price = 0.0;
            String paymentStatus = "Chưa thanh toán";
            String orderStatus = "Chưa xác nhận";           

            OrderDAO dao = new OrderDAO();
            ServiceDAO serviceDAO = new ServiceDAO();
            PartDAO partDAO = new PartDAO();

            if (serviceIds != null) {
                for (String sid : serviceIds) {
                    if (sid != null && !sid.trim().isEmpty()) {
                        int serviceId = Integer.parseInt(sid);

                        Service service = serviceDAO.getServiceDetail(serviceId);
            
                        if (service != null) {
                            double totalServicePrice = service.getPrice();
                            if (service.getParts() != null) {
                                for (Part part : service.getParts()) {
                                    totalServicePrice += part.getPrice();
                                }
                            }
                
                            price += totalServicePrice;
                        }
                    }
                }
            }

            if (partIds != null) {
                for (String pid : partIds) {
                    if (pid != null && !pid.trim().isEmpty()) {
                        int partId = Integer.parseInt(pid);
                        double partPrice = partDAO.getPriceById(partId);
                        price += partPrice;
                    }
                }
            }
            
            int orderId = dao.createOrder(fullName, email, phone, address, carTypeId,
                                  appointmentDate, price, paymentStatus, orderStatus, paymentMethod);
            
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
            
            if ("Chuyển khoản ngân hàng".equals(paymentMethod)) {
                session.setAttribute("currentOrderId", orderId);
                session.setAttribute("appointmentDate", appointmentDate);
                session.setAttribute("totalPrice", price);
                session.setAttribute("paymentStatus", paymentStatus);
                request.getRequestDispatcher("/views/order/payment.jsp").forward(request, response);
            } else {
                request.setAttribute("currentOrderId", orderId);
                request.setAttribute("appointmentDate", appointmentDate);
                request.setAttribute("totalPrice", price);
                request.setAttribute("paymentStatus", paymentStatus);
                request.getRequestDispatcher("/views/order/success.jsp").forward(request, response);
            }
            return;
        } catch (Exception e) {
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
