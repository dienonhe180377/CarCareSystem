package controller;

import dao.NotificationDAO;
import dao.UserDAO;
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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import util.SendMailService;

@WebServlet(name = "ViewProfileServlet", urlPatterns = {"/viewProfile"})
public class ViewProfileServlet extends HttpServlet {

    private boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        return email != null && email.matches(emailRegex);
    }

    private boolean isValidUsername(String username) {
        // Chỉ cho phép chữ và số, không dấu cách, độ dài 4-20 ký tự
        String usernameRegex = "^[a-zA-Z0-9]{4,20}$";
        return username != null && username.matches(usernameRegex);
    }

    private boolean isValidPhone(String phone) {
        // Cho phép số Việt Nam hoặc quốc tế (+84...), độ dài 10-15 số, chỉ số hoặc dấu +
        if (phone == null || phone.trim().isEmpty()) {
            return true; // Không bắt buộc nhập
        }
        return phone.matches("^(\\+)?[0-9]{10,15}$");
    }

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
        // Chuyển đến trang xem thông tin tài khoản
        request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
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
            int userId = sessionUser.getId();

            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            UserDAO userDAO = new UserDAO();

            // ---------- VALIDATION ----------
            String errorMsg = null;
            if (username == null || username.trim().isEmpty()) {
                errorMsg = "Tên đăng nhập không được để trống!";
            } else if (!isValidUsername(username)) {
                errorMsg = "Tên đăng nhập chỉ gồm chữ, số và từ 4-20 ký tự. Không chứa dấu cách hoặc ký tự đặc biệt!";
            } else if (email == null || email.trim().isEmpty()) {
                errorMsg = "Email không được để trống!";
            } else if (!isValidEmail(email)) {
                errorMsg = "Email không hợp lệ!";
            } else if (!isValidPhone(phone)) {
                errorMsg = "Số điện thoại không hợp lệ. Nhập 10-15 số, có thể bắt đầu bằng dấu + (nếu là số quốc tế)!";
            } else {
                // Nếu hợp lệ định dạng mới kiểm tra trùng trong DB
                boolean usernameExists = userDAO.isUsernameExists(username, userId);
                boolean emailExists = userDAO.isEmailExists(email, userId);
                boolean phoneExists = userDAO.isPhoneExists(phone, userId);

                if (usernameExists) {
                    errorMsg = "Tên đăng nhập đã tồn tại!";
                } else if (emailExists) {
                    errorMsg = "Email đã tồn tại!";
                } else if (phone != null && !phone.isEmpty() && phoneExists) {
                    errorMsg = "Số điện thoại đã tồn tại!";
                }
            }

            if (errorMsg != null) {
                // Giữ lại dữ liệu user vừa nhập để trả lại form chỉnh sửa
                User user = userDAO.getUserById(userId);
                user.setUsername(username);
                user.setEmail(email);
                user.setPhone(phone);
                user.setAddress(address);
                request.setAttribute("user", user);
                request.setAttribute("error", errorMsg);
                // Chuyển về trang chỉnh sửa (profileDetail.jsp)
                request.getRequestDispatcher("profileDetail.jsp").forward(request, response);
                return;
            }

            // Nếu không lỗi, cập nhật thông tin
            User user = userDAO.getUserById(userId);
            user.setUsername(username);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAddress(address);
            userDAO.updateUser(user);

            //NOTIFICATION
            NotificationDAO notificationDAO = new NotificationDAO();

            NotificationSetting notiSetting;

            notiSetting = notificationDAO.getNotificationSettingById(user.getId());

            if (notiSetting.isEmail() && notiSetting.isProfile()) {
                SendMailService.sendNotification(user.getEmail(), "Thông tin cá nhân của bạn vừa được cập nhật ");
            }
            int addNoti = notificationDAO.addNotification(user.getId(), "Thông tin cá nhân của bạn vừa được cập nhật ", "Profile");

            ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(user.getId());
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

            session.setAttribute("notification", notifications);
            session.setAttribute("notiSetting", notiSetting);

            // Cập nhật lại session
            session.setAttribute("user", user);
            request.setAttribute("user", user);
            request.setAttribute("success", "Cập nhật thành công!");
            // Quay về trang xem thông tin tài khoản (viewProfile.jsp)
            request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ViewProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
