<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lịch sử đơn hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            body { 
                font-family: "Segoe UI", Arial, sans-serif; 
                background: #f3f4f7; 
                margin: 0;
                padding-top: 80px;
            }
            .main-container {
                display: flex;
                max-width: 1400px;
                margin: 0 auto;
                padding: 40px;
                gap: 40px;
            }
            .sidebar { 
                width: 300px;
                background: #fff; 
                border-radius: 22px; 
                box-shadow: 0 6px 36px rgba(0,0,0,0.08); 
                padding: 30px 0; 
                height: fit-content;
            }
            .sidebar .profile-pic { 
                display: flex; 
                flex-direction: column; 
                align-items: center; 
                margin-bottom: 30px; 
            }
            .profile-initial { 
                width: 80px;
                height: 80px;
                border-radius: 20px; 
                background: #b5bdc8; 
                color: #fff; 
                font-size: 35px;
                font-weight: 700; 
                display: flex; 
                align-items: center; 
                justify-content: center; 
                margin-bottom: 15px; 
                position: relative; 
            }
            .profile-pic .verified { 
                position: absolute; 
                bottom: 5px; 
                right: 5px; 
                background: #e53935; 
                color: #fff; 
                border-radius: 50%; 
                width: 24px;
                height: 24px;
                display: flex; 
                align-items: center; 
                justify-content: center; 
                font-size: 14px; 
                border: 2px solid #fff; 
            }
            .profile-pic .display-name { 
                font-size: 18px;
                font-weight: 600; 
                color: #222; 
                margin-bottom: 4px; 
            }
            .sidebar-menu { margin-top: 15px; }
            .sidebar-menu a { 
                display: flex; 
                align-items: center; 
                color: #333; 
                padding: 12px 30px; 
                text-decoration: none; 
                font-size: 16px; 
                border-radius: 10px; 
                margin-bottom: 8px; 
                transition: background 0.15s; 
            }
            .sidebar-menu .active, .sidebar-menu a:hover { 
                background: #f5f7fa; 
                color: #0077cc; 
            }
            .sidebar-menu i { 
                margin-right: 15px; 
                font-size: 16px; 
            }
            .content {
                flex: 1;
                background: #fff;
                border-radius: 22px;
                box-shadow: 0 6px 36px rgba(0,0,0,0.08);
                padding: 40px;
            }
            .content h1 {
                font-size: 28px;
                font-weight: 700;
                margin-bottom: 30px;
                color: #323f51;
            }
            .order-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            .order-table th {
                background-color: #f8f9fa;
                padding: 15px;
                text-align: left;
                font-weight: 600;
                color: #495057;
                border-bottom: 2px solid #e9ecef;
            }
            .order-table td {
                padding: 15px;
                border-bottom: 1px solid #e9ecef;
                vertical-align: middle;
            }
            .order-table tr:hover {
                background-color: #f8f9fa;
            }
            .status-paid { 
                color: #28a745;
                font-weight: 600;
            }
            .status-pending { 
                color: #ffc107;
                font-weight: 600;
            }
            .status-cancelled {
                color: #dc3545;
                font-weight: 600;
            }
            .no-orders {
                text-align: center;
                padding: 40px;
                color: #6c757d;
                font-size: 16px;
            }
            .order-id {
                font-weight: 600;
                color: #007bff;
            }
            .price {
                font-weight: 600;
                color: #212529;
            }
            @media (max-width: 1200px) {
                .main-container {
                    flex-direction: column;
                }
                .sidebar {
                    width: 100%;
                    margin-bottom: 30px;
                }
            }
            @media (max-width: 768px) {
                .main-container {
                    padding: 20px;
                }
                .content {
                    padding: 20px;
                }
                .order-table {
                    display: block;
                    overflow-x: auto;
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
                        ${user.username.substring(0,1).toUpperCase()}
                        <span class="verified"><i class="fa fa-check"></i></span>
                    </div>
                    <div class="display-name">${user.username}</div>
                </div>
                <div class="sidebar-menu">
                    <a href="viewProfile"><i class="fa fa-user"></i> Thông tin tài khoản</a>
                    <a class="active" href="myorder"><i class="fa fa-bookmark"></i> My Order</a>
                    <a href="changepass"><i class="fa fa-key"></i> Đổi mật khẩu</a>
                    <a href="logout"><i class="fa fa-sign-out-alt"></i> Đăng xuất</a>
                </div>
            </div>

            <!-- Main Content -->
            <div class="content">
                <h1>Lịch sử đơn hàng của bạn</h1>
                
                <c:if test="${not empty orders}">
                    <table class="order-table">
                        <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Ngày tạo</th>
                                <th>Ngày hẹn</th>
                                <th>Tổng tiền</th>
                                <th>Thanh toán</th>
                                <th>Trạng thái</th>
                                <th>Hình thức</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="order">
                                <tr>
                                    <td class="order-id">${order.id}</td>
                                    <td><fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td><fmt:formatDate value="${order.appointmentDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                    <td class="price"><fmt:formatNumber value="${order.price}" type="currency"/></td>
                                    <td class="${order.paymentStatus == 'Đã thanh toán' ? 'status-paid' : 'status-pending'}">
                                        ${order.paymentStatus}
                                    </td>
                                    <td class="${order.orderStatus == 'Đã hủy' ? 'status-cancelled' : ''}">
                                        ${order.orderStatus}
                                    </td>
                                    <td>${order.paymentMethod}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                
                <c:if test="${empty orders}">
                    <div class="no-orders">
                        <i class="far fa-folder-open" style="font-size: 24px; margin-bottom: 10px;"></i>
                        <p>Bạn chưa có đơn hàng nào!</p>
                    </div>
                </c:if>
            </div>
        </div>
    </body>
</html>