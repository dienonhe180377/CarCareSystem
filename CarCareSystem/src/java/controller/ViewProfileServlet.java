package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name="ViewProfileServlet", urlPatterns={"/viewProfile"})
public class ViewProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        // Lấy user từ session
        User sessionUser = (User) session.getAttribute("user");
        // Lấy user đầy đủ thông tin từ DB
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserById(sessionUser.getId());

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        doGet(request, response);
    }
}