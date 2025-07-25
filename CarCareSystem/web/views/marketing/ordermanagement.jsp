

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .container {
                max-width: 95%;
                margin: 0 auto;
                background: white;
                padding: 25px;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }
            h1 {
                color: #343a40;
                margin-bottom: 25px;
                padding-bottom: 10px;
                border-bottom: 1px solid #eee;
            }
            .order-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                font-size: 0.9em;
            }
            .order-table th, .order-table td {
                border: 1px solid #dee2e6;
                padding: 12px 15px;
                text-align: left;
            }
            .order-table th {
                background-color: #343a40;
                color: white;
                position: sticky;
                top: 0;
            }
            .order-table tr:nth-child(even) {
                background-color: #f8f9fa;
            }
            .order-table tr:hover {
                background-color: #e9ecef;
            }
            .filter-buttons {
                margin-bottom: 20px;
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }
            .search-box {
                margin-bottom: 25px;
                display: flex;
                max-width: 400px;
            }
            .search-box input {
                border-top-right-radius: 0;
                border-bottom-right-radius: 0;
            }
            .search-box button {
                border-top-left-radius: 0;
                border-bottom-left-radius: 0;
            }
            .status-form {
                display: inline;
                margin-right: 5px;
            }
            .btn-sm {
                padding: 0.25rem 0.5rem;
                font-size: 0.875rem;
            }
            .alert {
                padding: 10px 15px;
                margin-bottom: 20px;
                border-radius: 4px;
            }
            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            .action-buttons {
                display: flex;
                gap: 5px;
                flex-wrap: wrap;
            }
            .table-responsive {
                overflow-x: auto;
            }
            .badge {
                font-size: 0.85em;
                padding: 5px 8px;
                font-weight: 600;
            }
            .badge-warning {
                background-color: #ffc107;
                color: #212529;
            }
            .badge-danger {
                background-color: #dc3545;
            }
            .badge-success {
                background-color: #28a745;
            }
            .badge-info {
                background-color: #17a2b8;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>

        <div class="container">
            <h1>Order Management</h1>

            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="filter-buttons">
                <a href="${pageContext.request.contextPath}/ordermanagement" class="btn btn-dark">All Orders</a>
                <a href="${pageContext.request.contextPath}/ordermanagement?action=unconfirmed" class="btn btn-warning">Chưa Xác Nhận</a>
                <a href="${pageContext.request.contextPath}/ordermanagement?action=miss" class="btn btn-warning">Lỡ Hẹn</a>
                <a href="${pageContext.request.contextPath}/ordermanagement?action=unpaid" class="btn btn-danger">Chưa Thanh Toán</a>
                <a href="${pageContext.request.contextPath}/ordermanagement?action=paid" class="btn btn-success">Đã Thanh Toán</a>
                <a href="${pageContext.request.contextPath}/ordermanagement?action=done" class="btn btn-success">Đơn Hoàn Thành</a>
            </div>

            <div class="search-box">
                <form action="${pageContext.request.contextPath}/ordermanagement" method="GET" class="d-flex">
                    <input type="text" name="search" class="form-control" placeholder="Search by name, email, phone or ID">
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>
            </div>

            <div class="table-responsive">
                <table class="order-table">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên</th>
                            <th>Liên Hệ</th>
                            <th>Loại Xe</th>
                            <th>Ngày Hẹn</th>
                            <th>Giá</th>
                            <th>Thanh Toán</th>
                            <th>Trạng Thái</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="order" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${order.name}</td>
                                <td>
                                    <div>${order.email}</div>
                                    <div class="text-muted">${order.phone}</div>
                                </td>
                                <td>${order.carType.name}</td>
                                <td>
                                    <fmt:formatDate value="${order.appointmentDate}" pattern="dd/MM/yyyy" />
                                </td>
                                <td>
                                    <fmt:formatNumber value="${order.price}" type="currency" currencyCode="VND" groupingUsed="false" maxFractionDigits="0"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.paymentStatus == 'Đã thanh toán'}">
                                            <span class="badge badge-success">${order.paymentStatus}</span>
                                        </c:when>
                                        <c:when test="${order.paymentStatus == 'Chưa thanh toán'}">
                                            <span class="badge badge-danger">${order.paymentStatus}</span>
                                        </c:when>
                                        <c:otherwise>                                           
                                            <span class="badge badge-info">${order.paymentStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.orderStatus == 'Đã Nhận Xe'}">
                                            <span class="badge badge-success">${order.orderStatus}</span>
                                        </c:when>
                                        <c:when test="${order.orderStatus == 'Chưa xác nhận'}">
                                            <span class="badge badge-warning">${order.orderStatus}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-info">${order.orderStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <c:if test="${order.paymentStatus == 'Chưa thanh toán'}">
                                            <form class="status-form" action="${pageContext.request.contextPath}/ordermanagement" method="POST">
                                                <input type="hidden" name="action" value="confirmPayment">
                                                <input type="hidden" name="orderId" value="${order.id}">
                                                <button type="submit" class="btn btn-success btn-sm">Xác nhận thanh toán</button>
                                            </form>
                                        </c:if>
                                    </div>
                                    <div class="action-buttons">
                                        <c:if test="${order.orderStatus == 'Chưa xác nhận'}">
                                            <c:set var="now" value="<%= new java.util.Date() %>" />
                                            <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today"/>
                                            <fmt:formatDate value="${order.appointmentDate}" pattern="yyyy-MM-dd" var="appointmentDay"/>

                                            <c:choose>
                                                <c:when test="${appointmentDay == today}">
                                                    <form class="status-form" action="${pageContext.request.contextPath}/ordermanagement" method="POST">
                                                        <input type="hidden" name="action" value="confirmReceived">
                                                        <input type="hidden" name="orderId" value="${order.id}">
                                                        <button type="submit" class="btn btn-success btn-sm">Nhận xe</button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa đến ngày hẹn</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>

                                        <c:if test="${order.orderStatus == 'Lỡ hẹn'}">                                            
                                            <button type="button" class="btn btn-warning btn-sm" data-bs-toggle="modal" 
                                                    data-bs-target="#rescheduleModal${order.id}">
                                                Đặt lại lịch hẹn
                                            </button>  
                                        </c:if>        
                                        <a href="${pageContext.request.contextPath}/orderDetail?orderId=${order.id}" 
                                           class="btn btn-info btn-sm">Details</a>
                                    </div>

                                    <div class="modal fade" id="rescheduleModal${order.id}" tabindex="-1" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Đổi lịch hẹn cho đơn #${order.id}</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <form action="${pageContext.request.contextPath}/ordermanagement" method="POST">
                                                    <input type="hidden" name="action" value="reschedule">
                                                    <input type="hidden" name="orderId" value="${order.id}">
                                                    <div class="modal-body">
                                                        <div class="mb-3">
                                                            <label class="form-label">Ngày hẹn mới</label>
                                                            <input type="date" class="form-control" name="newAppointmentDate" required
                                                                   min="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />">
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
