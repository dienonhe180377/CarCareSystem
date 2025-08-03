<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="entity.User" %>
<%
    String success = (String) request.getAttribute("success");
    User user = (User) session.getAttribute("user");
    String headerFile = "/header.jsp";
    // Nếu user có và không phải role "customer" thì dùng header_emp.jsp
    if (user != null && !"customer".equalsIgnoreCase(user.getUserRole())) {
        headerFile = "/header_emp.jsp";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin cá nhân</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
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
        .info-table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-bottom: 28px; 
        }
        .info-table td { 
            padding: 16px 12px; 
        }
        .info-label { width: 200px; color: #444; font-weight: 600; }
        .info-value { color: #222; font-weight: 500; }
        .btn-row { text-align: right; }
        .btn-action { 
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
            margin-left: 16px; 
        }
        .btn-action:hover { background: #911616; color: #fff; }

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
            margin-left: 12px;
            margin-right: 12px;
            transition: background 0.18s, color 0.18s, border 0.18s;
        }
        .back-link:hover {
            background: #0077cc;
            color: #fff;
            border-color: #0077cc;
        }

        .success-message { color: #007700; font-weight: bold; text-align: center; margin-bottom: 14px; font-size: 17px;}
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
            .info-table td { padding: 10px 2px; }
            .btn-action { padding: 8px 18px; border-radius: 6px; font-size: 14px;}
            .back-link { padding: 7px 14px; font-size: 13px; border-radius: 5px;}
            .profile-content h2 { font-size: 20px; }
        }
    </style>
</head>
<body> 
    <jsp:include page="<%= headerFile %>" />
<% if (user == null) { %>
    <div class="profile-content full-screen" style="margin: 80px auto; max-width: 500px;">
        <h2>THÔNG TIN TÀI KHOẢN</h2>
        <div style="color:red;">Bạn chưa đăng nhập!</div>
        <a href="login" class="btn-action">Đăng nhập</a>
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
                <a class="active" href="viewProfile"><i class="fa fa-user"></i> Thông tin tài khoản</a>
                <a href="myorder"><i class="fa fa-bookmark"></i> My Order</a>
                <a href="changepass"><i class="fa fa-key"></i> Đổi mật khẩu</a>
                <a href="logout"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>
        <div class="profile-content">
            <h2>THÔNG TIN TÀI KHOẢN</h2>
            <% if (success != null) { %>
                <div class="success-message"><%= success %></div>
            <% } %>
            <table class="info-table">
                <tr>
                    <td class="info-label">Tên đăng nhập:</td>
                    <td class="info-value"><%= user.getUsername() %></td>
                </tr>
                <tr>
                    <td class="info-label">Email:</td>
                    <td class="info-value"><%= user.getEmail() %></td>
                </tr>
                <tr>
                    <td class="info-label">Số điện thoại:</td>
                    <td class="info-value"><%= user.getPhone() != null ? user.getPhone() : "(chưa cập nhật)" %></td>
                </tr>
                <tr>
                    <td class="info-label">Địa chỉ:</td>
                    <td class="info-value"><%= user.getAddress() != null ? user.getAddress() : "(chưa cập nhật)" %></td>
                </tr>
                <tr>
                    <td class="info-label">Ngày tạo:</td>
                    <td class="info-value">
                        <%
                            java.util.Date createdDate = user.getCreatedDate();
                            if (createdDate != null) {
                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
                                out.print(sdf.format(createdDate));
                            } else {
                                out.print("(chưa có)");
                            }
                        %>
                    </td>
                </tr>
                <tr>
                    <td class="info-label">Quyền:</td>
                    <td class="info-value"><%= user.getUserRole() %></td>
                </tr>
            </table>
            <div class="btn-row">
                <a class="btn-action" href="profileDetail">Chỉnh sửa thông tin</a>
                <a href="home" class="back-link"> Quay lại</a>
            </div>
        </div>
    </div>
<% } %>
</body>
</html>