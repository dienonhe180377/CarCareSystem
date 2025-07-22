package controller;

import dao.InsTypeDAO;
import entity.InsuranceType;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Vector;

@WebServlet(name="InsTypeServlet", urlPatterns={"/instype"})
public class InsTypeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        InsTypeDAO dao = new InsTypeDAO();
        String action = request.getParameter("action");
        if (action == null) action = "list";

        // Lấy user từ session
        User currentUser = (User) request.getSession().getAttribute("user");
        String role = (currentUser != null) ? currentUser.getUserRole() : "";
        boolean canEdit = "admin".equals(role) || "manager".equals(role);

        if (action.equals("list")) {
            String keyword = request.getParameter("keyword");
            int page = 1;
            int pageSize = 5;
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            Vector<InsuranceType> list;
            int totalRecords = 0;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = dao.searchInsuranceTypeByName(keyword.trim());
                totalRecords = list.size();
                page = 1; // Khi tìm kiếm chỉ hiển thị trang đầu
            } else {
                totalRecords = dao.getTotalInsuranceTypeCount();
                list = dao.getInsuranceTypeByPage(page, pageSize);
            }
            int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);

            request.setAttribute("list", list);
            request.setAttribute("keyword", keyword);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("role", role);
            if ("customer".equals(role)) {
    request.getRequestDispatcher("InsuranceType/InsuranceTypeCustomer.jsp").forward(request, response);
} else {
    request.getRequestDispatcher("InsuranceType/InsuranceType.jsp").forward(request, response);
}

        } else if (canEdit && action.equals("add")) {
            String submit = request.getParameter("submit");
            if (submit == null) {
                request.getRequestDispatcher("InsuranceType/addInsuranceType.jsp").forward(request, response);
            } else {
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                String priceStr = request.getParameter("price");
                String error = null;

                // Regex: chỉ cho phép chữ cái, số, khoảng trắng cho name và description
                String validPattern = "^[a-zA-Z0-9\\sÀ-ỹ]+$";
                double price = 0;
                try {
                    price = Double.parseDouble(priceStr);
                } catch (Exception e) {
                    error = "Giá phải là số!";
                }

                if (name == null || !name.matches(validPattern)) {
                    error = "Tên không được chứa ký tự đặc biệt!";
                } else if (description == null || !description.matches(validPattern)) {
                    error = "Mô tả không được chứa ký tự đặc biệt!";
                } else if (price <= 0) {
                    error = "Giá phải lớn hơn 0!";
                }

                if (error != null) {
                    request.setAttribute("error", error);
                    request.setAttribute("name", name);
                    request.setAttribute("description", description);
                    request.setAttribute("price", priceStr);
                    request.getRequestDispatcher("InsuranceType/addInsuranceType.jsp").forward(request, response);
                } else {
                    InsuranceType type = new InsuranceType(name, description, price);
                    dao.addInsuranceType(type);
                    response.sendRedirect("instype?action=list");
                }
            }

        } else if (canEdit && action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            InsuranceType type = dao.getInsuranceTypeById(id);
            request.setAttribute("type", type);
            request.getRequestDispatcher("InsuranceType/updateInsuranceType.jsp").forward(request, response);

        } else if (canEdit && action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String error = null;

            String validPattern = "^[a-zA-Z0-9\\sÀ-ỹ]+$";
            double price = 0;
            try {
                price = Double.parseDouble(priceStr);
            } catch (Exception e) {
                error = "Giá phải là số!";
            }

            if (name == null || !name.matches(validPattern)) {
                error = "Tên không được chứa ký tự đặc biệt!";
            } else if (description == null || !description.matches(validPattern)) {
                error = "Mô tả không được chứa ký tự đặc biệt!";
            } else if (price <= 0) {
                error = "Giá phải lớn hơn 0!";
            }

            if (error != null) {
                InsuranceType type = new InsuranceType(id, name, description, price);
                request.setAttribute("error", error);
                request.setAttribute("type", type);
                request.getRequestDispatcher("InsuranceType/updateInsuranceType.jsp").forward(request, response);
            } else {
                InsuranceType type = new InsuranceType(id, name, description, price);
                dao.updateInsuranceType(type);
                response.sendRedirect("instype?action=list");
            }
        } else if (canEdit && action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteInsuranceType(id);
            response.sendRedirect("instype?action=list");

        } else {
            // Không có quyền, chuyển về danh sách
            response.sendRedirect("instype?action=list");
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