/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import entity.Category;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class CategoryController extends HttpServlet {

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

            String service = request.getParameter("service");
            CategoryDAO categoryDAO = new CategoryDAO();
            HttpSession session = request.getSession();

            if (service.equals("list")) {
                ArrayList<Category> categoryList = categoryDAO.getAllCategory();
                session.setAttribute("mainCategoryList", categoryList);
                request.setAttribute("categoryList", categoryList);
                request.getRequestDispatcher("categoryList.jsp").forward(request, response);
            }

            if (service.equals("add")) {
                int checkError = 0;
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                String status = request.getParameter("status");
                ArrayList<Category> categoryList = categoryDAO.getAllCategory();
                for (int i = 0; i < categoryList.size(); i++) {
                    if (name.equalsIgnoreCase(categoryList.get(i).getName())) {
                        checkError++;
                        request.setAttribute("checkError", "existed");
                        request.getRequestDispatcher("categoryList.jsp").forward(request, response);
                    }
                }
                if (checkError == 0) {
                    if (status.equals("active")) {
                        categoryDAO.addCategory(name, description, true);
                    } else {
                        categoryDAO.addCategory(name, description, false);
                    }
                    request.setAttribute("checkError", "success");
                    request.getRequestDispatcher("categoryList.jsp").forward(request, response);
                }
            }

            if (service.equals("filter")) {
                String value = request.getParameter("filterValue");
                ArrayList<Category> categoryList = (ArrayList<Category>) session.getAttribute("mainCategoryList");
                ArrayList<Category> filteredList = new ArrayList<>(categoryList);
                if (value.equals("all")) {
                    request.setAttribute("all", "all");
                    request.setAttribute("categoryList", filteredList);
                    request.getRequestDispatcher("categoryList.jsp").forward(request, response);

                } else if (value.equals("active")) {
                    for (int i = filteredList.size() - 1; i >= 0; i--) {
                        if (!filteredList.get(i).isStatus()) {
                            filteredList.remove(i);
                        }
                    }
                    request.setAttribute("active", "active");
                    request.setAttribute("categoryList", filteredList);
                    request.getRequestDispatcher("categoryList.jsp").forward(request, response);

                } else if (value.equals("inactive")) {
                    for (int i = filteredList.size() - 1; i >= 0; i--) {
                        if (filteredList.get(i).isStatus()) {
                            filteredList.remove(i);
                        }
                    }
                    request.setAttribute("inactive", "inactive");
                    request.setAttribute("categoryList", filteredList);
                    request.getRequestDispatcher("categoryList.jsp").forward(request, response);

                } else if (value.equals("newest")) {
                    Collections.reverse(filteredList);
                    request.setAttribute("newest", "newest");
                    request.setAttribute("categoryList", filteredList);
                    request.getRequestDispatcher("categoryList.jsp").forward(request, response);

                } else {
                    request.setAttribute("oldest", "oldest");
                    request.setAttribute("categoryList", filteredList);
                    request.getRequestDispatcher("categoryList.jsp").forward(request, response);
                }
            }

            if (service.equals("search")) {
                String searchValue = request.getParameter("search").trim().toLowerCase();
                ArrayList<Category> searchedList = new ArrayList<>();
                if (!searchValue.equals("")) {
                    searchedList = categoryDAO.getAllCategoryByText(searchValue);
                } else {
                    searchedList = categoryDAO.getAllCategory();
                }
                session.setAttribute("categorySearch", searchValue);
                session.setAttribute("mainCategoryList", searchedList);
                request.setAttribute("categoryList", searchedList);
                request.getRequestDispatcher("categoryList.jsp").forward(request, response);
            }

            if (service.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("categoryId"));
                int successCheck = categoryDAO.deleteCategory(id);
                request.setAttribute("successCheck", successCheck);
                request.getRequestDispatcher("categoryList.jsp").forward(request, response);
            }
            
            if(service.equals("edit")){
                int id = Integer.parseInt(request.getParameter("detail-id"));
                String name = request.getParameter("detail-name");
                String description = request.getParameter("detail-description");
                String status = request.getParameter("detail-status");
                int editCheck = 0;
                if(status.equals("inactive")){
                    editCheck = categoryDAO.editCategory(id, name, description, false);
                } else {
                    editCheck = categoryDAO.editCategory(id, name, description, true);
                }
                request.setAttribute("editCheck", editCheck);
                request.getRequestDispatcher("categoryList.jsp").forward(request, response);
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
            Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, ex);
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
