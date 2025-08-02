<%-- 
    Document   : VoucherDetail
    Created on : Jul 13, 2025, 10:01:56 PM
    Author     : NTN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>
<fmt:setTimeZone value="Asia/Ho_Chi_Minh"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Voucher</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #add8e6;
            --secondary-blue: #87ceeb;
            --light-blue: #e6f3ff;
            --dark-blue: #4682b4;
            --accent-blue: #b0e0e6;
            --success-green: #28a745;
            --warning-orange: #fd7e14;
            --danger-red: #dc3545;
            --info-cyan: #17a2b8;
            --purple: #6f42c1;
            --indigo: #6610f2;
            --pink: #e83e8c;
            --teal: #20c997;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f0f8ff 0%, #e6f3ff 100%);
            min-height: 100vh;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            text-align: center;
            position: relative;
        }

        .header h1 {
            color: white;
            font-size: 2.5rem;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .header p {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
        }

        .back-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            background: rgba(255,255,255,0.2);
            color: white;
            border: 2px solid rgba(255,255,255,0.3);
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .back-btn:hover {
            background: rgba(255,255,255,0.3);
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }

        .detail-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 0;
        }

        .detail-section {
            padding: 30px;
            border-right: 1px solid #f0f0f0;
            position: relative;
        }

        .detail-section:last-child {
            border-right: none;
        }

        .section-header {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 3px solid var(--light-blue);
        }

        .section-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            font-size: 1.5rem;
            color: white;
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--dark-blue);
        }

        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px;
            background: var(--light-blue);
            border-radius: 12px;
            transition: all 0.3s ease;
        }

        .info-item:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .info-label {
            font-weight: 600;
            color: var(--dark-blue);
            min-width: 140px;
            display: flex;
            align-items: center;
        }

        .info-label i {
            margin-right: 8px;
            width: 20px;
        }

        .info-value {
            flex: 1;
            color: #333;
        }

        .badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-active {
            background: linear-gradient(45deg, var(--success-green), #32cd32);
            color: white;
        }

        .badge-inactive {
            background: linear-gradient(45deg, var(--danger-red), #ff6b6b);
            color: white;
        }

        .badge-percentage {
            background: linear-gradient(45deg, var(--success-green), #32cd32);
            color: white;
        }

        .badge-fixed {
            background: linear-gradient(45deg, var(--info-cyan), #20c997);
            color: white;
        }

        .badge-service {
            background: linear-gradient(45deg, var(--purple), var(--indigo));
            color: white;
        }

        .badge-all-services {
            background: linear-gradient(45deg, var(--teal), var(--info-cyan));
            color: white;
        }

        .badge-campaign {
            background: linear-gradient(45deg, var(--warning-orange), #ffc107);
            color: white;
        }

        .voucher-code {
            font-family: 'Courier New', monospace;
            font-size: 1.2rem;
            font-weight: bold;
            letter-spacing: 2px;
            background: linear-gradient(45deg, var(--primary-blue), var(--secondary-blue));
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-transform: uppercase;
        }

        .owners-section {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            padding: 30px;
            margin-bottom: 30px;
        }

        .owners-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }

        .owner-item {
            background: var(--light-blue);
            padding: 15px 20px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            border-left: 4px solid var(--primary-blue);
        }

        .owner-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .owner-item i {
            color: var(--dark-blue);
            margin-right: 12px;
            font-size: 1.1rem;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state i {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        .action-buttons {
            text-align: center;
            margin-top: 30px;
        }

        .btn {
            display: inline-block;
            padding: 12px 30px;
            margin: 0 10px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 1rem;
        }

        .btn-edit {
            background: linear-gradient(45deg, var(--warning-orange), #ffc107);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(45deg, var(--danger-red), #ff6b6b);
            color: white;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        }

        .currency {
            color: var(--success-green);
            font-weight: bold;
        }

        .percentage {
            color: var(--success-green);
            font-weight: bold;
            font-size: 1.1rem;
        }

        @media (max-width: 768px) {
            .detail-grid {
                grid-template-columns: 1fr;
            }
            
            .detail-section {
                border-right: none;
                border-bottom: 1px solid #f0f0f0;
            }
            
            .detail-section:last-child {
                border-bottom: none;
            }
            
            .header h1 {
                font-size: 2rem;
            }
            
            .back-btn {
                position: relative;
                top: auto;
                left: auto;
                margin-bottom: 20px;
            }
            
            .owners-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/header_emp.jsp"></jsp:include>
    
    <div class="container">
        <div class="header">
            <a href="voucher" class="back-btn">
                <i class="fas fa-arrow-left"></i> Quay lại
            </a>
            <h1><i class="fas fa-ticket-alt"></i> Chi tiết Voucher</h1>
            <p>Thông tin chi tiết về voucher trong hệ thống</p>
        </div>

        <c:if test="${not empty voucher}">
            <div class="detail-container">
                <div class="detail-grid">
                    <!-- Thông tin cơ bản -->
                    <div class="detail-section">
                        <div class="section-header">
                            <div class="section-icon" style="background: linear-gradient(45deg, var(--primary-blue), var(--secondary-blue));">
                                <i class="fas fa-info-circle"></i>
                            </div>
                            <div class="section-title">Thông tin cơ bản</div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-hashtag"></i> ID:
                            </div>
                            <div class="info-value">${voucher.id}</div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-tag"></i> Tên:
                            </div>
                            <div class="info-value">${voucher.name}</div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-barcode"></i> Mã voucher:
                            </div>
                            <div class="info-value">
                                <span class="voucher-code">${voucher.voucherCode}</span>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-align-left"></i> Mô tả:
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty voucher.description}">
                                        ${voucher.description}
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #999;">Không có mô tả</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-toggle-on"></i> Trạng thái:
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${voucher.status == 'ACTIVE'}">
                                        <span class="badge badge-active">Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-inactive">Không hoạt động</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-sort-numeric-up"></i> Tổng số voucher có thể Claim:
                            </div>
                            <div class="info-value">
                                <span class="badge" style="background: var(--accent-blue); color: var(--dark-blue);">
                                    ${voucher.totalVoucherCount}
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Thông tin giảm giá -->
                    <div class="detail-section">
                        <div class="section-header">
                            <div class="section-icon" style="background: linear-gradient(45deg, var(--success-green), #32cd32);">
                                <i class="fas fa-percent"></i>
                            </div>
                            <div class="section-title">Thông tin giảm giá</div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-chart-line"></i> Loại giảm:
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                        <span class="badge badge-percentage">Phần trăm</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-fixed">Số tiền</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-gift"></i> Giá trị giảm:
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                        <span class="percentage">
                                            <fmt:formatNumber value="${voucher.discount}" type="number" />%
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="currency">
                                            <fmt:formatNumber value="${voucher.discount}" type="currency" />
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-arrow-up"></i> Giảm tối đa:
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${voucher.maxDiscountAmount > 0}">
                                        <span class="currency">
                                            <fmt:formatNumber value="${voucher.maxDiscountAmount}" type="currency" />
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #999;">Không giới hạn</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-arrow-down"></i> Đơn tối thiểu:
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${voucher.minOrderAmount > 0}">
                                        <span class="currency">
                                            <fmt:formatNumber value="${voucher.minOrderAmount}" type="currency" />
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #999;">Không yêu cầu</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="section-header">
                            <div class="section-icon" style="background: linear-gradient(45deg, var(--purple), var(--indigo));">
                                <i class="fas fa-cogs"></i>
                            </div>
                            <div class="section-title">Thông tin áp dụng</div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-concierge-bell"></i> Dịch vụ:
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty serviceName}">
                                        ${serviceName}
                                    </c:when>
                                    <c:otherwise>
                                        Tất cả dịch vụ
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-bullhorn"></i> Chiến dịch:
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${not empty campaignName}">
                                       ${campaignName}
                                    </c:when>
                                    <c:otherwise>
                                        Không thuộc chiến dịch
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Thông tin áp dụng -->
<!--                    <div class="detail-section">
                        
                    </div>-->

                    <!-- Thông tin thời gian -->
                    <div class="detail-section">
                        <div class="section-header">
                            <div class="section-icon" style="background: linear-gradient(45deg, var(--warning-orange), #ffc107);">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                            <div class="section-title">Thông tin thời gian</div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-plus-circle"></i> Ngày tạo:
                            </div>
                            <div class="info-value">
                                <fmt:formatDate value="${voucher.createdDate}" pattern="HH:mm dd/MM/yyyy"/>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-play-circle"></i> Bắt đầu:
                            </div>
                            <div class="info-value">
                                <fmt:formatDate value="${voucher.startDate}" pattern="HH:mm dd/MM/yyyy"/>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-stop-circle"></i> Kết thúc:
                            </div>
                            <div class="info-value">
                                <fmt:formatDate value="${voucher.endDate}" pattern="HH:mm dd/MM/yyyy"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Danh sách người sở hữu -->
            <div class="owners-section">
                <div class="section-header">
                    <div class="section-icon" style="background: linear-gradient(45deg, var(--info-cyan), var(--teal));">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="section-title">
                        Người sở hữu voucher 
                        <span class="badge" style="background: var(--light-blue); color: var(--dark-blue); margin-left: 10px;">
                            ${fn:length(owners)}
                        </span>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty owners}">
                        <div class="owners-grid">
                            <c:forEach var="owner" items="${owners}">
                                <div class="owner-item">
                                    <i class="fas fa-user"></i>
                                    <span>${owner}</span>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-users"></i>
                            <h3>Chưa có người sở hữu</h3>
                            <p>Voucher này chưa được phân phối cho ai</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${empty voucher}">
            <div class="detail-container">
                <div class="empty-state" style="padding: 80px 20px;">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h2>Không tìm thấy voucher</h2>
                    <p>Voucher bạn tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                    <a href="voucher?action=list" class="btn" style="background: var(--primary-blue); color: white; margin-top: 20px;">
                        <i class="fas fa-arrow-left"></i> Quay lại danh sách
                    </a>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>
