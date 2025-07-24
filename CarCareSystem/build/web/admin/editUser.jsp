<%-- 
    Document   : editUser
    Created on : Jun 5, 2025, 7:36:26 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="entity.User" %>
<html>
    <head>
        <title>Sửa User</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }

            header {
                background-color: lightblue;
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #ddd;
            }

            header h1 {
                margin: 0;
                font-size: 24px;
                font-weight: bold;
            }

            .container {
                max-width: 500px;
                margin: 50px auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.05);
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin: 10px 0 5px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="password"],
            input[type="email"],
            select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                margin-bottom: 15px;
            }

            button {
                width: 100%;
                background-color: lightblue;
                color: #fff;
                border: none;
                padding: 12px;
                border-radius: 6px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #4daee0;
            }

            .error-message {
                color: red;
                margin-top: 10px;
                text-align: center;
            }

            .back-link {
                display: block;
                margin-top: 20px;
                text-align: center;
                text-decoration: none;
                color: #007bff;
            }

            .back-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="container">
            <%
                User user = (User) request.getAttribute("user");              
                if (user != null) {
            %>
            <h2>Sửa thông tin User</h2>
            <form action="${pageContext.request.contextPath}/admin/editUser" method="post">
                <input type="hidden" name="id" value="<%= user.getId() %>"/>

                Username: <input type="text" name="username" value="<%= user.getUsername() %>" required/><br/>
                Email: <input type="email" name="email" value="<%= user.getEmail() %>"/><br/>
                Phone: <input type="text" name="phone" value="<%= user.getPhone() %>"/><br/>
                Address: <input type="text" name="address" value="<%= user.getAddress() %>"/><br/>
                Role:
                <select name="userRole" required>
                    <option value="admin" <%= "admin".equals(user.getUserRole()) ? "selected" : "" %>>Admin</option>
                    <option value="manager" <%= "manager".equals(user.getUserRole()) ? "selected" : "" %>>Manager</option>
                    <option value="repairer" <%= "repairer".equals(user.getUserRole()) ? "selected" : "" %>>Repairer</option>
                    <option value="customer" <%= "customer".equals(user.getUserRole()) ? "selected" : "" %>>Customer</option>
                    <option value="warehouse_manager" <%= "warehouse_manager".equals(user.getUserRole()) ? "selected" : "" %>>Warehouse Manager</option>
                    <option value="marketing" <%= "marketing".equals(user.getUserRole()) ? "selected" : "" %>>Marketing</option>
                </select><br/><br/>
                <button type="submit">Cập nhật</button>
            </form>

            <div class="error-message">
                <%
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                        out.print(errorMessage);
                    }
                %>
                <% } %>
            </div>

            <a class="back-link" href="${pageContext.request.contextPath}/admin/userList">Quay lại danh sách</a>
        </div>
    </body>
</html>