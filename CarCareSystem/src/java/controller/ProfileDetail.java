package controller;

import dao.NotificationDAO;
import dao.UserDAO;
import entity.Notification;
import entity.NotificationSetting;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.SendMailService;

@WebServlet(name = "ProfileDetail", urlPatterns = {"/profileDetail"})
public class ProfileDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(sessionUser.getId());
        request.setAttribute("user", user);
        request.getRequestDispatcher("profileDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("login");
                return;
            }
            User sessionUser = (User) session.getAttribute("user");
            int id = sessionUser.getId();
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            User user = new User();
            user.setId(id);
            user.setUsername(username);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);

            UserDAO userDAO = new UserDAO();
            userDAO.updateUser(user);

            // Cập nhật lại session nếu cần
            session.setAttribute("user", userDAO.getUserById(id));

            response.sendRedirect("viewProfile");
        } catch (Exception ex) {
            Logger.getLogger(ProfileDetail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Profile detail edit and update";
    }
}
