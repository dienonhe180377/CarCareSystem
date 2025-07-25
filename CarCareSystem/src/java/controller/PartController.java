/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.NotificationDAO;
import dao.PartDAO;
import dao.SupplierDAO;
import dao.UserDAO;
import entity.Category;
import entity.Notification;
import entity.NotificationSetting;
import entity.Part;
import entity.Size;
import entity.Supplier;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.SendMailService;

/**
 *
 * @author Admin
 */
@MultipartConfig
public class PartController extends HttpServlet {

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

            String service = request.getParameter("service");
            CategoryDAO categoryDAO = new CategoryDAO();
            SupplierDAO supplierDAO = new SupplierDAO();
            PartDAO partDAO = new PartDAO();

//NOTIFICATION
            UserDAO userDAO = new UserDAO();
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            NotificationDAO notificationDAO = new NotificationDAO();
//NOTIFICATION

            if(!user.getUserRole().equals("warehouse manager")){
                response.sendRedirect("filterPage.jsp");
            }

            if (service.equals("list")) {
                ArrayList<Category> categoryList = categoryDAO.getAllCategory();
                ArrayList<Supplier> supplierList = supplierDAO.getAllSupplier();
                ArrayList<Part> parts = partDAO.getAllPart();
                request.setAttribute("filterList", parts);
                request.setAttribute("categoryList", categoryList);
                session.setAttribute("mainPartList", parts);
                request.setAttribute("supplierList", supplierList);
                request.getRequestDispatcher("partList.jsp").forward(request, response);
            }

            if (service.equals("filter")) {
                ArrayList<Part> partList = partDAO.getAllPart();
                String text = request.getParameter("search");
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                int supplierId = Integer.parseInt(request.getParameter("supplierId"));
                String outOfStock = request.getParameter("outOfStock");

                if (!text.equals("")) {
                    partList = partDAO.getAllPartByText(text);
                    request.setAttribute("textInputted", text);
                }

                if (categoryId != 0) {
                    for (int i = partList.size() - 1; i >= 0; i--) {
                        if (partList.get(i).getCategory().getId() != categoryId) {
                            partList.remove(i);
                        }
                    }
                    request.setAttribute("choosenCategory", categoryId);
                }

                if (supplierId != 0) {
                    for (int i = partList.size() - 1; i >= 0; i--) {
                        int checkValid = 0;
                        for (int j = 0; j < partList.get(i).getSuppliers().size(); j++) {
                            if (partList.get(i).getSuppliers().get(j).getId() == supplierId) {
                                checkValid++;
                            }
                        }
                        if (checkValid == 0) {
                            partList.remove(i);
                        }
                    }
                    request.setAttribute("choosenSupplier", supplierId);
                }

                if (outOfStock != null) {
                    for (int i = partList.size() - 1; i >= 0; i--) {
                        int checkValid = 0;
                        for (int j = 0; j < partList.get(i).getSizes().size(); j++) {
                            if (partList.get(i).getSizes().get(j).getQuantity() == 0) {
                                checkValid++;
                            }
                        }
                        if (checkValid == 0) {
                            partList.remove(i);
                        }
                    }
                    request.setAttribute("outOfStock", "out");
                }

                ArrayList<Category> categoryList = categoryDAO.getAllCategory();
                ArrayList<Supplier> supplierList = supplierDAO.getAllSupplier();
                request.setAttribute("filterList", partList);
                session.setAttribute("mainPartList", partList);
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("supplierList", supplierList);
                request.getRequestDispatcher("partList.jsp").forward(request, response);
            }

            if (service.equals("view")) {
                int id = Integer.parseInt(request.getParameter("id"));
                ArrayList<Part> partList = (ArrayList<Part>) session.getAttribute("mainPartList");
                Part choosenPart = null;
                for (int i = 0; i < partList.size(); i++) {
                    if (partList.get(i).getId() == id) {
                        choosenPart = partList.get(i);
                    }
                }
                ArrayList<Category> categoryList = categoryDAO.getAllCategory();
                ArrayList<Supplier> supplierList = supplierDAO.getAllSupplier();
                request.setAttribute("choosenPart", choosenPart);
                request.setAttribute("filterList", partList);
                session.setAttribute("mainPartList", partList);
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("supplierList", supplierList);
                request.getRequestDispatcher("partList.jsp").forward(request, response);
            }

