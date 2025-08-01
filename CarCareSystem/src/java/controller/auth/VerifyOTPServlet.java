/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import dao.NotificationDAO;
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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name="VerifyOTPServlet", urlPatterns={"/verifyOTP"})
public class VerifyOTPServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        String inputOtp = request.getParameter("otp");
        HttpSession session = request.getSession();
        String realOtp = (String) session.getAttribute("otp");

        if (realOtp != null && realOtp.equals(inputOtp)) {
            String username = (String) session.getAttribute("username");
            String password = (String) session.getAttribute("password");
            String email = (String) session.getAttribute("email");
            String phone = (String) session.getAttribute("phone");
            String address = (String) session.getAttribute("address");
            
            UserDAO dao = new UserDAO();
            dao.registerUser(username, password, email, phone, address);
            //Notification
            NotificationDAO notificationDAO = new NotificationDAO();
            User user = dao.getUserByEmail(email);
            notificationDAO.addNotificationSetting(user.getId(), true, true, true, true, true, false, true, true, true, true, true, true, true, true, true, true);
            int addNoti = notificationDAO.addNotification(user.getId(), "Bạn đã tạo tài khoản thành công", "Profile");

            session.invalidate();
            request.setAttribute("success", "Tạo tài khoản thành công!");
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "OTP không chính xác. Vui lòng thử lại.");
            request.getRequestDispatcher("/views/auth/verify-register-otp.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(VerifyOTPServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(VerifyOTPServlet.class.getName()).log(Level.SEVERE, null, ex);
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
