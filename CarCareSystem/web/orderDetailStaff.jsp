<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="entity.Order" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    Order order = (Order) request.getAttribute("order");
%>
<html>
    <head>
        <title>Chi tiết đơn hàng - Nhân viên</title>
        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                background: #f7f8fa;
                margin: 0;
            }
            .container {
                max-width: 900px;
                margin: 24px auto;
                padding: 24px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 2px 16px #e5eaf2;
            }
            h2 {
                color: #003366;
                text-align: center;
                margin-top: 0;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 18px;
            }
            th, td {
                border: 1px solid #d5dae3;
                padding: 10px 8px;
            }
            th {
                background: #f1f5fc;
                text-align: left;
                color: #0e2147;
            }
            h3 {
                color: #1b4882;
                margin-bottom: 0;
                margin-top: 32px;
            }
            .total {
                color: #e53935;
                font-weight: bold;
                font-size: 1.08em;
            }
            .label {
                font-weight: bold;
            }
            .service-row {
                background: #fbfcff;
            }
            .parts-list {
                color: #1b4882;
                font-size: 0.98em;
            }
            .back-link {
                display:inline-block;
                margin-top:28px;
                background:#e3eaf7;
                color:#1b4882;
                padding:8px 18px;
                text-decoration:none;
                border-radius:5px;
                transition:background .2s;
            }
            .back-link:hover {
                background:#c9dafc;
            }
            .info-table td {
                width: 50%;
            }
            .voucher-info {
                margin-top: 20px;
                padding: 15px;
                background-color: #f8f9fa;
                border-radius: 5px;
                border: 1px solid #dee2e6;
            }
            .voucher-title {
                font-weight: bold;
                color: #1b4882;
                margin-bottom: 5px;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="container">
            <h2>Chi tiết đơn hàng</h2>
            <c:if test="${order != null}">
                <table class="info-table">
                    <tr>
                        <th>Mã đơn hàng</th><td>${order.id}</td>
                    </tr>
                    <tr>
                        <th>Khách hàng</th>
                        <td>
                            <c:choose>
                                <c:when test="${not empty order.name}">
                                    <c:out value="${order.name}" />
                                </c:when>
                                <c:when test="${order.user != null && not empty order.user.username}">
                                    <c:out value="${order.user.username}" />
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #999;">(Ẩn danh)</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>Email</th><td>${order.email}</td>
                    </tr>
                    <tr>
                        <th>Số điện thoại</th><td>${order.phone}</td>
                    </tr>
                    <tr>
                        <th>Địa chỉ</th><td>${order.address}</td>
                    </tr>
                    <tr>
                        <th>Ngày tạo</th><td><fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy"/></td>
                    </tr>
                    <tr>
                        <th>Ngày hẹn</th><td><fmt:formatDate value="${order.appointmentDate}" pattern="dd/MM/yyyy"/></td>
                    </tr>
                    <tr>
                        <th>Loại xe</th>
                        <td>
                            ${order.carType}
                        </td>
                    </tr>
                    <tr>
                        <th>Trạng thái đơn</th>
                        <td>
                            <c:choose>
                                <c:when test="${order.orderStatus == 'pending'}">
                                    <span class="badge badge-warning">Chờ xác nhận</span>
                                </c:when>
                                <c:when test="${order.orderStatus == 'received'}">
                                    <span class="badge badge-primary">Đã nhận xe</span>
                                </c:when>
                                <c:when test="${order.orderStatus == 'done'}">
                                    <span class="badge badge-success">Hoàn thành sửa chữa</span>
                                </c:when>
                                <c:when test="${order.orderStatus == 'missed'}">
                                    <span class="badge badge-danger">Lỡ hẹn</span>
                                </c:when>
                                <c:when test="${order.orderStatus == 'fixing'}">
                                    <span class="badge badge-danger">Đang sửa chữa</span>
                                </c:when>
                                <c:when test="${order.orderStatus == 'returned'}">
                                    <span class="badge badge-danger">Đã trả Xe</span>
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>Trạng thái thanh toán</th>
                        <td>
                            <c:choose>
                                <c:when test="${order.paymentStatus == 'paid'}">
                                    <span class="badge badge-success">Đã thanh toán</span>
                                </c:when>
                                <c:when test="${order.paymentStatus == 'unpaid'}">
                                    <span class="badge badge-danger">Chưa thanh toán</span>
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>Phương thức thanh toán</th>
                        <td>
                            <c:choose>
                                <c:when test="${order.paymentMethod == 'cash'}">
                                    Tiền mặt
                                </c:when>
                                <c:when test="${order.paymentMethod == 'transfer'}">
                                    Chuyển khoản
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>Tổng tiền</th>
                        <td class="total">
                            <fmt:formatNumber value="${order.price}" type="number" groupingUsed="true" minFractionDigits="0"/> VNĐ
                        </td>
                    </tr>
                </table>

                <h3>Dịch vụ thực hiện</h3>
                <table>
                    <tr>
                        <th style="width:18%;">Tên dịch vụ</th>
                        <th style="width:30%;">Mô tả</th>
                        <th style="width:14%;">Giá dịch vụ</th>
                        <th style="width:26%;">Phụ tùng kèm dịch vụ</th>
                        <th style="width:12%;">Tổng (dịch vụ + phụ tùng)</th>
                    </tr>
                    <c:forEach var="sv" items="${order.services}">
                        <tr class="service-row">
                            <td>${sv.name}</td>
                            <td>${sv.description}</td>
                            <td>
                                <fmt:formatNumber value="${sv.price}" type="number" groupingUsed="true" minFractionDigits="0"/> VNĐ
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty sv.parts}">
                                        <div class="parts-list">
                                            <c:forEach var="pt" items="${sv.parts}">
                                                • ${pt.name} (<fmt:formatNumber value="${pt.price}" type="number" groupingUsed="true" minFractionDigits="0"/> VNĐ)<br/>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color:#999;">Không có</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <fmt:formatNumber value="${sv.totalPriceWithParts}" type="number" groupingUsed="true" minFractionDigits="0"/> VNĐ
                            </td>
                        </tr>
                    </c:forEach>
                </table>

                <h3>Phụ tùng thay thế ngoài dịch vụ</h3>
                <table>
                    <tr>
                        <th style="width:60%;">Tên phụ tùng</th>
                        <th style="width:40%;">Giá</th>
                    </tr>
                    <c:choose>
                        <c:when test="${not empty order.parts}">
                            <c:forEach var="pt" items="${order.parts}">
                                <tr>
                                    <td>${pt.name}</td>
                                    <td><fmt:formatNumber value="${pt.price}" type="number" groupingUsed="true" minFractionDigits="0"/> VNĐ</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="2" style="text-align:center;color:#999;">Không có phụ tùng thay thế ngoài dịch vụ</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </table>
            </c:if>
            <c:if test="${order == null}">
                <p style="color: #d32f2f; text-align:center;">Không tìm thấy đơn hàng.</p>
            </c:if>
            <a class="back-link" href="ordermanagement">← Quay lại danh sách đơn hàng</a>
        </div>
    </body>
</html>