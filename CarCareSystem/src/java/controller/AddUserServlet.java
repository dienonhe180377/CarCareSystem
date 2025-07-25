/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author GIGABYTE
 */
@WebServlet(name = "AddUserServlet", urlPatterns = {"/admin/addUser"})
public class AddUserServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet AddUserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddUserServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
            response.sendRedirect(request.getContextPath() + "/accessDenied.jsp");
            return;
        }
        request.getRequestDispatcher("/admin/addUser.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
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
            response.sendRedirect(request.getContextPath() + "/accessDenied.jsp");
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        Date createDate = new Date();
        String role = request.getParameter("userRole");

        String error = null;
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$";
        String phoneRegex = "^0\\d{9}$";

        if (username.length() > 50) {
            error = "Username quá dài!";
        } else if (password.length() < 6) {
            error = "Mật khẩu phải có ít nhất 6 ký tự!";
        } else if (!email.matches(emailRegex)) {
            error = "Email không hợp lệ!";
        } else if (uDao.isEmailTaken(email)) {
            error = "Email đã tồn tại!";
        } else if (email.length() > 100) {
            error = "Email quá dài!";
        } else if (!phone.matches(phoneRegex)) {
            error = "Số điện thoại không hợp lệ! (phải bắt đầu bằng 0 và có 10 chữ số)";
        } else if (uDao.isPhoneTaken(phone)) {
            error = "Số điện thoại đã tồn tại!";
        } else if (phone.length() > 20) {
            error = "Số điện thoại quá dài!";
        } else if (address.length() > 200) {
            error = "Địa chỉ quá dài!";
        }

        if (error != null) {
            request.setAttribute("errorMessage", error);
            request.setAttribute("username", username);
            request.setAttribute("password", password);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("userRole", role);
            request.getRequestDispatcher("addUser.jsp").forward(request, response);
            return;
        }

        User newUser = new User(0, username, password, email, phone, address, createDate, role);

        boolean success = uDao.addUser(newUser);
        if (success) {

            //Notification
            NotificationDAO notificationDAO = new NotificationDAO();
            User user = uDao.getUserByEmail(email);
            try {
                notificationDAO.addNotificationSetting(user.getId(), true, true, true, true, true, false, true, true, true, true, true, true, true, true, true, true);
                int addNoti = notificationDAO.addNotification(user.getId(), "Bạn đã tạo tài khoản thành công", "Profile");
            } catch (Exception ex) {
                Logger.getLogger(AddUserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            request.getSession().setAttribute("message", "Thêm user thành công!");
            response.sendRedirect(request.getContextPath() + "/admin/userList");
        } else {
            error = "Thêm user thất bại!";
            request.setAttribute("errorMessage", error);
            request.getRequestDispatcher("admin/addUser.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
