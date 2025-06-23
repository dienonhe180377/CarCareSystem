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
@WebServlet(name = "EditCarTypeServlet", urlPatterns = {"/manager/editCarType"})
public class EditCarTypeServlet extends HttpServlet {

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
            out.println("<title>Servlet EditCarTypeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditCarTypeServlet at " + request.getContextPath() + "</h1>");
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

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/manager/carTypeList");
            return;
        }

        int id = Integer.parseInt(idStr);
        CarType carType = ctDao.getCarTypeById(id);
        if (carType == null) {
            response.sendRedirect(request.getContextPath() + "/manager/carTypeList");
            return;
        }

        request.setAttribute("carType", carType);
        request.getRequestDispatcher("/manager/editCarType.jsp").forward(request, response);
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
        String idStr = request.getParameter("id");
        int id = Integer.parseInt(idStr);
        String name = request.getParameter("name");
        String statusStr = request.getParameter("status");
        boolean status = "on".equals(statusStr);

        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/manager/carTypeList");
            return;
        }

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Tên loại xe không được để trống hoặc chỉ chứa khoảng trắng!");
            CarType carType = new CarType(id, name, status);
            request.setAttribute("carType", carType);
            request.getRequestDispatcher("/manager/editCarType.jsp").forward(request, response);
            return;
        }

        if (name.trim().length() > 50) {
            request.setAttribute("errorMessage", "Tên loại xe không được vượt quá 50 ký tự!");
            CarType carType = new CarType(id, name, status);
            request.setAttribute("carType", carType);
            request.getRequestDispatcher("/manager/editCarType.jsp").forward(request, response);
            return;
        }

        // Kiểm tra trùng tên (ngoại trừ chính bản ghi đang sửa)
        if (ctDao.isNameExistsForOtherId(name, id)) {
            request.setAttribute("errorMessage", "Tên loại xe đã tồn tại, vui lòng chọn tên khác!");
            CarType carType = new CarType(id, name, status);
            request.setAttribute("carType", carType);
            request.getRequestDispatcher("/manager/editCarType.jsp").forward(request, response);
            return;
        }

        ctDao.update(new CarType(id, name, status));
        response.sendRedirect(request.getContextPath() + "/manager/carTypeList");
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