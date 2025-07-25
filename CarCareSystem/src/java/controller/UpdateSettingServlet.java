/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.NotificationDAO;
import dao.SettingDAO;
import dao.UserDAO;
import entity.Notification;
import entity.NotificationSetting;
import entity.Setting;
import entity.User;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.SendMailService;

/**
 *
 * @author GIGABYTE
 */
@WebServlet(name = "UpdateSettingServlet", urlPatterns = {"/admin/updateSetting"})
public class UpdateSettingServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateSettingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateSettingServlet at " + request.getContextPath() + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (User) (session != null ? session.getAttribute("user") : null);
        if (currentUser == null || !currentUser.getUserRole().equalsIgnoreCase("admin")) {
            response.sendRedirect(request.getContextPath() + "/filterPage.jsp");
            return;
        }
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
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(false);
            User currentUser = (User) (session != null ? session.getAttribute("user") : null);
            if (currentUser == null || !currentUser.getUserRole().equalsIgnoreCase("admin")) {
                response.sendRedirect(request.getContextPath() + "/accessDenied.jsp");
                return;
            }

            int id = Integer.parseInt(request.getParameter("id"));
            String value = request.getParameter("value");

            Setting setting = new Setting();
            setting.setId(id);
            setting.setValue(value);

            SettingDAO sDao = new SettingDAO();
            sDao.updateSetting(setting);

            //                        NOTIFICATION
            UserDAO userDAO = new UserDAO();
            NotificationDAO notificationDAO = new NotificationDAO();
            String message = "Setting " + setting.getId()+ " vừa được sửa";

            List<User> userList = userDAO.getAllUser();
            for (int i = 0; i < userList.size(); i++) {
                if (userList.get(i).getUserRole().equals("admin")) {
                    NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(userList.get(i).getId());
                    if (notiSetting.isEmail() && notiSetting.isSettingChange()) {
                        SendMailService.sendNotification(userList.get(i).getEmail(), message);
                    }
                    int addNoti = notificationDAO.addNotification(userList.get(i).getId(), message, "Setting Change");
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


            if (!notiSetting.isSettingChange()) {
                for (int i = notifications.size() - 1; i >= 0; i--) {
                    if (notifications.get(i).getType().equals("Setting Change")) {
                        notifications.remove(i);
                    }
                }
            }

            request.getSession().setAttribute("notification", notifications);
            request.getSession().setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION

            ServletContext context = getServletContext();
            sDao.reloadSettingMap(context);

            request.getSession().setAttribute("success", "Cập nhật cài đặt thành công!");
            response.sendRedirect("settingList");
        } catch (Exception ex) {
            Logger.getLogger(UpdateSettingServlet.class.getName()).log(Level.SEVERE, null, ex);
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
