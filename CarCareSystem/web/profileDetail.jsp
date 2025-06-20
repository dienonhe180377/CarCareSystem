<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="entity.User" %>
<%
    User user = (User) request.getAttribute("user");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa thông tin cá nhân</title>
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
            padding: 40px 20px;
            gap: 30px;
            flex-wrap: wrap;
        }
        .sidebar {
            width: 260px;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 4px 30px rgba(0,0,0,0.06);
            padding: 28px 0;
            border-right: 1px solid #eee;
        }
        .sidebar .profile-pic {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 28px;
        }
        .profile-initial {
            width: 68px;
            height: 68px;
            border-radius: 10px;
            background: #b5bdc8;
            color: #fff;
            font-size: 36px;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 12px;
            position: relative;
        }
        .profile-pic .verified {
            position: absolute;
            bottom: 4px;
            right: 4px;
            background: #e53935;
            color: #fff;
            border-radius: 50%;
            width: 22px;
            height: 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            border: 2px solid #fff;
        }
        .profile-pic .display-name {
            font-size: 18px;
            font-weight: 600;
            color: #222;
            margin-bottom: 4px;
        }
        .profile-pic .edit-photo {
            font-size: 14px;
            color: #0077cc;
            text-decoration: underline;
            cursor: pointer;
            margin-bottom: 6px;
        }
        .sidebar-menu {
            margin-top: 12px;
        }
        .sidebar-menu a {
            display: flex;
            align-items: center;
            color: #333;
            padding: 10px 22px;
            text-decoration: none;
            font-size: 15px;
            border-radius: 6px;
            margin-bottom: 6px;
            transition: background 0.15s;
        }
        .sidebar-menu .active, .sidebar-menu a:hover {
            background: #f5f7fa;
            color: #0077cc;
        }
        .sidebar-menu i {
            margin-right: 14px;
            font-size: 17px;
        }
        .profile-content {
            flex: 1;
            background: #fff;
            border-radius: 14px;
            box-shadow: 0 4px 30px rgba(0,0,0,0.06);
            padding: 32px;
            min-width: 600px;
            max-width: 740px;
        }
        .profile-content h2 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #323f51;
        }
        .account-info-form {
            background: #f7f8fa;
            border-radius: 16px;
            padding: 30px 24px 20px;
            max-width: 580px;
            margin: 0 auto;
        }
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .form-group label {
            width: 140px;
            font-weight: 600;
            color: #222;
        }
        .form-group input {
            flex: 1;
            padding: 10px 14px;
            border: 1px solid #dde1e8;
            border-radius: 5px;
            font-size: 16px;
            background: #fff;
            color: #333;
            outline: none;
            transition: border 0.2s;
        }
        .form-group input:focus {
            border: 1.5px solid #0077cc;
        }
        .button-row {
            text-align: right;
            margin-top: 24px;
        }
        .button-row button {
            background: #b71c1c;
            color: #fff;
            font-size: 16px;
            padding: 9px 28px;
            border: none;
            border-radius: 7px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.18s;
        }
        .button-row button:hover {
            background: #911616;
        }
        .back-link {
            background: #eee;
            color: #333;
            padding: 9px 22px;
            border-radius: 7px;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            margin-left: 18px;
            transition: background 0.2s;
            border: 1px solid #ccc;
            display: inline-block;
        }
        .back-link:hover {
            background: #dedede;
            color: #0077cc;
        }
        .message {
            color: #007700;
            text-align: center;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 10px;
            font-weight: bold;
        }
        @media (max-width: 1024px) {
            .main-container {
                flex-direction: column;
                align-items: center;
            }
            .sidebar {
                width: 100%;
                max-width: 480px;
                margin-bottom: 24px;
                border-right: none;
            }
            .profile-content {
                width: 100%;
                max-width: 640px;
                padding: 24px 16px;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
<div class="main-container">
    <div class="sidebar">
        <% if (user != null) { %>
        <div class="profile-pic">
            <div class="profile-initial">
                <%= user.getUsername().substring(0,1).toUpperCase() %>
                <span class="verified"><i class="fa fa-check"></i></span>
            </div>
            <div class="display-name">
                <%= user.getUsername() %> 
                <span class="verified" style="position:static;"><i class="fa fa-check-circle"></i></span>
            </div>
            <a class="edit-photo" href="#">Sửa ảnh</a>
        </div>
        <div class="sidebar-menu">
            <a class="active" href="#"><i class="fa fa-user"></i> Thông tin tài khoản</a>
            <a href="#"><i class="fa fa-history"></i> Đọc gần đây</a>
            <a href="#"><i class="fa fa-bookmark"></i> Tin đã lưu</a>
            <a href="#"><i class="fa fa-key"></i> Đổi mật khẩu</a>
            <a href="login"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
        <% } %>
    </div>
    <div class="profile-content">
        <h2>CHỈNH SỬA THÔNG TIN</h2>
        <% if (error != null) { %>
            <div class="error-message"><%= error %></div>
        <% } else if (message != null) { %>
            <div class="message"><%= message %></div>
        <% } %>
        <% if (user == null) { %>
            <div class="error-message">Không tìm thấy thông tin người dùng!</div>
        <% } else { %>
        <form class="account-info-form" action="profileDetail" method="post">
            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <input type="text" id="username" name="username" value="<%= user.getUsername() %>" required />
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required />
            </div>
            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input type="text" id="phone" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" />
            </div>
            <div class="form-group">
                <label for="address">Địa chỉ</label>
                <input type="text" id="address" name="address" value="<%= user.getAddress() != null ? user.getAddress() : "" %>" />
            </div>
            <div class="button-row">
                <button type="submit">CẬP NHẬT</button>
                <a href="viewProfile" class="back-link">Quay lại</a>
            </div>
        </form>
        <% } %>
    </div>
</div>
</body>
</html>