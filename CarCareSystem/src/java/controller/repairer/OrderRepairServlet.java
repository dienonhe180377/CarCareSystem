/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.repairer;

import dao.OrderDAO;
import dao.PartDAO;
import dao.ServiceDAO;
import entity.Order;
import entity.Part;
import entity.Service;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Vector;

/**
 *
 * @author TRAN ANH HAI
 */
@WebServlet(name="OrderRepairServlet", urlPatterns={"/order_repair"})
public class OrderRepairServlet extends HttpServlet {
   
    private OrderDAO orderDAO = new OrderDAO();
    private ServiceDAO serviceDAO = new ServiceDAO();
    private PartDAO partDAO = new PartDAO();
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
            out.println("<title>Servlet OrderRepairServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderRepairServlet at " + request.getContextPath () + "</h1>");
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        processRequest(request, response);
        try {
            String status = request.getParameter("status");
            ArrayList<Order> orders;
        
            if (status != null && !status.trim().isEmpty()) {
                orders = orderDAO.getOrdersByStatus(status);
            } else {
                orders = orderDAO.getOrdersByStatus("Đã Nhận Xe");
            }
        
            request.setAttribute("orders", orders);
        
            Vector<Service> allServices = serviceDAO.getAllService();
            ArrayList<Part> allParts = partDAO.getAllParts();
        
            request.setAttribute("allServices", allServices);
            request.setAttribute("allParts", allParts);
        
            request.getRequestDispatcher("/views/repairer/order_management.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/views/repairer/order_management.jsp").forward(request, response);
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
//        processRequest(request, response);
        String action = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");
        
        try {
            int orderId = Integer.parseInt(orderIdStr);
            
            if ("updateServices".equals(action)) {
                handleUpdateServices(request, response, orderId);
            } else if ("updateParts".equals(action)) {
                handleUpdateParts(request, response, orderId);
            } else if ("updateStatus".equals(action)) {
                handleUpdateStatus(request, response, orderId);
            }
            response.sendRedirect(request.getContextPath() + "/order_repair");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/views/repairer/order_management.jsp").forward(request, response);
        }
    }
    
    private void handleUpdateServices(HttpServletRequest request, HttpServletResponse response, int orderId) throws Exception {
        String[] selectedServiceIds = request.getParameterValues("serviceIds");
    
        Order currentOrder = orderDAO.getOrderById(orderId);
        ArrayList<Service> currentServices = currentOrder.getServices();
    
        ArrayList<Integer> currentServiceIds = new ArrayList<>();
        for (Service service : currentServices) {
            currentServiceIds.add(service.getId());
        }
    
        if (selectedServiceIds != null) {
            for (String serviceIdStr : selectedServiceIds) {
                int serviceId = Integer.parseInt(serviceIdStr);
                if (!currentServiceIds.contains(serviceId)) {
                    orderDAO.addServiceToOrder(orderId, serviceId);
                }
            }
        
            for (Integer existingId : currentServiceIds) {
                boolean stillSelected = false;
                for (String selectedIdStr : selectedServiceIds) {
                    if (existingId == Integer.parseInt(selectedIdStr)) {
                        stillSelected = true;
                        break;
                    }
                }
                if (!stillSelected) {
                    orderDAO.removeServiceFromOrder(orderId, existingId);
                }
            }
        } else {
            orderDAO.removeAllServicesFromOrder(orderId);
        }   
        updateOrderPrice(orderId);
        request.getSession().setAttribute("message", "Cập nhật dịch vụ thành công!");
    }
    
    private void handleUpdateParts(HttpServletRequest request, HttpServletResponse response, int orderId) throws Exception {
        String[] selectedPartIds = request.getParameterValues("partIds");
    
        Order currentOrder = orderDAO.getOrderById(orderId);
        ArrayList<Part> currentParts = currentOrder.getParts();
    
        ArrayList<Integer> currentPartIds = new ArrayList<>();
        for (Part part : currentParts) {
            currentPartIds.add(part.getId());
        }
    
        if (selectedPartIds != null) {
            for (String partIdStr : selectedPartIds) {
                int partId = Integer.parseInt(partIdStr);
                if (!currentPartIds.contains(partId)) {
                    orderDAO.addPartToOrder(orderId, partId);
                }
            }
        
            for (Integer existingId : currentPartIds) {
                boolean stillSelected = false;
                for (String selectedIdStr : selectedPartIds) {
                    if (existingId == Integer.parseInt(selectedIdStr)) {
                        stillSelected = true;
                        break;
                    }
                }
                if (!stillSelected) {
                    orderDAO.removePartFromOrder(orderId, existingId);
                }
            }
        } else {
            orderDAO.removeAllPartsFromOrder(orderId);
        }
    
        updateOrderPrice(orderId);
        request.getSession().setAttribute("message", "Cập nhật phụ tùng thành công!");
    }
    
    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response, int orderId) throws Exception {
        String newStatus = request.getParameter("newStatus");
        
        if (newStatus != null && !newStatus.trim().isEmpty()) {
            boolean success = orderDAO.updateOrderStatus(orderId, newStatus);
            if (success) {
                request.getSession().setAttribute("message", "Cập nhật trạng thái thành công!");
            } else {
                request.getSession().setAttribute("error", "Không thể cập nhật trạng thái");
            }
        }
    }
    
    private void updateOrderPrice(int orderId) throws Exception {
        Order order = orderDAO.getOrderById(orderId);
        double newPrice = 0.0;
    
        for (Service service : order.getServices()) {       
            newPrice += service.getPrice();
        
            if (service.getParts() != null) {
                for (Part part : service.getParts()) {
                    newPrice += part.getPrice();
                }
            }
        }
    
        for (Part part : order.getParts()) {
            boolean isPartOfService = false;
            for (Service service : order.getServices()) {
                if (service.getParts() != null && service.getParts().contains(part)) {
                    isPartOfService = true;
                    break;
                }
            }
            if (!isPartOfService) {
                newPrice += part.getPrice();
            }
        }
        orderDAO.updateOrderPrice(orderId, newPrice);
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
