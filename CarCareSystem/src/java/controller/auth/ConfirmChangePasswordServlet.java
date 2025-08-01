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

/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name="ConfirmChangePasswordServlet", urlPatterns={"/confirmchangepass"})
public class ConfirmChangePasswordServlet extends HttpServlet {
   
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
        String otpInput = request.getParameter("otpInput");
        String sessionOtp = (String) session.getAttribute("otp");
        String newPassword = (String) session.getAttribute("newPassword");
        
        User user = (User) session.getAttribute("user");
        
         if (!otpInput.equals(sessionOtp)) {
            request.setAttribute("error", "OTP không chính xác. Vui lòng thử lại.");
            request.getRequestDispatcher("/views/auth/verify-change-otp.jsp").forward(request, response);
            return;
        }
         
        String email = user.getEmail();
        
        UserDAO dao = new UserDAO();
        dao.updatePassword(email, newPassword);
        request.setAttribute("message", "Mật khẩu đã được thay đổi thành công!");
        session.removeAttribute("otp");
        session.removeAttribute("newPassword");
        response.sendRedirect(request.getContextPath() + "/home");
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
