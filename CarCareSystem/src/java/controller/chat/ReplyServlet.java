/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.chat;

import dao.MessageDAO;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author GIGABYTE
 */
@WebServlet(name="ReplyServlet", urlPatterns={"/api/reply"})
public class ReplyServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ReplyServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReplyServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
    private static final int MARKETING_USER_ID = 6;
    private MessageDAO mDao = new MessageDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        if (currentUser == null || !currentUser.getUserRole().equalsIgnoreCase("marketing") 
                || currentUser.getId() != MARKETING_USER_ID) {
            response.sendRedirect(request.getContextPath() + "/filterPage.jsp");
            return;
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
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        
        if (currentUser == null || 
            !currentUser.getUserRole().equalsIgnoreCase("marketing") ||
            currentUser.getId() != MARKETING_USER_ID) {
            response.sendError(403, "Access denied");
            return;
        }
        
        String customerIdStr = request.getParameter("customerId");
        String content = request.getParameter("content");

        if (customerIdStr == null || content == null || content.trim().isEmpty()) {
            response.sendError(400, "Missing data");
            return;
        }

        try {
            int customerId = Integer.parseInt(customerIdStr);
            // Gửi tin từ marketing (6) đến customer
            mDao.sendMessage(MARKETING_USER_ID, customerId, content);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Failed to send message");
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
