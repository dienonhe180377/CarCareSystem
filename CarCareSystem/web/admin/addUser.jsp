<%-- 
    Document   : addUser
    Created on : Jun 5, 2025, 3:29:04 PM
    Author     : GIGABYTE
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Thêm User mới</title>
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
            <h2>Thêm User mới</h2>
            <form action="${pageContext.request.contextPath}/admin/addUser" method="post">
                <label>Username:</label>
                <input type="text" name="username" value="${username}" required />

                <label>Password:</label>
                <input type="password" name="password" value="${password}" required />

                <label>Email:</label>
                <input type="email" name="email" value="${email}" />

                <label>Phone:</label>
                <input type="text" name="phone" value="${phone}" />

                <label>Address:</label>
                <input type="text" name="address" value="${address}" />

                <label>Role:</label>
                <select name="userRole" required>
                    <option value="admin" ${userRole == 'admin' ? 'selected' : ''}>Admin</option>
                    <option value="manager" ${userRole == 'manager' ? 'selected' : ''}>Manager</option>
                    <option value="repairer" ${userRole == 'repairer' ? 'selected' : ''}>Repairer</option>
                    <option value="customer" ${userRole == 'customer' ? 'selected' : ''}>Customer</option>
                    <option value="warehouse_manager" ${userRole == 'warehouse_manager' ? 'selected' : ''}>Warehouse Manager</option>
                    <option value="marketing" ${userRole == 'marketing' ? 'selected' : ''}>Marketing</option>
                </select>

                <button type="submit">Thêm User</button>
            </form>

            <div class="error-message">
                <%
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                        out.print(errorMessage);
                    }
                %>
            </div>

            <a class="back-link" href="${pageContext.request.contextPath}/admin/userList">Quay lại danh sách</a>
        </div>
    </body>
</html>