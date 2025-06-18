package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

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
    }

    @Override
    public String getServletInfo() {
        return "Profile detail edit and update";
    }
}