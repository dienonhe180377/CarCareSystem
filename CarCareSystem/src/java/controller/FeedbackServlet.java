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

    /**
     * Xử lý các request GET và POST cho chức năng feedback.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        String method = request.getMethod();
        FeedbackDAO feedbackDAO = new FeedbackDAO();

        if (method.equalsIgnoreCase("POST")) {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Feedback feedback = feedbackDAO.getFeedbackById(id);

                if (feedback != null && user != null && feedback.getUserId() == user.getId()) {
                    feedbackDAO.deleteFeedback(id);
                } else {
                    System.out.println("Không có quyền xóa hoặc feedback không tồn tại.");
                }
                response.sendRedirect("feedback");
                return;
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String description = request.getParameter("description");
                Feedback feedback = feedbackDAO.getFeedbackById(id);

                if (feedback != null && user != null && feedback.getUserId() == user.getId()) {
                    feedbackDAO.updateFeedback(id, description);
                } else {
                    System.out.println("Không có quyền cập nhật hoặc feedback không tồn tại.");
                }
                response.sendRedirect("feedback");
                return;
            }

            // THÊM FEEDBACK
            if (user == null) {
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
            request.setAttribute("feedbackDAO", feedbackDAO);
            request.getRequestDispatcher("Feedback/feedback.jsp").forward(request, response);
        }

    } catch (Exception e) {
        e.printStackTrace(); // In lỗi ra console
        response.getWriter().println("<h3>Lỗi hệ thống:</h3><pre>" + e.getMessage() + "</pre>");
    }
}


    /**
     * Xử lý request GET.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Xử lý request POST.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
