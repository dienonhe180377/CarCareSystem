package controller;

import dao.HomeDAO;
import entity.Service;
import entity.Part;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Vector;

@WebServlet(name="HomeServlet", urlPatterns={"/home"})
public class HomeServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HomeDAO homeDAO = new HomeDAO();
        Vector<Service> top3Services = homeDAO.getTop3BestServices();
        Vector<Part> top5Parts = homeDAO.getTop5FeaturedParts();

        // Không cần for này nữa, vì trong DAO đã set parts cho Service rồi!

        request.setAttribute("top3Services", top3Services);
        request.setAttribute("top5Parts", top5Parts);
        request.getRequestDispatcher("home.jsp").forward(request, response);
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
    public String getServletInfo() { return "HomeServlet phục vụ trang chủ"; }
}