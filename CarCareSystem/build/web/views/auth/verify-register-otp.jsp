<%-- 
    Document   : verify-otp
    Created on : Jun 3, 2025, 7:57:16 PM
    Author     : TRAN ANH HAI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>OTP Register</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: system-ui, -apple-system, sans-serif;
            }

            body {
                min-height: 100vh;
                display: flex;
                background-color: #ffffff;
            }

            .split-container {
                display: flex;
                width: 100%;
                min-height: 100vh;
            }

            .left-section {
                flex: 6;
                background-color: #5838FC;
                ;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
                position: relative;
            }

            .illustration-wrapper {
                max-width: 600px;
                width: 100%;
            }

            .illustration-wrapper img {
                width: 100%;
                height: auto;
                object-fit: contain;
            }

            .right-section {
                flex: 4;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
                background-color: #ffffff;
            }

            .login-form {
                width: 100%;
                max-width: 400px;
                padding: 2rem;
            }

            h1 {
                font-size: 2.5rem;
                margin-bottom: 0.5rem;
                color: #111827;
            }

            .subtitle {
                color: #6B7280;
                margin-bottom: 2rem;
            }

            .form-group {
                margin-bottom: 1rem;
            }

            label {
                display: block;
                margin-bottom: 0.5rem;
                color: #374151;
                font-weight: 500;
            }

            input {
                width: 100%;
                padding: 0.75rem 1rem;
                border: 1px solid #D1D5DB;
                border-radius: 0.375rem;
                font-size: 1rem;
            }

            input:focus {
                outline: none;
                border-color: #2563EB;
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            }

            .forgot-password {
                display: block;
                text-align: right;
                color: #6B7280;
                text-decoration: none;
                font-size: 0.875rem;
                margin-top: 0.5rem;
            }

            .forgot-password:hover {
                color: #374151;
            }

            .login-button {
                width: 100%;
                padding: 0.75rem;
                background-color: #5838FC;
                color: white;
                border: none;
                border-radius: 0.375rem;
                font-size: 1rem;
                cursor: pointer;
                margin-bottom: 1.5rem;
                transition: background-color 0.2s ease;
            }

            .login-button:hover {
                background-color: #00A090;
            }

            .register {
                text-align: center;
                color: #6B7280;
            }

            .register a {
                color: #5838FC;
                text-decoration: none;
                font-weight: 500;
            }

            .register a:hover {
                color: #00A090;
            }
            .alert {
                padding: 10px;
                margin-bottom: 15px;
                border-radius: 5px;
                font-size: 14px;
            }

            .alert-danger {
                color: white;
                background-color: #dc3545;
                border: 1px solid #b52b35;
            }
            @media (max-width: 768px) {
                .split-container {
                    flex-direction: column;
                }

                .left-section {
                    display: none;
                }

                .right-section {
                    padding: 1rem;
                }

                .login-form {
                    padding: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="split-container">
            <div class="left-section">
                <div class="illustration-wrapper">
                    <img src="${pageContext.request.contextPath}/assets/images" alt="Logo"/>
                </div>
            </div>
            <div class="right-section">
                <div class="login-form">
                    <h1>Xác minh OTP</h1>
                    <p class="subtitle">Nhập mã xác nhận hợp lệ</p>
                    </br>
                    <form action="verifyOTP" method="post">
                        <div class="form-group">
                            <label>Mã OTP</label>
                            <input type="text" name="otp" required />
                        </div>
                        <button type="submit" class="login-button">Xác minh</button>
                    </form>
                    <% if (request.getAttribute("error") != null) { %>
                        <p style="color:red"><%= request.getAttribute("error") %></p>
                    <% } %>
                    <% if (request.getAttribute("message") != null) { %>
                        <p style="color:green"><%= request.getAttribute("message") %></p>
                    <% } %>
                </div>
            </div>
        </div>
    </body>
</html>
