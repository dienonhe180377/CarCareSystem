<%-- 
    Document   : order
    Created on : Jun 27, 2025, 3:58:39 PM
    Author     : TRAN ANH HAI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, entity.CarType, entity.Service, entity.Part" %>
<%@ page import="dao.CarTypeDAO, dao.ServiceDAO, dao.PartDAO" %>
<%@ page import="entity.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    CarTypeDAO carDAO = new CarTypeDAO();
    ServiceDAO serviceDAO = new ServiceDAO();
    PartDAO partDAO = new PartDAO();

    List<CarType> carTypes = carDAO.getAllCarTypes();
    List<Service> services = serviceDAO.getAllService();
    List<Part> parts = partDAO.getAllPart();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đặt lịch sửa xe</title>
    </head>
    <body>
        <h2>Đặt lịch sửa xe</h2>
        <form action="order" method="post">
            <label>Họ và tên:</label><br/>
            <input type="text" name="fullName" required
                value="<%= currentUser != null ? currentUser.getUsername() : "" %>"
                <%= currentUser != null ? "readonly" : "" %>><br/><br/>

            <label>Email:</label><br/>
            <input type="email" name="email" required
                value="<%= currentUser != null ? currentUser.getEmail() : "" %>"
                <%= currentUser != null ? "readonly" : "" %>><br/><br/>

            <label>Số điện thoại:</label><br/>
            <input type="text" name="phone" required
                value="<%= currentUser != null ? currentUser.getPhone() : "" %>"
                <%= currentUser != null ? "readonly" : "" %>><br/><br/>

            <label>Địa chỉ:</label><br/>
            <input type="text" name="address" required
                value="<%= currentUser != null ? currentUser.getAddress() : "" %>"
                <%= currentUser != null ? "readonly" : "" %>><br/><br/>

            <% if (carTypes != null && !carTypes.isEmpty()) { %>
            <select name="carTypeId" required>
            <% for(CarType c : carTypes) { %>
                <option value="<%= c.getId() %>"><%= c.getName() %></option>
            <% } %>
            </select>
            <% } else { %>
                <p>Không có loại xe nào trong hệ thống.</p>
            <% } %>

            <label>Ngày hẹn:</label><br/>
            <input type="datetime-local" name="appointmentDate" required><br/><br/>

            <label>Dịch vụ muốn đặt:</label><br/>
            <% for(Service s : services) { %>
                <input type="checkbox" name="serviceIds" value="<%= s.getId() %>"><%= s.getName() %><br/>
            <% } %>
            <br/>

            <label>Thêm phụ tùng (nếu cần):</label><br/>
            <% for(Part p : parts) { %>
                <input type="checkbox" name="partIds" value="<%= p.getId() %>"><%= p.getName() %><br/>
            <% } %>
            <br/>

            <label>Hình thức thanh toán:</label><br/>           
            <input type="radio" name="paymentStatus" value="Thanh toán trước bằng tiền mặt"> Trả trước tiền mặt<br/>
            <input type="radio" name="paymentStatus" value="Chuyển khoản ngân hàng"> Chuyển khoản<br/><br/>

            <input type="submit" value="Đặt lịch">
        </form>
        <% if (request.getAttribute("message") != null) { %>
            <p style="color:green"><%= request.getAttribute("message") %></p>
        <% } %>
    </body>
</html>
