<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voucher của tôi</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #add8e6;
            --secondary-blue: #87ceeb;
            --light-blue: #e6f3ff;
            --dark-blue: #4682b4;
            --accent-blue: #b0e0e6;
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
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .page-header {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(173, 216, 230, 0.2);
            backdrop-filter: blur(10px);
            border: 2px solid var(--accent-blue);
            margin-bottom: 30px;
            overflow: hidden;
        }

        .header-content {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
            color: #333;
            padding: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
        }

        .header-content h1 {
            font-size: 2.5rem;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .header-info {
            background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
            padding: 20px 30px;
            color: var(--dark-blue);
            font-weight: 600;
        }

        .vouchers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .voucher-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
            overflow: hidden;
            transition: all 0.3s ease;
            border: 2px solid transparent;
            backdrop-filter: blur(10px);
        }

        .voucher-card:hover {
            transform: translateY(-8px);
            border-color: var(--primary-blue);
            box-shadow: 0 15px 35px rgba(173, 216, 230, 0.3);
        }

        .voucher-card.voucher-active {
            border-left: 6px solid #28a745;
        }

        .voucher-card.voucher-used {
            opacity: 0.8;
            background: linear-gradient(135deg, #f8f9fa 0%, var(--light-blue) 100%);
        }

        .voucher-card.voucher-expired {
            opacity: 0.7;
            background: linear-gradient(135deg, #f8f9fa 0%, #ffebee 100%);
        }

        .card-header {
            padding: 20px;
            background: linear-gradient(135deg, var(--accent-blue) 0%, var(--primary-blue) 100%);
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #333;
        }

        .card-title {
            font-weight: bold;
            font-size: 1.1rem;
            flex: 1;
            margin-right: 10px;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .badge-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .badge-secondary {
            background: linear-gradient(135deg, #6c757d, #495057);
            color: white;
        }

        .badge-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .badge-warning {
            background: linear-gradient(135deg, #ffc107, #fd7e14);
            color: #333;
        }

        .card-body {
            padding: 25px;
        }

        .voucher-code-box {
            background: linear-gradient(135deg, var(--dark-blue) 0%, var(--secondary-blue) 100%);
            color: white;
            border-radius: 15px;
            padding: 15px;
            text-align: center;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(70, 130, 180, 0.3);
        }

        .voucher-code {
            font-family: 'Courier New', monospace;
            font-size: 1.3rem;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .code-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .discount-highlight {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            color: white;
            border-radius: 50px;
            padding: 12px 20px;
            font-weight: bold;
            font-size: 1.2rem;
            text-align: center;
            margin-bottom: 15px;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }

        .description-text {
            background: rgba(255, 255, 255, 0.7);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            color: #666;
            font-size: 0.9rem;
            line-height: 1.4;
            min-height: 50px;
            border: 1px solid var(--accent-blue);
        }

        .conditions-list {
            margin-bottom: 20px;
        }

        .condition-item {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
            font-size: 0.9rem;
            color: #555;
        }

        .condition-item i {
            margin-right: 10px;
            color: var(--secondary-blue);
            width: 16px;
        }

        .detail-btn {
            background: linear-gradient(135deg, var(--dark-blue) 0%, var(--secondary-blue) 100%);
            border: none;
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            text-align: center;
            width: 100%;
            box-shadow: 0 4px 15px rgba(70, 130, 180, 0.3);
        }

        .detail-btn:hover {
            background: linear-gradient(135deg, var(--secondary-blue) 0%, var(--primary-blue) 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(70, 130, 180, 0.4);
            color: white;
        }

        .card-footer {
            padding: 20px;
            background: linear-gradient(135deg, #f8f9fa 0%, var(--light-blue) 100%);
            border-top: 1px solid var(--accent-blue);
        }

        .date-range {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 10px;
        }

        .used-info {
            text-align: center;
            padding-top: 10px;
            border-top: 1px solid var(--accent-blue);
            font-size: 0.8rem;
            color: #666;
        }

        .stats-section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(173, 216, 230, 0.2);
            backdrop-filter: blur(10px);
            border: 2px solid var(--accent-blue);
            overflow: hidden;
        }

        .stats-header {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
            color: #333;
            padding: 25px;
            text-align: center;
        }

        .stats-header h3 {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 0;
        }

        .stat-item {
            padding: 30px 20px;
            text-align: center;
            border-right: 1px solid var(--accent-blue);
            background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
        }

        .stat-item:last-child {
            border-right: none;
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .stat-label {
            font-size: 0.9rem;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .text-success { color: #28a745; }
        .text-secondary { color: #6c757d; }
        .text-danger { color: #dc3545; }
        .text-warning { color: #ffc107; }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: var(--dark-blue);
        }

        .empty-state i {
            font-size: 5rem;
            margin-bottom: 30px;
            color: var(--secondary-blue);
        }

        .empty-state h3 {
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .empty-state p {
            font-size: 1.1rem;
            color: #666;
        }

        @media (max-width: 768px) {
            .vouchers-grid {
                grid-template-columns: 1fr;
            }

            .header-content {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .stat-item {
                border-right: none;
                border-bottom: 1px solid var(--accent-blue);
            }

            .stat-item:nth-child(2n) {
                border-right: 1px solid var(--accent-blue);
            }

            .stat-item:last-child,
            .stat-item:nth-last-child(2) {
                border-bottom: none;
            }
        }
    </style>
</head>
<body>
    <!-- Set current date for comparison -->
    <jsp:useBean id="now" class="java.util.Date" />
    <jsp:include page="/header.jsp"></jsp:include>
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div class="header-content">
                <h1><i class="fas fa-ticket-alt"></i> Voucher của tôi</h1>
            </div>
            <div class="header-info">
                <i class="fas fa-info-circle"></i> 
                Tổng cộng: <strong>${not empty userVouchers ? userVouchers.size() : 0}</strong> voucher
            </div>
        </div>
        
        <c:choose>
            <c:when test="${not empty userVouchers}">
                <!-- Vouchers Grid -->
                <div class="vouchers-grid">
                    <c:forEach var="userVoucher" items="${userVouchers}">
                        <div class="voucher-card 
                            <c:choose>
                                <c:when test='${userVoucher.isUsed}'>voucher-used</c:when>
                                <c:when test='${userVoucher.voucher.endDate.time < now.time}'>voucher-expired</c:when>
                                <c:otherwise>voucher-active</c:otherwise>
                            </c:choose>">
                            
                            <!-- Card Header -->
                            <div class="card-header">
                                <div class="card-title" title="${userVoucher.voucher.name}">
                                    ${userVoucher.voucher.name}
                                </div>
                                <div class="status-badge 
                                    <c:choose>
                                        <c:when test="${userVoucher.isUsed}">badge-secondary</c:when>
                                        <c:when test="${userVoucher.voucher.endDate.time < now.time}">badge-danger</c:when>
                                        <c:when test="${userVoucher.voucher.startDate.time > now.time}">badge-warning</c:when>
                                        <c:otherwise>badge-success</c:otherwise>
                                    </c:choose>">
                                    <c:choose>
                                        <c:when test="${userVoucher.isUsed}">
                                            <i class="fas fa-check"></i> Đã sử dụng
                                        </c:when>
                                        <c:when test="${userVoucher.voucher.endDate.time < now.time}">
                                            <i class="fas fa-times"></i> Hết hạn
                                        </c:when>
                                        <c:when test="${userVoucher.voucher.startDate.time > now.time}">
                                            <i class="fas fa-clock"></i> Chưa bắt đầu
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-check-circle"></i> Có thể sử dụng
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            
                            <!-- Card Body -->
                            <div class="card-body">
                                <!-- Voucher Code -->
                                <div class="voucher-code-box">
                                    <div class="voucher-code">${userVoucher.voucherCode}</div>
                                    <div class="code-label">Mã voucher</div>
                                </div>
                                
                                <!-- Discount Value -->
                                <div class="discount-highlight">
                                    <c:choose>
                                        <c:when test="${userVoucher.voucher.discountType == 'PERCENTAGE'}">
                                            <i class="fas fa-percent"></i> ${userVoucher.voucher.discount}%
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-money-bill"></i>
                                            <fmt:formatNumber value="${userVoucher.voucher.discount}" type="currency" currencySymbol="₫"/>
                                        </c:otherwise>
                                    </c:choose>
                                    <div style="font-size: 0.8rem; margin-top: 5px;">Giá trị giảm</div>
                                </div>
                                
                                <!-- Description -->
                                <c:if test="${not empty userVoucher.voucher.description}">
                                    <div class="description-text">
                                        ${userVoucher.voucher.description}
                                    </div>
                                </c:if>
                                
                                <!-- Conditions -->
                                <div class="conditions-list">
                                    <c:if test="${userVoucher.voucher.minOrderAmount > 0}">
                                        <div class="condition-item">
                                            <i class="fas fa-shopping-cart"></i>
                                            <span>Đơn tối thiểu: 
                                                <strong>
                                                    <fmt:formatNumber value="${userVoucher.voucher.minOrderAmount}" type="currency" currencySymbol="₫"/>
                                                </strong>
                                            </span>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${userVoucher.voucher.maxDiscountAmount > 0}">
                                        <div class="condition-item">
                                            <i class="fas fa-coins"></i>
                                            <span>Giảm tối đa: 
                                                <strong>
                                                    <fmt:formatNumber value="${userVoucher.voucher.maxDiscountAmount}" type="currency" currencySymbol="₫"/>
                                                </strong>
                                            </span>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <!-- Detail Button -->
                                <a href="voucher?action=userDetail&id=${userVoucher.voucher.id}" class="detail-btn">
                                    <i class="fas fa-eye"></i> Xem chi tiết
                                </a>
                            </div>
                            
                            <!-- Card Footer -->
                            <div class="card-footer">
                                <div class="date-range">
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
                                    <div class="used-info">
                                        <i class="fas fa-check-circle"></i>
                                        Đã sử dụng: <fmt:formatDate value="${userVoucher.usedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Statistics -->
                <div class="stats-section">
                    <div class="stats-header">
                        <h3><i class="fas fa-chart-bar"></i> Thống kê voucher</h3>
                    </div>
                    <div class="stats-grid">
                        <div class="stat-item">
                            <div class="stat-icon text-success">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="stat-number text-success">
                                <c:set var="activeCount" value="0"/>
                                <c:forEach var="uv" items="${userVouchers}">
                                    <c:if test="${!uv.isUsed && uv.voucher.endDate.time >= now.time && uv.voucher.startDate.time <= now.time}">
                                        <c:set var="activeCount" value="${activeCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${activeCount}
                            </div>
                            <div class="stat-label">Có thể sử dụng</div>
                        </div>
                        
                        <div class="stat-item">
                            <div class="stat-icon text-secondary">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="stat-number text-secondary">
                                <c:set var="usedCount" value="0"/>
                                <c:forEach var="uv" items="${userVouchers}">
                                    <c:if test="${uv.isUsed}">
                                        <c:set var="usedCount" value="${usedCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${usedCount}
                            </div>
                            <div class="stat-label">Đã sử dụng</div>
                        </div>
                        
                        <div class="stat-item">
                            <div class="stat-icon text-danger">
                                <i class="fas fa-times-circle"></i>
                            </div>
                            <div class="stat-number text-danger">
                                <c:set var="expiredCount" value="0"/>
                                <c:forEach var="uv" items="${userVouchers}">
                                    <c:if test="${!uv.isUsed && uv.voucher.endDate.time < now.time}">
                                        <c:set var="expiredCount" value="${expiredCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${expiredCount}
                            </div>
                            <div class="stat-label">Hết hạn</div>
                        </div>
                        
                        <div class="stat-item">
                            <div class="stat-icon text-warning">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="stat-number text-warning">
                                <c:set var="pendingCount" value="0"/>
                                <c:forEach var="uv" items="${userVouchers}">
                                    <c:if test="${!uv.isUsed && uv.voucher.startDate.time > now.time}">
                                        <c:set var="pendingCount" value="${pendingCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${pendingCount}
                            </div>
                            <div class="stat-label">Chưa bắt đầu</div>
                        </div>
                    </div>
                </div>
                
            </c:when>
            <c:otherwise>
                <div class="page-header">
                    <div class="empty-state">
                        <i class="fas fa-ticket-alt"></i>
                        <h3>Chưa có voucher nào</h3>
                                                <p>Bạn chưa có voucher nào. Hãy tham gia các chương trình khuyến mãi để nhận voucher!</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <script>
        // Add smooth scroll effect
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.voucher-card');
            
            // Animate cards on scroll
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, {
                threshold: 0.1
            });
            
            cards.forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                observer.observe(card);
            });
            
            // Copy voucher code functionality
            document.querySelectorAll('.voucher-code').forEach(codeElement => {
                codeElement.style.cursor = 'pointer';
                codeElement.title = 'Click để sao chép mã';
                
                codeElement.addEventListener('click', function() {
                    const code = this.textContent;
                    navigator.clipboard.writeText(code).then(() => {
                        // Show temporary success message
                        const originalText = this.textContent;
                        this.textContent = 'Đã sao chép!';
                        this.style.background = 'linear-gradient(135deg, #28a745, #20c997)';
                        
                        setTimeout(() => {
                            this.textContent = originalText;
                            this.style.background = '';
                        }, 2000);
                    }).catch(() => {
                        // Fallback for older browsers
                        const textArea = document.createElement('textarea');
                        textArea.value = code;
                        document.body.appendChild(textArea);
                        textArea.select();
                        document.execCommand('copy');
                        document.body.removeChild(textArea);
                        
                        const originalText = this.textContent;
                        this.textContent = 'Đã sao chép!';
                        this.style.background = 'linear-gradient(135deg, #28a745, #20c997)';
                        
                        setTimeout(() => {
                            this.textContent = originalText;
                            this.style.background = '';
                        }, 2000);
                    });
                });
            });
        });
    </script>
</body>
</html>

