<%-- 
    Document   : Voucher
    Created on : Jul 13, 2025, 1:51:45 PM
    Author     : NTN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Voucher</title>
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
                padding: 20px;
            }

            .container {
                max-width: 1400px;
                margin: 0 auto;
                background: rgba(255, 255, 255, 0.95);
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(173, 216, 230, 0.2);
                overflow: hidden;
                backdrop-filter: blur(10px);
                border: 2px solid var(--accent-blue);
            }

            .header {
                background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
                color: #333;
                padding: 30px;
                text-align: center;
                box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
            }

            .header h1 {
                font-size: 2.5rem;
                margin-bottom: 10px;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
                font-weight: bold;
            }

            .header p {
                font-size: 1.1rem;
                opacity: 0.8;
                margin-top: 10px;
            }

            .content {
                padding: 30px;
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid transparent;
                border-radius: 15px;
                font-weight: 600;
                box-shadow: 0 4px 15px rgba(173, 216, 230, 0.2);
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .alert-success {
                color: #155724;
                background: linear-gradient(135deg, #d4edda 0%, var(--light-blue) 100%);
                border-color: var(--success-green);
            }

            .alert-danger {
                color: #721c24;
                background: linear-gradient(135deg, #f8d7da 0%, #ffebee 100%);
                border-color: var(--danger-red);
            }

            .action-buttons {
                background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
                border-radius: 15px;
                padding: 30px;
                margin-bottom: 30px;
                box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
                border: 2px solid var(--accent-blue);
            }

            .action-buttons h3 {
                color: var(--dark-blue);
                margin-bottom: 25px;
                font-size: 1.5rem;
                font-weight: bold;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .btn-group {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 20px;
                justify-content: center;
            }

            .btn {
                padding: 18px 30px;
                border: none;
                border-radius: 15px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 12px;
                text-align: center;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
                position: relative;
                overflow: hidden;
                min-height: 65px;
            }

            .btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
                transition: left 0.6s;
            }

            .btn:hover::before {
                left: 100%;
            }

            .btn i {
                font-size: 1.3rem;
            }

            .btn span {
                font-weight: 700;
                font-size: 0.95rem;
            }

            /* ✅ NÚT VOUCHER CÔNG KHAI - XANH DƯƠNG */
            .btn-public {
                background: linear-gradient(135deg, #007bff, #0056b3);
                color: white;
                border: 3px solid #004085;
            }

            .btn-public:hover {
                background: linear-gradient(135deg, #0056b3, #004085);
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(0, 123, 255, 0.4);
            }

            /* ✅ NÚT VOUCHER RIÊNG TƯ - XANH LÁ */
            .btn-private {
                background: linear-gradient(135deg, var(--success-green), #1e7e34);
                color: white;
                border: 3px solid #155724;
            }

            .btn-private:hover {
                background: linear-gradient(135deg, #1e7e34, #155724);
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(40, 167, 69, 0.4);
            }

            /* ✅ NÚT VOUCHER CÁ NHÂN - CAM VÀNG */
            .btn-personal {
                background: linear-gradient(135deg, #ffc107, var(--warning-orange));
                color: #333;
                border: 3px solid #e0a800;
                font-weight: 700;
            }

            .btn-personal:hover {
                background: linear-gradient(135deg, var(--warning-orange), #e0a800);
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(255, 193, 7, 0.4);
                color: white;
            }

            /* ✅ NÚT VOUCHER CLAIM - TÍM HỒNG */
            .btn-claim {
                background: linear-gradient(135deg, var(--purple), var(--pink));
                color: white;
                border: 3px solid #5a2d91;
            }

            .btn-claim:hover {
                background: linear-gradient(135deg, var(--pink), var(--indigo));
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(111, 66, 193, 0.4);
            }

            /* ✅ CÁC NÚT NHỎ TRONG BẢNG */
            .btn-small {
                padding: 8px 15px;
                font-size: 0.85rem;
                border-radius: 20px;
                min-height: auto;
            }

            .btn-info-small {
                background: linear-gradient(135deg, var(--info-cyan), var(--teal));
                color: white;
            }

            .btn-info-small:hover {
                background: linear-gradient(135deg, var(--teal), var(--success-green));
                transform: translateY(-1px);
                box-shadow: 0 4px 15px rgba(23, 162, 184, 0.4);
            }

            .btn-danger-small {
                background: linear-gradient(135deg, var(--danger-red), #c82333);
                color: white;
                margin-left: 5px;
            }

            .btn-danger-small:hover {
                background: linear-gradient(135deg, #c82333, #a71e2a);
                transform: translateY(-1px);
                box-shadow: 0 4px 15px rgba(220, 53, 69, 0.4);
            }

            .table-section {
                background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
                border: 2px solid var(--accent-blue);
            }

            .table-section h2 {
                color: var(--dark-blue);
                margin-bottom: 25px;
                font-size: 1.8rem;
                position: relative;
                padding-bottom: 15px;
                font-weight: bold;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .table-section h2::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 60px;
                height: 4px;
                background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
                border-radius: 2px;
            }

            .table-container {
                overflow-x: auto;
                margin-top: 20px;
                border-radius: 15px;
                box-shadow: 0 4px 15px rgba(173, 216, 230, 0.15);
                background: white;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 0.9rem;
                background: white;
            }

            th {
                background: linear-gradient(135deg, var(--dark-blue), var(--secondary-blue));
                color: white;
                padding: 18px 15px;
                text-align: center;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 0.85rem;
                white-space: nowrap;
                position: relative;
            }

            th:first-child {
                border-top-left-radius: 15px;
                text-align: left;
            }

            th:last-child {
                border-top-right-radius: 15px;
            }

            th i {
                margin-right: 6px;
                font-size: 0.9rem;
            }

            td {
                padding: 18px 15px;
                border-bottom: 1px solid #e9ecef;
                vertical-align: middle;
                text-align: center;
                transition: all 0.2s ease;
            }

            td:first-child {
                text-align: left;
                font-weight: 600;
                color: var(--dark-blue);
                max-width: 200px;
                word-wrap: break-word;
            }

            tr:nth-child(even) {
                background: #f8f9fa;
            }

            tr:hover {
                background: var(--light-blue);
                transform: scale(1.002);
                transition: all 0.2s ease;
                box-shadow: 0 2px 8px rgba(173, 216, 230, 0.3);
            }

            tr:last-child td:first-child {
                border-bottom-left-radius: 15px;
            }

            tr:last-child td:last-child {
                border-bottom-right-radius: 15px;
            }

            /* ✅ STYLING CHO CỘT LOẠI GIẢM GIÁ */
            .discount-type {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 8px 15px;
                border-radius: 25px;
                font-size: 0.8rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.3px;
                background: linear-gradient(135deg, #e3f2fd, #bbdefb);
                color: #1565c0;
                border: 2px solid #90caf9;
                box-shadow: 0 2px 8px rgba(21, 101, 192, 0.2);
            }

            .discount-type i {
                font-size: 0.9rem;
            }

            /* ✅ STYLING CHO GIÁ TRỊ GIẢM GIÁ */
            .discount-value {
                font-weight: bold;
                font-size: 1.1rem;
                color: var(--success-green);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 6px;
                padding: 5px 10px;
                border-radius: 15px;
                background: linear-gradient(135deg, #f0fff4, #e6ffed);
                border: 1px solid #c3e6cb;
            }

            .discount-value::before {
                content: '🎯';
                font-size: 1rem;
            }

            /* ✅ STYLING CHO MÃ VOUCHER */
            .voucher-code {
                font-family: 'Courier New', monospace;
                background: linear-gradient(135deg, var(--accent-blue), #f0f8ff);
                padding: 8px 15px;
                border-radius: 20px;
                font-weight: bold;
                color: var(--dark-blue);
                border: 2px solid var(--primary-blue);
                display: inline-block;
                font-size: 0.85rem;
                letter-spacing: 1px;
                box-shadow: 0 2px 8px rgba(70, 130, 180, 0.2);
                transition: all 0.2s ease;
            }

            .voucher-code:hover {
                transform: scale(1.05);
                box-shadow: 0 4px 12px rgba(70, 130, 180, 0.3);
            }

            /* ✅ STYLING CHO NGÀY THÁNG */
            .date-cell {
                font-size: 0.85rem;
                color: #6c757d;
                font-weight: 500;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 6px;
                padding: 5px;
            }

            .date-cell i {
                color: var(--primary-blue);
                font-size: 0.9rem;
            }

            /* ✅ STYLING CHO TRẠNG THÁI */
            .badge {
                padding: 10px 18px;
                border-radius: 25px;
                font-size: 0.75rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: all 0.2s ease;
            }

            .bg-success {
                background: linear-gradient(135deg, var(--success-green), #20c997);
                color: white;
                box-shadow: 0 3px 10px rgba(40, 167, 69, 0.3);
            }

            .bg-success:hover {
                transform: scale(1.05);
                box-shadow: 0 4px 15px rgba(40, 167, 69, 0.4);
            }

            .bg-secondary {
                background: linear-gradient(135deg, #6c757d, #495057);
                color: white;
                box-shadow: 0 3px 10px rgba(108, 117, 125, 0.3);
            }

            .bg-secondary:hover {
                transform: scale(1.05);
                box-shadow: 0 4px 15px rgba(108, 117, 125, 0.4);
            }

            .bg-warning {
                background: linear-gradient(135deg, #ffc107, var(--warning-orange));
                color: #333;
                box-shadow: 0 3px 10px rgba(255, 193, 7, 0.3);
            }

            .bg-warning:hover {
                transform: scale(1.05);
                box-shadow: 0 4px 15px rgba(255, 193, 7, 0.4);
            }

            .bg-danger {
                background: linear-gradient(135deg, var(--danger-red), #c82333);
                color: white;
                box-shadow: 0 3px 10px rgba(220, 53, 69, 0.3);
            }

            .bg-danger:hover {
                transform: scale(1.05);
                box-shadow: 0 4px 15px rgba(220, 53, 69, 0.4);
            }

            /* ✅ STYLING CHO ACTIONS */
            .actions {
                display: flex;
                gap: 10px;
                align-items: center;
                justify-content: center;
                flex-wrap: wrap;
            }

            .no-data {
                text-align: center;
                padding: 80px 20px;
                color: var(--dark-blue);
                font-style: italic;
                font-size: 1.2rem;
                background: linear-gradient(135deg, #f8f9fa, var(--light-blue));
                border-radius: 15px;
                border: 2px dashed var(--accent-blue);
            }

            .no-data i {
                font-size: 4rem;
                margin-bottom: 20px;
                color: var(--accent-blue);
                display: block;
                opacity: 0.7;
            }

            .no-data p {
                margin: 10px 0;
                line-height: 1.6;
            }

            .no-data p:first-of-type {
                font-weight: 600;
                font-size: 1.3rem;
            }

            /* ✅ RESPONSIVE */
            @media (max-width: 992px) {
                .btn-group {
                    grid-template-columns: repeat(2, 1fr);
                    gap: 15px;
                }
            }

            @media (max-width: 768px) {
                .container {
                    margin: 10px;
                    border-radius: 15px;
                }

                .content {
                    padding: 20px;
                }

                .header h1 {
                    font-size: 2rem;
                }

                .btn-group {
                    grid-template-columns: 1fr;
                    gap: 15px;
                }

                .btn {
                    padding: 15px 20px;
                    font-size: 0.9rem;
                }

                .actions {
                    flex-direction: column;
                    gap: 8px;
                }

                .btn-small {
                    width: 100%;
                    justify-content: center;
                }

                th, td {
                    padding: 12px 8px;
                    font-size: 0.8rem;
                }

                .voucher-code {
                    font-size: 0.75rem;
                    padding: 6px 10px;
                }

                .discount-type {
                    font-size: 0.7rem;
                    padding: 6px 10px;
                }

                .discount-value {
                    font-size: 0.9rem;
                }

                .badge {
                    font-size: 0.7rem;
                    padding: 6px 12px;
                }

                .table-container {
                    border-radius: 10px;
                }

                th:first-child, th:last-child {
                    border-radius: 0;
                }

                .no-data {
                    padding: 40px 15px;
                    font-size: 1rem;
                }

                .no-data i {
                    font-size: 2.5rem;
                    margin-bottom: 15px;
                }
            }

            /* ✅ HIỆU ỨNG LOADING CHO BUTTONS */
            .btn:active {
                transform: scale(0.98);
            }

            /* ✅ ANIMATION CHO TABLE ROWS */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            tbody tr {
                animation: fadeInUp 0.3s ease forwards;
            }

            tbody tr:nth-child(1) { animation-delay: 0.1s; }
            tbody tr:nth-child(2) { animation-delay: 0.2s; }
            tbody tr:nth-child(3) { animation-delay: 0.3s; }
            tbody tr:nth-child(4) { animation-delay: 0.4s; }
            tbody tr:nth-child(5) { animation-delay: 0.5s; }
        </style>
    </head>
    <body>
        <jsp:include page="/header_emp.jsp"></jsp:include>
        <fmt:setLocale value="vi_VN"/>
        <div class="container">
            <div class="header">
                <h1><i class="fas fa-ticket-alt"></i> Quản lý Voucher</h1>
                <p>Tạo và quản lý các voucher giảm giá cho hệ thống</p>
            </div>

            <div class="content">
                <!-- ✅ HIỂN THỊ THÔNG BÁO -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        ${successMessage}
                    </div>
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i>
                        ${errorMessage}
                    </div>
                </c:if>

                <!-- ✅ CÁC NÚT THAO TÁC - 4 NÚT KHÁC MÀU KHÁC STYLE -->
                <div class="action-buttons">
                    <h3><i class="fas fa-plus-circle"></i> Tạo Voucher Mới</h3>
                    <div class="btn-group">
                        <!-- NÚT 1: VOUCHER CÔNG KHAI - XANH DƯƠNG -->
                        <a href="voucher?action=addPublic" class="btn btn-public">
                            <i class="fas fa-bullhorn"></i>
                            <span>Voucher Công khai</span>
                        </a>
                        
                        <!-- NÚT 2: VOUCHER RIÊNG TƯ - XANH LÁ -->
                        <a href="voucher?action=addPrivate" class="btn btn-private">
                            <i class="fas fa-user-shield"></i>
                            <span>Voucher Riêng tư</span>
                        </a>
                        
                        <!-- NÚT 3: VOUCHER CÁ NHÂN - CAM VÀNG -->
                        <a href="voucher?action=addByUser" class="btn btn-personal">
                            <i class="fas fa-user"></i>
                            <span>Voucher Cá nhân</span>
                        </a>
                        
                        <!-- NÚT 4: VOUCHER CLAIM - TÍM HỒNG -->
                        <a href="voucher?action=addClaim" class="btn btn-claim">
                            <i class="fas fa-user-plus"></i>
                            <span>Voucher để người dùng Claim</span>
                        </a>
                    </div>
                </div>

                <!-- ✅ BẢNG DANH SÁCH VOUCHER -->
                <div class="table-section">
                    <h2><i class="fas fa-list"></i> Danh sách Voucher</h2>
                    
                    <div class="table-container">
                        <c:choose>
                            <c:when test="${not empty vouchers}">
                                <table>
                                    <thead>
                                        <tr>
                                            <th><i class="fas fa-tag"></i> Tên Voucher</th>
                                            <th><i class="fas fa-code"></i> Mã Voucher</th>
                                            <th><i class="fas fa-percentage"></i> Loại Giảm Giá</th>
                                            <th><i class="fas fa-gift"></i> Giá Trị</th>
                                            <th><i class="fas fa-calendar-alt"></i> Ngày Bắt Đầu</th>
                                            <th><i class="fas fa-calendar-times"></i> Ngày Kết Thúc</th>
                                            <th><i class="fas fa-info-circle"></i> Trạng Thái</th>
                                            <th><i class="fas fa-cogs"></i> Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="voucher" items="${vouchers}">
                                            <tr>
                                                <!-- TÊN VOUCHER -->
                                                <td>
                                                    <strong>${voucher.name}</strong>
                                                </td>

                                                <!-- MÃ VOUCHER -->
                                                <td>
                                                    <span class="voucher-code">${voucher.voucherCode}</span>
                                                </td>

                                                <!-- LOẠI GIẢM GIÁ -->
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                                            <span class="discount-type">
                                                                <i class="fas fa-percentage"></i>
                                                                Phần trăm
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="discount-type">
                                                                <i class="fas fa-dollar-sign"></i>
                                                                Cố định
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <!-- GIÁ TRỊ GIẢM -->
                                                <td>
                                                    <span class="discount-value">
                                                        <c:choose>
                                                            <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                                                <fmt:formatNumber value="${voucher.discount}" type="number" maxFractionDigits="1"/>%
                                                            </c:when>
                                                            <c:otherwise>
                                                                <fmt:formatNumber value="${voucher.discount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </td>

                                                <!-- NGÀY BẮT ĐẦU -->
                                                <td>
                                                    <div class="date-cell">
                                                        <i class="fas fa-play-circle"></i>
                                                        <fmt:formatDate value="${voucher.startDate}" pattern="dd/MM/yyyy"/>
                                                    </div>
                                                </td>

                                                <!-- NGÀY KẾT THÚC -->
                                                <td>
                                                    <div class="date-cell">
                                                        <i class="fas fa-stop-circle"></i>
                                                        <fmt:formatDate value="${voucher.endDate}" pattern="dd/MM/yyyy"/>
                                                    </div>
                                                </td>

                                                <!-- TRẠNG THÁI -->
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${voucher.status == 'ACTIVE'}">
                                                            <span class="badge bg-success">
                                                                <i class="fas fa-check-circle"></i>
 Hoạt động
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${voucher.status == 'INACTIVE'}">
                                                            <span class="badge bg-secondary">
                                                                <i class="fas fa-pause-circle"></i>
                                                                Tạm dừng
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${voucher.status == 'EXPIRED'}">
                                                            <span class="badge bg-danger">
                                                                <i class="fas fa-times-circle"></i>
                                                                Hết hạn
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-warning">
                                                                <i class="fas fa-clock"></i>
                                                                Chờ kích hoạt
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <!-- THAO TÁC -->
                                                <td>
                                                    <div class="actions">
                                                        <a href="voucher?action=detail&id=${voucher.id}" 
                                                           class="btn btn-info-small btn-small" title="Xem chi tiết">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                        <a href="voucher?action=delete&id=${voucher.id}" 
                                                           class="btn btn-danger-small btn-small" 
                                                           onclick="return confirm('Bạn có chắc chắn muốn xóa voucher này?')"
                                                           title="Xóa voucher">
                                                            <i class="fas fa-trash"></i>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="no-data">
                                    <i class="fas fa-inbox"></i>
                                    <p>Chưa có voucher nào được tạo</p>
                                    <p>Hãy tạo voucher đầu tiên của bạn!</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

