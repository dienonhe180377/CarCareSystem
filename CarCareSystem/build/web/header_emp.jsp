<%-- 
    Document   : header_emp
    Created on : Jun 3, 2025, 7:21:08 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Header_Emp</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            Body {
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }


            .Sidebar {
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

            .Sidebar.open {
                left: 0;
            }

            .Overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.4);
                z-index: 999;
                display: none;
            }

            .Overlay.show {
                display: block;
            }

            .Sidebar h2 {
                font-size: 24px;
                color: #333;
                margin-bottom: 20px;
            }

            .Sidebar a {
                display: block;
                text-decoration: none;
                color: #333;
                padding: 10px 0;
                font-size: 16px;
            }

            .Sidebar a:hover {
                color: #007bff;
            }

            .Main-content {
                margin-left: 0;
                transition: margin-left 0.3s ease;
                height: 100vh;
                display: flex;
                flex-direction: column;
                background-color: #f8f9fa;
            }

            .Main-content.shifted {
                margin-left: 250px;
            }

            Header {
                background-color: lightblue;
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #ddd;
            }

            .Menu-button {
                background: none;
                border: none;
                font-size: 24px;
                cursor: pointer;
                margin-right: 20px;
                color: black;
            }

            Header .title {
                font-size: 24px;
                font-weight: bold;
                display: flex;
                align-items: center;
            }

            /* Avatar Dropdown */
            .Avatar-icon {
                font-size: 36px;
                color: black;
                cursor: pointer;
            }

            .Avatar-button {
                background: none;
                border: none;
                padding: 0;
                cursor: pointer;
            }

            .Dropdown {
                position: relative;
            }

            .Dropdown-content {
                position: absolute;
                top: 100%;
                right: 0;
                margin-top: 10px;
                background-color: white;
                min-width: 160px;
                border: 1px solid #ccc;
                border-radius: 6px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                display: none;
                z-index: 1000;
            }

            .Dropdown-content a {
                padding: 10px 16px;
                color: black;
                text-decoration: none;
                display: block;
                font-size: 14px;
            }

            .Dropdown-content a:hover {
                background-color: #f1f1f1;
            }

            .Dropdown-content.show {
                display: block;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div id="sidebar" class="Sidebar">           
            <% 
                Object role = session.getAttribute("role");
                if ("admin".equals(role)) { %>
            <h2>Admin</h2>
            <a href="${pageContext.request.contextPath}/attendance">Quản lý điểm danh</a>
            <a href="${pageContext.request.contextPath}/admin/userList">Quản lý người dùng</a>
            <a href="${pageContext.request.contextPath}/insurance">Quản lý bảo hiểm</a>
            <a href="${pageContext.request.contextPath}/ServiceServlet_JSP">Quản lý dịch vụ</a>
            <% } else if ("manager".equals(role)) { %>
            <h2>Manager</h2>
            <a href="${pageContext.request.contextPath}/categoryList.jsp">Quản lý category</a>
            <a href="${pageContext.request.contextPath}/supplierList.jsp">Quản lý nhà cung cấp</a>
            <a href="${pageContext.request.contextPath}/partList.jsp">Quản lý bộ phận</a>
            <a href="${pageContext.request.contextPath}/manager/carTypeList">Quản lý loại xe</a>
            <a href="${pageContext.request.contextPath}/insurance">Quản lý bảo hiểm</a>
            <a href="${pageContext.request.contextPath}/ServiceServlet_JSP">Quản lý dịch vụ</a>
            <% } else if ("repairer".equals(role)) { %>
            <h2>Repairer</h2>
            <a href="#"></a>
            <% } else if ("warehouse_manager".equals(role)) { %>
            <h2>Warehouse Manager</h2>
            <a href="${pageContext.request.contextPath}/categoryList.jsp">Quản lý category</a>
            <a href="${pageContext.request.contextPath}/supplierList.jsp">Quản lý nhà cung cấp</a>
            <a href="${pageContext.request.contextPath}/partList.jsp">Quản lý bộ phận</a>
            <% } else if ("marketing".equals(role)) { %>
            <h2>Marketing</h2>
            <a href="${pageContext.request.contextPath}/insurance">Quản lý bảo hiểm</a>
            <a href="${pageContext.request.contextPath}/ServiceServlet_JSP">Quản lý dịch vụ</a>
            <% } %>
        </div>

        <!-- Overlay -->
        <div id="overlay" class="Overlay" onclick="toggleSidebar()"></div>

        <!-- Header -->
        <header>
            <div class="title">
                <button class="Menu-button" onclick="toggleSidebar()">☰</button>
            </div>
            <div class="Dropdown">
                <button class="Avatar-button" onclick="toggleDropdown()">
                    <i class="fas fa-user-circle Avatar-icon"></i>
                </button>
                <div id="userDropdown" class="Dropdown-content">
                    <a href="profile.jsp">Profile</a>
                    <a href="orders.jsp">My Orders</a>
                    <a href="${pageContext.request.contextPath}/logout">Logout</a>
                </div>
            </div>
        </header>

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

            function toggleDropdown() {
                var dropdown = document.getElementById("userDropdown");
                dropdown.classList.toggle("show");
            }

            window.onclick = function (event) {
                if (!event.target.matches('.avatar-icon')) {
                    var dropdown = document.getElementById("userDropdown");
                    if (dropdown && dropdown.classList.contains('show')) {
                        dropdown.classList.remove('show');
                    }
                }
            };
        </script>
    </body>
</html>