

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đặt lịch thành công</title>
        <style>
            :root {
                --primary: #2c3e50;
                --secondary: #3498db;
                --success: #27ae60;
                --warning: #f39c12;
                --light: #ecf0f1;
                --dark: #34495e;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: #f8f9fa;
                color: #333;
                line-height: 1.6;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            .success-container {
                max-width: 800px;
                margin: 40px auto;
                padding: 30px;
                background: white;
                border-radius: 12px;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .success-icon {
                font-size: 80px;
                color: var(--success);
                margin-bottom: 20px;
            }

            h1 {
                color: var(--success);
                margin-bottom: 20px;
                font-size: 32px;
            }

            .message {
                font-size: 18px;
                margin-bottom: 25px;
                color: var(--dark);
            }

            .order-details {
                background: #f8f9fa;
                border-radius: 10px;
                padding: 25px;
                margin: 25px 0;
                text-align: left;
            }

            .detail-item {
                display: flex;
                margin-bottom: 15px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
            }

            .detail-label {
                font-weight: bold;
                min-width: 180px;
                color: var(--dark);
            }

            .detail-value {
                flex: 1;
                color: var(--primary);
                font-weight: 500;
            }

            .payment-status {
                padding: 10px 20px;
                border-radius: 20px;
                font-weight: bold;
                display: inline-block;
                margin: 15px 0;
            }

            .payment-status.paid {
                background: #d4edda;
                color: #155724;
            }

            .payment-status.pending {
                background: #fff3cd;
                color: #856404;
            }

            .actions {
                margin-top: 30px;
            }

            .btn {
                display: inline-block;
                padding: 12px 30px;
                font-size: 18px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s;
                margin: 0 10px;
            }

            .btn-primary {
                background: var(--secondary);
                color: white;
            }

            .btn-primary:hover {
                background: #2980b9;
                transform: translateY(-2px);
            }

            .btn-secondary {
                background: var(--primary);
                color: white;
            }

            .btn-secondary:hover {
                background: #1a252f;
                transform: translateY(-2px);
            }

            .contact-info {
                background: #e8f4fd;
                padding: 20px;
                border-radius: 10px;
                margin: 25px 0;
                text-align: left;
            }

            .contact-info h3 {
                color: var(--primary);
                margin-bottom: 15px;
                padding-bottom: 10px;
                border-bottom: 2px solid var(--secondary);
            }

            .contact-item {
                display: flex;
                margin-bottom: 10px;
            }

            .contact-label {
                font-weight: bold;
                min-width: 140px;
            }

            .thank-you {
                font-size: 20px;
                color: var(--primary);
                margin-top: 30px;
                font-style: italic;
            }
        </style>
    </head>
    <body>
        <%@include file="/header.jsp" %>
        <div class="success-container">
            <div class="success-icon">✅</div>
            <h1>Đặt Lịch Thành Công!</h1>

            <div class="message">
                Cảm ơn bạn đã đặt lịch tại CarCareSystem. Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất.
            </div>

            <div class="order-details">
                <div class="detail-item">
                    <span class="detail-label">Mã đơn hàng:</span>
                    <span class="detail-value">${currentOrderId}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Thời gian hẹn:</span>
                    <span class="detail-value">
                        <fmt:formatDate value="${appointmentDate}" pattern="HH:mm 'ngày' dd/MM/yyyy" />
                    </span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Tổng tiền:</span>
                    <span class="detail-value">
                        <fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="0" /> VNĐ
                    </span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Trạng thái thanh toán:</span>
                    <c:choose>
                        <c:when test="${paymentStatus eq 'Đã thanh toán'}">
                            <span class="payment-status paid">Đã thanh toán</span>
                        </c:when>
                        <c:otherwise>
                            <span class="payment-status pending">Chưa thanh toán</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="contact-info">
                <h3>Thông tin liên hệ</h3>
                <div class="contact-item">
                    <span class="contact-label">Địa chỉ:</span>
                    <span>198 Đường Giải Phóng, Đống Đa, TP Hà Nội</span>
                </div>
                <div class="contact-item">
                    <span class="contact-label">Hotline:</span>
                    <span>0123 456 789</span>
                </div>
                <div class="contact-item">
                    <span class="contact-label">Email:</span>
                    <span>support@carcarecentre.com</span>
                </div>
                <div class="contact-item">
                    <span class="contact-label">Giờ làm việc:</span>
                    <span>08:00 - 18:00 hàng ngày</span>
                </div>
            </div>

            <div class="actions">
                <a href="ordertracking" class="btn btn-primary">Theo dõi đơn hàng</a>
                <a href="home" class="btn btn-secondary">Về trang chủ</a>
            </div>

            <div class="thank-you">
                Cảm ơn bạn đã tin tưởng và sử dụng dịch vụ của chúng tôi!
            </div>
        </div>
        <%@include file="/footer.jsp" %>
    </body>
</html>
