<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>
<fmt:setTimeZone value="Asia/Ho_Chi_Minh"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <!-- CSS giữ nguyên như cũ -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voucher của tôi</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* CSS code giữ nguyên như trong code gốc */
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
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            text-align: center;
        }

        .header h1 {
            color: white;
            font-size: 2rem;
            margin-bottom: 8px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .header p {
            color: rgba(255,255,255,0.9);
            font-size: 1rem;
        }

        .stats-info {
            background: rgba(255,255,255,0.2);
            padding: 12px 20px;
            border-radius: 20px;
            margin-top: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.3);
            font-size: 0.95rem;
        }

        /* Filter & Search Section */
        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 25px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .filter-row {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 12px 45px 12px 15px;
            border: 2px solid var(--light-blue);
            border-radius: 25px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 3px rgba(173, 216, 230, 0.2);
        }

        .search-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--dark-blue);
        }

        .filter-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 8px 16px;
            border: 2px solid var(--light-blue);
            background: white;
            border-radius: 20px;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .filter-btn.active,
        .filter-btn:hover {
            background: var(--primary-blue);
            border-color: var(--primary-blue);
            color: white;
        }

        /* Compact Stats */
        .compact-stats {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .stat-compact {
            background: white;
            padding: 15px 20px;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.08);
            text-align: center;
            flex: 1;
            min-width: 120px;
            transition: transform 0.3s ease;
        }

        .stat-compact:hover {
            transform: translateY(-3px);
        }

        .stat-compact .number {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stat-compact .label {
            font-size: 0.8rem;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Compact Voucher Grid */
        .vouchers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 15px;
        }

        .voucher-compact {
            background: white;
            border-radius: 12px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.08);
            overflow: hidden;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
            height: 140px;
        }

        .voucher-compact:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 25px rgba(0,0,0,0.12);
        }

        .voucher-compact.active {
            border-left-color: var(--success-green);
        }

        .voucher-compact.used {
            border-left-color: #6c757d;
            opacity: 0.8;
        }

        .voucher-compact.expired {
            border-left-color: var(--danger-red);
            opacity: 0.7;
        }

        .voucher-compact.pending {
            border-left-color: var(--warning-orange);
            opacity: 0.85;
        }

        .voucher-content {
            padding: 15px;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .voucher-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
        }

        .voucher-title {
            font-weight: 600;
            font-size: 0.95rem;
            color: var(--dark-blue);
            line-height: 1.3;
            flex: 1;
            margin-right: 10px;
        }

        .status-mini {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.7rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            white-space: nowrap;
        }

        .status-mini.success {
            background: var(--success-green);
            color: white;
        }

        .status-mini.secondary {
            background: #6c757d;
            color: white;
        }

        .status-mini.danger {
            background: var(--danger-red);
            color: white;
        }

        .status-mini.warning {
            background: var(--warning-orange);
            color: white;
        }

        .voucher-main {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 12px;
            flex: 1;
        }

        .voucher-code-compact {
            background: linear-gradient(45deg, var(--dark-blue), var(--secondary-blue));
            color: white;
            padding: 8px 12px;
            border-radius: 8px;
            font-family: 'Courier New', monospace;
            font-weight: bold;
            font-size: 0.9rem;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
        }

        .voucher-code-compact:hover {
            transform: scale(1.05);
        }

        .discount-compact {
            background: linear-gradient(45deg, var(--danger-red), #ff6b6b);
            color: white;
            padding: 8px 12px;
            border-radius: 8px;
            font-weight: bold;
            font-size: 0.9rem;
            text-align: center;
            min-width: 70px;
        }

        .voucher-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.8rem;
            color: #666;
        }

        .condition-info {
            display: flex;
            gap: 10px;
        }

        .condition-item {
            display: flex;
            align-items: center;
            gap: 3px;
        }

        .condition-item i {
            font-size: 0.7rem;
            color: var(--info-cyan);
        }

        .detail-link {
            color: var(--dark-blue);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 3px;
            transition: color 0.3s ease;
        }

        .detail-link:hover {
            color: var(--secondary-blue);
        }

        .detail-link i {
            font-size: 0.8rem;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--dark-blue);
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: var(--secondary-blue);
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: var(--dark-blue);
        }

        .empty-state p {
            font-size: 1rem;
            color: #666;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .vouchers-grid {
                grid-template-columns: 1fr;
            }

            .filter-row {
                flex-direction: column;
                align-items: stretch;
            }

            .search-box {
                min-width: auto;
            }

            .compact-stats {
                grid-template-columns: repeat(2, 1fr);
            }

            .voucher-main {
                flex-direction: column;
                gap: 8px;
                align-items: stretch;
            }

            .voucher-compact {
                height: auto;
                min-height: 140px;
            }

            .voucher-info {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }
        }

        /* Loading Animation */
        .loading {
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.4s ease;
        }

        .loading.show {
            opacity: 1;
            transform: translateY(0);
        }

        /* Copy Success Animation */
        .copy-success {
            background: linear-gradient(45deg, var(--success-green), #32cd32) !important;
        }

        .copy-success::after {
            content: "✓ Đã sao chép";
            position: absolute;
            top: -30px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0,0,0,0.8);
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.7rem;
            white-space: nowrap;
        }

        /* Hidden voucher */
        .voucher-hidden {
            display: none !important;
        }
    </style>
