<%-- 
    Document   : dashboard
    Created on : Jun 3, 2025, 7:21:08 PM
    Author     : GIGABYTE
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="entity.User" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    request.setAttribute("role", user.getUserRoleStr().toLowerCase());
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                height: 100vh;
                overflow: hidden;
                position: relative;
            }

            .sidebar {
                width: 250px;
                background-color: lightblue;
                border-right: 1px solid #ddd;
                padding: 20px;
                overflow-y: auto;
                transition: left 0.3s ease;
                position: fixed;
                top: 0;
                left: -250px;
                bottom: 0;
                z-index: 1000;
            }

            .sidebar.open {
                left: 0;
            }

            .overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.4);
                z-index: 999;
                display: none;
            }

            .overlay.show {
                display: block;
            }

            .sidebar h2 {
                font-size: 24px;
                color: #333;
                margin-bottom: 20px;
            }

            .sidebar a {
                display: block;
                text-decoration: none;
                color: #333;
                padding: 10px 0;
                font-size: 16px;
            }

            .sidebar a:hover {
                color: #007bff;
            }

            .main-content {
                margin-left: 0;
                transition: margin-left 0.3s ease;
                height: 100vh;
                display: flex;
                flex-direction: column;
                background-color: #f8f9fa;
            }

            .main-content.shifted {
                margin-left: 250px;
            }

            header {
                background-color: lightblue;
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #ddd;
            }

            .menu-button {
                background: none;
                border: none;
                font-size: 24px;
                cursor: pointer;
                margin-right: 20px;
            }

            header .title {
                font-size: 24px;
                font-weight: bold;
                display: flex;
                align-items: center;
            }

            header .profile {
                display: flex;
                align-items: center;
            }

            header .profile img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-left: 15px;
            }

            .dashboard {
                padding: 30px;
                flex: 1;
                overflow-y: auto;
            }

            .cards {
                display: flex;
                gap: 20px;
                margin-bottom: 30px;
            }

            .card {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                flex: 1;
                box-shadow: 0 0 10px rgba(0,0,0,0.05);
            }

            .map-section, .stats-section {
                display: flex;
                gap: 20px;
            }

            .map, .stats {
                flex: 1;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
            }

            .chart-placeholder {
                width: 100%;
                height: 300px;
                background-color: #eaeaea;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #777;
                border-radius: 8px;
            }
        </style>
    </head>
    <body>       
        <div id="sidebar" class="sidebar">
            <h2>Adminator</h2>
            <a href="#">Dashboard</a>
            <a href="#">Email</a>
            <a href="#">Compose</a>
            <a href="#">Calendar</a>
            <a href="#">Chat</a>
            <a href="#">Charts</a>
            <a href="#">Forms</a>
            <a href="#">UI Elements</a>
            <a href="#">Tables</a>
            <a href="#">Maps</a>
            <a href="#">Pages</a>
            <a href="#">Multiple Levels</a>
        </div>

        <div id="overlay" class="overlay" onclick="toggleSidebar()"></div>

        <div id="mainContent" class="main-content">
            <header>
                <div class="title">
                    <button class="menu-button" onclick="toggleSidebar()">☰</button>
                    Dashboard
                </div>
                <div class="profile">
                    <span>John Doe</span>
                    <img src="https://via.placeholder.com/40" alt="Profile">
                </div>
            </header>

            <div class="dashboard">
                <div class="cards">
                    <div class="card">Total Visits<br><strong>+10%</strong></div>
                    <div class="card">Total Page Views<br><strong>-7%</strong></div>
                    <div class="card">Unique Visitors<br><strong>-12%</strong></div>
                    <div class="card">Bounce Rate<br><strong>33%</strong></div>
                </div>

                <div class="map-section">
                    <div class="map">
                        <div class="chart-placeholder">Map Placeholder</div>
                    </div>
                    <div class="stats">
                        <div class="chart-placeholder">Stats Placeholder</div>
                    </div>
                </div>

                <hr>
                <h1>Chào mừng, <%= user.getUsername() %>!</h1>
                <h3>Vai trò của bạn: <%= user.getUserRoleStr() %></h3>

                <%-- Hiển thị nội dung theo vai trò --%>
                <c:choose>
                    <c:when test="${role == 'admin'}">
                        <p>Đây là nội dung dành cho Admin.</p>
                        <h2>Danh sách User</h2>
                        <a href="${pageContext.request.contextPath}/addUser">Thêm User mới</a>
                        <table border="1" cellpadding="5" cellspacing="0">
                            <tr>
                                <th>ID</th><th>Username</th><th>Email</th><th>Role</th><th>Hành động</th>
                            </tr>
                            <%
                                List<User> users = (List<User>) request.getAttribute("users");
                                if (users != null) {
                                    for (User u : users) {
                            %>
                            <tr>
                                <td><%= u.getId() %></td>
                                <td><%= u.getUsername() %></td>
                                <td><%= u.getEmail() %></td>
                                <td><%= u.getUserRole() %></td>
                                <td><a href="<%= request.getContextPath() %>/
                                       userDetail?id=<%= u.getId() %>">Xem chi tiết</a></td>
                            </tr>
                            <%      }
                            } else { %>
                            <tr><td colspan="5">Chưa có user nào</td></tr>
                            <% } %>
                        </table>
                    </c:when>
                    <c:when test="${role == 'manager'}">
                        <p>Đây là nội dung dành cho Manager.</p>
                        <%-- Thêm chức năng quản lý dịch vụ, nhân sự --%>
                    </c:when>
                    <c:when test="${role == 'repairer'}">
                        <p>Đây là nội dung dành cho Repairer.</p>
                        <%-- Thêm chức năng cập nhật sửa chữa --%>
                    </c:when>
                    <c:when test="${role == 'warehouse_manager'}">
                        <p>Đây là nội dung dành cho Warehouse Manager.</p>
                        <%-- Thêm chức năng quản lý kho --%>
                    </c:when>
                    <c:when test="${role == 'marketing'}">
                        <p>Đây là nội dung dành cho Marketing.</p>
                        <%-- Thêm chức năng quản lý khuyến mãi --%>
                    </c:when>
                    <c:otherwise>
                        <p>Vai trò không xác định.</p>
                    </c:otherwise>
                </c:choose>

                <hr>
            </div>
        </div>

        <script>
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                const overlay = document.getElementById('overlay');
                const mainContent = document.getElementById('mainContent');
                const isOpen = sidebar.classList.contains('open');

                if (isOpen) {
                    sidebar.classList.remove('open');
                    overlay.classList.remove('show');
                    mainContent.classList.remove('shifted');
                } else {
                    sidebar.classList.add('open');
                    overlay.classList.add('show');
                    mainContent.classList.add('shifted');
                }
            }
        </script>
    </body>
</html>