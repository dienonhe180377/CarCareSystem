

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Theo dõi đơn hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!--        <style>
                .tracking-container { max-width: 800px; margin: 0 auto; padding: 20px; }
                .step { display: none; }
                .step.active { display: block; }
                .error { color: red; }
                .success { color: green; }
                table { width: 100%; border-collapse: collapse; margin-top: 20px; }
                th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
                th { background-color: #f2f2f2; }
            </style>-->
        <style>
            .tracking-container {
                max-width: 800px;
                margin: 40px auto;
                padding: 30px;
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                position: relative;
                overflow: hidden;
            }

            .tracking-container::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 6px;
                background: linear-gradient(90deg, #3498db, #2ecc71, #9b59b6);
            }

            .step {
                display: none;
                padding: 25px;
                background: #f8f9fa;
                border-radius: 14px;
                margin-bottom: 25px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                border: 1px solid #eaeaea;
                animation: fadeIn 0.5s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .step.active {
                display: block;
            }

            .error {
                color: #c62828;
                background: #ffebee;
                padding: 15px 20px;
                border-radius: 12px;
                margin: 15px 0;
                border-left: 5px solid #c62828;
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 500;
            }

            .error::before {
                content: "⚠️";
                font-size: 20px;
            }

            .success {
                color: #2e7d32;
                background: #e8f5e9;
                padding: 15px 20px;
                border-radius: 12px;
                margin: 15px 0;
                border-left: 5px solid #2e7d32;
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 500;
            }

            .success::before {
                content: "✓";
                font-size: 20px;
                font-weight: bold;
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                margin: 25px 0 15px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                border-radius: 14px;
                overflow: hidden;
                background: white;
            }

            th, td {
                border: 1px solid #e0e0e0;
                padding: 14px 16px;
                text-align: left;
            }

            th {
                background: linear-gradient(135deg, #3498db 0%, #1a5f8e 100%);
                color: white;
                font-weight: 600;
                border: none;
                position: sticky;
                top: 0;
            }

            tr:nth-child(even) {
                background-color: #f8f9fa;
            }

            tr:hover {
                background-color: #e3f2fd;
            }

            form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            label {
                font-weight: 600;
                color: #2c3e50;
                font-size: 1.05rem;
                display: block;
                margin-bottom: 6px;
            }

            input[type="email"],
            input[type="text"] {
                width: 95%;
                padding: 14px 18px;
                border: 2px solid #e0e0e0;
                border-radius: 12px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: white;
            }

            input:focus {
                border-color: #3498db;
                box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.2);
                outline: none;
            }

            .button {
                padding: 14px 28px;
                border-radius: 12px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                border: none;
                background: linear-gradient(135deg, #3498db 0%, #1a5f8e 100%);
                color: white;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
                align-self: flex-start;
                margin-top: 10px;
            }

            .button:hover {
                transform: translateY(-3px);
                box-shadow: 0 7px 15px rgba(0,0,0,0.15);
            }

            @media (max-width: 768px) {
                .tracking-container {
                    padding: 20px;
                    margin: 20px;
                    border-radius: 14px;
                }

                .step {
                    padding: 20px;
                }

                table {
                    display: block;
                    overflow-x: auto;
                }

                button {
                    width: 100%;
                    margin: 10px 0 0;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="/header.jsp" %>

        <div class="tracking-container">
            <h1>Theo dõi đơn hàng</h1>

            <!-- Step 1: Email Input -->
            <div id="step-email" class="step <c:if test="${step == 'email' or empty step}">active</c:if>">
                    <form action="ordertracking" method="post">
                        <input type="hidden" name="action" value="request-otp">
                        <label for="email">Nhập email của bạn:</label>
                        <input type="email" id="email" name="email" required value="${email}">
                    <button class="button" type="submit">Gửi mã OTP</button>

                    <c:if test="${not empty error}">
                        <p class="error">${error}</p>
                    </c:if>
                </form>
            </div>

            <!-- Step 2: OTP Verification -->
            <div id="step-otp" class="step <c:if test="${step == 'otp'}">active</c:if>">
                    <form action="ordertracking" method="post">
                        <input type="hidden" name="action" value="verify-otp">
                        <p>Mã OTP đã được gửi đến ${email}. Vui lòng kiểm tra email của bạn.</p>
                    <label for="otp">Nhập mã OTP:</label>
                    <input type="text" id="otp" name="otp" required>
                    <button class="button" type="submit">Xác nhận</button>

                    <c:if test="${not empty error}">
                        <p class="error">${error}</p>
                    </c:if>
                </form>
                <form action="ordertracking" method="post">
                    <input type="hidden" name="action" value="reset">
                    <button class="button" type="submit">Thử lại với email khác</button>
                </form>
            </div>

            <!-- Step 3: Display Orders -->
            <div id="step-orders" class="step <c:if test="${step == 'orders'}">active</c:if>">
                <c:if test="${not empty message}">
                    <p class="success">${message}</p>
                </c:if>

                <h2>Danh sách đơn hàng cho ${email}</h2>

                <c:choose>
                    <c:when test="${not empty orders and orders.size() > 0}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Mã đơn</th>
                                    <th>Ngày tạo</th>
                                    <th>Ngày hẹn</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái thanh toán</th>
                                    <th>Trạng thái đơn</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orders}" var="order">
                                    <tr>
                                        <td>${order.id}</td>
                                        <td><fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                        <td><fmt:formatDate value="${order.appointmentDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                        <td><fmt:formatNumber value="${order.price}" type="currency" currencySymbol="₫" /></td>
                                        <td>${order.paymentStatus}</td>
                                        <td>${order.orderStatus}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <p>Không tìm thấy đơn hàng nào cho email này.</p>
                    </c:otherwise>
                </c:choose>

                <form action="ordertracking" method="post">
                    <input type="hidden" name="action" value="reset">
                    <button class="button" type="submit">Tra cứu đơn hàng khác</button>
                </form>
            </div>
        </div>
        <%@include file="/footer.jsp" %>
    </body>
</html>
