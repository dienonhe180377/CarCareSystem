

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lịch sử đơn hàng</title>
        <style>
        body { font-family: Arial, sans-serif; }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f2f2f2; }
        .status-paid { color: green; }
        .status-pending { color: orange; }
        .order-details { margin-top: 30px; }
        .section-title { margin-top: 30px; font-size: 1.2em; font-weight: bold; }
    </style>
    </head>
    <body>
        <%@include file="/header.jsp" %>
        
        <div class="container">
            <h1>Lịch sử đơn hàng của bạn</h1>
        
            <c:if test="${not empty orders}">
                <table>
                    <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Ngày tạo</th>
                            <th>Ngày hẹn</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái thanh toán</th>
                            <th>Trạng thái đơn</th>
                            <th>Hình thức thanh toán</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="order">
                            <tr>
                                <td>${order.id}</td>
                                <td><fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td><fmt:formatDate value="${order.appointmentDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td><fmt:formatNumber value="${order.price}" type="currency"/></td>
                                <td class="${order.paymentStatus == 'Đã thanh toán' ? 'status-paid' : 'status-pending'}">
                                    ${order.paymentStatus}
                                </td>
                                <td>${order.orderStatus}</td>
                                <td>${order.paymentMethod}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        
            <c:if test="${empty orders}">
                <p>Bạn chưa có đơn hàng nào!</p>
            </c:if>
        </div>
    </body>
</html>
