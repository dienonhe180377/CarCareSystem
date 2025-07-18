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

            /* ================== NOTIFICATION SETTINGS POPUP STYLES ================== */
            .notification-settings-popup {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.6);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 2000;
                overflow: auto;
                display: none;
            }

            .notification-settings-container {
                background: white;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
                max-width: 800px;
                width: 100%;
                display: flex;
                flex-direction: column;
                max-height: 90vh;
            }

            .notification-settings-header {
                padding: 20px 24px;
                border-bottom: 1px solid #e5e5e5;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-shrink: 0;
            }

            .notification-settings-content {
                padding: 24px;
                overflow-y: auto;
                flex: 1;
            }

            .notification-settings-footer {
                padding: 16px 24px;
                background-color: #f9f9f9;
                display: flex;
                justify-content: flex-end;
                border-top: 1px solid #e5e5e5;
                flex-shrink: 0;
            }

            .email-info {
                margin-bottom: 24px;
                padding-bottom: 16px;
                border-bottom: 1px solid #e5e5e5;
            }

            .email-info p {
                font-size: 0.95rem;
                line-height: 1.5;
                color: #606060;
            }

            .email-info strong {
                color: #0f0f0f;
                font-weight: 500;
            }

            .filter-section {
                margin-bottom: 24px;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .filter-section label {
                font-size: 0.95rem;
                font-weight: 500;
                color: #0f0f0f;
                white-space: nowrap;
            }

            .filter-select {
                flex: 1;
                position: relative;
            }

            .filter-select select {
                width: 100%;
                padding: 10px 16px;
                border-radius: 8px;
                border: 1px solid #ccc;
                background-color: white;
                font-size: 0.95rem;
                appearance: none;
                cursor: pointer;
            }

            .filter-select::after {
                content: "▼";
                position: absolute;
                right: 16px;
                top: 50%;
                transform: translateY(-50%);
                font-size: 0.8rem;
                color: #606060;
                pointer-events: none;
            }

            .settings-section {
                margin-bottom: 28px;
            }

            .section-title {
                font-size: 1.1rem;
                font-weight: 500;
                color: #0f0f0f;
                margin-bottom: 16px;
            }

            .setting-item {
                display: flex;
                padding: 12px 0;
                border-bottom: 1px solid #f2f2f2;
            }

            .toggle-container {
                margin-right: 16px;
                position: relative;
            }

            /* YouTube-style toggle switch */
            .toggle-switch {
                position: relative;
                display: inline-block;
                width: 48px;
                height: 24px;
            }

            .toggle-switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

            .toggle-slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
                border-radius: 24px;
            }

            .toggle-slider:before {
                position: absolute;
                content: "";
                height: 18px;
                width: 18px;
                left: 3px;
                bottom: 3px;
                background-color: white;
                transition: .4s;
                border-radius: 50%;
            }

            input:checked + .toggle-slider {
                background-color: #065fd4;
            }

            input:checked + .toggle-slider:before {
                transform: translateX(24px);
            }

            .setting-content {
                flex: 1;
            }

            .setting-title {
                font-size: 0.95rem;
                font-weight: 500;
                margin-bottom: 4px;
                color: #0f0f0f;
            }

            .setting-description {
                font-size: 0.9rem;
                color: #606060;
                line-height: 1.5;
            }

            .language-section {
                background-color: #f9f9f9;
                border-radius: 8px;
                padding: 16px;
                margin-top: 24px;
            }

            .language-row {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 16px;
            }

            .language-row:last-child {
                margin-bottom: 0;
            }

            .language-label {
                font-size: 0.95rem;
                font-weight: 500;
                color: #0f0f0f;
            }

            .language-select {
                width: 200px;
                position: relative;
            }

            .language-select select {
                width: 100%;
                padding: 10px 16px;
                border-radius: 8px;
                border: 1px solid #ccc;
                background-color: white;
                font-size: 0.95rem;
                appearance: none;
                cursor: pointer;
            }

            .language-select::after {
                content: "▼";
                position: absolute;
                right: 16px;
                top: 50%;
                transform: translateY(-50%);
                font-size: 0.8rem;
                color: #606060;
                pointer-events: none;
            }

            /* Animation for popup */
            @keyframes popupFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .notification-settings-container {
                animation: popupFadeIn 0.3s ease-out;
            }

            /* Responsive design */
            @media (max-width: 600px) {
                .notification-settings-container {
                    max-height: 95vh;
                    width: 95%;
                }

                .notification-settings-content {
                    padding: 15px;
                }

                .filter-section {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .filter-select {
                    width: 100%;
                }

                .language-row {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .language-select {
                    width: 100%;
                }

                .setting-item {
                    flex-direction: column;
                }

                .toggle-container {
                    margin-bottom: 10px;
                }
            }

            .notification-settings-footer .confirm-btn {
                background-color: #065fd4 !important;
                color: white !important;
                border: none !important;
                border-radius: 24px !important;
                padding: 10px 24px !important;
                font-size: 0.95rem !important;
                font-weight: 500 !important;
                cursor: pointer !important;
                transition: background-color 0.2s !important;
                display: inline-block !important;
                text-align: center !important;
                line-height: normal !important;
            }

            .notification-settings-footer .confirm-btn:hover {
                background-color: #054ab4 !important;
            }

            .notification-settings-header .close-btn {
                background: none !important;
                border: none !important;
                font-size: 24px !important;
                color: #606060 !important;
                cursor: pointer !important;
                width: 40px !important;
                height: 40px !important;
                border-radius: 50% !important;
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                transition: background-color 0.2s !important;
                position: relative !important;
                z-index: 1 !important;
            }

            .notification-settings-header .close-btn:hover {
                background-color: #f2f2f2 !important;
                color: #0f0f0f !important;
            }

            .notification-settings-header .close-btn i {
                font-size: 24px !important;
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
            <% } else if ("warehouse manager".equals(role)) { %>
            <h2>Warehouse Manager</h2>
            <a href="${pageContext.request.contextPath}/categoryList.jsp">Quản lý category</a>
            <a href="${pageContext.request.contextPath}/SupplierController?service=list">Quản lý nhà cung cấp</a>
            <a href="${pageContext.request.contextPath}/PartController?service=list">Quản lý bộ phận</a>
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
                            <button class="notification-settings" onclick="openNotificationSettings()">
                                <i class="fas fa-cog"></i>
                            </button>
                        </div>
                        <div class="notification-content">
                            <!-- Thêm 3 thông báo mẫu -->
                            <c:forEach var="notification" items="${notification}">
                                <a href="#" 
                                   <c:choose>
                                       <c:when test="${notification.status == true}">
                                           class="notification-item"
                                       </c:when>
                                       <c:otherwise>
                                           class="notification-item unread"
                                       </c:otherwise>
                                   </c:choose>>
                                    <div class="notification-details">
                                        <div class="notification-title">${notification.message}</div>
                                        <div class="notification-time">${notification.createDate}</div>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                        <div class="notification-footer">
                            Xóa tất cả thông báo
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

        <!-- Notification Settings Popup -->
        <div id="notificationSettingsPopup" class="notification-settings-popup">
            <div class="notification-settings-container">
                <div class="notification-settings-header">
                    <h2>Thông báo</h2>
                    <button class="close-btn">
                        <i class="fas fa-times"></i>
                    </button>
                </div>

                <div class="notification-settings-content">
                    <div class="email-info">
                        <p>Email của bạn được gửi đến <strong>ongdien4@gmail.com</strong></p>
                    </div>

                    <div class="filter-section">
                        <label for="category-filter">Lọc theo:</label>
                        <div class="filter-select">
                            <select id="category-filter" name="filter">
                                <option value="all">Tất cả danh mục</option>
                                <option value="family">Gia đình</option>
                                <option value="permissions">Quyền</option>
                                <option value="preferences">Lựa chọn ưu tiên</option>
                                <option value="premium">Nội dung cập nhật và YouTube Premium</option>
                                <option value="language">Ngôn ngữ</option>
                            </select>
                        </div>
                    </div>

                    <div class="settings-section" data-category="family">
                        <h3 class="section-title">Gia đình của bạn</h3>
                        <div class="setting-item">
                            <div class="toggle-container">
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="setting-content">
                                <div class="setting-title">Gửi email cập nhật cho tôi và thông tin dành cho gia đình và thông tin và sản phẩm YouTube hoặc YouTube Kids</div>
                                <div class="setting-description">Bằng việc bật chế độ cài đặt này, bạn chọn nhận email về các mục, thông tin cập nhật sản phẩm và nội dung đề xuất dành cho gia đình</div>
                            </div>
                        </div>
                    </div>

                    <div class="settings-section" data-category="permissions">
                        <h3 class="section-title">Quyền</h3>
                        <div class="setting-item">
                            <div class="toggle-container">
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="setting-content">
                                <div class="setting-title">Gửi cho tôi email về hoạt động của tôi trên YouTube và thông tin cập nhật mà tôi đã yêu cầu</div>
                                <div class="setting-description">Nếu bạn tắt tùy chọn cài đặt này, YouTube vẫn có thể gửi thư cho bạn liên quan đến tài khoản của bạn, thông báo bắt buộc về dịch vụ, thông báo pháp lý và các vấn đề về quyền riêng tư</div>
                            </div>
                        </div>
                    </div>

                    <div class="settings-section" data-category="preferences">
                        <h3 class="section-title">Lựa chọn ưu tiên của bạn</h3>
                        <div class="setting-item">
                            <div class="toggle-container">
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="setting-content">
                                <div class="setting-title">Thông báo cập nhật chung và sản phẩm</div>
                                <div class="setting-description">Thông báo và nội dung đề xuất</div>
                            </div>
                        </div>
                    </div>

                    <div class="settings-section" data-category="premium">
                        <h3 class="section-title">Nội dung cập nhật và YouTube Premium</h3>
                        <div class="setting-item">
                            <div class="toggle-container">
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="setting-content">
                                <div class="setting-title">Thông báo, nội dung cập nhật và đề xuất từ YouTube Premium và YouTube Music Premium</div>
                            </div>
                        </div>
                    </div>

                    <div class="settings-section" data-category="language">
                        <h3 class="section-title">Ngôn ngữ</h3>
                        <div class="setting-item">
                            <div class="toggle-container">
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="setting-content">
                                <div class="setting-title">Thông báo và bản tin cập nhật cho nhà sáng tạo</div>
                                <div class="setting-description">Thông báo và sản phẩm, sự kiện cho người sáng tạo và các mục đặc biệt dành cho bạn để phát triển kênh YouTube</div>
                            </div>
                        </div>
                    </div>

                    <!-- Thêm nội dung mẫu để kiểm tra khả năng cuộn -->
                    <div class="settings-section" data-category="additional">
                        <h3 class="section-title">Cài đặt bổ sung</h3>
                        <div class="setting-item">
                            <div class="toggle-container">
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="setting-content">
                                <div class="setting-title">Thông báo về các sự kiện đặc biệt</div>
                                <div class="setting-description">Nhận email về các sự kiện, chương trình khuyến mãi và cập nhật đặc biệt từ YouTube</div>
                            </div>
                        </div>
                        <div class="setting-item">
                            <div class="toggle-container">
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="setting-content">
                                <div class="setting-title">Thông báo về nội dung được đề xuất</div>
                                <div class="setting-description">Nhận email về các video và kênh được đề xuất dựa trên sở thích xem của bạn</div>
                            </div>
                        </div>
                        <div class="setting-item">
                            <div class="toggle-container">
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="setting-content">
                                <div class="setting-title">Thông báo về nhận xét và tương tác</div>
                                <div class="setting-description">Nhận email khi có người nhận xét hoặc tương tác với nội dung của bạn</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="notification-settings-footer">
                    <button class="confirm-btn">Xác nhận</button>
                </div>
            </div>
        </div>


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

            // ================== NOTIFICATION SETTINGS POPUP FUNCTIONS ==================
            function openNotificationSettings() {
                const popup = document.getElementById('notificationSettingsPopup');
                popup.style.display = 'flex';
                document.body.style.overflow = 'hidden'; // Lock background scroll
            }

            function closeNotificationSettings() {
                const popup = document.getElementById('notificationSettingsPopup');
                popup.style.display = 'none';
                document.body.style.overflow = 'auto'; // Restore background scroll
            }

            // Close popup when close button is clicked
            document.querySelector('#notificationSettingsPopup .close-btn').addEventListener('click', closeNotificationSettings);

            // Close popup when confirm button is clicked
            document.querySelector('#notificationSettingsPopup .confirm-btn').addEventListener('click', closeNotificationSettings);

            // Close popup when clicking outside the container
            document.getElementById('notificationSettingsPopup').addEventListener('click', function (e) {
                if (e.target === this) {
                    closeNotificationSettings();
                }
            });

            // Toggle switch functionality
            document.querySelectorAll('#notificationSettingsPopup .toggle-switch input').forEach(checkbox => {
                checkbox.addEventListener('change', function () {
                    const parentItem = this.closest('.setting-item');
                    if (this.checked) {
                        parentItem.style.opacity = 1;
                    } else {
                        parentItem.style.opacity = 0.7;
                    }
                });
            });

        </script>
    </body>
</html>