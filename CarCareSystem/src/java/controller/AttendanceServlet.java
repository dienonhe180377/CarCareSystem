package controller;

import dao.AttendanceDAO;
import entity.Attendance;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

@WebServlet(name = "AttendanceServlet", urlPatterns = {"/attendance"})
public class AttendanceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AttendanceDAO dao = new AttendanceDAO();
        User currentUser = (User) request.getSession().getAttribute("user");

        // Nếu chưa đăng nhập thì chuyển về trang login
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = currentUser.getUserRole();
        String method = request.getMethod();
        String action = request.getParameter("action");

        // ======== 1. Hiển thị danh sách điểm danh ========
        if ("list".equalsIgnoreCase(action)) {
    String dateParam = request.getParameter("date");
    Vector<Attendance> attendanceList;

    if (dateParam != null && !dateParam.trim().isEmpty()) {
        try {
            java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateParam);
            Date selectedDate = new Date(utilDate.getTime());

            attendanceList = dao.getAttendanceByDate(selectedDate);
            request.setAttribute("selectedDate", dateParam);
        } catch (Exception e) {
            attendanceList = dao.getAllAttendance("SELECT * FROM Attendance ORDER BY date DESC");
            request.setAttribute("error", "Sai định dạng ngày! Định dạng đúng: yyyy-MM-dd");
        }
    } else {
        attendanceList = dao.getAllAttendance("SELECT * FROM Attendance ORDER BY date DESC");
    }

    request.setAttribute("attendanceList", attendanceList);
    Map<Integer, String> userMap = new HashMap<>();
for (User user : dao.getAllUsersForAttendance()) {
    userMap.put(user.getId(), user.getUsername());
}
request.setAttribute("userMap", userMap);
    request.getRequestDispatcher("Attendance/listAttendance.jsp").forward(request, response);
    return;
}

        // ======== 2. Trang điểm danh hôm nay (GET) ========
        if ("GET".equalsIgnoreCase(method)) {

            if ("admin".equals(role) || "manager".equals(role)) {
                Vector<User> users = dao.getAllUsersForAttendance();
                Map<Integer, Boolean> todayStatus = new HashMap<>();
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

        } else if ("POST".equalsIgnoreCase(method)) {
            // ======== Manager gửi điểm danh hôm nay ========
            if ("manager".equals(role)) {
                Vector<User> users = dao.getAllUsersForAttendance();
                Date today = new Date(System.currentTimeMillis());

                for (User user : users) {
                    String statusParam = request.getParameter("status_" + user.getId());
                    boolean status = "present".equals(statusParam);
                    Attendance existing = dao.getAttendanceByUserIdAndDate(user.getId(), today);

                    if (existing == null) {
                        dao.addAttendance(new Attendance(user.getId(), today, status));
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
