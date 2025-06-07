package controller;

import dao.ServiceDAO;
import entity.Service;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Vector;

@WebServlet(name = "ServiceServlet_JSP", urlPatterns = {"/ServiceServlet_JSP"})
public class ServiceServlet_JSP extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ServiceDAO dao = new ServiceDAO();
        String service = request.getParameter("service");
        if (service == null) {
            service = "listService";
        }
        try {
            switch (service) {
                case "deleteService": {
                    int seid = Integer.parseInt(request.getParameter("id"));
                    dao.deleteService(seid);
                    response.sendRedirect("ServiceServlet_JSP");
                    break;
                }
                case "updateService": {
                    String submit = request.getParameter("submit");
                    if (submit == null) {
                        int id = Integer.parseInt(request.getParameter("id"));
                        Service ser = dao.searchService(id);
                        request.setAttribute("service", ser);
                        request.getRequestDispatcher("jsp/UpdateService.jsp").forward(request, response);
                    } else {
                        int id = Integer.parseInt(request.getParameter("id"));
                        String name = request.getParameter("name");
                        String description = request.getParameter("description");
                        double price = Double.parseDouble(request.getParameter("price"));
                        Service se = new Service(id, name, description, price);
                        dao.updateService(se);
                        response.sendRedirect("ServiceServlet_JSP?service=listService");
                    }
                    break;
                }
                case "addService": {
                    String submit = request.getParameter("submit");
                    if (submit == null) {
                        request.getRequestDispatcher("jsp/InsertService.jsp").forward(request, response);
                    } else {
                        String name = request.getParameter("name");
                        String description = request.getParameter("description");
                        double price = Double.parseDouble(request.getParameter("price"));
                        Service se = new Service(0, name, description, price);
                        dao.insertService(se);
                        response.sendRedirect("ServiceServlet_JSP?service=listService");
                    }
                    break;
                }
                case "detailService": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Service se = dao.searchService(id);
                    request.setAttribute("service", se);
                    request.getRequestDispatcher("jsp/ServiceDetail.jsp").forward(request, response);
                    break;
                }
                case "previewService": {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Service se = dao.searchService(id);
                    request.setAttribute("service", se);
                    request.getRequestDispatcher("jsp/ServicePreview.jsp").forward(request, response);
                    break;
                }
                case "listService": {
                    Vector<Service> list;
                    String searchName = request.getParameter("name");
                    if (searchName == null || searchName.isEmpty()) {
                        list = dao.getAllService();
                    } else {
                        list = dao.searchServiceByName(searchName);
                    }
                    request.setAttribute("data", list);
                    request.setAttribute("pageTitle", "Service Manager");
                    request.setAttribute("tableTitle", "List of Service");

                    RequestDispatcher dispath = request.getRequestDispatcher("jsp/ServiceJSP.jsp");
                    dispath.forward(request, response);
                    break;
                }
                default:
                    response.sendRedirect("ServiceServlet_JSP?service=listService");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Internal Server Error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "ServiceServlet_JSP";
    }
}