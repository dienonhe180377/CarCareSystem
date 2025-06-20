/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.SupplierDAO;
import entity.Supplier;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@MultipartConfig
public class SupplierController extends HttpServlet {

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
            SupplierDAO supplierDAO = new SupplierDAO();

            if (service.equals("list")) {
                ArrayList<Supplier> suppliers = supplierDAO.getAllSupplier();
                request.setAttribute("supplierList", suppliers);
                request.getRequestDispatcher("supplierList.jsp").forward(request, response);
            }

            if (service.equals("search")) {
                String text = request.getParameter("search");
                ArrayList<Supplier> suppliers = supplierDAO.getAllSupplierByText(text);
                request.setAttribute("supplierList", suppliers);
                request.setAttribute("searchedValue", text);
                request.getRequestDispatcher("supplierList.jsp").forward(request, response);
            }

            if (service.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                int successDelete = supplierDAO.deleteSupplier(id);
                request.setAttribute("successDelete", successDelete);
                request.getRequestDispatcher("supplierList.jsp").forward(request, response);
            }

            if (service.equals("add")) {
                String name = request.getParameter("name").trim();
                String email = request.getParameter("email").trim();
                String description = request.getParameter("description").trim();
                String phone = request.getParameter("phone").trim();
                String address = request.getParameter("address").trim();
                if (!isValidPhone(phone)) {
                    request.setAttribute("phoneInvalid", "a");
                    request.getRequestDispatcher("supplierDetail.jsp").forward(request, response);
                } else {
                    //Supplier Logo
                    Part logo = request.getPart("logo");
                    String fileName = Paths.get(logo.getSubmittedFileName()).getFileName().toString();
                    String uploadDir = getServletContext().getRealPath("/image");
                    File uploadDirFile = new File(uploadDir);
                    if (!uploadDirFile.exists()) {
                        uploadDirFile.mkdirs();
                    }
                    String logoFilePath = uploadDir + File.separator + fileName;
                    int successCheck = supplierDAO.addSupplier(name, fileName, description, email, phone, address);
                    if (successCheck > 0) {
                        logo.write(logoFilePath);
                    }
                    request.setAttribute("successCheck", successCheck);
                    request.getRequestDispatcher("supplierDetail.jsp").forward(request, response);
                }
            }

            if (service.equals("edit")) {
                String action = request.getParameter("action");
                int id = Integer.parseInt(request.getParameter("id"));
                Supplier supplier = supplierDAO.getSupplierById(id);
                if (action.equals("load")) {
                    request.setAttribute("supplier", supplier);
                    request.getRequestDispatcher("supplierDetail.jsp").forward(request, response);
                } else {
                    String name = request.getParameter("name").trim();
                    String email = request.getParameter("email").trim();
                    String description = request.getParameter("description").trim();
                    String phone = request.getParameter("phone").trim();
                    String address = request.getParameter("address").trim();

                    String oldLogo = request.getParameter("oldLogo");
                    Part newLogo = request.getPart("logo");
                    String uploadDir = getServletContext().getRealPath("/image");

                    if (!isValidPhone(phone)) {
                        request.setAttribute("phoneInvalid", "a");
                        request.getRequestDispatcher("supplierDetail.jsp").forward(request, response);
                    } else {
                        if (newLogo.getSize() > 0) {
                            String newLogoName = Paths.get(newLogo.getSubmittedFileName()).getFileName().toString();
                            String newLogoFileUploadPath = uploadDir + File.separator + newLogoName;
                            newLogo.write(newLogoFileUploadPath);
                            int changeSuccess = supplierDAO.editSupplier(id, name, newLogoName, description, email, phone, address);
                            request.setAttribute("changeSuccess", changeSuccess);
                        } else {
                            int changeSuccess = supplierDAO.editSupplier(id, name, oldLogo, description, email, phone, address);
                            request.setAttribute("changeSuccess", changeSuccess);
                        }
                        request.setAttribute("supplier", supplier);
                        request.getRequestDispatcher("supplierDetail.jsp").forward(request, response);
                    }

                }
            }
        }
    }

    public boolean isValidPhone(String input) {
        return input.matches("^0\\d{9}$");
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
            Logger.getLogger(SupplierController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SupplierController.class.getName()).log(Level.SEVERE, null, ex);
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
