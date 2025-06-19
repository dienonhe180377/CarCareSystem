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
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        User sessionUser = (User) session.getAttribute("user");
        int userId = sessionUser.getId();

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        UserDAO userDAO = new UserDAO();
        boolean usernameExists = userDAO.isUsernameExists(username, userId);
        boolean emailExists = userDAO.isEmailExists(email, userId);
        boolean phoneExists = userDAO.isPhoneExists(phone, userId);

        String errorMsg = null;
        if (usernameExists) {
            errorMsg = "Tên đăng nhập đã tồn tại!";
        } else if (emailExists) {
            errorMsg = "Email đã tồn tại!";
        } else if (phone != null && !phone.isEmpty() && phoneExists) {
            errorMsg = "Số điện thoại đã tồn tại!";
        }

        if (errorMsg != null) {
            User user = userDAO.getUserById(userId);
            request.setAttribute("user", user);
            request.setAttribute("error", errorMsg);
            request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
            return;
        }

        // Nếu không trùng, cập nhật thông tin
        User user = userDAO.getUserById(userId);
        user.setUsername(username);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        userDAO.updateUser(user);

        // Cập nhật lại session
        session.setAttribute("user", user);
        request.setAttribute("user", user);
        request.setAttribute("success", "Cập nhật thành công!");
        request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
    }
}