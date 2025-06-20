<%-- 
    Document   : footer
    Created on : May 30, 2025, 2:12:57 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Footer</title>
        <style>
            html {
                margin: 0;
                padding: 0;
                height: 100%;
                font-family: Arial, sans-serif;
                background-color: #111;
                color: #fff;
            }

            .page-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            .content {
                flex: 1;
            }

            a {
                text-decoration: none;
            }

            footer {
                background-color: lightblue;
                padding: 50px 30px 20px;
            }

            .footer-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                border-bottom: 1px solid #444;
                padding-bottom: 30px;
            }

            .footer-column {
                flex: 1 1 200px;
                margin: 10px;
            }

            .footer-column h4 {
                color: #000;
                font-size: 16px;
                margin-bottom: 20px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .footer-column ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .footer-column ul li {
                margin-bottom: 10px;
                color: #000;
            }

            .footer-column ul li span {
                color: red;
                font-weight: bold;
                display: inline-block;
                width: 20px;
            }

            .footer-bottom {
                text-align: center;
                margin-top: 20px;
                font-size: 14px;
                color: #000;
            }

            .footer-bottom span {
                float: right;
                color: #ccc;
            }

            @media (max-width: 768px) {
                .footer-container {
                    flex-direction: column;
                }
                .footer-bottom span {
                    float: none;
                    display: block;
                    margin-top: 10px;
                }
            }
        </style>
    </head>
    <body>

        <div class="page-container">
            <!-- Nội dung trang nằm ở đây -->
            <div class="content">
                <!-- Có thể thêm nội dung chính ở đây -->
            </div>

            <footer>
                <div class="footer-container">
                    <div class="footer-column">
                        <h4>SITE INFORMATION</h4>
                        <ul>
                            <a href="home.jsp"><li>Home</li></a>
                            <li>Shop</li>
                            <li>Cart</li>
                        </ul>
                    </div>

                    <div class="footer-column">
                        <h4>SERVICE & SUPPORT</h4>
                        <ul>
                            <li>Terms & Conditions</li>
                            <li>Delivery & Returns</li>
                            <li>Training Academy</li>
                            <a href="ServiceServlet_JSP"><li>Car Care Services</li></a>
                        </ul>
                    </div>

                    <div class="footer-column">
                        <h4>CONTACT</h4>
                        <ul>
                            <li><span>A.</span> Car Care Centre</li>
                            <li><span>T.</span> Service Booking</li>
                            <li><span>T.</span> Product Order</li>
                            <li><span>E.</span> Hotline:0328728197</li>
                        </ul>
                    </div>
                </div>

                <div class="footer-bottom">
                    ©Car Care Centre © 2025. All rights reserved
                </div>
            </footer>
        </div>
    </body>
</html>