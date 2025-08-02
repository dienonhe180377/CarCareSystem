<%-- 
    Document   : VoucherDetailUser
    Created on : Jul 13, 2025, 11:37:40 PM
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

        /* Voucher Card - User Style */
        .voucher-showcase {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0,0,0,0.15);
            overflow: hidden;
            margin-bottom: 30px;
            position: relative;
        }

        .voucher-main-card {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            color: white;
            padding: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .voucher-main-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="20" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="20" cy="80" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="80" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="50" cy="50" r="2" fill="rgba(255,255,255,0.1)"/></svg>') repeat;
            animation: float 20s linear infinite;
            opacity: 0.3;
        }

        @keyframes float {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }

        .voucher-content {
            position: relative;
            z-index: 2;
        }

        .voucher-name {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .voucher-code-display {
            font-family: 'Courier New', monospace;
            font-size: 1.8rem;
            font-weight: bold;
            background: rgba(255,255,255,0.2);
            padding: 15px 30px;
            border-radius: 30px;
            border: 3px dashed rgba(255,255,255,0.6);
            display: inline-block;
            margin: 20px 0;
            letter-spacing: 3px;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .voucher-code-display:hover {
            background: rgba(255,255,255,0.3);
            transform: scale(1.05);
        }

        .discount-highlight {
            background: linear-gradient(45deg, var(--success-green), #32cd32);
            color: white;
            padding: 15px 25px;
            border-radius: 25px;
            font-weight: bold;
            font-size: 1.4rem;
            display: inline-block;
            margin: 20px 0;
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
        }

        /* Detail Sections */
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

        .currency {
            color: var(--success-green);
            font-weight: bold;
        }

        .percentage {
            color: var(--success-green);
            font-weight: bold;
            font-size: 1.1rem;
        }

        .copy-success {
            background: var(--success-green) !important;
            color: white !important;
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
            
            .voucher-name {
                font-size: 1.8rem;
            }
            
            .voucher-code-display {
                font-size: 1.4rem;
                padding: 12px 20px;
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
            <!-- Voucher Showcase -->
            <div class="voucher-showcase">
                <div class="voucher-main-card">
                    <div class="voucher-content">
                        <div class="voucher-name">
                            <i class="fas fa-gift"></i> ${voucher.name}
                        </div>
                        
                        <div class="voucher-code-display" onclick="copyVoucherCode(this)">
                            ${voucher.voucherCode}
                        </div>

                        
                        <c:if test="${not empty voucher.description}">
                            <div style="margin-top: 20px; font-size: 1.1rem; opacity: 0.9;">
                                <i class="fas fa-info-circle"></i> ${voucher.description}
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Detail Information -->
            <div class="detail-container">
                <div class="detail-grid">
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
                                <i class="fas fa-tag"></i> Loại giảm giá:
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                        <span class="badge badge-percentage">Phần trăm</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-fixed">Số tiền cố định</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-calculator"></i> Mức giảm:
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                        <fmt:formatNumber value="${voucher.discount}" type="number" />%
                                    </c:when>
                                    <c:otherwise>
                                        <span class="currency">
                                            <fmt:formatNumber value="${voucher.discount}" type="currency" currencySymbol="₫"/>
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <c:if test="${voucher.minOrderAmount > 0}">
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-shopping-cart"></i> Đơn hàng tối thiểu:
                                </div>
                                <div class="info-value">
                                    <span class="currency">
                                        <fmt:formatNumber value="${voucher.minOrderAmount}" type="currency" currencySymbol="₫"/>
                                    </span>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${voucher.maxDiscountAmount > 0}">
                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-hand-holding-usd"></i> Giảm tối đa:
                                </div>
                                <div class="info-value">
                                    <span class="currency">
                                        <fmt:formatNumber value="${voucher.maxDiscountAmount}" type="currency" currencySymbol="₫"/>
                                    </span>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Thông tin thời gian & trạng thái -->
                    <div class="detail-section">
                        <div class="section-header">
                            <div class="section-icon" style="background: linear-gradient(45deg, var(--info-cyan), var(--teal));">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="section-title">Thời gian</div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-calendar-plus"></i> Ngày bắt đầu:
                            </div>
                            <div class="info-value">
                                <fmt:formatDate value="${voucher.startDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-calendar-minus"></i> Ngày kết thúc:
                            </div>
                            <div class="info-value">
                                <fmt:formatDate value="${voucher.endDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </div>
                        </div>
                        

                        
                        <div class="info-item">
                            <div class="info-label">
                                <i class="fas fa-sort-numeric-up"></i> Số lượng có thể claim:
                            </div>
                            <div class="info-value">
                                <span class="badge" style="background: var(--accent-blue); color: var(--dark-blue);">
                                    ${voucher.totalVoucherCount}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${empty voucher}">
            <div class="empty-state">
                <i class="fas fa-exclamation-triangle"></i>
                <h3>Không tìm thấy thông tin voucher!</h3>
                <p>Voucher có thể đã bị xóa hoặc không tồn tại trong hệ thống.</p>
            </div>
        </c:if>
    </div>

    <script>
        // Copy voucher code functionality
        function copyVoucherCode(element) {
            const code = element.textContent.trim();
            
            if (navigator.clipboard && window.isSecureContext) {
                navigator.clipboard.writeText(code).then(() => {
                    showCopySuccess(element);
                }).catch(err => {
                    console.error('Clipboard API failed:', err);
                    fallbackCopyTextToClipboard(code, element);
                });
            } else {
                fallbackCopyTextToClipboard(code, element);
            }
        }

        function showCopySuccess(element) {
            const originalText = element.textContent;
            const originalClass = element.className;
            
            element.classList.add('copy-success');
            element.textContent = '✓ Đã sao chép mã voucher!';
            
            setTimeout(() => {
                element.className = originalClass;
                element.textContent = originalText;
            }, 2000);
        }

        function fallbackCopyTextToClipboard(text, element) {
            const textArea = document.createElement('textarea');
            textArea.value = text;
            textArea.style.position = 'fixed';
            textArea.style.opacity = '0';
            textArea.style.left = '-9999px';
            
            document.body.appendChild(textArea);
            textArea.select();
            textArea.setSelectionRange(0, 99999);
            
            try {
                const successful = document.execCommand('copy');
                if (successful) {
                    showCopySuccess(element);
                } else {
                    console.error('Copy command failed');
                }
            } catch (err) {
                console.error('Could not copy text: ', err);
            }
            
            document.body.removeChild(textArea);
        }

        // Animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.info-item, .voucher-showcase');
            elements.forEach((el, index) => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(20px)';
                
                setTimeout(() => {
                    el.style.transition = 'all 0.6s ease';
                    el.style.opacity = '1';
                    el.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>