</head>
<body>
    <jsp:useBean id="now" class="java.util.Date" />
    <jsp:include page="/header.jsp"></jsp:include>
    
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1><i class="fas fa-ticket-alt"></i> Voucher của tôi</h1>
            <p>Quản lý và sử dụng voucher cá nhân</p>
            <div class="stats-info">
                <i class="fas fa-info-circle"></i> 
                Tổng cộng: <strong>${not empty userVouchers ? userVouchers.size() : 0}</strong> voucher
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty userVouchers}">
                <!-- Filter & Search -->
                <div class="filter-section">
                    <div class="filter-row">
                        <div class="search-box">
                            <input type="text" class="search-input" placeholder="Tìm kiếm voucher theo tên hoặc mã..." id="searchInput">
                            <i class="fas fa-search search-icon"></i>
                        </div>
                        <div class="filter-buttons">
                            <button class="filter-btn active" data-filter="all">Tất cả</button>
                            <button class="filter-btn" data-filter="available">Có thể dùng</button>
                            <button class="filter-btn" data-filter="used">Đã dùng</button>
                            <button class="filter-btn" data-filter="expired">Hết hạn</button>
                            <button class="filter-btn" data-filter="pending">Chưa bắt đầu</button>
                        </div>
                    </div>
                </div>

                <!-- Compact Stats -->
                <div class="compact-stats">
                    <div class="stat-compact">
                        <div class="number text-success">
                            <c:set var="activeCount" value="0"/>
                            <c:forEach var="uv" items="${userVouchers}">
                                <c:if test="${!uv.isUsed && uv.voucher.endDate.time >= now.time && uv.voucher.startDate.time <= now.time}">
                                    <c:set var="activeCount" value="${activeCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${activeCount}
                        </div>
                        <div class="label">Có thể dùng</div>
                    </div>
                    
                    <div class="stat-compact">
                        <div class="number text-secondary">
                            <c:set var="usedCount" value="0"/>
                            <c:forEach var="uv" items="${userVouchers}">
                                <c:if test="${uv.isUsed}">
                                    <c:set var="usedCount" value="${usedCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${usedCount}
                        </div>
                        <div class="label">Đã sử dụng</div>
                    </div>
                    
                    <div class="stat-compact">
                        <div class="number text-danger">
                            <c:set var="expiredCount" value="0"/>
                            <c:forEach var="uv" items="${userVouchers}">
                                <c:if test="${!uv.isUsed && uv.voucher.endDate.time < now.time}">
                                    <c:set var="expiredCount" value="${expiredCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${expiredCount}
                        </div>
                        <div class="label">Hết hạn</div>
                    </div>
                    
                    <div class="stat-compact">
                        <div class="number text-warning">
                            <c:set var="pendingCount" value="0"/>
                            <c:forEach var="uv" items="${userVouchers}">
                                <c:if test="${!uv.isUsed && uv.voucher.startDate.time > now.time}">
                                    <c:set var="pendingCount" value="${pendingCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${pendingCount}
                        </div>
                        <div class="label">Chưa bắt đầu</div>
                    </div>
                </div>

                <!-- Compact Vouchers Grid -->
                <div class="vouchers-grid" id="vouchersGrid">
                    <c:forEach var="userVoucher" items="${userVouchers}" varStatus="status">
                        <!-- Xác định trạng thái voucher -->
                        <c:set var="voucherStatus" value=""/>
                        <c:choose>
                            <c:when test='${userVoucher.isUsed}'>
                                <c:set var="voucherStatus" value="used"/>
                            </c:when>
                            <c:when test='${userVoucher.voucher.endDate.time < now.time}'>
                                <c:set var="voucherStatus" value="expired"/>
                            </c:when>
                            <c:when test='${userVoucher.voucher.startDate.time > now.time}'>
                                <c:set var="voucherStatus" value="pending"/>
                            </c:when>
                            <c:otherwise>
                                <c:set var="voucherStatus" value="available"/>
                            </c:otherwise>
                        </c:choose>

                        <div class="voucher-compact loading ${voucherStatus}"
                            data-status="${voucherStatus}"
                            data-name="${fn:toLowerCase(userVoucher.voucher.name)}"
                            data-code="${fn:toLowerCase(userVoucher.voucherCode)}">
                            
                            <div class="voucher-content">
                                <!-- Header -->
                                <div class="voucher-header">
                                    <div class="voucher-title">${userVoucher.voucher.name}</div>
                                    <div class="status-mini 
                                        <c:choose>
                                            <c:when test="${voucherStatus == 'used'}">secondary</c:when>
                                            <c:when test="${voucherStatus == 'expired'}">danger</c:when>
                                            <c:when test="${voucherStatus == 'pending'}">warning</c:when>
                                            <c:otherwise>success</c:otherwise>
                                        </c:choose>">
                                        <c:choose>
                                            <c:when test="${voucherStatus == 'used'}">Đã dùng</c:when>
                                            <c:when test="${voucherStatus == 'expired'}">Hết hạn</c:when>
                                            <c:when test="${voucherStatus == 'pending'}">Chưa đến ngày</c:when>
                                            <c:otherwise>Sẵn sàng</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- Main Content -->
                                <div class="voucher-main">
                                    <div class="voucher-code-compact" title="Click để sao chép">${userVoucher.voucherCode}</div>
                                    <div class="discount-compact">
                                        <c:choose>
                                            <c:when test="${userVoucher.voucher.discountType == 'PERCENTAGE'}">
                                                <fmt:formatNumber value="${userVoucher.voucher.discount}" type="number" />%
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${userVoucher.voucher.discount / 1000}" maxFractionDigits="0"/>K
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- Info Footer -->
                                <div class="voucher-info">
                                    <div class="condition-info">
                                        <c:if test="${userVoucher.voucher.minOrderAmount > 0}">
                                            <div class="condition-item">
                                                <i class="fas fa-shopping-cart"></i>
                                                <span><fmt:formatNumber value="${userVoucher.voucher.minOrderAmount / 1000}" maxFractionDigits="0"/>K+</span>
                                            </div>
                                        </c:if>
                                        <c:if test="${userVoucher.voucher.maxDiscountAmount > 0}">
                                            <div class="condition-item">
                                                <i class="fas fa-coins"></i>
                                                <span>Max <fmt:formatNumber value="${userVoucher.voucher.maxDiscountAmount / 1000}" maxFractionDigits="0"/>K</span>
                                            </div>
                                        </c:if>
                                    </div>
                                    <a href="voucher?action=userDetail&id=${userVoucher.voucher.id}" class="detail-link">
                                        Chi tiết <i class="fas fa-chevron-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-ticket-alt"></i>
                    <h3>Chưa có voucher nào</h3>
                    <p>Bạn chưa có voucher nào. Hãy tham gia các chương trình khuyến mãi để nhận voucher!</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('DOM loaded, initializing voucher page...');
            
            // Animation on load
            setTimeout(() => {
                document.querySelectorAll('.loading').forEach((el, index) => {
                    setTimeout(() => {
                        el.classList.add('show');
                    }, index * 50);
                });
            }, 100);

            // Get elements
            const searchInput = document.getElementById('searchInput');
            const vouchersGrid = document.getElementById('vouchersGrid');
            const filterButtons = document.querySelectorAll('.filter-btn');
            
            let currentFilter = 'all';

            console.log('Found elements:', {
                searchInput: !!searchInput,
                vouchersGrid: !!vouchersGrid,
                filterButtons: filterButtons.length
            });

            // Search functionality
            if (searchInput) {
                searchInput.addEventListener('input', function() {
                    console.log('Search input changed:', this.value);
                    filterVouchers();
                });
            }

            // Filter buttons
            filterButtons.forEach((btn, index) => {
                console.log(`Filter button ${index}:`, btn.dataset.filter);
                btn.addEventListener('click', function(e) {
                    e.preventDefault();
                    console.log('Filter button clicked:', this.dataset.filter);
                    
                    // Remove active class from all buttons
                    filterButtons.forEach(b => b.classList.remove('active'));
                    
                    // Add active class to clicked button
                    this.classList.add('active');
                    
                    // Update current filter
                    currentFilter = this.dataset.filter;
                    console.log('Current filter set to:', currentFilter);
                    
                    // Apply filter
                    filterVouchers();
                });
            });

            function filterVouchers() {
                console.log('Filtering vouchers with:', {
                    searchTerm: searchInput ? searchInput.value.toLowerCase() : '',
                    currentFilter: currentFilter
                });

                const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';
                const vouchers = vouchersGrid ? vouchersGrid.querySelectorAll('.voucher-compact') : [];

                console.log('Found vouchers to filter:', vouchers.length);

                let visibleCount = 0;
                vouchers.forEach((voucher, index) => {
                    const name = voucher.dataset.name || '';
                    const code = voucher.dataset.code || '';
                    const status = voucher.dataset.status || '';
                    
                    console.log(`Voucher ${index}:`, { name, code, status });
                    
                    const matchesSearch = !searchTerm || name.includes(searchTerm) || code.includes(searchTerm);
                    const matchesFilter = currentFilter === 'all' || status === currentFilter;
                    
                    console.log(`Voucher ${index} matches:`, { matchesSearch, matchesFilter });
                    
                    if (matchesSearch && matchesFilter) {
                        voucher.style.display = 'block';
                        voucher.style.opacity = '1';
                        voucher.style.transform = 'translateY(0)';
                        voucher.classList.remove('voucher-hidden');
                        visibleCount++;
                    } else {
                        voucher.style.display = 'none';
                        voucher.classList.add('voucher-hidden');
                    }
                });

                console.log('Visible vouchers after filter:', visibleCount);
            }

            // Copy voucher code functionality
            document.querySelectorAll('.voucher-code-compact').forEach(codeEl => {
                codeEl.addEventListener('click', function() {
                    const code = this.textContent.trim();
                    console.log('Copying voucher code:', code);
                    
                    if (navigator.clipboard && window.isSecureContext) {
                        navigator.clipboard.writeText(code).then(() => {
                            showCopySuccess(this);
                        }).catch(err => {
                            console.error('Copy failed:', err);
                            fallbackCopyTextToClipboard(code, this);
                        });
                    } else {
                        fallbackCopyTextToClipboard(code, this);
                    }
                });
            });

            function showCopySuccess(element) {
                element.classList.add('copy-success');
                element.style.position = 'relative';
                
                setTimeout(() => {
                    element.classList.remove('copy-success');
                }, 2000);
            }

            function fallbackCopyTextToClipboard(text, element) {
                const textArea = document.createElement('textarea');
                textArea.value = text;
                textArea.style.position = 'fixed';
                textArea.style.opacity = '0';
                
                document.body.appendChild(textArea);
                textArea.select();
                
                try {
                    const successful = document.execCommand('copy');
                    if (successful) {
                        showCopySuccess(element);
                    }
                } catch (err) {
                    console.error('Could not copy text: ', err);
                }
                
                document.body.removeChild(textArea);
            }

            // Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                if (e.key === '/' && !e.ctrlKey && !e.metaKey && e.target.tagName !== 'INPUT') {
                    e.preventDefault();
                    if (searchInput) {
                        searchInput.focus();
                    }
                }
            });

            // Initial filter to show all vouchers
            console.log('Running initial filter...');
            filterVouchers();
        });
    </script>
</body>
</html>
