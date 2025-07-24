package controller;

import dao.AttendanceDAO;
import dao.NotificationDAO;
import dao.UserDAO;
import entity.Attendance;
import entity.Notification;
import entity.NotificationSetting;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.SendMailService;

@WebServlet(name = "AttendanceServlet", urlPatterns = {"/attendance"})
public class AttendanceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        AttendanceDAO dao = new AttendanceDAO();
        User currentUser = (User) request.getSession().getAttribute("user");
        
//NOTIFICATION
            UserDAO userDAO = new UserDAO();
            NotificationDAO notificationDAO = new NotificationDAO();
//NOTIFICATION

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
                
//                        NOTIFICATION
                    String message = "Điểm danh hệ thống vừa được sửa";

                    List<User> userList = userDAO.getAllUser();
                    for (int i = 0; i < userList.size(); i++) {
                        if (userList.get(i).getUserRole().equals("manager")) {
                            NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(userList.get(i).getId());
                            if (notiSetting.isEmail() && notiSetting.isSupplier()) {
                                SendMailService.sendNotification(userList.get(i).getEmail(), message);
                            }
                            int addNoti = notificationDAO.addNotification(userList.get(i).getId(), message, "Attendance");
                        }
                    }
                    ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(currentUser.getId());
                    NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(currentUser.getId());
                    if (!notiSetting.isProfile()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Profile")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isOrderChange()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Order Change")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isAttendance()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Attendance")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isService()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Service")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isInsurance()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Insurance")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isCategory()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Category")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isSupplier()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Supplier")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isParts()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Part")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isSettingChange()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Setting Change")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isCarType()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Car Type")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isCampaign()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Campaign")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isBlog()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Blog")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    if (!notiSetting.isVoucher()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Voucher")) {
                                notifications.remove(i);
                            }
                        }
                    }

                    request.getSession().setAttribute("notification", notifications);
                    request.getSession().setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION

                response.sendRedirect("attendance?success=1");
            } else {
                response.sendRedirect("attendance?error=permission");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(AttendanceServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(AttendanceServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
