<%-- 
    Document   : userDetail
    Created on : Jun 5, 2025, 6:57:29 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="entity.User" %>
<html>
    <head>
        <title>Chi tiết User</title>
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
                max-width: 700px;
                margin: 40px auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.05);
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            .info p {
                font-size: 16px;
                margin-bottom: 12px;
                color: #333;
            }

            .back-link {
                display: inline-block;
                margin-top: 30px;
                padding: 10px 16px;
                background-color: lightblue;
                color: #fff;
                text-decoration: none;
                border-radius: 6px;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }

            .back-link:hover {
                background-color: #4daee0;
            }

            .not-found {
                text-align: center;
                font-size: 18px;
                color: red;
                margin-top: 50px;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="container">
            <%
                User user = (User) request.getAttribute("user");
                if (user == null) {
            %>
            <div class="not-found">Không tìm thấy user.</div>
            <%
                } else {
            %>
            <h2>Chi tiết User: <%= user.getUsername() %></h2>
            <div class="info">
                <p><strong>ID:</strong> <%= user.getId() %></p>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
                <p><strong>Phone:</strong> <%= user.getPhone() %></p>
                <p><strong>Address:</strong> <%= user.getAddress() %></p>
                <p><strong>Role:</strong> <%= user.getUserRole() %></p>
                <p><strong>Ngày tạo:</strong> <%= user.getCreatedDate() %></p>
            </div>
            <%
                }
            %>
            <a class="back-link" href="${pageContext.request.contextPath}/admin/userList">← Quay lại danh sách</a>
        </div>
    </body>
</html>