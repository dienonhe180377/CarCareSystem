/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.auth;

import dao.NotificationDAO;
import dao.UserDAO;
import entity.Notification;
import entity.NotificationSetting;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name="LoginServlet", urlPatterns={"/login"})
public class LoginServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        // Lấy username & password từ request
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Kiểm tra nếu không nhập username/password (truy cập lần đầu)
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        NotificationDAO notificationDAO = new NotificationDAO();
        User userA = userDAO.authenticationUserLogin(username, password);
        
        if (userA == null) {
            // Đăng nhập thất bại, hiển thị lỗi
            request.setAttribute("error", "Thông tin đăng nhập không hợp lệ!");
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
        } else {
            // Đăng nhập thành công -> Xử lý session
            HttpSession session = request.getSession(false); // Không tạo mới session nếu chưa có
            if (session != null) {
                session.invalidate(); // Xóa session cũ để tránh lỗi session trước đó
            }
            session = request.getSession(true); // Tạo session mới

            // Lưu thông tin user vào session
            ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(userA.getId());
            NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(userA.getId());
            if(!notiSetting.isProfile()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Profile")){
                        notifications.remove(i);
                    }
                }
            }
            
            if(!notiSetting.isOrderChange()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Order Change")){
                        notifications.remove(i);
                    }
                }
            }
            
            if(!notiSetting.isAttendance()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Attendance")){
                        notifications.remove(i);
                    }
                }
            }
            
            if(!notiSetting.isService()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Service")){
                        notifications.remove(i);
                    }
                }
            }
            
            if(!notiSetting.isInsurance()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Insurance")){
                        notifications.remove(i);
                    }
                }
            }
            
            if(!notiSetting.isCategory()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Category")){
                        notifications.remove(i);
                    }
                }
            }
            
            if(!notiSetting.isSupplier()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Supplier")){
                        notifications.remove(i);
                    }
                }
            }
            
            if(!notiSetting.isParts()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Part")){
                        notifications.remove(i);
                    }
                }
            }
            
            if(!notiSetting.isSettingChange()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Setting Change")){
                        notifications.remove(i);
                    }
                }
            }
            
            if(!notiSetting.isCarType()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Car Type")){
                        notifications.remove(i);
                    }
                }
            }
            
            if(!notiSetting.isCampaign()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Campaign")){
                        notifications.remove(i);
                    }
                }
            }
            
            if(!notiSetting.isBlog()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Blog")){
                        notifications.remove(i);
                    }
                }
            }
            
            if(!notiSetting.isVoucher()){
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if(notifications.get(i).getType().equals("Voucher")){
                        notifications.remove(i);
                    }
                }
            }
            
            session.setAttribute("user", userA);
            session.setAttribute("notification", notifications);
            session.setAttribute("notiSetting", notiSetting);
            session.setAttribute("roleID", userA.getUserRole()); // Lưu role vào session để Filter kiểm tra

            // Điều hướng theo quyền
            if ("customer".equals(userA.getUserRole())) {
                response.sendRedirect("home"); // User               
            } else {
                response.sendRedirect("authorization"); // Admin
            }
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
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