            if (service.equals("add")) {
                String action = request.getParameter("action");
                if (action.equals("load")) {
                    ArrayList<Category> categoryList = categoryDAO.getAllActiveCategory();
                    ArrayList<Supplier> supplierList = supplierDAO.getAllSupplier();
                    request.setAttribute("categoryList", categoryList);
                    request.setAttribute("supplierList", supplierList);
                    request.getRequestDispatcher("partDetail.jsp").forward(request, response);
                } else {
                    String name = request.getParameter("name");
                    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                    double price = Double.parseDouble(request.getParameter("price"));
                    jakarta.servlet.http.Part image = request.getPart("image");
                    String fileName = "car-parts-icon-style-vector.jpg";
                    String imageFilePath = "";
                    if (image.getSize() > 0) {
                        fileName = Paths.get(image.getSubmittedFileName()).getFileName().toString();
                        String uploadDir = getServletContext().getRealPath("/image");
                        imageFilePath = uploadDir + File.separator + fileName;
                    }
                    int successCheck = partDAO.addPart(name, fileName, categoryId, price);
                    if (successCheck > 0) {

                        if (image.getSize() > 0) {
                            image.write(imageFilePath);
                        }

                        ArrayList<Part> partList = partDAO.getAllPart();
                        int id = partList.get(partList.size() - 1).getId();

                        String[] supplierIds = request.getParameterValues("supplierId");
                        partDAO.addPartSupplier(id, supplierIds);

                        String[] sizeNames = request.getParameterValues("sizeName");
                        String[] quantity = request.getParameterValues("quantity");
                        String[] sizeStatus = request.getParameterValues("status");
                        for (int i = 0; i < sizeNames.length; i++) {
                            boolean status = true;
                            int sizeQuantity = Integer.parseInt(quantity[i]);
                            if (sizeStatus[i].equals("0")) {
                                status = false;
                            }
                            partDAO.addPartSize(sizeNames[i], id, status, sizeQuantity);
                        }

//                        NOTIFICATION
                        String message = "Linh kiện " + name + " vừa được thêm vào hệ thống";

                        List<User> users = userDAO.getAllUser();
                        for (int i = 0; i < users.size(); i++) {
                            if (users.get(i).getUserRole().equals("warehouse manager")) {
                                NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                                if (notiSetting.isEmail() && notiSetting.isParts()) {
                                    SendMailService.sendNotification(users.get(i).getEmail(), message);
                                }
                                int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Part");
                            }
                        }
                        ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(user.getId());
                        NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(user.getId());
                        if (!notiSetting.isProfile()) {
                            for (int i = notifications.size() - 1; i >= 0; i--) {
                                if (notifications.get(i).getType().equals("Profile")) {
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

                        session.setAttribute("notification", notifications);
                        session.setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION

                        request.setAttribute("successAdd", 2);
                        request.getRequestDispatcher("partDetail.jsp").forward(request, response);
                    } else {
                        request.setAttribute("successAdd", 0);
                        request.getRequestDispatcher("partDetail.jsp").forward(request, response);
                    }
                }
            }

            if (service.equals("edit")) {
                String action = request.getParameter("action");
                if (action.equals("load")) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Part part = partDAO.getPartById(id);
                    ArrayList<Category> categoryList = categoryDAO.getAllActiveCategory();
                    ArrayList<Supplier> supplierList = supplierDAO.getAllSupplier();
                    request.setAttribute("categoryList", categoryList);
                    request.setAttribute("choosedPart", part);
                    request.setAttribute("supplierList", supplierList);
                    request.getRequestDispatcher("partDetail.jsp").forward(request, response);
                } else {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Part part = partDAO.getPartById(id);
                    String name = request.getParameter("name");
                    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                    double price = Double.parseDouble(request.getParameter("price"));
                    jakarta.servlet.http.Part image = request.getPart("image");
                    String fileName, uploadDir, imageFilePath = "";
                    if (image.getSize() != 0) {
                        fileName = Paths.get(image.getSubmittedFileName()).getFileName().toString();
                        uploadDir = getServletContext().getRealPath("/image");
                        imageFilePath = uploadDir + File.separator + fileName;
                    } else {
                        fileName = part.getImage();
                    }
                    int successCheck = partDAO.editPart(id, name, fileName, categoryId, price);
                    if (successCheck > 0) {
                        if (image.getSize() != 0) {
                            image.write(imageFilePath);
                        }
                        //SUPPLIER EDIT
                        ArrayList<Supplier> oldSuppliers = part.getSuppliers();
                        ArrayList<Integer> deleteSupplierId = new ArrayList<>();
                        String[] supplierIds = request.getParameterValues("supplierId");
                        for (int i = oldSuppliers.size() - 1; i >= 0; i--) {
                            int check = 0;
                            for (int j = 0; j < supplierIds.length; j++) {
                                if (oldSuppliers.get(i).getId() == Integer.parseInt(supplierIds[j])) {
                                    check++;
                                }
                            }
                            if (check == 0) {
                                deleteSupplierId.add(oldSuppliers.get(i).getId());
                                oldSuppliers.remove(i);
                            }
                        }
                        for (int i = 0; i < deleteSupplierId.size(); i++) {
                            partDAO.deletePartSupplier(id, deleteSupplierId.get(i));
                        }
                        for (int i = 0; i < supplierIds.length; i++) {
                            int checkExist = partDAO.getAllPartSupplier(id, Integer.parseInt(supplierIds[i]));
                            if (checkExist == 0) {
                                partDAO.addSinglePartSupplier(id, Integer.parseInt(supplierIds[i]));
                            }
                        }

                        //SIZE EDIT
                        String[] sizeId = request.getParameterValues("sizeId");
                        String[] sizeNames = request.getParameterValues("sizeName");
                        String[] quantity = request.getParameterValues("quantity");
                        String[] sizeStatus = request.getParameterValues("status");

                        ArrayList<Integer> deleteSizeId = new ArrayList<>();
                        ArrayList<Size> oldSizes = part.getSizes();
                        for (int i = oldSizes.size() - 1; i >= 0; i--) {
                            int check = 0;
                            for (int j = 0; j < sizeId.length; j++) {
                                if (oldSizes.get(i).getId() == Integer.parseInt(sizeId[j])) {
                                    check++;
                                }
                            }
                            if (check == 0) {
                                deleteSizeId.add(oldSizes.get(i).getId());
                                oldSizes.remove(i);
                            }
                        }
                        for (int i = 0; i < deleteSizeId.size(); i++) {
                            partDAO.deleteSizeById(deleteSizeId.get(i));
                        }
                        for (int i = 0; i < sizeId.length; i++) {
                            int checkExist = partDAO.getAllSizeById(Integer.parseInt(sizeId[i]));
                            if (checkExist > 0) {
                                boolean status = true;
                                if (sizeStatus[i].equals("0")) {
                                    status = false;
                                }
                                partDAO.editSize(Integer.parseInt(sizeId[i]), sizeNames[i], status, Integer.parseInt(quantity[i]));
                            } else {
                                boolean status = true;
                                int sizeQuantity = Integer.parseInt(quantity[i]);
                                if (sizeStatus[i].equals("0")) {
                                    status = false;
                                }
                                partDAO.addPartSize(sizeNames[i], id, status, sizeQuantity);
                            }
                        }

//                        NOTIFICATION
                        String message = "Linh kiện " + name + " vừa được sửa";

                        List<User> users = userDAO.getAllUser();
                        for (int i = 0; i < users.size(); i++) {
                            if (users.get(i).getUserRole().equals("warehouse manager")) {
                                NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                                if (notiSetting.isEmail() && notiSetting.isParts()) {
                                    SendMailService.sendNotification(users.get(i).getEmail(), message);
                                }
                                int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Part");
                            }
                        }
                        ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(user.getId());
                        NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(user.getId());
                        if (!notiSetting.isProfile()) {
                            for (int i = notifications.size() - 1; i >= 0; i--) {
                                if (notifications.get(i).getType().equals("Profile")) {
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

                        session.setAttribute("notification", notifications);
                        session.setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION

                        request.setAttribute("successAdd", 2);
                        request.setAttribute("choosedPart", part);
                        request.getRequestDispatcher("partDetail.jsp").forward(request, response);

                    } else {

                        request.setAttribute("successAdd", 0);
                        request.setAttribute("choosedPart", part);
                        request.getRequestDispatcher("partDetail.jsp").forward(request, response);

                    }
                }
            }

            if (service.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Part part = partDAO.getPartById(id);
                if (part.getServices().size() > 0) {
                    request.setAttribute("successDelete", 0);
                    request.getRequestDispatcher("partList.jsp").forward(request, response);
                } else {
                    partDAO.deleteSizeByPartId(id);
                    partDAO.deletePartSupplierByPartId(id);
                    partDAO.deletePartById(id);

                    //                        NOTIFICATION
                    String message = "Linh kiện " + part.getName() + " vừa bị xóa khỏi hệ thống";

                    List<User> users = userDAO.getAllUser();
                    for (int i = 0; i < users.size(); i++) {
                        if (users.get(i).getUserRole().equals("warehouse manager")) {
                            NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(users.get(i).getId());
                            if (notiSetting.isEmail() && notiSetting.isParts()) {
                                SendMailService.sendNotification(users.get(i).getEmail(), message);
                            }
                            int addNoti = notificationDAO.addNotification(users.get(i).getId(), message, "Part");
                        }
                    }
                    ArrayList<Notification> notifications = notificationDAO.getAllNotificationById(user.getId());
                    NotificationSetting notiSetting = notificationDAO.getNotificationSettingById(user.getId());
                    if (!notiSetting.isProfile()) {
                        for (int i = notifications.size() - 1; i >= 0; i--) {
                            if (notifications.get(i).getType().equals("Profile")) {
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

                    session.setAttribute("notification", notifications);
                    session.setAttribute("notiSetting", notiSetting);
//                        NOTIFICATION

                    request.setAttribute("successDelete", 1);
                    request.getRequestDispatcher("partList.jsp").forward(request, response);
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
            Logger.getLogger(PartController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(PartController.class.getName()).log(Level.SEVERE, null, ex);
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
