/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import dao.UserDAO;
import entity.User;
import util.SendMailService;
import java.io.IOException;
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
@WebServlet(name="RegisterServlet", urlPatterns={"/register"})
public class RegisterServlet extends HttpServlet {
   
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
        String userName = request.getParameter("username");
        String passWord = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
         // Validate input
        UserDAO udao = new UserDAO();
        if (userName == null || userName.isEmpty() || passWord == null || passWord.isEmpty() || email == null || email.isEmpty() || phone == null || phone.isEmpty() || address == null || address.isEmpty()) {
            request.setAttribute("username", userName);
            request.setAttribute("password", passWord);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }
        
        // Check if user already exists
        User user = udao.checkUserExistByUserName(userName);
        if(user != null){
            request.setAttribute("error", "User đã tồn tại!!!");
            request.getRequestDispatcher("views/auth/register.jsp").forward(request, response);
            return;
        }
        
        if (!isValidPassword(passWord)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, chữ cái đầu viết hoa và chứa ký tự đặc biệt.");
            request.getRequestDispatcher("views/auth/register.jsp").forward(request, response);
            return;
        }
        
        user = udao.checkUserExistByEmail(email);
        if(user != null){
            request.setAttribute("error", "Email đã tồn tại!!!");
            request.getRequestDispatcher("views/auth/register.jsp").forward(request, response);
            return;
        }
        
        user = udao.checkUserExistByPhone(phone);
        if(user != null){
            request.setAttribute("error", "Phone đã tồn tại!!!");
            request.getRequestDispatcher("views/auth/register.jsp").forward(request, response);
            return;
        }
        
        // Tạo OTP
        String otp = String.valueOf((int)(Math.random() * 900000 + 100000)); // 6 chữ số
        
        // Lưu thông tin tạm vào session
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("username", userName);
        session.setAttribute("password", passWord);
        session.setAttribute("email", email);
        session.setAttribute("phone", phone);
        session.setAttribute("address", address);
        
        // Gửi email
        boolean sent = SendMailService.sendOTP(email, otp);
        if (sent) {
            request.setAttribute("message", "Mã OTP đã được gửi đến email của bạn.");
            request.getRequestDispatcher("/views/auth/verify-register-otp.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Không thể gửi OTP đến email của bạn.");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
        }
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
