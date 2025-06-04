/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AttendanceDAO;
import entity.Attendance;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.Vector;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "AttendanceServlet", urlPatterns = {"/attendance"})
public class AttendanceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AttendanceDAO dao = new AttendanceDAO();
        User currentUser = (User) request.getSession().getAttribute("user");
        if (currentUser == null) {
//            response.sendRedirect("login.jsp");
//            return;
//            currentUser = new User(1, "admin", "admin"); 
//            request.getSession().setAttribute("user", currentUser);
//            currentUser = new User(1, "testuser", "repairer");
//            request.getSession().setAttribute("user", currentUser);
        }
        String role = currentUser.getUserRoleStr();

        String method = request.getMethod();
        if (method.equalsIgnoreCase("GET")) {
            if ("admin".equals(role) || "manager".equals(role)) {
                Vector<User> users = dao.getAllUsersForAttendance();
                java.util.Map<Integer, Boolean> todayStatus = new java.util.HashMap<>();
                Date today = new Date(System.currentTimeMillis());
                for (User user : users) {
                    Attendance att = dao.getAttendanceByUserIdAndDate(user.getId(), today);
                    if (att != null) {
                        todayStatus.put(user.getId(), att.isStatus());
                    }
                }
                request.setAttribute("users", users);
                request.setAttribute("todayStatus", todayStatus);
                request.getRequestDispatcher("Attendance/Attendance.jsp").forward(request, response);
            } else {
                Vector<Attendance> myAttendance = dao.getAttendanceByUserId(currentUser.getId());
                request.setAttribute("myAttendance", myAttendance);
                request.getRequestDispatcher("Attendance/MyAttendance.jsp").forward(request, response);
            }
        } else if (method.equalsIgnoreCase("POST")) {
            if ("admin".equals(role) || "manager".equals(role)) {
                Vector<User> users = dao.getAllUsersForAttendance();
                Date today = new Date(System.currentTimeMillis());
                for (User user : users) {
                    String statusParam = request.getParameter("status_" + user.getId());
                    boolean status = "present".equals(statusParam);
                    Attendance existing = dao.getAttendanceByUserIdAndDate(user.getId(), today);
                    if (existing == null) {
                        Attendance att = new Attendance(user.getId(), today, status);
                        dao.addAttendance(att);
                    } else {
                        existing.setStatus(status);
                        dao.updateAttendance(existing);
                    }
                }
                response.sendRedirect("attendance?success=1");
            } else {
                response.sendRedirect("attendance?error=permission");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
