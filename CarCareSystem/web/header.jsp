<%-- 
    Document   : header
    Created on : May 30, 2025, 2:05:47 PM
    Author     : GIGABYTE
--%>
<%
    Map<String, String> settingMap = (Map<String, String>) application.getAttribute("settingMap");
%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map" %>
<%@page import="entity.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Car Care Centre</title>
        <style>
            Body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #fff;
                padding-top: 80px;
            }

            Header {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                background-color: <%= settingMap.get("header_color") %>;
                color: #fff;
                display: grid;
                grid-template-columns: 1fr auto 1fr;
                align-items: center;
                padding: 10px 20px;
                z-index: 1000;
                box-sizing: border-box;
            }

            .Header-left {
                display: flex;
                align-items: center;
                gap: 96px;
                justify-content: flex-start;
            }

            .Header-right {
                display: flex;
                align-items: center;
                gap: 56px;
                justify-content: flex-end;
            }

            .Menu-toggle {
                background: none;
                border: none;
                color: black;
                font-size: 20px;
                cursor: pointer;
            }

            .Nav-menu {
                display: flex;
                align-items: center;
                gap: 40px;
            }

            .Nav-menu a {
                text-decoration: none;
                color: black;
                font-weight: bold;
                font-size: 18px;
                position: relative;
                padding: 6px 0;
            }

            .Nav-menu .active::after {
                content: "";
                display: block;
                width: 100%;
                height: 3px;
                background-color: red;
                position: absolute;
                bottom: -4px;
                left: 0;
            }

            .Logo img {
                height: 70px;
                transform: scale(1.75);
                transform-origin: center center;
            }

            /* Sidebar styles */
            .Sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 300px;
                height: 100%;
                background-color: lightcyan;
                color: white;
                padding: 30px 20px;
                transform: translateX(-100%);
                transition: transform 0.3s ease;
                z-index: 999;
            }

            .Sidebar.open {
                transform: translateX(0);
            }

            .Sidebar .close-btn {
                background: none;
                border: none;
                color: black;
                font-size: 24px;
                position: absolute;
                top: 20px;
                right: 20px;
                cursor: pointer;
            }

            .Sidebar nav a {
                display: block;
                color: #000;
                text-decoration: none;
                margin: 20px 0;
                font-weight: bold;
                font-size: 18px;
            }


            .Login-button {
                background-color: #fff;
                color: #000;
                border: none;
                padding: 8px 16px;
                font-weight: bold;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .Login-button:hover {
                background-color: #ccc;
            }

            .Notification-icon {
                font-size: 32px;
                color: black;
                cursor: pointer;
                margin-right: 15px;
                position: relative;
            }

            .Notification-icon:hover {
                color: red;
            }

            .Notification-count {
                position: absolute;
                top: -6px;
                right: -8px;
                background-color: red;
                color: white;
                font-size: 12px;
                padding: 2px 6px;
                border-radius: 50%;
            }

            /* Optional: badge */
            .Notification-icon .Notification-count {
                position: absolute;
                top: -6px;
                right: -8px;
                background-color: red;
                color: white;
                font-size: 12px;
                padding: 2px 6px;
                border-radius: 50%;
            }

            /* Responsive (optional) */
            @media (max-width: 768px) {
                Header {
                    flex-direction: column;
                    gap: 15px;
                }

                .Nav-menu {
                    flex-wrap: wrap;
                    justify-content: center;
                }
            }

            /* Optional overlay */
            .Overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
                z-index: 998;
                display: none;
            }

            .Overlay.active {
                display: block;
            }

            /* Avatar and dropdown */
            .Avatar-icon {
                font-size: 36px;
                color: black;
                cursor: pointer;
            }

            .Dropdown {
                position: relative;
                display: inline-block;
            }

            .Dropdown-content {
                display: none;
                position: absolute;
                right: 0;
                background-color: lightcyan;
                min-width: 160px;
                box-shadow: 0 8px 16px rgba(0,0,0,0.2);
                z-index: 1000;
            }

            .Dropdown-content a {
                color: black;
                padding: 10px 16px;
                text-decoration: none;
                display: block;
            }

            .Dropdown-content a:hover {
                background-color: #ddd;
            }

            .Show {
                display: block;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="Header-left">
                <button class="Menu-toggle" onclick="openSidebar()">☰ MENU</button>
                <nav class="Nav-menu">
                    <a href="ServiceServlet_JSP">DỊCH VỤ</a>
                    <a href="part">PHỤ TÙNG</a>
                    <a href="instype?action=list">BẢO HIỂM</a>
                </nav>
            </div>

            <div class="Logo">
                <a href="home"><img src="<%= settingMap.get("logo_url") %>" alt="<%= settingMap.get("site_name") %>"></a>
            </div>

            <div class="Header-right">
                <nav class="Nav-menu">
                    <a href="blog">BLOG</a>
                    <a href="ordertracking">VẬN ĐƠN</a>
                    <a href="contact.jsp">LIÊN HỆ</a>
                    <a href="campaignlist">CHƯƠNG TRÌNH</a>
                </nav>
                <!-- Đoạn login/avatar -->
                <% User user = (User) session.getAttribute("user"); %>
                <div class="Menu-right">
                    <% if (user == null) { %>
                    <a href="login"><button class="Login-button">Login</button></a>
                    <% } else { %>
                    <div class="Dropdown">
                        <i class="fas fa-bell Notification-icon" onclick="toggleNotificationDropdown()"></i>
                        <div id="notificationDropdown" class="Dropdown-content">
                            <a href="#">You have 3 new messages</a>
                            <a href="#">Booking confirmed</a>
                            <a href="#">Promotion: 20% off service</a>
                        </div>
                    </div>

                    <div class="Dropdown">
                        <i class="fas fa-user-circle Avatar-icon" onclick="toggleUserDropdown()"></i>
                        <div id="userDropdown" class="Dropdown-content">
                            <a href="viewProfile">Thông tin cá nhân</a>
                            <a href="myorder">Đơn hàng của tôi</a>
                            <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- Sidebar -->
            <div id="sidebar" class="Sidebar">
                <button class="close-btn" onclick="closeSidebar()">✖</button>
                <nav>
                    <a href="home">TRANG CHỦ</a>
                    <a href="ServiceServlet_JSP">DỊCH VỤ</a>
                    <a href="part">PHỤ TÙNG</a>
                    <a href="instype?action=list">BẢO HIỂM</a>
                    <a href="blog">BLOG</a>
                    <a href="ordertracking">VẬN ĐƠN</a>
                    <a href="contact.jsp">LIÊN HỆ</a>
                    <a href="campaignlist">CHƯƠNG TRÌNH</a>
                    <br>
                </nav>
            </div>

            <!-- Optional overlay -->
            <div id="overlay" class="Overlay" onclick="closeSidebar()"></div>

            

            <script>
                function openSidebar() {
                    document.getElementById('sidebar').classList.add('open');
                    document.getElementById('overlay').classList.add('active');
                }

                function closeSidebar() {
                    document.getElementById('sidebar').classList.remove('open');
                    document.getElementById('overlay').classList.remove('active');
                }

                function toggleDropdown(dropdownId) {
                    const allDropdowns = document.querySelectorAll('.Dropdown-content');
                    allDropdowns.forEach(drop => {
                        if (drop.id !== dropdownId) {
                            drop.classList.remove('Show');
                        }
                    });

                    const target = document.getElementById(dropdownId);
                    target.classList.toggle('Show');
                }

                function toggleUserDropdown() {
                    toggleDropdown("userDropdown");
                }

                function toggleNotificationDropdown() {
                    toggleDropdown("notificationDropdown");
                }

                window.onclick = function (event) {
                    if (!event.target.closest('.Dropdown') && !event.target.matches('.Avatar-icon') && !event.target.matches('.Notification-icon')) {
                        document.querySelectorAll('.Dropdown-content').forEach(dropdown => {
                            dropdown.classList.remove('Show');
                        });
                    }
                }
            </script>
        </header>
    </body>
</html>