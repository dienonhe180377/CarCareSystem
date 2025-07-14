<%-- 
    Document   : Voucher
    Created on : Jul 13, 2025, 1:51:45 PM
    Author     : NTN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý Voucher</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Quản lý Voucher</h2>
        
        <!-- Hiển thị thông báo -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>
        
        <!-- Các nút thêm voucher -->
        <div class="mb-3">
            <a href="voucher?action=addByUser" class="btn btn-primary">Thêm Voucher cho User</a>
            <a href="voucher?action=addPublic" class="btn btn-success">Thêm Voucher Công khai</a>
            <a href="voucher?action=addPrivate" class="btn btn-warning">Thêm Voucher Riêng tư</a>
        </div>
        
        <!-- Bảng danh sách voucher -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Mã Voucher</th>
                    <th>Loại giảm giá</th>
                    <th>Giá trị</th>
                    <th>Ngày bắt đầu</th>
                    <th>Ngày kết thúc</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="voucher" items="${vouchers}">
                    <tr>
                        <td>${voucher.id}</td>
                        <td>${voucher.name}</td>
                        <td><strong>${voucher.voucherCode}</strong></td>
                        <td>
                            <c:choose>
                                <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                    Phần trăm
                                </c:when>
                                <c:otherwise>
                                    Số tiền
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                    ${voucher.discount}%
                                </c:when>
                                <c:otherwise>
                                    ${voucher.discount} VNĐ
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${voucher.startDate}</td>
                        <td>${voucher.endDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${voucher.status}">
                                    <span class="badge bg-success">Hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">Không hoạt động</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="voucher?action=detail&id=${voucher.id}" class="btn btn-info btn-sm">Chi tiết</a>
                            <a href="voucher?action=delete&id=${voucher.id}" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Bạn có chắc muốn xóa voucher này?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty vouchers}">
                    <tr>
                        <td colspan="9" class="text-center">Không có voucher nào</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
