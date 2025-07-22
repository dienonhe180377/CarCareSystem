package controller;

import dao.FeedbackDAO;
import entity.Feedback;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Vector;

@WebServlet(name = "FeedbackServlet", urlPatterns = {"/feedback"})
public class FeedbackServlet extends HttpServlet {

    private final FeedbackDAO feedbackDAO = new FeedbackDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String serviceIdStr = request.getParameter("serviceId");
        Vector<Feedback> feedbackList;

        if (serviceIdStr != null) {
            try {
                int serviceId = Integer.parseInt(serviceIdStr);
                feedbackList = feedbackDAO.getFeedbackByServiceId(serviceId);
            } catch (NumberFormatException e) {
                feedbackList = new Vector<>();
            }
        } else {
            feedbackList = feedbackDAO.getAllFeedback();
        }

        request.setAttribute("feedbackList", feedbackList);
        request.getRequestDispatcher("Feedback/feedback.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        
        User user = (User) session.getAttribute("user");

        // Nếu chưa đăng nhập thì chuyển về trang login
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Feedback feedback = feedbackDAO.getFeedbackById(id);

                if (feedback != null && feedback.getUserId() == user.getId()) {
                    feedbackDAO.deleteFeedback(id);
                }
                response.sendRedirect("feedback");
                return;
            }

            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String description = request.getParameter("description");
                int rating = Integer.parseInt(request.getParameter("rating"));
                Feedback feedback = feedbackDAO.getFeedbackById(id);

                if (feedback != null && feedback.getUserId() == user.getId()) {
                    feedbackDAO.updateFeedback(id, description, rating);
                }
                response.sendRedirect("feedback");
                return;
            }

            // Thêm feedback mới
            String description = request.getParameter("description");
            String ratingStr = request.getParameter("rating");
            String serviceIdStr = request.getParameter("serviceId");

            if (description != null && ratingStr != null && serviceIdStr != null
                    && !description.trim().isEmpty()) {
                int rating = Integer.parseInt(ratingStr);
                int serviceId = Integer.parseInt(serviceIdStr);

                feedbackDAO.addFeedback(user.getId(), serviceId, description, rating);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("feedback");
    }
}
