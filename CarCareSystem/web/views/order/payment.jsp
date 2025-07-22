

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán chuyển khoản</title>
        <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --accent: #e74c3c;
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
        }
        
        .payment-container {
            max-width: 800px;
            margin: 30px auto;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
        }
        
        h1 {
            text-align: center;
            color: var(--primary);
            margin-bottom: 20px;
            font-size: 28px;
        }
        
        .description {
            text-align: center;
            margin-bottom: 30px;
            color: var(--dark);
            font-size: 18px;
        }
        
        .payment-content {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .qr-section, .bank-section {
            flex: 1;
            min-width: 300px;
        }
        
        .section-title {
            font-size: 20px;
            color: var(--primary);
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--secondary);
        }
        
        .qr-code {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            border: 1px dashed #ddd;
        }
        
        .qr-placeholder {
            width: 200px;
            height: 200px;
            margin: 0 auto 20px;
            background: linear-gradient(135deg, #3498db, #2c3e50);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 16px;
            border-radius: 8px;
        }
        
        .bank-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }
        
        .info-item {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .info-label {
            font-weight: bold;
            min-width: 150px;
            color: var(--dark);
        }
        
        .info-value {
            flex: 1;
            color: var(--primary);
            font-weight: 500;
        }
        
        .highlight {
            color: var(--accent);
            font-weight: bold;
            font-size: 18px;
        }
        
        .total-price {
            background: #e8f4fd;
            padding: 12px 20px;
            border-radius: 8px;
            margin: 20px 0;
            font-size: 18px;
            text-align: center;
        }
        
        .total-price strong {
            color: var(--accent);
            font-size: 24px;
        }
        
        .note {
            background: #fff8e6;
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #ffc107;
            margin: 25px 0;
        }
        
        .note p {
            margin-bottom: 10px;
        }
        
        .confirm-section {
            text-align: center;
            margin-top: 30px;
        }
        
        .confirm-btn {
            background: var(--secondary);
            color: white;
            border: none;
            padding: 14px 35px;
            font-size: 18px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 600;
            box-shadow: 0 4px 6px rgba(50, 50, 93, 0.11), 0 1px 3px rgba(0, 0, 0, 0.08);
        }
        
        .confirm-btn:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 7px 14px rgba(50, 50, 93, 0.1), 0 3px 6px rgba(0, 0, 0, 0.08);
        }
        
        .order-id {
            display: inline-block;
            background: var(--primary);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
            margin-top: 10px;
        }
        
        @media (max-width: 768px) {
            .payment-content {
                flex-direction: column;
            }
            
            .qr-section, .bank-section {
                min-width: 100%;
            }
        }
    </style>
    </head>
    <body>
        <%@include file="/header.jsp" %>
        <div class="payment-container">
            <h1>Thanh Toán Chuyển Khoản</h1>
            <p class="description">Vui lòng quét mã QR hoặc chuyển khoản theo thông tin dưới đây</p>
            <div class="total-price">
                Tổng số tiền cần thanh toán: 
                <strong>
                    <fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="0" /> VNĐ
                </strong>
            </div>
        
            <div class="payment-content">
                <div class="qr-section">
                    <h2 class="section-title">Mã QR Thanh Toán</h2>
                    <div class="qr-code">
                        <img src="data:image/png;base64,${qrCodeImage}" alt="Mã QR Thanh Toán">
                        <p>Quét mã QR để chuyển tiền nhanh chóng</p>
                    </div>
                </div>
            
                <div class="bank-section">
                    <h2 class="section-title">Thông Tin Ngân Hàng</h2>
                    <div class="bank-info">
                        <div class="info-item">
                            <span class="info-label">Ngân hàng:</span>
                            <span class="info-value">Vietcombank</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Số tài khoản:</span>
                            <span class="info-value">1013367685</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Tên tài khoản:</span>
                            <span class="info-value">TRAN THANH HAI</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Chi nhánh:</span>
                            <span class="info-value">Hà Nội</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Nội dung chuyển khoản:</span>
                            <span class="info-value highlight">DH${currentOrderId}</span>
                        </div>
                    </div>
                </div>
            </div>
        
            <div class="note">
                <p><strong>Lưu ý quan trọng:</strong></p>
                <p>1. Vui lòng chuyển khoản đúng số tiền: <fmt:formatNumber value="${totalPrice}" type="number" maxFractionDigits="0" /> VNĐ</p>
                <p>2. Ghi chính xác nội dung chuyển khoản: <strong>DH${currentOrderId}</strong></p>
                <p>3. Đơn hàng sẽ được xử lý trong vòng 15 phút sau khi nhận được thanh toán</p>
                <p>4. Nếu có bất kỳ thắc mắc nào, vui lòng liên hệ hotline: 1900 1234</p>
            </div>
        
            <div class="confirm-section">
                <p>Sau khi chuyển khoản, vui lòng nhấn nút xác nhận bên dưới</p>
                <form action="payment" method="post">
                    <input type="hidden" name="orderId" value="${currentOrderId}">
                    <button type="submit" class="confirm-btn">Tôi đã chuyển tiền</button>
                </form>
            </div>
            <% if (request.getAttribute("message") != null) { %>
                <p class="message"><%= request.getAttribute("message") %></p>
            <% } %>
        </div>
    </body>
</html>
