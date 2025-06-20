<%-- 
    Document   : change-password
    Created on : Jun 20, 2025, 9:30:20 AM
    Author     : TRAN ANH HAI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String username = user.getUsername();
    String firstLetter = username.substring(0, 1).toUpperCase();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đổi mật khẩu</title>
        <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            padding: 40px;
        }

        .sidebar {
            width: 250px;
            background: #fff;
            border-right: 1px solid #ccc;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.05);
        }

        .avatar {
            width: 60px;
            height: 60px;
            background: #c62828;
            color: #fff;
            font-size: 30px;
            font-weight: bold;
            border-radius: 50%;
            text-align: center;
            line-height: 60px;
            margin-bottom: 10px;
        }

        .sidebar h3 {
            margin-top: 0;
            margin-bottom: 5px;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            padding: 10px;
            border-radius: 8px;
            margin-top: 5px;
        }

        .sidebar ul li.active, .sidebar ul li:hover {
            background: #e0e0e0;
            cursor: pointer;
        }

        .content {
            flex: 1;
            padding: 20px 40px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
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
        }

        .error {
            color: red;
            margin-top: 10px;
        }

        .success {
            color: green;
            margin-top: 10px;
        }
    </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
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
            <div class="content">
                <h2>THAY ĐỔI MẬT KHẨU</h2>
                <form action="changepass" method="post">
                    <div class="form-group">
                        <label>Mật khẩu cũ <span style="color:red">*</span></label>
                        <input type="password" name="currentPassword" placeholder="Nhập mật khẩu cũ" required>
                    </div>

                    <div class="form-group">
                        <label>Mật khẩu mới <span style="color:red">*</span></label>
                        <input type="password" name="newPassword" placeholder="Nhập mật khẩu mới" required>
                    </div>

                    <div class="form-group">
                        <label>Nhập lại mật khẩu mới <span style="color:red">*</span></label>
                        <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
                    </div>
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
                    <button type="submit" class="btn-submit">CẬP NHẬT</button>
                </form>
            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
