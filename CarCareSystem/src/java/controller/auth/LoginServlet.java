/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import dao.UserDAO;
import entity.User;
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
@WebServlet(name="LoginServlet", urlPatterns={"/login"})
public class LoginServlet extends HttpServlet {
   
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
        // Lấy username & password từ request
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Kiểm tra nếu không nhập username/password (truy cập lần đầu)
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        User userA = userDAO.authenticationUserLogin(username, password);
        
        if (userA == null) {
            // Đăng nhập thất bại, hiển thị lỗi
            request.setAttribute("error", "Thông tin đăng nhập không hợp lệ!");
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
        } else {
            // Đăng nhập thành công -> Xử lý session
            HttpSession session = request.getSession(false); // Không tạo mới session nếu chưa có
            if (session != null) {
                session.invalidate(); // Xóa session cũ để tránh lỗi session trước đó
            }
            session = request.getSession(true); // Tạo session mới

            // Lưu thông tin user vào session
            session.setAttribute("user", userA);
            session.setAttribute("roleID", userA.getUserRole()); // Lưu role vào session để Filter kiểm tra

            // Điều hướng theo quyền
            if (userA.getUserRole() == 6) {
                response.sendRedirect("home"); // User               
            } else {
                response.sendRedirect("admin"); // Admin
            }
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
