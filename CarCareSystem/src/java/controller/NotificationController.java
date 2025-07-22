/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.NotificationDAO;
import entity.Notification;
import entity.NotificationSetting;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class NotificationController extends HttpServlet {

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
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            HttpSession session = request.getSession();
            String service = request.getParameter("service");
            User user = (User) session.getAttribute("user");
            NotificationDAO notificationDAO = new NotificationDAO();

            if (service.equals("load")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Notification notification = notificationDAO.getNotificationById(id);
                notificationDAO.setNotificationStatus(id);
                ArrayList<Notification> notifications = (ArrayList<Notification>) session.getAttribute("notification");

                for (int i = 0; i < notifications.size(); i++) {
                    if (notifications.get(i).getId() == id) {
                        notifications.get(i).setStatus(true);
                    }
                }
                session.setAttribute("notification", notifications);

                if (notification.getType().equals("Part")) {
                    request.getRequestDispatcher("/PartController?service=list").forward(request, response);
                } else if (notification.getType().equals("Profile")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else if (notification.getType().equals("Order Change")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else if (notification.getType().equals("Attendance")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else if (notification.getType().equals("Service")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else if (notification.getType().equals("Insurance")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else if (notification.getType().equals("Category")) {
                    request.getRequestDispatcher("/CategoryController?service=list").forward(request, response);
                } else if (notification.getType().equals("Supplier")) {
                    request.getRequestDispatcher("/SupplierController?service=list").forward(request, response);
                } else if (notification.getType().equals("Setting Change")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else if (notification.getType().equals("Car Type")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else if (notification.getType().equals("Campaign")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else if (notification.getType().equals("Blog")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                }

            }

            if (service.equals("delete")) {
                int userId = Integer.parseInt(request.getParameter("user"));
                notificationDAO.deleteNotification(userId);
                ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(userId);
                session.setAttribute("notification", notifications);
                if (user.getUserRole().equals("admin")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else if (user.getUserRole().equals("manager")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else if (user.getUserRole().equals("repairer")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else if (user.getUserRole().equals("customer")) {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                } else if (user.getUserRole().equals("warehouse manager")) {
                    request.getRequestDispatcher("/PartController?service=list").forward(request, response);
                } else {
                    request.getRequestDispatcher("/viewProfile").forward(request, response);
                }
            }

            if (service.equals("filter")) {
                String notiTime = request.getParameter("notiTime");
                String notiStatus = request.getParameter("notiStatus");
                String profile = request.getParameter("profile");
                String settingChange = request.getParameter("settingChange");
                String order = request.getParameter("order");
                String category = request.getParameter("category");
                String supplier = request.getParameter("supplier");
                String part = request.getParameter("part");
                String attendance = request.getParameter("attendance");
                String insurance = request.getParameter("insurance");
                String serviceChanges = request.getParameter("serviceChanges");
                String carType = request.getParameter("carType");
                String campaign = request.getParameter("campaign");
                String blog = request.getParameter("blog");
                String voucher = request.getParameter("voucher");
                String email = request.getParameter("email");

                int successCheck = notificationDAO.editNotificationSetting(user.getId(), notiTime, notiStatus, profile, order, attendance, email, serviceChanges, insurance, category, supplier, part, settingChange, carType, campaign, blog, voucher);
                
                
                
            }

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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(NotificationController.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(NotificationController.class.getName()).log(Level.SEVERE, null, ex);
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
