<%-- 
    Document   : VoucherDetail
    Created on : Jul 13, 2025, 10:01:56 PM
    Author     : NTN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Voucher</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="card">
                    <div class="card-header">
                        <h4><i class="fas fa-ticket-alt"></i> Chi tiết Voucher</h4>
                        <a href="voucher" class="btn btn-secondary btn-sm float-end">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty voucher}">
                            <div class="row">
                                <!-- Thông tin cơ bản -->
                                <div class="col-md-6">
                                    <div class="card border-primary">
                                        <div class="card-header bg-primary text-white">
                                            <h5><i class="fas fa-info-circle"></i> Thông tin cơ bản</h5>
                                        </div>
                                        <div class="card-body">
                                            <table class="table table-borderless">
                                                <tr>
                                                    <td><strong>ID:</strong></td>
                                                    <td>${voucher.id}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Tên:</strong></td>
                                                    <td>${voucher.name}</td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Mã voucher:</strong></td>
                                                    <td>
                                                        <span class="badge bg-info fs-6">${voucher.voucherCode}</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Mô tả:</strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty voucher.description}">
                                                                ${voucher.description}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Không có mô tả</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Trạng thái:</strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${voucher.status}">
                                                                <span class="badge bg-success">Hoạt động</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">Không hoạt động</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Thông tin giảm giá -->
                                <div class="col-md-6">
                                    <div class="card border-success">
                                        <div class="card-header bg-success text-white">
                                            <h5><i class="fas fa-percent"></i> Thông tin giảm giá</h5>
                                        </div>
                                        <div class="card-body">
                                            <table class="table table-borderless">
                                                <tr>
                                                    <td><strong>Loại giảm giá:</strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                                                <span class="badge bg-success">Phần trăm</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-primary">Số tiền cố định</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Giá trị giảm:</strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                                                <span class="text-success fw-bold">${voucher.discount}%</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-success fw-bold">
                                                                    <fmt:formatNumber value="${voucher.discount}" type="currency" currencySymbol="₫"/>
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Giảm tối đa:</strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${voucher.maxDiscountAmount > 0}">
                                                                <fmt:formatNumber value="${voucher.maxDiscountAmount}" type="currency" currencySymbol="₫"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Không giới hạn</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><strong>Đơn hàng tối thiểu:</strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${voucher.minOrderAmount > 0}">
                                                                <fmt:formatNumber value="${voucher.minOrderAmount}" type="currency" currencySymbol="₫"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Không yêu cầu</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Thông tin thời gian -->
                            <div class="row mt-3">
                                <div class="col-md-12">
                                    <div class="card border-warning">
                                        <div class="card-header bg-warning text-dark">
                                            <h5><i class="fas fa-calendar-alt"></i> Thông tin thời gian</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <strong>Ngày tạo:</strong><br>
                                                    <fmt:formatDate value="${voucher.createdDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                                </div>
                                                <div class="col-md-4">
                                                    <strong>Ngày bắt đầu:</strong><br>
                                                    <fmt:formatDate value="${voucher.startDate}" pattern="dd/MM/yyyy"/>
                                                </div>
                                                <div class="col-md-4">
                                                    <strong>Ngày kết thúc:</strong><br>
                                                    <fmt:formatDate value="${voucher.endDate}" pattern="dd/MM/yyyy"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Danh sách người sở hữu -->
                            <div class="row mt-3">
                                <div class="col-md-12">
                                    <div class="card border-info">
                                        <div class="card-header bg-info text-white">
                                            <h5><i class="fas fa-users"></i> Người sở hữu voucher (${fn:length(owners)})</h5>
                                        </div>
                                        <div class="card-body">
                                            <c:choose>
                                                <c:when test="${not empty owners}">
                                                    <div class="row">
                                                        <c:forEach var="owner" items="${owners}" varStatus="status">
                                                            <div class="col-md-4 mb-2">
                                                                <span class="badge bg-light text-dark border">
                                                                    <i class="fas fa-user"></i> ${owner}
                                                                </span>
                                                            </div>
                                                            <c:if test="${status.count % 3 == 0}">
                                                                </div><div class="row">
                                                            </c:if>
                                                        </c:forEach>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="text-center py-4">
                                                        <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                                        <p class="text-muted">Chưa có ai sở hữu voucher này</p>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${empty voucher}">
                            <div class="text-center py-5">
                                <i class="fas fa-exclamation-triangle fa-3x text-warning mb-3"></i>
                                <h4>Không tìm thấy voucher</h4>
                                <p class="text-muted">Voucher bạn tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

