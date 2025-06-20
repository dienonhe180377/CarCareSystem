package controller;

import dao.InsuranceDAO;
import entity.Insurance;
import entity.User;
import entity.CarType;
import java.io.IOException;
import java.sql.Date;
import java.util.Vector;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="InsuranceServlet", urlPatterns={"/insurance"})
public class InsuranceServlet extends HttpServlet {
    private static final String sql = "SELECT * FROM [dbo].[Insurance]";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        InsuranceDAO dao = new InsuranceDAO();
        String service = request.getParameter("service");
        if (service == null) {
            service = "listInsurance";
        }

        User currentUser = (User) request.getSession().getAttribute("user");
        if (currentUser == null) {
//           response.sendRedirect("views/auth/login.jsp");
//            return;
            currentUser = new User(1, "admin", "admin");
            request.getSession().setAttribute("user", currentUser);

//        currentUser = new User(1, "testuser", "repairer");
//            request.getSession().setAttribute("user", currentUser);

        }
        String role = currentUser.getUserRole();

        boolean canEdit = "admin".equals(role) || "manager".equals(role) || "maketing".equals(role);

        if (service.equals("listInsurance")) {
    int page = 1;
    int pageSize = 5;
    if (request.getParameter("page") != null) {
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            page = 1;
        }
    }
    Vector<Insurance> list;
    int totalRecords = 0;
    if (canEdit) {
        totalRecords = dao.getTotalInsuranceCount();
        list = dao.getInsuranceByPage(page, pageSize);
    } else {
        // Nếu là user thường, chỉ lấy của user đó, có thể tự viết phân trang tương tự
        list = dao.getInsuranceByUserId(currentUser.getId());
        totalRecords = list.size();
        // Nếu muốn phân trang cho user thường, cần viết thêm hàm getInsuranceByUserIdAndPage
    }
    int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);

    request.setAttribute("data", list);
    request.setAttribute("role", role);
    request.setAttribute("currentPage", page);
    request.setAttribute("totalPages", totalPages);
    request.getRequestDispatcher("Insurance/Insurance.jsp").forward(request, response);
} else if (service.equals("addInsurance")) {
            if (!canEdit) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thêm bảo hiểm.");
                return;
            }
            String submit = request.getParameter("submit");
            if (submit == null) {
                Vector<User> userList = dao.getAllUsers();
                Vector<CarType> carTypeList = dao.getAllCarTypes();
                request.setAttribute("user", userList);
                request.setAttribute("carType", carTypeList);
                request.setAttribute("role", role);
                request.getRequestDispatcher("Insurance/addInsurance.jsp").forward(request, response);
            } else {
                int userId = Integer.parseInt(request.getParameter("userId"));
                int carTypeId = Integer.parseInt(request.getParameter("carTypeId"));
                Date startDate = Date.valueOf(request.getParameter("startDate"));
                Date endDate = Date.valueOf(request.getParameter("endDate"));
                String priceStr = request.getParameter("price");
                String description = request.getParameter("discription");

                // Validate price
                float price = 0;
                boolean valid = true;
                String errorMsg = "";
                try {
                    price = Float.parseFloat(priceStr);
                    if (price < 0) {
                        valid = false;
                        errorMsg = "Giá phải lớn hơn hoặc bằng 0!";
                    }
                } catch (NumberFormatException e) {
                    valid = false;
                    errorMsg = "Giá phải là số!";
                }

                if (!valid) {
                    Vector<User> userList = dao.getAllUsers();
                    Vector<CarType> carTypeList = dao.getAllCarTypes();
                    request.setAttribute("user", userList);
                    request.setAttribute("carType", carTypeList);
                    request.setAttribute("role", role);
                    request.setAttribute("error", errorMsg);
                    request.getRequestDispatcher("Insurance/addInsurance.jsp").forward(request, response);
                    return;
                }

                Insurance i = new Insurance(userId, carTypeId, startDate, endDate, price, description);
                dao.addInsurance(i);
                // Lấy lại dữ liệu phân trang trang 1
        int page = 1;
        int pageSize = 5;
        int totalRecords = dao.getTotalInsuranceCount();
        int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);
        Vector<Insurance> list = dao.getInsuranceByPage(page, pageSize);

        request.setAttribute("data", list);
        request.setAttribute("role", role);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("Insurance/Insurance.jsp").forward(request, response);
            }

        } else if (service.equals("deleteInsurance")) {
    if (!canEdit) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xóa bảo hiểm.");
        return;
    }
    int id = Integer.parseInt(request.getParameter("id"));
    dao.deleteInsurance(id);

    // Sau khi xóa, lấy lại dữ liệu phân trang trang 1
    int page = 1;
    int pageSize = 5;
    int totalRecords = dao.getTotalInsuranceCount();
    int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);
    Vector<Insurance> list = dao.getInsuranceByPage(page, pageSize);

    request.setAttribute("data", list);
    request.setAttribute("role", role);
    request.setAttribute("currentPage", page);
    request.setAttribute("totalPages", totalPages);
    request.getRequestDispatcher("Insurance/Insurance.jsp").forward(request, response);

} else if (service.equals("updateInsurance")) {
    if (!canEdit) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền sửa bảo hiểm.");
        return;
    }
    String submit = request.getParameter("submit");
    if (submit == null) {
        int id = Integer.parseInt(request.getParameter("id"));
        Insurance ins = dao.searchInsurance(id);
        Vector<User> userList = dao.getAllUsers();
        Vector<CarType> carTypeList = dao.getAllCarTypes();
        request.setAttribute("insurance", ins);
        request.setAttribute("user", userList);
        request.setAttribute("carType", carTypeList);
        request.setAttribute("role", role);
        request.getRequestDispatcher("Insurance/updateInsurance.jsp").forward(request, response);
    } else {
        int id = Integer.parseInt(request.getParameter("id"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        int carTypeId = Integer.parseInt(request.getParameter("carTypeId"));
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        float price = Float.parseFloat(request.getParameter("price"));
        String description = request.getParameter("discription");
        Insurance i = new Insurance(id, userId, carTypeId, startDate, endDate, price, description);
        dao.updateInsurance(i);

        // Sau khi cập nhật, lấy lại dữ liệu phân trang trang 1
        int page = 1;
        int pageSize = 5;
        int totalRecords = dao.getTotalInsuranceCount();
        int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);
        Vector<Insurance> list = dao.getInsuranceByPage(page, pageSize);

        request.setAttribute("data", list);
        request.setAttribute("role", role);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("Insurance/Insurance.jsp").forward(request, response);
    
}
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
        return "InsuranceServlet";
    }
}