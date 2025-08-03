<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="entity.User" %>
<%
    String message = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");
    User user = (User) session.getAttribute("user");
    String headerFile = "/header.jsp";
    if (user != null && !"customer".equalsIgnoreCase(user.getUserRole())) {
        headerFile = "/header_emp.jsp";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa thông tin cá nhân</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        /* giữ nguyên CSS như bạn gửi */
        body { font-family: "Segoe UI", Arial, sans-serif; background: #f3f4f7; margin: 0; }
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
        .sidebar-menu { margin-top: 18px; }
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
        .sidebar-menu .active, .sidebar-menu a:hover { background: #f5f7fa; color: #0077cc; }
        .sidebar-menu i { margin-right: 20px; font-size: 19px; }
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
        .form-table { width: 100%; }
        .form-table td { padding: 16px 12px; }
        .form-label { width: 200px; color: #444; font-weight: 600; }
        .form-input input {
            width: 100%;
            padding: 12px 14px;
            border: 1.5px solid #dde1e8;
            border-radius: 7px;
            font-size: 16px;
            background: #fff;
            color: #333;
            outline: none;
            transition: border 0.2s;
        }
        .form-input input:focus { border: 1.5px solid #0077cc; }
        .btn-row { text-align: right; margin-top: 30px;}
        .btn-action {
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
        }
        .btn-action:hover { background: #911616; color: #fff; }
        .back-link {
            background: #eee;
            color: #333;
            padding: 13px 32px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            margin-left: 18px;
            transition: background 0.2s;
            border: 1px solid #ccc;
            display: inline-block;
        }
        .back-link:hover { background: #dedede; color: #0077cc; }
        .message { color: #007700; text-align: center; margin-bottom: 14px; font-weight: bold; font-size: 17px;}
        .error-message { color: red; text-align: center; margin-bottom: 14px; font-weight: bold; font-size: 17px;}
        @media (max-width: 1100px) {
            .main-container { flex-direction: column; align-items: center; }
            .sidebar { width: 100%; max-width: 520px; margin-bottom: 36px; border-right: none; }
            .profile-content { width: 100%; max-width: 980px; padding: 38px 12px 38px 12px; min-width: unset;}
        }
        @media (max-width: 700px) {
            .profile-content { padding: 14px 2vw; }
            .sidebar { padding: 12px 0; }
            .profile-initial { width: 70px; height: 70px; font-size: 27px;}
            .sidebar-menu a { padding: 10px 12px; font-size: 14px;}
            .form-table td { padding: 10px 2px; }
            .form-input input { padding: 8px 7px; }
            .btn-action, .back-link { padding: 8px 18px; border-radius: 6px; font-size: 14px;}
            .profile-content h2 { font-size: 20px; }
        }
    </style>
</head>
<body>
    <jsp:include page="<%= headerFile %>" />
<div class="main-container">
    <div class="sidebar">
        <% if (user != null) { %>
        <div class="profile-pic">
            <div class="profile-initial">
                <%= user.getUsername().substring(0,1).toUpperCase() %>
                <span class="verified"><i class="fa fa-check"></i></span>
            </div>
            <div class="display-name"><%= user.getUsername() %></div>
        </div>
        <div class="sidebar-menu">
            <a href="viewProfile"><i class="fa fa-user"></i> Thông tin tài khoản</a>
            <a href="#"><i class="fa fa-bookmark"></i> My Order</a>
            <a href="changepass"><i class="fa fa-key"></i> Đổi mật khẩu</a>
            <a href="logout"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
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
        <form action="viewProfile" method="post">
            <table class="form-table">
                <tr>
                    <td class="form-label"><label for="username">Tên đăng nhập</label></td>
                    <td class="form-input"><input type="text" id="username" name="username" value="<%= user.getUsername() %>" required /></td>
                </tr>
                <tr>
                    <td class="form-label"><label for="email">Email</label></td>
                    <td class="form-input"><input type="email" id="email" name="email" value="<%= user.getEmail() %>" required /></td>
                </tr>
                <tr>
                    <td class="form-label"><label for="phone">Số điện thoại</label></td>
                    <td class="form-input"><input type="text" id="phone" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" /></td>
                </tr>
                <tr>
                    <td class="form-label"><label for="address">Địa chỉ</label></td>
                    <td class="form-input"><input type="text" id="address" name="address" value="<%= user.getAddress() != null ? user.getAddress() : "" %>" /></td>
                </tr>
            </table>
            <div class="btn-row">
                <button type="submit" class="btn-action">CẬP NHẬT</button>
                <a href="viewProfile" class="back-link">Quay lại</a>
            </div>
        </form>
        <% } %>
    </div>
</div>
</body>
</html>