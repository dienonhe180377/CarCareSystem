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
//        currentUser = new User(1, "admin", "admin");
//        request.getSession().setAttribute("user", currentUser);
        currentUser = new User(1, "testuser", "repairer");
            request.getSession().setAttribute("user", currentUser);
    }
    String role = currentUser.getUserRoleStr();

    boolean canEdit = "admin".equals(role) || "manager".equals(role) || "maketing".equals(role);

    if (service.equals("listInsurance")) {
        Vector<Insurance> list;
        if (canEdit) {
            list = dao.getAllInsurance(sql);
        } else {
            list = dao.getInsuranceByUserId(currentUser.getId());
        }
        request.setAttribute("data", list);
        request.setAttribute("role", role);
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
            float price = Float.parseFloat(request.getParameter("price"));
            String description = request.getParameter("discription");
            Insurance i = new Insurance(userId, carTypeId, startDate, endDate, price, description);
            dao.addInsurance(i);
            Vector<Insurance> list = dao.getAllInsurance(sql);
            request.setAttribute("data", list);
            request.setAttribute("role", role);
            request.getRequestDispatcher("Insurance/Insurance.jsp").forward(request, response);
        }

    } else if (service.equals("deleteInsurance")) {
        if (!canEdit) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xóa bảo hiểm.");
            return;
        }
        int id = Integer.parseInt(request.getParameter("id"));
        dao.deleteInsurance(id);
        Vector<Insurance> list = dao.getAllInsurance(sql);
        request.setAttribute("data", list);
        request.setAttribute("role", role);
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
            Vector<Insurance> list = dao.getAllInsurance(sql);
            request.setAttribute("data", list);
            request.setAttribute("role", role);
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