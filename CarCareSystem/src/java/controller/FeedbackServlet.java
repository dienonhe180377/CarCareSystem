package controller;

import dao.FeedbackDAO;
import entity.Feedback;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Vector;

@WebServlet(name = "FeedbackServlet", urlPatterns = {"/feedback"})
public class FeedbackServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getMethod();
        FeedbackDAO feedbackDAO = new FeedbackDAO();

        if (method.equalsIgnoreCase("POST")) {
    String action = request.getParameter("action");
    if ("delete".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        feedbackDAO.deleteFeedback(id);
        response.sendRedirect("feedback");
        return;
    } else if ("update".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        String description = request.getParameter("description");
        feedbackDAO.updateFeedback(id, description);
        response.sendRedirect("feedback");
        return;
    }
    // Thêm feedback như cũ
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");
    if (user == null) {
//        user = new User(4, "customer01", "123");
//        session.setAttribute("user", user);
        user = new User(1, "admin01", "123");
        session.setAttribute("user", user);
    }
    String description = request.getParameter("description");
    if (description != null && !description.trim().isEmpty()) {
        feedbackDAO.addFeedback(user.getId(), description);
    }
    response.sendRedirect("feedback");
} else {
    Vector<Feedback> feedbackList = feedbackDAO.getAllFeedback();
    request.setAttribute("feedbackList", feedbackList);
    request.setAttribute("feedbackDAO", feedbackDAO); // Thêm dòng này
    request.getRequestDispatcher("Feedback/feedback.jsp").forward(request, response);
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
}