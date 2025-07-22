package controller;

import dao.ServiceDAO;
import entity.Part;
import java.io.IOException;
import java.util.Vector;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="PartUserServlet", urlPatterns={"/part"})
public class PartUserServlet extends HttpServlet {

    private static final int PAGE_SIZE = 9; // Số phụ tùng mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ServiceDAO serviceDAO = new ServiceDAO();

        // Lấy từ khóa tìm kiếm từ request (nếu có)
        String keyword = request.getParameter("keyword");
        Vector<Part> allParts;

        // Nếu có từ khóa, lọc phụ tùng theo tên chứa keyword
        if (keyword != null && !keyword.trim().isEmpty()) {
            allParts = new Vector<>();
            for (Part p : serviceDAO.getAllParts()) {
                if (p.getName() != null && p.getName().toLowerCase().contains(keyword.trim().toLowerCase())) {
                    allParts.add(p);
                }
            }
        } else {
            allParts = serviceDAO.getAllParts();
        }

        // Lấy số trang hiện tại từ request
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ex) {
                page = 1;
            }
        }

        // Phân trang
        int totalParts = allParts.size();
        int totalPage = (int) Math.ceil((double) totalParts / PAGE_SIZE);
        int start = (page - 1) * PAGE_SIZE;
        int end = Math.min(start + PAGE_SIZE, totalParts);

        Vector<Part> partsPage = new Vector<>();
        if (start < end && start >= 0) {
            for (Part p : allParts.subList(start, end)) {
                // Đảm bảo mọi Part đều có đúng đường dẫn image là "image/[tên file]"
                if (p.getImage() != null && !p.getImage().startsWith("image/")) {
                    p.setImage("image/" + p.getImage());
                }
                partsPage.add(p);
            }
        }

        // Truyền dữ liệu cho JSP
        request.setAttribute("parts", partsPage);        // Danh sách phụ tùng trang hiện tại
        request.setAttribute("currentPage", page);       // Trang hiện tại
        request.setAttribute("totalPage", totalPage);    // Tổng số trang
        request.setAttribute("keyword", keyword);        // Để giữ lại keyword khi chuyển trang

        // Forward sang trang JSP
        request.getRequestDispatcher("partUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }
}