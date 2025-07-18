<%-- 
    Document   : header
    Created on : May 30, 2025, 2:05:47 PM
    Author     : GIGABYTE
--%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Car Care Centre</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #fff;
                padding-top: 80px;
            }

            header {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                background-color: lightblue;
                color: #fff;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 10px 20px;
                flex-wrap: wrap;
                z-index: 1000;
            }

            .menu-left,
            .menu-right {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .menu-toggle,
            .search-icon {
                background: none;
                border: none;
                color: black;
                font-size: 20px;
                cursor: pointer;
            }

            .nav-menu {
                display: flex;
                align-items: center;
                gap: 40px;
            }

            .nav-menu a {
                text-decoration: none;
                color: black;
                font-weight: bold;
                font-size: 18px;
                position: relative;
                padding: 6px 0;
            }

            .nav-menu .active::after {
                content: "";
                display: block;
                width: 100%;
                height: 3px;
                background-color: red;
                position: absolute;
                bottom: -4px;
                left: 0;
            }

            .logo img {
                height: 70px;
                transform: scale(1.75);
                transform-origin: center center;
            }

            /* Sidebar styles */
            .sidebar {
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

            .sidebar.open {
                transform: translateX(0);
            }

            .sidebar .close-btn {
                background: none;
                border: none;
                color: black;
                font-size: 24px;
                position: absolute;
                top: 20px;
                right: 20px;
                cursor: pointer;
            }

            .sidebar nav a {
                display: block;
                color: #000;
                text-decoration: none;
                margin: 20px 0;
                font-weight: bold;
                font-size: 18px;
            }


            .login-button {
                background-color: #fff;
                color: #000;
                border: none;
                padding: 8px 16px;
                font-weight: bold;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .login-button:hover {
                background-color: #ccc;
            }

            .notification-icon {
                font-size: 24px;
                color: black;
                cursor: pointer;
                margin-right: 15px;
                position: relative;
            }

            .notification-icon:hover {
                color: red;
            }

            .notification-count {
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
            .notification-icon .notification-count {
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
                header {
                    flex-direction: column;
                    gap: 15px;
                }

                .nav-menu {
                    flex-wrap: wrap;
                    justify-content: center;
                }
            }

            /* Optional overlay */
            .overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
                z-index: 998;
                display: none;
            }

            .overlay.active {
                display: block;
            }

            /* Avatar and dropdown */
            .avatar-icon {
                font-size: 36px;
                color: black;
                cursor: pointer;
            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                right: 0;
                background-color: lightcyan;
                min-width: 160px;
                box-shadow: 0 8px 16px rgba(0,0,0,0.2);
                z-index: 1000;
            }

            .dropdown-content a {
                color: black;
                padding: 10px 16px;
                text-decoration: none;
                display: block;
            }

            .dropdown-content a:hover {
                background-color: #ddd;
            }

            .show {
                display: block;
            }
        </style>
    </head>
    <body>
        <header>
            <!-- Menu icon -->
            <div class="menu-left">
                <button class="menu-toggle" onclick="openSidebar()">☰ MENU</button>
            </div>

            <!-- Sidebar -->
            <div id="sidebar" class="sidebar">
                <button class="close-btn" onclick="closeSidebar()">✖</button>
                <nav>
                    <a href="home.jsp">HOME</a>
                    <a href="ServiceServlet_JSP">SERVICES</a>
                    <a href="part">ACCESSORIES</a>
                    <a href="promotions.jsp">PROMOTIONS</a>
                    <a href="blog.jsp">BLOG</a>
                    <a href="ordertracking">TRACKING</a>
                    <a href="contact.jsp">CONTACT</a>
                    <br>
                </nav>
            </div>

            <!-- Optional overlay -->
            <div id="overlay" class="overlay" onclick="closeSidebar()"></div>

            <!-- Navigation menu left -->
            <nav class="nav-menu">
                <a href="ServiceServlet_JSP">SERVICES</a>
                <a href="part">ACCESSORIES</a>
                <a href="promotions.jsp">PROMOTIONS</a>
            </nav>

            <!-- Logo -->
            <div class="logo">
                <a href="home.jsp"><img src="img/logo.png " alt="CAR CARE Centre"></a>
            </div>

            <!-- Navigation menu right -->
            <nav class="nav-menu">
                <a href="blog.jsp">BLOG</a>
                <a href="ordertracking">TRACKING</a>
                <a href="contact.jsp">CONTACT</a>
            </nav>

            <!-- After login: avatar with dropdown -->
            <%
                User user = (User) session.getAttribute("user");
            %>

            <div class="menu-right">
                <% if (user == null) { %>
                <!-- Nếu chưa login -->
                <a href="login"><button class="login-button">Login</button></a>
                <% } else { %>
                <!-- Nếu đã login -->

                <!-- Icon chuông thông báo -->
                <div class="dropdown">
                    <i class="fas fa-bell notification-icon" onclick="toggleNotificationDropdown()"></i>
                    <div id="notificationDropdown" class="dropdown-content">
                        <a href="#">You have 3 new messages</a>
                        <a href="#">Booking confirmed</a>
                        <a href="#">Promotion: 20% off service</a>
                    </div>
                </div>

                <div class="dropdown">
                    <i class="fas fa-user-circle avatar-icon" onclick="toggleUserDropdown()"></i>
                    <div id="userDropdown" class="dropdown-content">
                        <a href="viewProfile">Profile</a>
                        <a href="myorder">My Orders</a>
                        <a href="${pageContext.request.contextPath}/logout">Logout</a>
                    </div>
                </div>
                <% } %>
            </div>

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
                    const allDropdowns = document.querySelectorAll('.dropdown-content');
                    allDropdowns.forEach(drop => {
                        if (drop.id !== dropdownId) {
                            drop.classList.remove('show');
                        }
                    });

                    const target = document.getElementById(dropdownId);
                    target.classList.toggle('show');
                }

                function toggleUserDropdown() {
                    toggleDropdown("userDropdown");
                }

                function toggleNotificationDropdown() {
                    toggleDropdown("notificationDropdown");
                }

                window.onclick = function (event) {
                    if (!event.target.closest('.dropdown') && !event.target.matches('.avatar-icon') && !event.target.matches('.notification-icon')) {
                        document.querySelectorAll('.dropdown-content').forEach(dropdown => {
                            dropdown.classList.remove('show');
                        });
                    }
                }
            </script>
        </header>
    </body>
</html>