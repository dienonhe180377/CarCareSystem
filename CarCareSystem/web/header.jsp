
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            }

            header {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                background-color: gold;
                color: #fff;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 20px 40px;
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
                height: 100px;
                transform: scale(1.2);
                transform-origin: center center;
            }

            /* Sidebar styles */
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 300px;
                height: 100%;
                background-color: #d80000;
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
                color: white;
                font-size: 24px;
                position: absolute;
                top: 20px;
                right: 20px;
                cursor: pointer;
            }

            .sidebar nav a {
                display: block;
                color: white;
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
                    <a href="accessories.jsp">ACCESSORIES</a>
                    <a href="promotions.jsp">PROMOTIONS</a>
                    <a href="blog.jsp">BLOG</a>
                    <a href="booking.jsp">BOOKING</a>
                    <a href="contact.jsp">CONTACT</a>
                    <br>
                </nav>
            </div>

            <!-- Optional overlay -->
            <div id="overlay" class="overlay" onclick="closeSidebar()"></div>

            <script>
                function openSidebar() {
                    document.getElementById('sidebar').classList.add('open');
                    document.getElementById('overlay').classList.add('active');
                }

                function closeSidebar() {
                    document.getElementById('sidebar').classList.remove('open');
                    document.getElementById('overlay').classList.remove('active');
                }
            </script>

            <!-- Navigation menu left -->
            <nav class="nav-menu">
                <a href="ServiceServlet_JSP">SERVICES</a>
                <a href="accessories.jsp">ACCESSORIES</a>
                <a href="promotions.jsp">PROMOTIONS</a>
            </nav>

            <!-- Logo -->
            <div class="logo">
                <a href="home.jsp"><img src="img/img.jpg " alt="CAR CARE Centre"></a>
            </div>

            <!-- Navigation menu right -->
            <nav class="nav-menu">
                <a href="blog.jsp">BLOG</a>
                <a href="booking.jsp">BOOKING</a>
                <a href="contact.jsp">CONTACT</a>
            </nav>

            <!-- Login button and search -->
            <div class="menu-right">
                <a href="login"><button class="login-button">Login</button></a>
            </div>
        </header>
        <div style="height: 120px;"></div>
    </body>

</html>