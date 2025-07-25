
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="entity.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    String username = currentUser.getUsername();
    String firstLetter = username.substring(0, 1).toUpperCase();
    String errorMessage = (String) request.getAttribute("error");
    String successMessage = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đổi mật khẩu</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background: #f3f4f7;
                margin: 0;
            }
            .main-container {
                display: flex;
                justify-content: center;
                align-items: flex-start;
                min-height: 100vh;
                padding: 70px 40px;
                gap: 64px;
                flex-wrap: wrap;
            }
            .sidebar {
                width: 380px;
                background: #fff;
                border-radius: 22px;
                box-shadow: 0 6px 36px rgba(0,0,0,0.08);
                padding: 48px 0;
                border-right: 1.5px solid #eee;
            }
            .sidebar .profile-pic {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-bottom: 48px;
            }
            .profile-initial {
                width: 120px;
                height: 120px;
                border-radius: 20px;
                background: #b5bdc8;
                color: #fff;
                font-size: 45px;
                font-weight: 700;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 18px;
                position: relative;
            }
            .profile-pic .verified {
                position: absolute;
                bottom: 10px;
                right: 10px;
                background: #e53935;
                color: #fff;
                border-radius: 50%;
                width: 32px;
                height: 32px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 18px;
                border: 2.5px solid #fff;
            }
            .profile-pic .display-name {
                font-size: 21px;
                font-weight: 600;
                color: #222;
                margin-bottom: 4px;
            }
            .sidebar-menu {
                margin-top: 18px;
            }
            .sidebar-menu a {
                display: flex;
                align-items: center;
                color: #333;
                padding: 16px 48px;
                text-decoration: none;
                font-size: 17px;
                border-radius: 10px;
                margin-bottom: 10px;
                transition: background 0.15s;
            }
            .sidebar-menu .active, .sidebar-menu a:hover {
                background: #f5f7fa;
                color: #0077cc;
            }
            .sidebar-menu i {
                margin-right: 20px;
                font-size: 19px;
            }
            .profile-content {
                flex: 1;
                background: #fff;
                border-radius: 22px;
                box-shadow: 0 6px 36px rgba(0,0,0,0.08);
                padding: 60px 60px;
                min-width: 480px;
                max-width: 820px;
            }
            .profile-content h2 {
                font-size: 28px;
                font-weight: 700;
                margin-bottom: 32px;
                color: #323f51;
            }
            .form-group {
                margin-bottom: 24px;
            }
            .form-group label {
                display: block;
                font-weight: 600;
                margin-bottom: 8px;
                color: #444;
                font-size: 16px;
            }
            .form-group input {
                width: 100%;
                padding: 14px 16px;
                border: 1px solid #ddd;
                border-radius: 10px;
                font-size: 16px;
                transition: border 0.2s;
            }
            .form-group input:focus {
                border-color: #0077cc;
                outline: none;
            }
            .btn-submit {
                display: inline-block;
                background: #b71c1c;
                color: #fff;
                font-size: 18px;
                padding: 13px 44px;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                cursor: pointer;
                transition: background 0.18s;
                text-decoration: none;
                margin-top: 10px;
            }
            .btn-submit:hover {
                background: #911616;
            }
            .back-link {
                display: inline-block;
                background: #ededed;
                color: #333;
                font-size: 17px;
                padding: 11px 32px;
                border-radius: 9px;
                font-weight: 600;
                text-decoration: none;
                border: 1.2px solid #bbb;
                margin-left: 16px;
                transition: background 0.18s, color 0.18s, border 0.18s;
            }
            .back-link:hover {
                background: #0077cc;
                color: #fff;
                border-color: #0077cc;
            }
            .alert {
                padding: 16px;
                margin-bottom: 28px;
                border-radius: 10px;
                font-size: 16px;
            }
            .alert-danger {
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
                color: #721c24;
            }
            .alert-success {
                background-color: #d4edda;
                border: 1px solid #c3e6cb;
                color: #155724;
            }
            .btn-row {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-top: 30px;
            }
            @media (max-width: 1100px) {
                .main-container {
                    flex-direction: column;
                    align-items: center;
                }
                .sidebar {
                    width: 100%;
                    max-width: 520px;
                    margin-bottom: 36px;
                    border-right: none;
                }
                .profile-content {
                    width: 100%;
                    max-width: 980px;
                    padding: 38px 12px 38px 12px;
                    min-width: unset;
                }
            }
            @media (max-width: 700px) {
                .profile-content {
                    padding: 14px 2vw;
                }
                .sidebar {
                    padding: 12px 0;
                }
                .profile-initial {
                    width: 70px;
                    height: 70px;
                    font-size: 27px;
                }
                .sidebar-menu a {
                    padding: 10px 12px;
                    font-size: 14px;
                }
                .form-group input {
                    padding: 10px 12px;
                }
                .btn-submit {
                    padding: 8px 18px;
                    font-size: 14px;
                }
                .back-link {
                    padding: 7px 14px;
                    font-size: 13px;
                }
                .profile-content h2 {
                    font-size: 20px;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="/header.jsp" %>

        <div class="main-container">
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="profile-pic">
                    <div class="profile-initial">
                        <%= firstLetter %>
                        <span class="verified"><i class="fa fa-check"></i></span>
                    </div>
                    <div class="display-name"><%= username %></div>
                </div>
                <div class="sidebar-menu">
                    <a href="viewProfile"><i class="fa fa-user"></i> Thông tin tài khoản</a>
                    <a href="myorder"><i class="fa fa-bookmark"></i> My Order</a>
                    <a class="active" href="changepass"><i class="fa fa-key"></i> Đổi mật khẩu</a>
                    <a href="logout"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
                </div>
            </div>

            <!-- Main Content -->
            <div class="profile-content">
                <h2>THAY ĐỔI MẬT KHẨU</h2>

                <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i> <%= errorMessage %>
                </div>
                <% } %>

                <% if (successMessage != null && !successMessage.isEmpty()) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> <%= successMessage %>
                </div>
                <% } %>

                <form action="changepass" method="post">
                    <div class="form-group">
                        <label>Mật khẩu mới <span style="color:red">*</span></label>
                        <input type="password" name="newPassword" placeholder="Nhập mật khẩu mới" required>
                    </div>

                    <div class="form-group">
                        <label>Nhập lại mật khẩu mới <span style="color:red">*</span></label>
                        <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required>
                    </div>

                    <div class="btn-row">
                        <button type="submit" class="btn-submit">CẬP NHẬT</button>
                        <a href="viewProfile" class="back-link"> Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>