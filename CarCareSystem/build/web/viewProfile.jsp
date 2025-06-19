<%@ page import="entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin cá nhân</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            body {
                margin: 0;
                padding: 0;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                background: #f3f4f7;
                font-family: "Segoe UI", Arial, sans-serif;
            }

            .full-screen {
                background: #fff;
                padding: 40px;
                border-radius: 14px;
                box-shadow: 0 4px 30px rgba(0,0,0,0.06);
                text-align: center;
                min-width: 360px;
            }

            /* Giao diện mặc định khi đã đăng nhập */
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
            .info-row {
                display: flex;
                align-items: center;
                margin-bottom: 18px;
                font-size: 16px;
            }
            .info-label {
                width: 160px;
                color: #444;
                font-weight: 600;
                flex-shrink: 0;
            }
            .info-value {
                color: #222;
                font-weight: 500;
            }
            .btn-edit {
                display: inline-block;
                background: #b71c1c;
                color: #fff;
                font-size: 16px;
                padding: 9px 28px;
                border: none;
                border-radius: 7px;
                font-weight: 600;
                cursor: pointer;
                transition: background 0.18s;
                text-decoration: none;
                margin-top: 18px;
            }
            .btn-edit:hover {
                background: #911616;
                color: #fff;
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
    </head>
    <body>

        <% if (user == null) { %>
        <div class="profile-content full-screen">
            <h2>THÔNG TIN TÀI KHOẢN</h2>
            <div style="color:red;">Bạn chưa đăng nhập!</div>
            <a href="login" class="btn-edit">Đăng nhập</a>
        </div>
        <% } else { %>
        <div class="main-container">
            <div class="sidebar">
                <div class="profile-pic">
                    <div class="profile-initial">
                        <%= user.getUsername().substring(0,1).toUpperCase() %>
                        <span class="verified"><i class="fa fa-check"></i></span>
                    </div>
                    <div class="display-name"><%= user.getUsername() %></div>
                </div>
                <div class="sidebar-menu">
                    <a class="active" href="#">Thông tin tài khoản</a>
                    <a href="#"><i class="fa fa-history"></i> Đọc gần đây</a>
                    <a href="#"><i class="fa fa-bookmark"></i> Tin đã lưu</a>
                    <a href="#"><i class="fa fa-key"></i> Đổi mật khẩu</a>
                    <a href="login"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
                </div>
            </div>

            <div class="profile-content">
                <h2>THÔNG TIN TÀI KHOẢN</h2>
                <div class="info-row">
                    <span class="info-label">Tên hiển thị:</span>
                    <span class="info-value"><%= user.getUsername() %></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Email:</span>
                    <span class="info-value"><%= user.getEmail() %></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Số điện thoại:</span>
                    <span class="info-value"><%= user.getPhone() != null ? user.getPhone() : "(chưa cập nhật)" %></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Địa chỉ:</span>
                    <span class="info-value"><%= user.getAddress() != null ? user.getAddress() : "(chưa cập nhật)" %></span>
                </div>
                <div class="info-row">
                    <span class="info-label">Ngày tạo:</span>
                    <span class="info-value">
                        <% 
                            java.util.Date createdDate = user.getCreatedDate();
                            if (createdDate != null) {
                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
                                out.print(sdf.format(createdDate));
                            } else {
                                out.print("(chưa có)");
                            }
                        %>
                    </span>
                </div>
                <div class="info-row">
                    <span class="info-label">Quyền:</span>
                    <span class="info-value"><%= user.getUserRole() %></span>
                </div>
                <a class="btn-edit" href="profileDetail">Chỉnh sửa thông tin</a>
            </div>
        </div>
        <% } %>

    </body>
</html>
