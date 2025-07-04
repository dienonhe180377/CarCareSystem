<%-- 
    Document   : header_emp
    Created on : Jun 3, 2025, 7:21:08 PM
    Author     : GIGABYTE
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Header_Emp</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            Body {
                display: block;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }

            .Sidebar {
                width: 250px;
                background-color: lightblue;
                border-right: 1px solid #ddd;
                padding: 20px;
                overflow-y: auto;
                transition: left 0.3s ease;
                position: fixed;
                top: 0;
                left: -250px;
                bottom: 0;
                z-index: 1000;
            }

            .Sidebar.open {
                left: 0;
            }

            .Overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.4);
                z-index: 999;
                display: none;
            }

            .Overlay.show {
                display: block;
            }

            .Sidebar h2 {
                font-size: 24px;
                color: #333;
                margin-bottom: 20px;
            }

            .Sidebar a {
                display: block;
                text-decoration: none;
                color: #333;
                padding: 10px 0;
                font-size: 16px;
            }

            .Sidebar a:hover {
                color: #007bff;
            }

            .Main-content {
                margin-left: 0;
                transition: margin-left 0.3s ease;
                height: 100vh;
                display: flex;
                flex-direction: column;
                background-color: #f8f9fa;
            }

            .Main-content.shifted {
                margin-left: 250px;
            }

            Header {
                background-color: lightblue;
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #ddd;
            }

            .Menu-button {
                background: none;
                border: none;
                font-size: 24px;
                cursor: pointer;
                margin-right: 20px;
                color: black;
            }

            .Header-right {
                display: flex;
                align-items: center;
                gap: 20px;
            }


            Header .title {
                font-size: 24px;
                font-weight: bold;
                display: flex;
                align-items: center;
            }

            .Notification-icon {
                font-size: 24px;
                color: black;
                cursor: pointer;
                margin-right: 15px;
                position: relative;
            }

            .Notification-icon:hover {
                color: red;
            }

            /* Avatar Dropdown */
            .Avatar-icon {
                font-size: 36px;
                color: black;
                cursor: pointer;
            }

            .Avatar-button {
                background: none;
                border: none;
                padding: 0;
                cursor: pointer;
            }

            .Dropdown {
                position: relative;
            }

            .Dropdown-content {
                position: absolute;
                top: 100%;
                right: 0;
                margin-top: 10px;
                background-color: white;
                min-width: 160px;
                border: 1px solid #ccc;
                border-radius: 6px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                display: none;
                z-index: 1000;
            }

            .Dropdown-content a {
                padding: 10px 16px;
                color: black;
                text-decoration: none;
                display: block;
                font-size: 14px;
            }

            .Dropdown-content a:hover {
                background-color: #f1f1f1;
            }

            .Dropdown-content.show {
                display: block;
            }

            /* Thêm mới */
            .notification-badge {
                position: absolute;
                top: -5px;
                right: -5px;
                background-color: #ff0000;
                color: white;
                font-size: 10px;
                border-radius: 50%;
                width: 18px;
                height: 18px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
            }

            /* Sửa đổi dropdown notification */
            #notificationDropdown {
                width: 400px; /* Rộng hơn */
                border-radius: 12px; /* Bo góc */
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15); /* Đổ bóng */
                overflow: hidden; /* Ẩn tràn */
                max-height: 80vh; /* Giới hạn chiều cao */
                flex-direction: column; /* Bố cục dọc */
                display: none; /* Ẩn ban đầu */
            }

            #notificationDropdown.show {
                display: flex; /* Hiển thị khi có class show */
            }

            /* Thêm các class mới cho cấu trúc popup */
            .notification-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 16px;
                border-bottom: 1px solid #e5e5e5;
            }

            .notification-content {
                overflow-y: auto;
                flex: 1;
            }

            .notification-section {
                padding: 16px;
                border-bottom: 1px solid #e5e5e5;
            }

            .section-title {
                font-size: 16px;
                font-weight: 500;
                margin-bottom: 12px;
                color: #606060;
            }

            .notification-item {
                text-decoration: none;
                color: inherit;
                display: flex;
                padding: 12px 16px;
                position: relative;
            }

            .notification-details {
                flex: 1;
                padding-left: 16px; /* Add space for the dot */
            }

            .notification-title {
                font-weight: 500;
                margin-bottom: 4px;
            }

            .notification-channel {
                font-size: 14px;
                color: #606060;
            }

            .notification-time {
                font-size: 12px;
                color: #909090;
            }


            .promo-section {
                background-color: #f8f9fa;
                padding: 16px;
                border-top: 1px solid #e5e5e5;
            }

            .promo-button {
                background-color: #065fd4;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 18px;
                font-weight: 500;
                cursor: pointer;
                width: 100%;
            }

            .notification-footer {
                text-align: center;
                padding: 12px;
                font-size: 14px;
                color: #065fd4;
                cursor: pointer;
                border-top: 1px solid #e5e5e5;
            }

            .notification-settings {
                background: none;
                border: none;
                padding: 0; /* Loại bỏ padding */
                width: auto; /* Xóa kích thước cố định */
                height: auto; /* Xóa kích thước cố định */
                font-size: 22px; /* Tăng kích thước */
            }

            .notification-settings:hover {
                background-color: transparent; /* Không có nền khi hover */
            }

            .notification-settings i {
                font-size: 22px;
                color: #606060;
                transition: transform 0.5s ease, color 0.3s ease;
            }

            .notification-settings:hover i {
                transform: rotate(180deg); /* Hiệu ứng xoay 180 độ */
                color: #065fd4; /* Màu xanh nước biển đậm */
            }

            /* NEW: UNREAD INDICATOR DOT */
            .notification-item.unread::before {
                content: "";
                position: absolute;
                left: 6px;
                top: 50%;
                transform: translateY(-50%);
                width: 8px;
                height: 8px;
                background-color: #ff0000;
                border-radius: 50%;
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div id="sidebar" class="Sidebar">           
            <% 
                Object role = session.getAttribute("role");
                if ("admin".equals(role)) { %>
            <h2>Admin</h2>
            <a href="${pageContext.request.contextPath}/attendance">Quản lý điểm danh</a>
            <a href="${pageContext.request.contextPath}/admin/userList">Quản lý người dùng</a>
            <a href="${pageContext.request.contextPath}/insurance">Quản lý bảo hiểm</a>
            <a href="${pageContext.request.contextPath}/ServiceServlet_JSP">Quản lý dịch vụ</a>
            <% } else if ("manager".equals(role)) { %>
            <h2>Manager</h2>
            <a href="${pageContext.request.contextPath}/categoryList.jsp">Quản lý category</a>
            <a href="${pageContext.request.contextPath}/supplierList.jsp">Quản lý nhà cung cấp</a>
            <a href="${pageContext.request.contextPath}/partList.jsp">Quản lý bộ phận</a>
            <a href="${pageContext.request.contextPath}/manager/carTypeList">Quản lý loại xe</a>
            <a href="${pageContext.request.contextPath}/insurance">Quản lý bảo hiểm</a>
            <a href="${pageContext.request.contextPath}/ServiceServlet_JSP">Quản lý dịch vụ</a>
            <% } else if ("repairer".equals(role)) { %>
            <h2>Repairer</h2>
            <a href="${pageContext.request.contextPath}/orderList.jsp">Quản lý đơn</a>
            <% } else if ("warehouse_manager".equals(role)) { %>
            <h2>Warehouse Manager</h2>
            <a href="${pageContext.request.contextPath}/categoryList.jsp">Quản lý category</a>
            <a href="${pageContext.request.contextPath}/supplierList.jsp">Quản lý nhà cung cấp</a>
            <a href="${pageContext.request.contextPath}/partList.jsp">Quản lý bộ phận</a>
            <% } else if ("marketing".equals(role)) { %>
            <h2>Marketing</h2>
            <a href="${pageContext.request.contextPath}/insurance">Quản lý bảo hiểm</a>
            <a href="${pageContext.request.contextPath}/ServiceServlet_JSP">Quản lý dịch vụ</a>
            <% } %>
        </div>

        <!-- Overlay -->
        <div id="overlay" class="Overlay" onclick="toggleSidebar()"></div>

        <!-- Header -->
        <header>
            <div class="title">
                <button class="Menu-button" onclick="toggleSidebar()">☰</button>
            </div>

            <div class="Header-right" style="display: flex; align-items: center; gap: 20px;">

                <!--Thong bao-->
                <div class="Dropdown">
                    <div class="Notification-icon" onclick="toggleNotificationDropdown()">
                        <i class="fas fa-bell"></i>
                        <div class="notification-badge">3</div>
                    </div>
                    <div id="notificationDropdown" class="Dropdown-content">
                        <div class="notification-header">
                            <h3>Thông báo</h3>
                            <button class="notification-settings">
                                <i class="fas fa-cog"></i>
                            </button>
                        </div>
                        <div class="notification-content">
                            <!-- Thêm 3 thông báo mẫu -->
                            <a href="#" 
                               <c:choose>
                                   <c:when test="${not empty unread}">
                                       class="notification-item unread"
                                   </c:when>
                                   <c:otherwise>
                                       class="notification-item unread"
                                   </c:otherwise>
                               </c:choose>>
                                <div class="notification-details">
                                    <div class="notification-title">Thông báo mới: Đơn hàng #1234 đã được xác nhận</div>
                                    <div class="notification-time">2 giờ trước</div>
                                </div>
                            </a>
                            <a href="#" class="notification-item">
                                <div class="notification-details">
                                    <div class="notification-title">Khuyến mãi đặc biệt: Giảm 30% dịch vụ bảo dưỡng</div>
                                    <div class="notification-time">5 giờ trước</div>
                                </div>
                            </a>
                            <a href="#" class="notification-item">
                                <div class="notification-details">
                                    <div class="notification-title">Nhắc nhở: Lịch hẹn bảo dưỡng vào ngày mai</div>
                                    <div class="notification-time">1 ngày trước</div>
                                </div>
                            </a>
                            <a href="#" class="notification-item">
                                <div class="notification-details">
                                    <div class="notification-title">Nhắc nhở: Lịch hẹn bảo dưỡng vào ngày mai</div>
                                    <div class="notification-time">1 ngày trước</div>
                                </div>
                            </a>
                            <a href="#" class="notification-item">
                                <div class="notification-details">
                                    <div class="notification-title">Nhắc nhở: Lịch hẹn bảo dưỡng vào ngày mai</div>
                                    <div class="notification-time">1 ngày trước</div>
                                </div>
                            </a>
                            <a href="#" class="notification-item">
                                <div class="notification-details">
                                    <div class="notification-title">Nhắc nhở: Lịch hẹn bảo dưỡng vào ngày mai</div>
                                    <div class="notification-time">1 ngày trước</div>
                                </div>
                            </a>
                            <a href="#" class="notification-item">
                                <div class="notification-details">
                                    <div class="notification-title">Nhắc nhở: Lịch hẹn bảo dưỡng vào ngày mai</div>
                                    <div class="notification-time">1 ngày trước</div>
                                </div>
                            </a>
                            <a href="#" class="notification-item">
                                <div class="notification-details">
                                    <div class="notification-title">Nhắc nhở: Lịch hẹn bảo dưỡng vào ngày mai</div>
                                    <div class="notification-time">1 ngày trước</div>
                                </div>
                            </a>
                            <a href="#" class="notification-item">
                                <div class="notification-details">
                                    <div class="notification-title">Nhắc nhở: Lịch hẹn bảo dưỡng vào ngày mai</div>
                                    <div class="notification-time">1 ngày trước</div>
                                </div>
                            </a>
                            <a href="#" class="notification-item">
                                <div class="notification-details">
                                    <div class="notification-title">Nhắc nhở: Lịch hẹn bảo dưỡng vào ngày mai</div>
                                    <div class="notification-time">1 ngày trước</div>
                                </div>
                            </a>
                            <a href="#" class="notification-item">
                                <div class="notification-details">
                                    <div class="notification-title">Nhắc nhở: Lịch hẹn bảo dưỡng vào ngày mai</div>
                                    <div class="notification-time">1 ngày trước</div>
                                </div>
                            </a>
                            <a href="#" class="notification-item">
                                <div class="notification-details">
                                    <div class="notification-title">Nhắc nhở: Lịch hẹn bảo dưỡng vào ngày mai</div>
                                    <div class="notification-time">1 ngày trước</div>
                                </div>
                            </a>
                            <a href="#" class="notification-item">
                                <div class="notification-details">
                                    <div class="notification-title">Nhắc nhở: Lịch hẹn bảo dưỡng vào ngày mai</div>
                                    <div class="notification-time">1 ngày trước</div>
                                </div>
                            </a>
                        </div>
                        <div class="notification-footer">
                            Đánh dấu tất cả đã đọc
                        </div>
                    </div>
                </div>

                <!--Avatar User-->
                <div class="Dropdown">
                    <button class="Avatar-button" onclick="toggleUserDropdown()">
                        <i class="fas fa-user-circle Avatar-icon"></i>
                    </button>
                    <div id="userDropdown" class="Dropdown-content">
                        <a href="profile.jsp">Profile</a>
                        <a href="orders.jsp">My Orders</a>
                        <a href="${pageContext.request.contextPath}/logout">Logout</a>
                    </div>
                </div>
            </div>
        </header>


        <script>
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                const overlay = document.getElementById('overlay');

                const isOpen = sidebar.classList.contains('open');
                if (isOpen) {
                    sidebar.classList.remove('open');
                    overlay.classList.remove('show');
                } else {
                    sidebar.classList.add('open');
                    overlay.classList.add('show');
                }
            }

            function toggleDropdown(dropdownId) {
                const allDropdowns = document.querySelectorAll('.Dropdown-content');
                allDropdowns.forEach(drop => {
                    if (drop.id !== dropdownId) {
                        drop.classList.remove('show');
                    }
                });

                const target = document.getElementById(dropdownId);
                target.classList.toggle('show');
            }

            function toggleUserDropdown() {
                toggleDropdown("userDropdown");
            }

            function toggleNotificationDropdown() {
                toggleDropdown("notificationDropdown");
            }

            // Sửa hàm xử lý click ngoài để không đóng popup khi click vào các thành phần mới
            window.onclick = function (event) {
                if (!event.target.closest('.Dropdown') &&
                        !event.target.matches('.Avatar-icon') &&
                        !event.target.matches('.Notification-icon') &&
                        !event.target.matches('.notification-badge') && // Thêm dòng này
                        !event.target.matches('.fa-bell')) { // Và dòng này
                    document.querySelectorAll('.Dropdown-content').forEach(dropdown => {
                        dropdown.classList.remove('show');
                    });
                }
            }
        </script>
    </body>
</html>