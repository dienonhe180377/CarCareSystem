<%-- 
    Document   : verify-change-otp
    Created on : Jun 20, 2025, 9:31:09 AM
    Author     : TRAN ANH HAI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xác nhận OTP</title>
        <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            padding: 50px;
        }

        .form-container {
            width: 400px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #ccc;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .btn-submit {
            padding: 10px 30px;
            background: #c62828;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
        }

        .error {
            color: red;
            text-align: center;
        }

        .success {
            color: green;
            text-align: center;
        }
    </style>
    </head>
    <body>
        <%--<%@ include file="/header.jsp" %>--%>
        <div class="container">
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="avatar"><%= firstLetter %></div>
                <h3><%= username %> <span style="color: red;">✔</span></h3>
                <ul>
                    <li>Thông tin tài khoản</li>
                    <li>Order gần đây</li>
                    <li>Đánh giá dịch vụ</li>
                    <li class="active">Đổi mật khẩu</li>
                    <li><a href="logout">Đăng xuất</a></li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="form-container">
                <h2>Nhập mã OTP đã gửi tới email</h2>
                <form action="confirmchangepass" method="post">
                    <input type="text" name="otpInput" placeholder="Nhập mã OTP" required/>
                    <!-- Hiển thị thông báo -->
                    <% String errorMessage = (String) request.getAttribute("error"); %>
                        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
                            <div class="alert alert-danger">
                                <i class="fa fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                    <% String successMessage = (String) request.getAttribute("success"); %>
                        <% if (successMessage != null && !successMessage.isEmpty()) { %>
                            <div class="alert alert-danger-sucess">
                                <i class="fa fa-exclamation-circle"></i> <%= request.getAttribute("success") %>
                            </div>
                        <% } %>
                    <button class="btn-submit" type="submit">Xác nhận</button>    
                </form>
            </div>
        </div>
        <%--<%@ include file="/footer.jsp" %>--%>       
    </body>
</html>
