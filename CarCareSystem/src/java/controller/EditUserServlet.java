/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

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
 * @author GIGABYTE
 */
@WebServlet(name="EditUserServlet", urlPatterns={"/admin/editUser"})
public class EditUserServlet extends HttpServlet {
   
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
            out.println("<title>Servlet EditUserServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditUserServlet at " + request.getContextPath () + "</h1>");
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
    private UserDAO uDao = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (User) (session != null ? session.getAttribute("user") : null);
        if (currentUser == null || !currentUser.getUserRole().equalsIgnoreCase("admin")) {
            response.sendRedirect(request.getContextPath() + "/filterPage.jsp");
            return;
        }
        
        int id = Integer.parseInt(request.getParameter("id"));
        User user = uDao.getUserById(id);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/admin/editUser.jsp").forward(request, response);
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
        HttpSession session = request.getSession(false);
        User currentUser = (User) (session != null ? session.getAttribute("user") : null);
        if (currentUser == null || !currentUser.getUserRole().equalsIgnoreCase("admin")) {
            response.sendRedirect(request.getContextPath() + "/filterPage.jsp");
            return;
        }
        
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("userRole");

        String error = null;
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$";
        String phoneRegex = "^0\\d{9}$";

        User existingUser = uDao.getUserById(id);
        
        if (username.length() > 50) {
            error = "Username quá dài!";
        } else if (!email.matches(emailRegex)) {
            error = "Email không hợp lệ!";
        } else if (!email.equals(existingUser.getEmail()) && uDao.isEmailTaken(email)) {
            error = "Email đã tồn tại!";
        } else if (email.length() > 100) {
            error = "Email quá dài!";
        } else if (!phone.matches(phoneRegex)) {
            error = "Số điện thoại không hợp lệ! (phải bắt đầu bằng 0 và có 10 chữ số)";
        } else if (!phone.equals(existingUser.getPhone()) && uDao.isPhoneTaken(phone)) {
            error = "Số điện thoại đã tồn tại!";
        } else if (phone.length() > 20) {
            error = "Số điện thoại quá dài!";
        } else if (address.length() > 200) {
            error = "Địa chỉ quá dài!";
        }

        if (error != null) {
            request.setAttribute("errorMessage", error);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("userRole", role);
            request.setAttribute("user", existingUser);
            
            request.getRequestDispatcher("/admin/editUser.jsp").forward(request, response);
            return;
        }
        
        User user = new User(id, username, "", email, phone, address, null, role);
        uDao.updateUser(user);
        request.getSession().setAttribute("message", "Cập nhật user thành công!");
        response.sendRedirect(request.getContextPath() + "/admin/userList");
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
