<%-- 
    Document   : userList
    Created on : Jun 5, 2025, 3:06:34 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<html>
    <head>
        <title>Danh sách User</title>
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
                max-width: 900px;
                margin: 40px auto;
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

            .top-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                gap: 10px;
            }

            .search-form {
                display: flex;
                align-items: center;
                gap: 6px;
                height: 40px;
            }

            .search-form input[type="text"] {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                height: 100%;
            }

            .search-form button {
                padding: 8px 12px;
                border: none;
                border-radius: 5px;
                background-color: lightblue;
                color: black;
                cursor: pointer;
                height: 100%;
            }

            .search-form button:hover {
                background-color: deepskyblue;
                color: white;
            }

            .add-user {
                padding: 8px 16px;
                background-color: lightblue;
                color: #fff;
                border-radius: 6px;
                text-decoration: none;
                font-weight: bold;
                transition: background-color 0.3s ease;
                height: 40px;
                display: flex;
                align-items: center;
            }

            .add-user:hover {
                background-color: deepskyblue;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
            }

            th, td {
                padding: 12px;
                border: 1px solid #ccc;
                text-align: left;
            }

            th {
                background-color: #f1f1f1;
            }

            .no-user {
                text-align: center;
                color: #999;
                padding: 20px;
            }

            button {
                padding: 5px 10px;
                margin: 0 2px;
                border: none;
                border-radius: 4px;
                background-color: lightblue;
                color: black;
                cursor: pointer;
            }

            button:hover {
                background-color: deepskyblue;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="container"> 
            <h2>Danh sách User</h2>
            <div class="top-bar">
                <a class="add-user" href="${pageContext.request.contextPath}/admin/addUser">+ Thêm User mới</a>
                <form class="search-form" action="${pageContext.request.contextPath}/admin/userList" method="get">
                    <input type="text" name="search" placeholder="Tìm username..." value="${param.search}"/>
                    <button type="submit">Tìm</button>          
                </form>             
            </div>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Hành động</th>
                </tr>
                <%
                    List<User> users = (List<User>) request.getAttribute("users");
                    if (users != null && !users.isEmpty()) {
                        for (User u : users) {
                %>
                <tr>
                    <td><%= u.getId() %></td>
                    <td><%= u.getUsername() %></td>
                    <td><%= u.getEmail() %></td>
                    <td><%= u.getUserRole() %></td>
                    <td>
                        <form action="<%= request.getContextPath() %>/admin/userDetail" method="get" style="display:inline;">
                            <input type="hidden" name="id" value="<%= u.getId() %>"/>
                            <button type="submit">Xem</button>
                        </form>

                        <form action="<%= request.getContextPath() %>/admin/editUser" method="get" style="display:inline;">
                            <input type="hidden" name="id" value="<%= u.getId() %>"/>
                            <button type="submit">Sửa</button>
                        </form>

                        <form action="<%= request.getContextPath() %>/admin/deleteUser" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc chắn muốn xóa user này?');">
                            <input type="hidden" name="id" value="<%= u.getId() %>"/>
                            <button type="submit">Xóa</button>
                        </form>
                    </td>

                </tr>
                <% 
                        }
                    } else { 
                %>
                <tr>
                    <td colspan="5" class="no-user">Chưa có user nào</td>
                </tr>
                <% } %>
            </table>            
        </div>
    </body>
</html>