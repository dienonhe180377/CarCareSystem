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
                    request.getRequestDispatcher("/ordermanagement").forward(request, response);
                } else if (notification.getType().equals("Attendance")) {
                    request.getRequestDispatcher("/attendance").forward(request, response);
                } else if (notification.getType().equals("Service")) {
                    request.getRequestDispatcher("/ServiceServlet_JSP").forward(request, response);
                } else if (notification.getType().equals("Insurance")) {
                    request.getRequestDispatcher("/insurance").forward(request, response);
                } else if (notification.getType().equals("Category")) {
                    request.getRequestDispatcher("/CategoryController?service=list").forward(request, response);
                } else if (notification.getType().equals("Supplier")) {
                    request.getRequestDispatcher("/SupplierController?service=list").forward(request, response);
                } else if (notification.getType().equals("Setting Change")) {
                    request.getRequestDispatcher("/admin/settingList").forward(request, response);
                } else if (notification.getType().equals("Car Type")) {
                    request.getRequestDispatcher("/manager/carTypeList").forward(request, response);
                } else if (notification.getType().equals("Campaign")) {
                    request.getRequestDispatcher("/campaign").forward(request, response);
                } else if (notification.getType().equals("Blog")) {
                    request.getRequestDispatcher("/blog").forward(request, response);
                } else {
                    request.getRequestDispatcher("/voucher").forward(request, response);
                }

            }

            if (service.equals("delete")) {
                int userId = Integer.parseInt(request.getParameter("user"));
                notificationDAO.deleteNotification(userId);
                ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(userId);
                session.setAttribute("notification", notifications);
                if (user.getUserRole().equals("admin")) {
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                } else if (user.getUserRole().equals("manager")) {
                    response.sendRedirect(request.getContextPath() + "/attendance");
                } else if (user.getUserRole().equals("repairer")) {
                    response.sendRedirect(request.getContextPath() + "/ordermanagement");
                } else if (user.getUserRole().equals("customer")) {
                    response.sendRedirect(request.getContextPath() + "/home");
                } else if (user.getUserRole().equals("warehouse manager")) {
                    response.sendRedirect(request.getContextPath() + "/PartController?service=list");
                } else {
                    response.sendRedirect(request.getContextPath() + "/blog");
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
                ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(user.getId());
                NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(user.getId());
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

                session.setAttribute("notification", notifications);
                session.setAttribute("notiSetting", notiSetting);
                if (user.getUserRole().equals("admin")) {
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                } else if (user.getUserRole().equals("manager")) {
                    response.sendRedirect(request.getContextPath() + "/attendance");
                } else if (user.getUserRole().equals("repairer")) {
                    response.sendRedirect(request.getContextPath() + "/ordermanagement");
                } else if (user.getUserRole().equals("customer")) {
                    response.sendRedirect(request.getContextPath() + "/home");
                } else if (user.getUserRole().equals("warehouse manager")) {
                    response.sendRedirect(request.getContextPath() + "/PartController?service=list");
                } else {
                    response.sendRedirect(request.getContextPath() + "/blog");
                }
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
