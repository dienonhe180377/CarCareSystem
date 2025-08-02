<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Campaign - ${campaign.name}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            text-align: center;
        }

        .header h1 {
            color: #2c3e50;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .header h1 i {
            color: #e74c3c;
            margin-right: 15px;
        }

        .content {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        /* BREADCRUMB */
        .breadcrumb {
            background: #f8f9fa;
            padding: 15px 30px;
            border-bottom: 1px solid #e9ecef;
            font-size: 14px;
        }

        .breadcrumb a {
            color: #007bff;
            text-decoration: none;
            transition: color 0.3s;
        }

        .breadcrumb a:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        /* ALERT STYLES */
        .alert {
            padding: 15px 30px;
            margin: 0;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            border-bottom: 1px solid rgba(0,0,0,0.1);
        }

        .alert-success {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
        }

        .alert-error {
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            color: #721c24;
        }

        .alert-info {
            background: linear-gradient(135deg, #d1ecf1, #bee5eb);
            color: #0c5460;
        }

        /* CAMPAIGN IMAGE */
        .campaign-image {
            padding: 30px;
            text-align: center;
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
        }

        .campaign-image img {
            max-width: 100%;
            max-height: 400px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            object-fit: cover;
        }

        /* SECTION */
        .section {
            padding: 30px;
            border-bottom: 1px solid #e9ecef;
        }

        .section:last-child {
            border-bottom: none;
        }

        .section h2 {
            color: #2c3e50;
            font-size: 1.8rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section h2 i {
            color: #e74c3c;
        }

        /* CAMPAIGN INFO */
        .campaign-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .info-item {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #007bff;
        }

        .info-item h4 {
            color: #2c3e50;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-item p {
            color: #6c757d;
            line-height: 1.6;
        }

        .status-badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .status-active {
            background: #d4edda;
            color: #155724;
        }

        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }

        .status-expired {
            background: #e2e3e5;
            color: #383d41;
        }

        /* VOUCHER GRID */
        .voucher-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }

        .voucher-card {
            background: white;
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .voucher-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            border-color: #007bff;
        }

        .voucher-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #007bff, #28a745);
        }

        /* VOUCHER STATUS */
        .voucher-status {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-available {
            background: #d4edda;
            color: #155724;
        }

        .status-claimed {
            background: #cce7ff;
            color: #004085;
        }

        .status-expired {
            background: #e2e3e5;
            color: #383d41;
        }

        .status-out {
            background: #f8d7da;
            color: #721c24;
        }

        /* VOUCHER HEADER */
        .voucher-header {
            margin-bottom: 20px;
            padding-right: 100px;
        }

        .voucher-name {
            color: #2c3e50;
            font-size: 1.3rem;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .voucher-code {
            background: #f8f9fa;
            color: #007bff;
            padding: 8px 12px;
            border-radius: 8px;
            font-family: 'Courier New', monospace;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-block;
            border: 2px dashed #007bff;
        }

        .voucher-code:hover {
            background: #007bff;
            color: white;
            transform: scale(1.05);
        }

        /* DISCOUNT VALUE */
        .discount-value {
            text-align: center;
            margin: 20px 0;
            padding: 20px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border-radius: 10px;
            font-size: 2rem;
            font-weight: bold;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }

        /* VOUCHER DETAILS */
        .voucher-details {
            margin: 20px 0;
        }

        .voucher-details p {
            margin: 8px 0;
            color: #6c757d;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .voucher-details i {
            color: #007bff;
            width: 16px;
            text-align: center;
        }

        /* VOUCHER ACTIONS */
        .voucher-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-claim, .btn-detail {
            flex: 1;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-claim {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .btn-claim:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
        }

        .btn-claim:disabled {
            background: #6c757d;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .btn-detail {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }

        .btn-detail:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.4);
            text-decoration: none;
            color: white;
        }

        /* NO DATA */
        .no-data {
            text-align: center;
            padding: 60px 30px;
            color: #6c757d;
        }

        .no-data i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: #dee2e6;
        }

        .no-data h2 {
            margin-bottom: 15px;
            color: #495057;
        }

        .no-data p {
            font-size: 1.1rem;
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn:hover {
            background: #0056b3;
            transform: translateY(-2px);
            text-decoration: none;
            color: white;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff, #0056b3);
        }

        /* NOTIFICATION */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            z-index: 1000;
            transform: translateX(400px);
            transition: transform 0.3s ease;
        }

        .notification.show {
            transform: translateX(0);
        }

        .notification.success {
            background: linear-gradient(135deg, #28a745, #20c997);
        }

        .notification.error {
            background: linear-gradient(135deg, #dc3545, #c82333);
        }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .voucher-grid {
                grid-template-columns: 1fr;
            }

            .campaign-info {
                grid-template-columns: 1fr;
            }

            .voucher-actions {
                flex-direction: column;
            }

            .section {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/header.jsp"></jsp:include>

    <div class="container">
        <div class="header">
            <h1><i class="fas fa-bullhorn"></i> Chi tiết Campaign</h1>
        </div>

        <div class="content">
            <!-- BREADCRUMB -->
            <div class="breadcrumb">
                <a href="campaignlist"><i class="fas fa-list"></i> Danh sách Campaign</a> > Chi tiết Campaign
            </div>

            <!-- HIỂN THỊ THÔNG BÁO -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${successMessage}
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty campaign}">
                    <div class="no-data">
                        <i class="fas fa-exclamation-triangle"></i>
                        <h2>Không tìm thấy Campaign</h2>
                        <p>Campaign bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                        <a href="campaignlist" class="btn btn-primary"><i class="fas fa-arrow-left"></i> Quay lại danh sách</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- CAMPAIGN IMAGE -->
                    <div class="campaign-image">
                        <img src="${not empty campaign.img ? pageContext.request.contextPath.concat('/').concat(campaign.img) : pageContext.request.contextPath.concat('/image/campaign.png')}" 
                             alt="${campaign.name}" 
                             onerror="this.src='${pageContext.request.contextPath}/image/campaign.png'">
                    </div>

                    <!-- CAMPAIGN INFO -->
                    <div class="section">
                        <h2><i class="fas fa-info-circle"></i> Thông tin Campaign</h2>
                        <div class="campaign-info">
                            <div class="info-item">
                                <h4><i class="fas fa-tag"></i> Tên Campaign</h4>
                                <p>${campaign.name}</p>
                            </div>
                            
                            <div class="info-item">
                                <h4><i class="fas fa-align-left"></i> Mô tả</h4>
                                <p>${not empty campaign.description ? campaign.description : 'Không có mô tả'}</p>
                            </div>
                            
                            <div class="info-item">
                                <h4><i class="fas fa-calendar-alt"></i> Thời gian</h4>
                                <p>
                                    <strong>Bắt đầu:</strong> <fmt:formatDate value="${campaign.startDate}" pattern="dd/MM/yyyy HH:mm"/><br>
                                    <strong>Kết thúc:</strong> <fmt:formatDate value="${campaign.endDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </p>
                            </div>
                            
                            <div class="info-item">
                                <h4><i class="fas fa-flag"></i> Trạng thái</h4>
                                <p>
                                    <c:set var="now" value="<%= new java.util.Date() %>" />
                                    <c:choose>
                                        <c:when test="${campaign.startDate.time > now.time}">
                                            <span class="status-badge status-inactive">Chưa bắt đầu</span>
                                        </c:when>
                                        <c:when test="${campaign.endDate.time < now.time}">
                                            <span class="status-badge status-expired">Đã kết thúc</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-active">Đang diễn ra</span>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- VOUCHERS SECTION -->
                    <div class="section">
                        <h2><i class="fas fa-gift"></i> Voucher trong Campaign (${fn:length(campaignVouchers)})</h2>

                        <c:choose>
                            <c:when test="${not empty campaignVouchers}">
                                <div class="voucher-grid">
                                    <c:forEach var="voucher" items="${campaignVouchers}">
                                        <div class="voucher-card">
                                            <!-- VOUCHER STATUS -->
                                            <c:set var="voucherNow" value="<%= new java.util.Date() %>" />
                                            <c:set var="isExpired" value="${voucher.endDate.time < voucherNow.time}" />
                                            <c:set var="isOutOfStock" value="${voucher.totalVoucherCount <= 0}" />
                                            <c:set var="isClaimed" value="${claimedStatus[voucher.id]}" />

                                            <c:choose>
                                                <c:when test="${isExpired}">
                                                    <span class="voucher-status status-expired">Hết hạn</span>
                                                </c:when>
                                                <c:when test="${isOutOfStock}">
                                                    <span class="voucher-status status-out">Hết voucher</span>
                                                </c:when>
                                                <c:when test="${not empty sessionScope.user and isClaimed}">
                                                    <span class="voucher-status status-claimed">Đã lấy</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="voucher-status status-available">Có thể lấy</span>
                                                </c:otherwise>
                                            </c:choose>

                                            <!-- VOUCHER HEADER -->
                                            <div class="voucher-header">
                                                <h4 class="voucher-name">${voucher.name}</h4>
                                                <span class="voucher-code" onclick="copyCode('${voucher.voucherCode}')" title="Click để copy mã voucher">
                                                    ${voucher.voucherCode}
                                                </span>
                                            </div>

                                            <!-- DISCOUNT VALUE -->
                                            <div class="discount-value">
                                                <c:choose>
                                                    <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                                        <fmt:formatNumber value="${voucher.discount}" type="number" maxFractionDigits="0"/>%
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatNumber value="${voucher.discount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <!-- VOUCHER DETAILS -->
                                            <div class="voucher-details">
                                                <p>
                                                    <i class="fas fa-concierge-bell"></i> 
                                                    <strong>Dịch vụ:</strong> ${not empty serviceNames[voucher.id] ? serviceNames[voucher.id] : 'Tất cả dịch vụ'}
                                                </p>
                                                <p>
                                                    <i class="fas fa-calendar"></i> 
                                                    <strong>Hạn sử dụng:</strong> <fmt:formatDate value="${voucher.startDate}" pattern="dd/MM/yyyy"/> - <fmt:formatDate value="${voucher.endDate}" pattern="dd/MM/yyyy"/>
                                                </p>
                                                <c:if test="${voucher.minOrderAmount > 0}">
                                                    <p>
                                                        <i class="fas fa-shopping-cart"></i> 
                                                        <strong>Đơn tối thiểu:</strong> <fmt:formatNumber value="${voucher.minOrderAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                    </p>
                                                </c:if>
                                                <p>
                                                    <i class="fas fa-warehouse"></i> 
                                                    <strong>Còn lại:</strong> <span style="color: #e74c3c; font-weight: bold;">${voucher.totalVoucherCount}</span> voucher
                                                </p>
                                            </div>

                                            <!-- VOUCHER ACTIONS -->
                                            <div class="voucher-actions">
                                                <c:choose>
                                                    <%-- Voucher hết hạn --%>
                                                    <c:when test="${isExpired}">
                                                        <button class="btn-claim" disabled>
                                                            <i class="fas fa-times"></i> Voucher hết hạn
                                                        </button>
                                                    </c:when>
                                                    <%-- Hết voucher --%>
                                                    <c:when test="${isOutOfStock}">
                                                        <button class="btn-claim" disabled>
                                                            <i class="fas fa-ban"></i> Hết voucher
                                                        </button>
                                                    </c:when>
                                                    <%-- Đã đăng nhập và đã lấy voucher --%>
                                                    <c:when test="${not empty sessionScope.user and isClaimed}">
                                                        <button class="btn-claim" disabled>
                                                            <i class="fas fa-check"></i> Đã lấy voucher
                                                        </button>
                                                    </c:when>
                                                    <%-- Có thể lấy voucher (bao gồm cả chưa đăng nhập) --%>
                                                    <c:otherwise>
                                                        <form method="post" style="display: inline; width: 100%;">
                                                            <input type="hidden" name="action" value="claimVoucher">
                                                            <input type="hidden" name="voucherId" value="${voucher.id}">
                                                            <input type="hidden" name="campaignId" value="${campaign.id}">
                                                            <button type="submit" class="btn-claim">
                                                                <i class="fas fa-gift"></i> 
                                                                ${empty sessionScope.user ? 'Đăng nhập để lấy' : 'Lấy voucher'}
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="no-data">
                                    <i class="fas fa-ticket-alt"></i>
                                    <h2>Chưa có voucher</h2>
                                    <p>Campaign này hiện tại chưa có voucher nào.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- NOTIFICATION -->
    <div id="notification" class="notification"></div>

    <script>
        // Copy voucher code to clipboard
        function copyCode(code) {
            if (navigator.clipboard) {
                navigator.clipboard.writeText(code).then(() => {
                    showNotification('Đã copy mã voucher: ' + code, 'success');
                }).catch(() => {
                    fallbackCopyTextToClipboard(code);
                });
            } else {
                fallbackCopyTextToClipboard(code);
            }
        }

        // Fallback copy method for older browsers
        function fallbackCopyTextToClipboard(text) {
            const textArea = document.createElement("textarea");
            textArea.value = text;
            textArea.style.top = "0";
            textArea.style.left = "0";
            textArea.style.position = "fixed";
            document.body.appendChild(textArea);
            textArea.focus();
            textArea.select();

            try {
                document.execCommand('copy');
                showNotification('Đã copy mã voucher: ' + text, 'success');
            } catch (err) {
                showNotification('Không thể copy mã voucher', 'error');
            }

            document.body.removeChild(textArea);
        }

        // Show notification
        function showNotification(message, type) {
            const notification = document.getElementById('notification');
            notification.textContent = message;
            notification.className = 'notification ' + type + ' show';

            setTimeout(() => {
                notification.classList.remove('show');
            }, 4000);
        }

        // Show server messages
        <c:if test="${not empty successMessage}">
            setTimeout(() => {
                showNotification('${successMessage}', 'success');
            }, 500);
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            setTimeout(() => {
                showNotification('${errorMessage}', 'error');
            }, 500);
        </c:if>

        // Remove alert after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.style.opacity = '0';
                    alert.style.transform = 'translateY(-20px)';
                    setTimeout(() => {
                        alert.remove();
                    }, 300);
                }, 5000);
            });
        });
    </script>
</body>
</html>
