<%-- 
    Document   : VoucherDetailUser
    Created on : Jul 13, 2025, 11:37:40 PM
    Author     : NTN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Voucher</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .voucher-card {
            border: 2px solid #e74c3c;
            border-radius: 15px;
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white;
            position: relative;
            overflow: hidden;
        }
        
        .voucher-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="2" fill="rgba(255,255,255,0.1)"/></svg>') repeat;
            opacity: 0.3;
        }
        
        .voucher-content {
            position: relative;
            z-index: 1;
        }
        
        .voucher-code {
            font-family: 'Courier New', monospace;
            font-size: 1.5rem;
            font-weight: bold;
            background: rgba(255,255,255,0.2);
            padding: 10px 20px;
            border-radius: 25px;
            border: 2px dashed rgba(255,255,255,0.5);
            display: inline-block;
            margin: 10px 0;
        }
        
        .discount-badge {
            background: #27ae60;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 1.1rem;
        }
        
        .status-active {
            color: #27ae60;
            font-weight: bold;
        }
        
        .status-inactive {
            color: #e74c3c;
            font-weight: bold;
        }
        
        .info-row {
            margin-bottom: 15px;
            padding: 10px;
            background: rgba(255,255,255,0.05);
            border-radius: 8px;
        }
        
        .back-btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            color: white;
            padding: 10px 25px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        
        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            color: white;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <!-- Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <h2><i class="fas fa-ticket-alt text-primary"></i> Chi tiết Voucher</h2>
                    <a href="voucher" class="btn back-btn">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                </div>
            </div>
        </div>

        <c:if test="${not empty voucher}">
            <!-- Voucher Card -->
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card voucher-card shadow-lg">
                        <div class="card-body p-4 voucher-content">
                            <!-- Voucher Name -->
                            <div class="text-center mb-4">
                                <h3 class="mb-3">
                                    <i class="fas fa-gift"></i> ${voucher.name}
                                </h3>
                                <div class="voucher-code">
                                    ${voucher.voucherCode}
                                </div>
                            </div>

                            <!-- Discount Info -->
                            <div class="text-center mb-4">
                                <span class="discount-badge">
                                    <c:choose>
                                        <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                            Giảm ${voucher.discount}%
                                        </c:when>
                                        <c:otherwise>
                                            Giảm <fmt:formatNumber value="${voucher.discount}" type="currency" currencySymbol="₫"/>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <!-- Description -->
                            <c:if test="${not empty voucher.description}">
                                <div class="info-row">
                                    <h6><i class="fas fa-info-circle"></i> Mô tả:</h6>
                                    <p class="mb-0">${voucher.description}</p>
                                </div>
                            </c:if>

                            <!-- Conditions -->
                            <c:if test="${voucher.minOrderAmount > 0}">
                                <div class="info-row">
                                    <h6><i class="fas fa-shopping-cart"></i> Đơn hàng tối thiểu:</h6>
                                    <p class="mb-0">
                                        <fmt:formatNumber value="${voucher.minOrderAmount}" type="currency" currencySymbol="₫"/>
                                    </p>
                                </div>
                            </c:if>

                            <c:if test="${voucher.maxDiscountAmount > 0}">
                                <div class="info-row">
                                    <h6><i class="fas fa-hand-holding-usd"></i> Giảm tối đa:</h6>
                                    <p class="mb-0">
                                        <fmt:formatNumber value="${voucher.maxDiscountAmount}" type="currency" currencySymbol="₫"/>
                                    </p>
                                </div>
                            </c:if>

                            <!-- Validity Period -->
                            <div class="info-row">
                                <h6><i class="fas fa-calendar-alt"></i> Thời gian sử dụng:</h6>
                                <p class="mb-0">
                                    Từ <fmt:formatDate value="${voucher.startDate}" pattern="dd/MM/yyyy"/>
                                    đến <fmt:formatDate value="${voucher.endDate}" pattern="dd/MM/yyyy"/>
                                </p>
                            </div>

                            <!-- Status -->
                            <div class="info-row">
                                <h6><i class="fas fa-toggle-on"></i> Trạng thái:</h6>
                                <p class="mb-0">
                                    <c:choose>
                                        <c:when test="${voucher.status}">
                                            <span class="status-active">
                                                <i class="fas fa-check-circle"></i> Đang hoạt động
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-inactive">
                                                <i class="fas fa-times-circle"></i> Ngừng hoạt động
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${empty voucher}">
            <div class="row">
                <div class="col-12">
                    <div class="alert alert-warning text-center">
                        <i class="fas fa-exclamation-triangle"></i>
                        Không tìm thấy thông tin voucher!
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
