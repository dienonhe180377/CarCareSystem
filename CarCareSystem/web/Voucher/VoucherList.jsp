<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Voucher của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .voucher-card {
            transition: transform 0.2s;
            border: 2px solid transparent;
        }
        .voucher-card:hover {
            transform: translateY(-5px);
            border-color: #0d6efd;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .voucher-expired {
            opacity: 0.6;
            background-color: #f8f9fa;
        }
        .voucher-used {
            opacity: 0.7;
            background-color: #f8f9fa;
        }
        .voucher-active {
            border-left: 4px solid #28a745;
        }
        .voucher-code-box {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 8px;
            padding: 10px;
            font-family: 'Courier New', monospace;
        }
        .discount-highlight {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            color: white;
            border-radius: 50px;
            padding: 8px 15px;
            font-weight: bold;
        }
        .detail-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }
        .detail-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            color: white;
        }
    </style>
</head>
<body class="bg-light">
    <!-- Set current date for comparison -->
    <jsp:useBean id="now" class="java.util.Date" />
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-ticket-alt text-primary"></i> Voucher của tôi</h2>
                    <div class="text-muted">
                        <i class="fas fa-info-circle"></i> 
                        Tổng cộng: <strong>${not empty userVouchers ? userVouchers.size() : 0}</strong> voucher
                    </div>
                </div>
                
                <c:choose>
                    <c:when test="${not empty userVouchers}">
                        <div class="row">
                            <c:forEach var="userVoucher" items="${userVouchers}">
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="card voucher-card h-100 
                                        <c:choose>
                                            <c:when test='${userVoucher.isUsed}'>voucher-used</c:when>
                                            <c:when test='${userVoucher.voucher.endDate.time < now.time}'>voucher-expired</c:when>
                                            <c:otherwise>voucher-active</c:otherwise>
                                        </c:choose>">
                                        
                                        <!-- Header với trạng thái -->
                                        <div class="card-header d-flex justify-content-between align-items-center">
                                            <h6 class="mb-0 text-truncate" title="${userVoucher.voucher.name}">
                                                ${userVoucher.voucher.name}
                                            </h6>
                                            <div>
                                                <c:choose>
                                                    <c:when test="${userVoucher.isUsed}">
                                                        <span class="badge bg-secondary">
                                                            <i class="fas fa-check"></i> Đã sử dụng
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${userVoucher.voucher.endDate.time < now.time}">
                                                        <span class="badge bg-danger">
                                                            <i class="fas fa-times"></i> Hết hạn
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${userVoucher.voucher.startDate.time > now.time}">
                                                        <span class="badge bg-warning">
                                                            <i class="fas fa-clock"></i> Chưa bắt đầu
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-success">
                                                            <i class="fas fa-check-circle"></i> Có thể sử dụng
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        
                                        <div class="card-body">
                                            <!-- Mã voucher -->
                                            <div class="text-center mb-3">
                                                <div class="voucher-code-box">
                                                    <h5 class="mb-1">${userVoucher.voucherCode}</h5>
                                                    <small>Mã voucher</small>
                                                </div>
                                            </div>
                                            
                                            <!-- Giá trị giảm giá -->
                                            <div class="text-center mb-3">
                                                <div class="discount-highlight d-inline-block">
                                                    <c:choose>
                                                        <c:when test="${userVoucher.voucher.discountType == 'PERCENTAGE'}">
                                                            <i class="fas fa-percent"></i> ${userVoucher.voucher.discount}%
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-money-bill"></i>
                                                            <fmt:formatNumber value="${userVoucher.voucher.discount}" type="currency" currencySymbol="₫"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="small text-muted mt-1">Giá trị giảm</div>
                                            </div>
                                            
                                            <!-- Mô tả ngắn gọn -->
                                            <c:if test="${not empty userVoucher.voucher.description}">
                                                <p class="card-text small text-muted text-center mb-3" 
                                                   style="height: 40px; overflow: hidden;">
                                                    ${userVoucher.voucher.description}
                                                </p>
                                            </c:if>
                                            
                                            <!-- Điều kiện quan trọng -->
                                            <div class="small mb-3">
                                                <c:if test="${userVoucher.voucher.minOrderAmount > 0}">
                                                    <div class="d-flex align-items-center mb-1">
                                                        <i class="fas fa-shopping-cart text-info me-2"></i>
                                                        <span>Đơn tối thiểu: 
                                                            <strong>
                                                                <fmt:formatNumber value="${userVoucher.voucher.minOrderAmount}" type="currency" currencySymbol="₫"/>
                                                            </strong>
                                                        </span>
                                                    </div>
                                                </c:if>
                                                
                                                <c:if test="${userVoucher.voucher.maxDiscountAmount > 0}">
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-coins text-warning me-2"></i>
                                                        <span>Giảm tối đa: 
                                                            <strong>
                                                                <fmt:formatNumber value="${userVoucher.voucher.maxDiscountAmount}" type="currency" currencySymbol="₫"/>
                                                            </strong>
                                                        </span>
                                                    </div>
                                                </c:if>
                                            </div>
                                            
                                            <!-- Nút xem chi tiết -->
                                            <div class="text-center">
                                                <a href="voucher?action=userDetail&id=${userVoucher.voucher.id}" 
                                                   class="btn detail-btn btn-sm">
                                                    <i class="fas fa-eye"></i> Xem chi tiết
                                                </a>
                                            </div>
                                        </div>
                                        
                                        <!-- Footer với thời gian -->
                                        <div class="card-footer small text-muted">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span>
                                                    <i class="fas fa-calendar-alt"></i>
                                                    <fmt:formatDate value="${userVoucher.voucher.startDate}" pattern="dd/MM/yyyy"/>
                                                </span>
                                                <span>
                                                    <i class="fas fa-calendar-times"></i>
                                                    <fmt:formatDate value="${userVoucher.voucher.endDate}" pattern="dd/MM/yyyy"/>
                                                </span>
                                            </div>
                                            
                                            <c:if test="${userVoucher.isUsed && not empty userVoucher.usedDate}">
                                                <div class="text-center mt-2 pt-2 border-top">
                                                    <small class="text-muted">
                                                        <i class="fas fa-check-circle"></i>
                                                        Đã sử dụng: <fmt:formatDate value="${userVoucher.usedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </small>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Thống kê nhanh -->
                        <div class="row mt-4">
                            <div class="col-12">
                                <div class="card bg-light">
                                    <div class="card-body">
                                        <div class="row text-center">
                                            <div class="col-md-3">
                                                <div class="text-success">
                                                    <i class="fas fa-check-circle fa-2x"></i>
                                                    <h5 class="mt-2">
                                                        <c:set var="activeCount" value="0"/>
                                                        <c:forEach var="uv" items="${userVouchers}">
                                                            <c:if test="${!uv.isUsed && uv.voucher.endDate.time >= now.time && uv.voucher.startDate.time <= now.time}">
                                                                <c:set var="activeCount" value="${activeCount + 1}"/>
                                                            </c:if>
                                                        </c:forEach>
                                                        ${activeCount}
                                                    </h5>
                                                    <small class="text-muted">Có thể sử dụng</small>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="text-secondary">
                                                    <i class="fas fa-check fa-2x"></i>
                                                    <h5 class="mt-2">
                                                        <c:set var="usedCount" value="0"/>
                                                        <c:forEach var="uv" items="${userVouchers}">
                                                            <c:if test="${uv.isUsed}">
                                                                <c:set var="usedCount" value="${usedCount + 1}"/>
                                                            </c:if>
                                                        </c:forEach>
                                                        ${usedCount}
                                                    </h5>
                                                    <small class="text-muted">Đã sử dụng</small>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="text-danger">
                                                    <i class="fas fa-times-circle fa-2x"></i>
                                                    <h5 class="mt-2">
                                                        <c:set var="expiredCount" value="0"/>
                                                        <c:forEach var="uv" items="${userVouchers}">
                                                            <c:if test="${!uv.isUsed && uv.voucher.endDate.time < now.time}">
                                                                <c:set var="expiredCount" value="${expiredCount + 1}"/>
                                                            </c:if>
                                                        </c:forEach>
                                                        ${expiredCount}
                                                    </h5>
                                                    <small class="text-muted">Hết hạn</small>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="text-warning">
                                                    <i class="fas fa-clock fa-2x"></i>
                                                    <h5 class="mt-2">
                                                        <c:set var="futureCount" value="0"/>
                                                        <c:forEach var="uv" items="${userVouchers}">
                                                            <c:if test="${!uv.isUsed && uv.voucher.startDate.time > now.time}">
                                                                <c:set var="futureCount" value="${futureCount + 1}"/>
                                                            </c:if>
                                                        </c:forEach>
                                                        ${futureCount}
                                                    </h5>
                                                    <small class="text-muted">Chưa bắt đầu</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <div class="card">
                                <div class="card-body py-5">
                                    <i class="fas fa-ticket-alt fa-5x text-muted mb-4"></i>
                                    <h4 class="text-muted">Bạn chưa có voucher nào</h4>
                                    <p class="text-muted">Hãy tham gia các chương trình khuyến mãi để nhận voucher!</p>
                                    <div class="mt-4">
                                        <i class="fas fa-gift text-primary me-2"></i>
                                        <span class="text-muted">Voucher sẽ được cập nhật thường xuyên</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
