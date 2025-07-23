<%-- 
    Document   : Voucher
    Created on : Jul 13, 2025, 1:51:45 PM
    Author     : NTN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        }

        .alert-success {
            color: #155724;
            background: linear-gradient(135deg, #d4edda 0%, var(--light-blue) 100%);
            border-color: var(--primary-blue);
        }

        .alert-danger {
            color: #721c24;
            background: linear-gradient(135deg, #f8d7da 0%, #ffebee 100%);
            border-color: #dc3545;
        }

        .action-buttons {
            background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
            border: 2px solid var(--accent-blue);
        }

        .action-buttons h3 {
            color: var(--dark-blue);
            margin-bottom: 20px;
            font-size: 1.5rem;
            font-weight: bold;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: #333;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--secondary-blue), var(--dark-blue));
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(173, 216, 230, 0.4);
            color: white;
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #20c997, #17a2b8);
            transform: translateY(-2px);
        }

        .btn-warning {
            background: linear-gradient(135deg, #ffc107, #fd7e14);
            color: #333;
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #fd7e14, #dc3545);
            transform: translateY(-2px);
            color: white;
        }

        .btn-info {
            background: linear-gradient(135deg, var(--accent-blue), var(--primary-blue));
            color: #333;
            padding: 8px 15px;
            font-size: 0.9rem;
        }

        .btn-info:hover {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            transform: translateY(-1px);
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            padding: 8px 15px;
            font-size: 0.9rem;
            margin-left: 5px;
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #c82333, #a71e2a);
            transform: translateY(-1px);
        }

        .table-section {
            background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
            border: 2px solid var(--accent-blue);
        }

        .table-section h2 {
            color: var(--dark-blue);
            margin-bottom: 20px;
            font-size: 1.8rem;
            position: relative;
            padding-bottom: 10px;
            font-weight: bold;
        }

        .table-section h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            border-radius: 2px;
        }

        .table-container {
            overflow-x: auto;
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.9rem;
        }

        th {
            background: linear-gradient(135deg, var(--dark-blue), var(--secondary-blue));
            color: white;
            padding: 15px 10px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        th:first-child {
            border-top-left-radius: 10px;
        }

        th:last-child {
            border-top-right-radius: 10px;
        }

        td {
            padding: 12px 10px;
            border-bottom: 1px solid var(--accent-blue);
            vertical-align: middle;
        }

        tr:hover {
            background: var(--light-blue);
            transform: scale(1.01);
            transition: all 0.2s ease;
        }

        .badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .bg-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .bg-secondary {
            background: linear-gradient(135deg, #6c757d, #495057);
            color: white;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: var(--dark-blue);
            font-style: italic;
        }

        .actions {
            display: flex;
            gap: 5px;
            align-items: center;
        }

        .voucher-code {
            font-family: 'Courier New', monospace;
            background: linear-gradient(135deg, var(--accent-blue), #f8f9fa);
            padding: 4px 8px;
            border-radius: 8px;
            font-weight: bold;
            color: var(--dark-blue);
        }

        .fa-ticket-alt, .fa-plus, .fa-eye, .fa-trash, .fa-check-circle, .fa-exclamation-triangle {
            margin-right: 8px;
            color: var(--secondary-blue);
        }

        @media (max-width: 768px) {
            .btn-group {
                flex-direction: column;
            }

            .actions {
                flex-direction: column;
                gap: 5px;
            }

            .btn {
                margin: 2px 0;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-ticket-alt"></i> Quản lý Voucher</h1>
        </div>

        <div class="content">
            <!-- Hiển thị thông báo -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${successMessage}
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                </div>
            </c:if>
            
            <!-- Các nút thêm voucher -->
            <div class="action-buttons">
                <h3><i class="fas fa-plus"></i> Thêm Voucher Mới</h3>
                <div class="btn-group">
                    <a href="voucher?action=addByUser" class="btn btn-primary">
                        <i class="fas fa-user-plus"></i> Thêm Voucher cho User
                    </a>
                    <a href="voucher?action=addPublic" class="btn btn-success">
                        <i class="fas fa-globe"></i> Thêm Voucher Công khai
                    </a>
                    <a href="voucher?action=addPrivate" class="btn btn-warning">
                        <i class="fas fa-lock"></i> Thêm Voucher Riêng tư
                    </a>
                </div>
            </div>
            
            <!-- Bảng danh sách voucher -->
            <div class="table-section">
                <h2><i class="fas fa-list"></i> Danh sách Voucher</h2>
                <div class="table-container">
                    <table>
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
                            <c:choose>
                                <c:when test="${empty vouchers}">
                                    <tr class="no-data">
                                        <td colspan="9"><i class="fas fa-inbox"></i> Không có voucher nào</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="voucher" items="${vouchers}">
                                        <tr>
                                            <td>${voucher.id}</td>
                                            <td><strong>${voucher.name}</strong></td>
                                            <td><span class="voucher-code">${voucher.voucherCode}</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                                        <span class="badge bg-success">
                                                            <i class="fas fa-percent"></i> Phần trăm
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge" style="background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue)); color: #333;">
                                                            <i class="fas fa-money-bill"></i> Số tiền
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <strong>
                                                    <c:choose>
                                                        <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                                            ${voucher.discount}%
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${voucher.discount} VNĐ
                                                        </c:otherwise>
                                                    </c:choose>
                                                </strong>
                                            </td>
                                            <td>${voucher.startDate}</td>
                                            <td>${voucher.endDate}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${voucher.status}">
                                                        <span class="badge bg-success">
                                                            <i class="fas fa-check-circle"></i> Hoạt động
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">
                                                            <i class="fas fa-times-circle"></i> Không hoạt động
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="actions">
                                                    <a href="voucher?action=detail&id=${voucher.id}" class="btn btn-info">
                                                        <i class="fas fa-eye"></i> Chi tiết
                                                    </a>
                                                    <a href="voucher?action=delete&id=${voucher.id}" 
                                                       class="btn btn-danger"
                                                       onclick="return confirm('Bạn có chắc muốn xóa voucher này?')">
                                                        <i class="fas fa-trash"></i> Xóa
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(function() {
                    alert.remove();
                }, 500);
            });
        }, 5000);
    </script>
</body>
</html>
