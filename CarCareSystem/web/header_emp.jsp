<%-- 
    Document   : dashboard
    Created on : Jun 3, 2025, 7:21:08 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard</title>

        <!-- Font Awesome cho icon avatar -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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

            /* Avatar Dropdown */
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
            <h2>Dashboard</h2>
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
                </div>
                <div class="profile">
                    <div class="dropdown">
                        <i class="fas fa-user-circle avatar-icon" onclick="toggleDropdown()"></i>
                        <div id="userDropdown" class="dropdown-content">
                            <a href="profile.jsp">Profile</a>
                            <a href="orders.jsp">My Orders</a>
                            <a href="logout.jsp">Logout</a>
                        </div>
                    </div>
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