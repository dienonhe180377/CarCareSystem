

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Repairer - Order Management</title>
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
            .badge {
                font-size: 0.85em;
                padding: 5px 8px;
                font-weight: 600;
                margin-right: 3px;
                margin-bottom: 3px;
                display: inline-block;
            }
            .service-badge {
                background-color: #0d6efd;
            }
            .part-badge {
                background-color: #198754;
            }
            .service-list, .part-list {
                max-height: 400px;
                overflow-y: auto;
                padding: 10px;
            }
            .service-item, .part-item {
                padding: 8px;
                border-bottom: 1px solid #eee;
            }
            .status-select {
                min-width: 150px;
            }
            .cursor-pointer {
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        
        <div class="container">
            <h1>Quản Lý Đơn Hàng Đã Nhận Xe</h1>
            
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
        
            <div class="table-responsive">
                <table class="order-table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Khách Hàng</th>
                            <th>Liên Hệ</th>
                            <th>Loại Xe</th>
                            <th>Giá</th>
                            <th>Dịch Vụ & Phụ Tùng</th>
                            <th>Trạng Thái</th>
                            <th>Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="order">
                            <tr>
                                <td>#${order.id}</td>
                                <td>${order.name}</td>
                                <td>
                                    <div>${order.phone}</div>
                                    <small class="text-muted">${order.email}</small>
                                </td>
                                <td>${order.carType.name}</td>
                                <td class="fw-bold">
                                    <fmt:formatNumber value="${order.price}" type="currency" currencyCode="VND"/>
                                </td>
                                <td>
                                    <!-- Dịch vụ -->
                                    <div class="mb-2">
                                        <span class="fw-bold">Dịch vụ:</span>
                                        <c:choose>
                                            <c:when test="${not empty order.services}">
                                                <c:forEach items="${order.services}" var="service">
                                                    <span class="badge service-badge cursor-pointer" 
                                                          data-bs-toggle="modal" data-bs-target="#serviceDetailModal${service.id}">
                                                        ${service.name}
                                                    </span>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Không có dịch vụ</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <!-- Phụ tùng -->
                                    <div>
                                        <span class="fw-bold">Phụ tùng:</span>
                                        <c:choose>
                                            <c:when test="${not empty order.parts}">
                                                <c:forEach items="${order.parts}" var="part">
                                                    <span class="badge part-badge">${part.name}</span>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Không có phụ tùng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/order_repair" method="POST" class="status-form">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" value="${order.id}">
                                        <select name="newStatus" class="form-select status-select" onchange="this.form.submit()">
                                            <option value="Đã Nhận Xe" ${order.orderStatus eq 'Đã Nhận Xe' ? 'selected' : ''}>Đã Nhận Xe</option>
                                            <option value="Đang Sửa Chữa" ${order.orderStatus eq 'Đang Sửa Chữa' ? 'selected' : ''}>Đang Sửa Chữa</option>
                                            <option value="Hoàn Thành" ${order.orderStatus eq 'Hoàn Thành' ? 'selected' : ''}>Hoàn Thành</option>
                                            <option value="Đã Trả Xe" ${order.orderStatus eq 'Đã Trả Xe' ? 'selected' : ''}>Đã Trả Xe</option>
                                        </select>
                                    </form>
                                </td>
                                <td>
                                    <div class="d-flex gap-2">
                                        <!-- Nút chỉnh sửa dịch vụ -->
                                        <button class="btn btn-sm btn-outline-primary" 
                                                data-bs-toggle="modal" data-bs-target="#editServicesModal${order.id}">
                                            <i class="bi bi-pencil"></i> Sửa DV
                                        </button>
                                        
                                        <!-- Nút chỉnh sửa phụ tùng -->
                                        <button class="btn btn-sm btn-outline-success" 
                                                data-bs-toggle="modal" data-bs-target="#editPartsModal${order.id}">
                                            <i class="bi bi-wrench"></i> Sửa PT
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            
                            <!-- Modal Chi tiết Dịch vụ -->
                            <c:forEach items="${order.services}" var="service">
                                <div class="modal fade" id="serviceDetailModal${service.id}" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Chi tiết dịch vụ: ${service.name}</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p><strong>Mô tả:</strong> ${service.description}</p>
                                                <p><strong>Giá dịch vụ:</strong> 
                                                    <fmt:formatNumber value="${service.price}" type="currency" currencyCode="VND"/>
                                                </p>
                                                <c:if test="${not empty service.parts}">
                                                    <h6>Phụ tùng sử dụng:</h6>
                                                    <ul>
                                                        <c:forEach items="${service.parts}" var="part">
                                                            <li>${part.name} - 
                                                                <fmt:formatNumber value="${part.price}" type="currency" currencyCode="VND"/>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </c:if>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            
                            <!-- Modal Sửa Dịch Vụ -->
                            <div class="modal fade" id="editServicesModal${order.id}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Chỉnh sửa dịch vụ - Đơn #${order.id}</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <form action="${pageContext.request.contextPath}/order_repair" method="POST">
                                            <input type="hidden" name="action" value="updateServices">
                                            <input type="hidden" name="orderId" value="${order.id}">
                                            <div class="modal-body">
                                                <div class="service-list">
                                                    <c:forEach items="${allServices}" var="service">
                                                        <div class="service-item form-check">
                                                            <input class="form-check-input" type="checkbox" 
                                                                   name="serviceIds" value="${service.id}"
                                                                   id="service${service.id}_order${order.id}"
                                                                   <c:if test="${order.services.stream().anyMatch(s -> s.id == service.id)}">checked</c:if>>
                                                            <label class="form-check-label w-100" for="service${service.id}_order${order.id}">
                                                                <div class="d-flex justify-content-between">
                                                                    <span>
                                                                        <strong>${service.name}</strong> - 
                                                                        <fmt:formatNumber value="${service.price}" type="currency" currencyCode="VND"/>
                                                                    </span>
                                                                    <button type="button" class="btn btn-sm btn-outline-info" 
                                                                            data-bs-toggle="modal" data-bs-target="#serviceDetailModal${service.id}">
                                                                        Chi tiết
                                                                    </button>
                                                                </div>
                                                                <small class="text-muted">${service.description}</small>
                                                            </label>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Modal Sửa Phụ Tùng -->
                            <div class="modal fade" id="editPartsModal${order.id}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Chỉnh sửa phụ tùng - Đơn #${order.id}</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <form action="${pageContext.request.contextPath}/order_repair" method="POST">
                                            <input type="hidden" name="action" value="updateParts">
                                            <input type="hidden" name="orderId" value="${order.id}">
                                            <div class="modal-body">
                                                <div class="part-list">
                                                    <c:forEach items="${allParts}" var="part">
                                                        <div class="part-item form-check">
                                                            <input class="form-check-input" type="checkbox" 
                                                                   name="partIds" value="${part.id}"
                                                                   id="part${part.id}_order${order.id}"
                                                                   <c:if test="${order.parts.stream().anyMatch(p -> p.id == part.id)}">checked</c:if>>
                                                            <label class="form-check-label" for="part${part.id}_order${order.id}">
                                                                <strong>${part.name}</strong> - 
                                                                <fmt:formatNumber value="${part.price}" type="currency" currencyCode="VND"/>
                                                            </label>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Tự động đóng thông báo sau 5 giây
            setTimeout(() => {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    new bootstrap.Alert(alert).close();
                });
            }, 5000);
        </script>
    </body>
</html>
