/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.EmployeeFeedbackDAO;
import dao.UserDAO;
import entity.RepairerRating;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class EmployeeFeedbackController extends HttpServlet {

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

            HttpSession session = request.getSession();
            String service = request.getParameter("service");
            User user = (User) session.getAttribute("user");
            EmployeeFeedbackDAO feedbackDAO = new EmployeeFeedbackDAO();
            UserDAO userDAO = new UserDAO();

            if (service.equals("customer_list")) {
                ArrayList<RepairerRating> feedbacks = feedbackDAO.getAllFeedbackByCustomerId(user.getId());
                request.setAttribute("feedbackList", feedbacks);
                request.getRequestDispatcher("customerFeedbackList.jsp").forward(request, response);
            }

            if (service.equals("rate")) {
                int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
                int rating = Integer.parseInt(request.getParameter("rating"));
                String comment = request.getParameter("comment");
                int success = feedbackDAO.setFeedback(feedbackId, rating, comment, true);
                request.getRequestDispatcher("/EmployeeFeedbackController?service=customer_list").forward(request, response);
            }
            
            if(service.equals("repairer_list")){
                List<User> repairers = userDAO.getAllRepairer();
                for (int i = 0; i < repairers.size(); i++) {
                    int repairerId = repairers.get(i).getId();
                    ArrayList<RepairerRating> feedbacks = feedbackDAO.getAllFeedbackByRepairerId(repairerId);
                    int rating = 0;
                    for (int j = 0; j < feedbacks.size(); j++) {
                        rating += feedbacks.get(j).getRating();
                    }
                    rating = rating /= feedbacks.size();
                    repairers.get(i).setRating(rating);
                }
                
                request.setAttribute("repairerList", repairers);
                request.getRequestDispatcher("repairerFeedbackList.jsp").forward(request, response);
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
            Logger.getLogger(EmployeeFeedbackController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(EmployeeFeedbackController.class.getName()).log(Level.SEVERE, null, ex);
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
