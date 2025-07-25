<%-- 
    Document   : header
    Created on : May 30, 2025, 2:05:47 PM
    Author     : GIGABYTE
--%>
<%
    Map<String, String> settingMap = (Map<String, String>) application.getAttribute("settingMap");
%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="java.util.Map" %>
<%@page import="entity.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Car Care Centre</title>
        <style>
            Body {
                margin: 0;
                font-family: Arial, sans-serif;
                background-color: #fff;
                padding-top: 80px;
            }

            Header {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                background-color: <%= settingMap.get("header_color") %>;
                color: #fff;
                display: grid;
                grid-template-columns: 1fr auto 1fr;
                align-items: center;
                padding: 10px 20px;
                z-index: 1000;
                box-sizing: border-box;
            }

            .Header-left {
                display: flex;
                align-items: center;
                gap: 96px;
                justify-content: flex-start;
            }

            .Header-right {
                display: flex;
                align-items: center;
                gap: 56px;
                justify-content: flex-end;
            }

            .Menu-toggle {
                background: none;
                border: none;
                color: black;
                font-size: 20px;
                cursor: pointer;
            }

            .Nav-menu {
                display: flex;
                align-items: center;
                gap: 40px;
            }

            .Nav-menu a {
                text-decoration: none;
                color: black;
                font-weight: bold;
                font-size: 18px;
                position: relative;
                padding: 6px 0;
            }

            .Nav-menu .active::after {
                content: "";
                display: block;
                width: 100%;
                height: 3px;
                background-color: red;
                position: absolute;
                bottom: -4px;
                left: 0;
            }

            .Logo img {
                height: 70px;
                transform: scale(1.75);
                transform-origin: center center;
            }

            /* Sidebar styles */
            .Sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 300px;
                height: 100%;
                background-color: lightcyan;
                color: white;
                padding: 30px 20px;
                transform: translateX(-100%);
                transition: transform 0.3s ease;
                z-index: 999;
            }

            .Sidebar.open {
                transform: translateX(0);
            }

            .Sidebar .close-btn {
                background: none;
                border: none;
                color: black;
                font-size: 24px;
                position: absolute;
                top: 20px;
                right: 20px;
                cursor: pointer;
            }

            .Sidebar nav a {
                display: block;
                color: #000;
                text-decoration: none;
                margin: 20px 0;
                font-weight: bold;
                font-size: 18px;
            }


            .Login-button {
                background-color: #fff;
                color: #000;
                border: none;
                padding: 8px 16px;
                font-weight: bold;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .Login-button:hover {
                background-color: #ccc;
            }

            .Notification-icon {
                font-size: 32px;
                color: black;
                cursor: pointer;
                margin-right: 15px;
                position: relative;
                display: flex;
                align-items: center;
            }

            .Notification-icon:hover {
                color: red;
            }

            .Notification-count {
                position: absolute;
                top: -6px;
                right: -8px;
                background-color: red;
                color: white;
                font-size: 12px;
                padding: 2px 6px;
                border-radius: 50%;
                min-width: 20px;
                min-height: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 10;
            }

            /* Optional: badge */
            .Notification-icon .Notification-count {
                position: absolute;
                top: -6px;
                right: -8px;
                background-color: red;
                color: white;
                font-size: 12px;
                padding: 2px 6px;
                border-radius: 50%;
            }

            /* Responsive (optional) */
            @media (max-width: 768px) {
                Header {
                    flex-direction: column;
                    gap: 15px;
                }

                .Nav-menu {
                    flex-wrap: wrap;
                    justify-content: center;
                }
            }

            /* Optional overlay */
            .Overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
                z-index: 998;
                display: none;
            }

            .Overlay.active {
                display: block;
            }

            /* Avatar and dropdown */
            .Avatar-icon {
                font-size: 36px;
                color: black;
                cursor: pointer;
            }

            .Dropdown {
                position: relative;
                display: inline-block;
            }

            .Dropdown-content {
                display: none;
                position: absolute;
                right: 0;
                background-color: white;
                min-width: 160px;
                box-shadow: 0 8px 16px rgba(0,0,0,0.2);
                z-index: 1000;
                border-radius: 8px;
                overflow: hidden;
            }

            .Dropdown-content a {
                color: black;
                padding: 10px 16px;
                text-decoration: none;
                display: block;
                transition: background-color 0.2s;
            }

            .Dropdown-content a:hover {
                background-color: #f0f0f0;
            }

            .Dropdown-content.show {
                display: block;
                animation: fadeIn 0.3s ease-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
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
                position: absolute;
                top: 100%;
                right: 0;
                margin-top: 10px;
                background: white;
                transition: all 0.3s ease;
                transform-origin: top right;
                opacity: 0;
                transform: scale(0.95);
            }

            #notificationDropdown.show {
                display: flex; /* Hiển thị khi có class show */
                opacity: 1;
                transform: scale(1);
            }

            /* Thêm các class mới cho cấu trúc popup */
            .notification-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 16px;
                border-bottom: 1px solid #e5e5e5;
                background-color: #f9f9f9;
            }

            .notification-content {
                overflow-y: auto;
                flex: 1;
                max-height: 400px;
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
                transition: background-color 0.2s;
            }

            .notification-item:hover {
                background-color: #f9f9f9;
            }

            .notification-details {
                flex: 1;
                padding-left: 16px; /* Add space for the dot */
            }

            .notification-title {
                font-weight: 500;
                margin-bottom: 4px;
                color: #333;
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
                transition: background-color 0.2s;
            }

            .promo-button:hover {
                background-color: #054ab4;
            }

            .notification-footer {
                text-align: center;
                padding: 12px;
                font-size: 14px;
                color: #065fd4;
                cursor: pointer;
                border-top: 1px solid #e5e5e5;
                transition: background-color 0.2s;
            }

            .notification-footer:hover {
                background-color: #f1f1f1;
            }

            .notification-settings {
                background: none;
                border: none;
                padding: 0; /* Loại bỏ padding */
                width: auto; /* Xóa kích thước cố định */
                height: auto; /* Xóa kích thước cố định */
                font-size: 22px; /* Tăng kích thước */
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 36px;
                height: 36px;
                border-radius: 50%;
                transition: background-color 0.2s;
            }

            .notification-settings:hover {
                background-color: #f0f0f0;
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

                #notificationDropdown {
                    width: 320px;
                    right: -20px;
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
        <header>
            <div class="Header-left">
                <button class="Menu-toggle" onclick="openSidebar()">☰ MENU</button>
                <nav class="Nav-menu">
                    <a href="ServiceServlet_JSP">DỊCH VỤ</a>
                    <a href="part">PHỤ TÙNG</a>
                    <a href="instype?action=list">BẢO HIỂM</a>
                </nav>
            </div>

            <div class="Logo">
                <a href="home"><img src="<%= settingMap.get("logo_url") %>" alt="<%= settingMap.get("site_name") %>"></a>
            </div>

            <div class="Header-right">
                <nav class="Nav-menu">
                    <a href="bloglist">BLOG</a>
                    <a href="ordertracking">VẬN ĐƠN</a>
                    <a href="contact.jsp">LIÊN HỆ</a>
                    <a href="campaignlist">CHƯƠNG TRÌNH</a>
                </nav>
                <!-- Đoạn login/avatar -->
                <% User user = (User) session.getAttribute("user"); %>
                <div class="Menu-right">
                    <% if (user == null) { %>
                    <a href="login"><button class="Login-button">Login</button></a>
                    <% } else { %>
                    <!--Thong bao-->

                    <c:set var="unreadCount" value="0"></c:set>
                    <c:forEach var="noti" items="${notification}">
                        <c:if test="${!noti.status}">
                            <c:set var="unreadCount" value="${unreadCount + 1}" />
                        </c:if>
                    </c:forEach>

                    <div class="Dropdown">
                        <div class="Notification-icon" onclick="toggleNotificationDropdown(event)">
                            <i class="fas fa-bell"></i>
                            <div class="Notification-count">${unreadCount}</div>
                        </div>
                        <div id="notificationDropdown" class="Dropdown-content">
                            <div class="notification-header">
                                <h3 style="color: black">Thông báo</h3>
                                <button class="notification-settings" onclick="openNotificationSettings()">
                                    <i class="fas fa-cog"></i>
                                </button>
                            </div>
                            <div class="notification-content">
                                <!-- Thêm 3 thông báo mẫu -->
                                <c:forEach var="notification" items="${notification}">
                                    <a href="${pageContext.request.contextPath}/NotificationController?service=load&id=${notification.id}" 
                                       <c:choose>
                                           <c:when test="${notification.status == true && notiSetting.notificationStatus == true}">
                                               class="notification-item"
                                           </c:when>
                                           <c:otherwise>
                                               <c:if test="${notiSetting.notificationStatus == true}">
                                                   class="notification-item unread"
                                               </c:if>
                                           </c:otherwise>
                                       </c:choose>>
                                        <div class="notification-details">
                                            <div class="notification-title">${notification.message}</div>
                                            <div class="notification-time">
                                                <c:if test="${notiSetting.notificationTime == true}">
                                                    ${notification.createDate}
                                                </c:if>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </div>

                            <div class="notification-footer">
                                <a href="${pageContext.request.contextPath}/NotificationController?service=delete&user=${user.id}">Xóa tất cả thông báo</a>
                            </div>
                        </div>
                    </div>

                    <div class="Dropdown">
                        <i class="fas fa-user-circle Avatar-icon" onclick="toggleUserDropdown(event)"></i>
                        <div id="userDropdown" class="Dropdown-content">
                            <a href="viewProfile">Thông tin cá nhân</a>
                            <a href="myorder">Đơn hàng của tôi</a>
                            <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- Sidebar -->
            <div id="sidebar" class="Sidebar">
                <button class="close-btn" onclick="closeSidebar()">✖</button>
                <nav>
                    <a href="home">TRANG CHỦ</a>
                    <a href="ServiceServlet_JSP">DỊCH VỤ</a>
                    <a href="part">PHỤ TÙNG</a>
                    <a href="instype?action=list">BẢO HIỂM</a>
                    <a href="blog">BLOG</a>
                    <a href="ordertracking">VẬN ĐƠN</a>
                    <a href="contact.jsp">LIÊN HỆ</a>
                    <a href="campaignlist">CHƯƠNG TRÌNH</a>
                    <br>
                </nav>
            </div>

            <!-- Optional overlay -->
            <div id="overlay" class="Overlay" onclick="closeSidebar()"></div>

            <form action="${pageContext.request.contextPath}/NotificationController?service=filter" method="post">
                <!-- Notification Settings Popup -->
                <div id="notificationSettingsPopup" class="notification-settings-popup">
                    <div class="notification-settings-container">
                        <div class="notification-settings-header">
                            <h2 style="color: black">Thông báo</h2>
                            <button type="button" class="close-btn" onclick="closeNotificationSettings()">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>

                        <div class="notification-settings-content">
                            <div class="email-info">
                                <p>Email của bạn được gửi đến <strong>${user.email}</strong></p>
                            </div>

                            <div class="filter-section">
                                <label for="category-filter">Lọc theo:</label>
                                <div class="filter-select">
                                    <select id="category-filter" name="filter">
                                        <option value="all">Tất cả danh mục</option>
                                        <option value="view">Hiển Thị</option>
                                        <option value="change">Các thay đổi</option>
                                        <option value="additional">Cài Đặt Bổ Sung</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Settings sections -->
                            <div class="settings-section" data-category="view">
                                <h3 class="section-title">Hiển Thị</h3>
                                <div class="setting-item">
                                    <div class="toggle-container">
                                        <label class="toggle-switch">
                                            <input type="checkbox" name="notiTime" value="yes" <c:if test="${notiSetting.notificationTime == true}">checked</c:if>>
                                                <span class="toggle-slider"></span>
                                            </label>
                                        </div>
                                        <div class="setting-content">
                                            <div class="setting-title">Ngày thông báo</div>
                                            <div class="setting-description">Cho phép hiển thị ngày của thông báo</div>
                                        </div>
                                    </div>
                                    <div class="setting-item">
                                        <div class="toggle-container">
                                            <label class="toggle-switch">
                                                <input type="checkbox" name="notiStatus" value="yes" <c:if test="${notiSetting.notificationStatus == true}">checked</c:if>>
                                                <span class="toggle-slider"></span>
                                            </label>
                                        </div>
                                        <div class="setting-content">
                                            <div class="setting-title">Trạng thái của thông báo</div>
                                            <div class="setting-description">Cho phép hiển thị trạng thái đọc/chưa đọc</div>
                                        </div>
                                    </div>
                                </div>

                                <!--Settting các thông báo thay đổi-->
                                <div class="settings-section" data-category="change">
                                    <h3 class="section-title">Các Thay Đổi</h3>
                                    <div class="setting-item">
                                        <div class="toggle-container">
                                            <label class="toggle-switch">
                                                <input type="checkbox" name="profile" value="yes" <c:if test="${notiSetting.profile == true}">checked</c:if> >
                                                <span class="toggle-slider"></span>
                                            </label>
                                        </div>
                                        <div class="setting-content">
                                            <div class="setting-title">Thông báo về thông tin cá nhân</div>
                                            <div class="setting-description">Bật chế độ này để nhận các thông báo các thay đổi thông tin cá nhân</div>
                                        </div>
                                    </div>
                                    <div class="setting-item">
                                        <div class="toggle-container">
                                            <label class="toggle-switch">
                                                <input type="checkbox" name="order" value="yes" <c:if test="${notiSetting.orderChange == true}">checked</c:if>>
                                                <span class="toggle-slider"></span>
                                            </label>
                                        </div>
                                        <div class="setting-content">
                                            <div class="setting-title">Thông báo về các thay đổi đơn hàng</div>
                                            <div class="setting-description">Bật chế độ này để nhận các thông báo các thay đổi đơn hàng</div>
                                        </div>
                                    </div>
                                    <div class="setting-item">
                                        <div class="toggle-container">
                                            <label class="toggle-switch">
                                                <input type="checkbox" name="blog" value="yes" <c:if test="${notiSetting.blog == true}">checked</c:if>>
                                                <span class="toggle-slider"></span>
                                            </label>
                                        </div>
                                        <div class="setting-content">
                                            <div class="setting-title">Thông báo về các bài viết mới</div>
                                            <div class="setting-description">Bật chế độ này để nhận các thông báo các bài viết mới</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="settings-section" data-category="additional">
                                    <h3 class="section-title">Cài đặt bổ sung</h3>
                                    <div class="setting-item">
                                        <div class="toggle-container">
                                            <label class="toggle-switch">
                                                <input type="checkbox" name="email" value="yes" <c:if test="${notiSetting.email == true}">checked</c:if>>
                                            <span class="toggle-slider"></span>
                                        </label>
                                    </div>
                                    <div class="setting-content">
                                        <div class="setting-title">Thông báo về các thay đổi qua email</div>
                                        <div class="setting-description">Nhận email về các thay đổi</div>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- Đóng notification-settings-content -->

                        <div class="notification-settings-footer">
                            <button class="confirm-btn" onclick="closeNotificationSettings()">Xác nhận</button>
                        </div>
                    </div> <!-- Đóng notification-settings-container -->
                </div> <!-- Đóng notificationSettingsPopup -->
            </form> <!-- Đóng form -->

            <script>
                function openSidebar() {
                    document.getElementById('sidebar').classList.add('open');
                    document.getElementById('overlay').classList.add('active');
                }

                function closeSidebar() {
                    document.getElementById('sidebar').classList.remove('open');
                    document.getElementById('overlay').classList.remove('active');
                }

                function toggleDropdown(dropdownId, event) {
                    event.stopPropagation();

                    const allDropdowns = document.querySelectorAll('.Dropdown-content');
                    allDropdowns.forEach(drop => {
                        if (drop.id !== dropdownId) {
                            drop.classList.remove('show');
                        }
                    });

                    const target = document.getElementById(dropdownId);
                    target.classList.toggle('show');
                }

                function toggleUserDropdown(event) {
                    toggleDropdown("userDropdown", event);
                }

                function toggleNotificationDropdown(event) {
                    toggleDropdown("notificationDropdown", event);
                }

                // Close dropdowns when clicking outside
                document.addEventListener('click', function (event) {
                    const userDropdown = document.getElementById('userDropdown');
                    const notificationDropdown = document.getElementById('notificationDropdown');

                    if (userDropdown && !userDropdown.contains(event.target) &&
                            !event.target.closest('.Avatar-icon')) {
                        userDropdown.classList.remove('show');
                    }

                    if (notificationDropdown && !notificationDropdown.contains(event.target) &&
                            !event.target.closest('.Notification-icon')) {
                        notificationDropdown.classList.remove('show');
                    }
                });

                // ================== NOTIFICATION SETTINGS POPUP FUNCTIONS ==================
                function openNotificationSettings() {
                    const popup = document.getElementById('notificationSettingsPopup');
                    popup.style.display = 'flex';
                    document.body.style.overflow = 'hidden';
                }

                function closeNotificationSettings() {
                    const popup = document.getElementById('notificationSettingsPopup');
                    popup.style.display = 'none';
                    document.body.style.overflow = 'auto';
                }

                // Close popup when clicking outside the container
                document.getElementById('notificationSettingsPopup').addEventListener('click', function (e) {
                    if (e.target === this) {
                        closeNotificationSettings();
                    }
                });

                // Toggle switch functionality
                document.querySelectorAll('.toggle-switch input').forEach(checkbox => {
                    checkbox.addEventListener('change', function () {
                        const parentItem = this.closest('.setting-item');
                        if (this.checked) {
                            parentItem.style.opacity = 1;
                        } else {
                            parentItem.style.opacity = 0.7;
                        }
                    });
                });

                // Filter settings by category
                document.getElementById('category-filter').addEventListener('change', function () {
                    const selectedCategory = this.value;
                    const allSections = document.querySelectorAll('.settings-section');

                    allSections.forEach(section => {
                        if (selectedCategory === 'all' || section.dataset.category === selectedCategory) {
                            section.style.display = 'block';
                        } else {
                            section.style.display = 'none';
                        }
                    });
                });
            </script>
        </header>
    </body>
</html>