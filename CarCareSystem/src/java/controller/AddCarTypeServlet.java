/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CarTypeDAO;
import entity.CarType;
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
@WebServlet(name = "AddCarTypeServlet", urlPatterns = {"/manager/addCarType"})
public class AddCarTypeServlet extends HttpServlet {

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
            out.println("<title>Servlet AddCarTypeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCarTypeServlet at " + request.getContextPath() + "</h1>");
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
    private CarTypeDAO ctDao = new CarTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        if (currentUser == null || !currentUser.getUserRole().equalsIgnoreCase("manager")) {
            response.sendRedirect(request.getContextPath() + "/accessDenied.jsp");
            return;
        }

        request.getRequestDispatcher("/manager/addCarType.jsp").forward(request, response);
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
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
        if (currentUser == null || !currentUser.getUserRole().equalsIgnoreCase("manager")) {
            response.sendRedirect(request.getContextPath() + "/accessDenied.jsp");
            return;
        }

        String name = request.getParameter("name");
        String statusStr = request.getParameter("status");
        String description = request.getParameter("description");
        boolean status = "on".equals(statusStr);

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Tên loại xe không được để trống hoặc chỉ chứa khoảng trắng!");
            request.setAttribute("name", name);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/manager/addCarType.jsp").forward(request, response);
            return;
        } else if (name.trim().length() > 50) {
            request.setAttribute("errorMessage", "Tên loại xe không được vượt quá 50 ký tự!");
            request.setAttribute("name", name);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/manager/addCarType.jsp").forward(request, response);
            return;
        } else if (ctDao.isNameExists(name)) {
            request.setAttribute("errorMessage", "Tên loại xe đã tồn tại, vui lòng chọn tên khác!");
            request.setAttribute("name", name);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/manager/addCarType.jsp").forward(request, response);
            return;
        }

        CarType newCarType = new CarType();
        newCarType.setName(name);
        newCarType.setStatus(status);
        newCarType.setDescription(description);

        boolean success = ctDao.addCarType(newCarType);

        if (success) {
            request.getSession().setAttribute("message", "Thêm loại xe thành công!");
            response.sendRedirect(request.getContextPath() + "/manager/carTypeList");
        } else {
            request.setAttribute("errorMessage", "Thêm loại xe thất bại!");
            request.setAttribute("name", name);
            request.setAttribute("status", status);
            request.getRequestDispatcher("/manager/addCarType.jsp").forward(request, response);
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