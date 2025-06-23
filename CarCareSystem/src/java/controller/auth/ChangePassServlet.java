/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import dao.UserDAO;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;
import util.SendMailService;

/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name="ChangePassServlet", urlPatterns={"/changepass"})
public class ChangePassServlet extends HttpServlet {
   
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
        User sessionUser = (User) session.getAttribute("user");

        if (sessionUser == null) {
            response.sendRedirect("login");
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.getUserByEmail(sessionUser.getEmail());

        String email = user.getEmail();
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra rỗng
        if (newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập mật khẩu mới và xác nhận.");
                request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
                return;
        }

        // Kiểm tra khớp
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu mới không khớp.");
            request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
            return;
        }

        // Gửi OTP
        String otp = String.valueOf(new Random().nextInt(900000) + 100000);
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);
        session.setAttribute("newPassword", newPassword);

        boolean sent = SendMailService.sendOTP(email, otp);
        if (!sent) {
            request.setAttribute("error", "Không thể gửi OTP đến email của bạn.");
            request.getRequestDispatcher("/views/auth/change-password.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Mã OTP đã được gửi. Vui lòng kiểm tra email.");
            request.getRequestDispatcher("/views/auth/verify-change-otp.jsp").forward(request, response);
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
