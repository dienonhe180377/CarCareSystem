/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import dao.UserDAO;
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
@WebServlet(name="VerifyRequestServlet", urlPatterns={"/verifyRequest"})
public class VerifyRequestServlet extends HttpServlet {
   
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
        String enteredOtp = request.getParameter("otp");
        String newPassword = request.getParameter("newPassword");

        HttpSession session = request.getSession();
        String sessionOtp = (String) session.getAttribute("otp");
        String email = (String) session.getAttribute("email");

        if (!enteredOtp.equals(sessionOtp)) {
            request.setAttribute("error", "OTP không đúng!");
            request.getRequestDispatcher("/views/auth/verify-request-otp.jsp").forward(request, response);
            return;
        }
        
        if (!isValidPassword(newPassword)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, chữ cái đầu viết hoa và chứa ký tự đặc biệt.");
            request.getRequestDispatcher("/views/auth/verify-request-otp.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        dao.updatePassword(email, newPassword);

        session.removeAttribute("otp");
        session.removeAttribute("email");

        request.setAttribute("message", "Mật khẩu đã được thay đổi thành công!");
        request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);

    }
    
    private boolean isValidPassword(String password) {
        String regex = "^[A-Z][A-Za-z0-9!@#$%^&*()_+=<>?{}\\[\\]-]{7,}$";
        return password != null && password.matches(regex);
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
