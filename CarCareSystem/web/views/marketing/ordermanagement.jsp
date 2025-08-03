

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" var="today" pattern="yyyy-MM-dd" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .container {
                max-width: 95%;
                margin: 0 auto;
                background: white;
                padding: 25px;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }
            h1 {
                color: #343a40;
                margin-bottom: 25px;
                padding-bottom: 10px;
                border-bottom: 1px solid #eee;
            }
            .order-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                font-size: 0.9em;
            }
            .order-table th, .order-table td {
                border: 1px solid #dee2e6;
                padding: 12px 15px;
                text-align: left;
            }
            .order-table th {
                background-color: #343a40;
                color: white;
                position: sticky;
                top: 0;
            }
            .order-table tr:nth-child(even) {
                background-color: #f8f9fa;
            }
            .order-table tr:hover {
                background-color: #e9ecef;
            }
            .filter-buttons {
                margin-bottom: 20px;
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }
            .search-box {
                margin-bottom: 25px;
                display: flex;
                max-width: 400px;
            }
            .search-box input {
                border-top-right-radius: 0;
                border-bottom-right-radius: 0;
            }
            .search-box button {
                border-top-left-radius: 0;
                border-bottom-left-radius: 0;
            }
            .status-form {
                display: inline;
                margin-right: 5px;
            }
            .btn-sm {
                padding: 0.25rem 0.5rem;
                font-size: 0.875rem;
            }
            .alert {
                padding: 10px 15px;
                margin-bottom: 20px;
                border-radius: 4px;
            }
            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            .action-buttons {
                display: flex;
                gap: 5px;
                flex-wrap: wrap;
            }
            .table-responsive {
                overflow-x: auto;
            }
            .badge {
                font-size: 0.85em;
                padding: 5px 8px;
                font-weight: 600;
            }
            .badge-warning {
                background-color: #ffc107;
                color: #212529;
            }
            .badge-danger {
                background-color: #dc3545;
            }
            .badge-success {
                background-color: #28a745;
            }
            .badge-info {
                background-color: #17a2b8;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>

        <div class="container">
            <h1>Order Management</h1>

            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="filter-buttons">
                <a href="${pageContext.request.contextPath}/ordermanagement" class="btn btn-dark">All Orders</a>
                <a href="${pageContext.request.contextPath}/ordermanagement?action=unconfirmed" class="btn btn-danger">Chưa Xác Nhận</a>
                <a href="${pageContext.request.contextPath}/ordermanagement?action=miss" class="btn btn-warning">Lỡ Hẹn</a>
                <a href="${pageContext.request.contextPath}/ordermanagement?action=done" class="btn btn-warning">Hoàn Thành Sửa Chữa</a>
                <a href="${pageContext.request.contextPath}/ordermanagement?action=paid" class="btn btn-success">Đã Thanh Toán</a>
                <a href="${pageContext.request.contextPath}/ordermanagement?action=complete" class="btn btn-success">Đơn Hoàn Thành</a>
            </div>

            <div class="search-box">
                <form action="${pageContext.request.contextPath}/ordermanagement" method="GET" class="d-flex">
                    <input type="text" name="search" class="form-control" placeholder="Search by name, email, phone or ID">
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>
            </div>

            <div class="table-responsive">
                <table class="order-table">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên</th>
                            <th>Liên Hệ</th>
                            <th>Loại Xe</th>
                            <th>Ngày Hẹn</th>
                            <th>Giá</th>
                            <th>Thanh Toán</th>
                            <th>Trạng Thái</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orders}" var="order" varStatus="loop">
                            <tr>
                                <td>${loop.index +1}</td>
                                <td>${order.name}</td>
                                <td>
                                    <div>${order.email}</div>
                                    <div class="text-muted">${order.phone}</div>
                                </td>
                                <td>${order.carType}</td>
                                <td>
                                    <fmt:formatDate value="${order.appointmentDate}" pattern="dd/MM/yyyy" />
                                </td>
                                <td>
                                    <fmt:formatNumber value="${order.price}" type="currency" currencyCode="VND" groupingUsed="false" maxFractionDigits="0"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.paymentStatus == 'paid'}">
                                            <span class="badge badge-success">Đã thanh toán</span>
                                        </c:when>
                                        <c:when test="${order.paymentStatus == 'unpaid'}">
                                            <span class="badge badge-danger">Chưa thanh toán</span>
                                        </c:when>
                                        <c:otherwise>                                           
                                            <span class="badge badge-info">${order.paymentStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.orderStatus == 'received'}">
                                            <span class="badge badge-success">Đã Nhận Xe</span>
                                        </c:when>
                                        <c:when test="${order.orderStatus == 'pending'}">
                                            <span class="badge badge-warning">Chưa xác nhận</span>
                                        </c:when>
                                        <c:when test="${order.orderStatus == 'missed'}">
                                            <span class="badge badge-warning">Lỡ hẹn</span>
                                        </c:when>
                                        <c:when test="${order.orderStatus == 'done'}">
                                            <span class="badge badge-success">Sửa Xong</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-info">${order.orderStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <c:if test="${order.paymentStatus eq 'unpaid' and order.orderStatus eq 'done'}">
                                            <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" 
                                                    data-bs-target="#paymentModal${order.id}">
                                                Thanh toán
                                            </button>
                                            <div class="modal fade" id="paymentModal${order.id}" tabindex="-1" aria-hidden="true">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Xác nhận thanh toán đơn hàng #${order.id}</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <form action="${pageContext.request.contextPath}/ordermanagement" method="post">
                                                            <input type="hidden" name="action" value="confirmPayment">
                                                            <input type="hidden" name="orderId" value="${order.id}">
                                                            <input type="hidden" id="finalPrice${order.id}" name="finalPrice" value="${order.price}" 
                                                                   data-original-price="${order.price}" defaultValue="${order.price}">

                                                            <div class="modal-body">
                                                                <!-- Phần chọn voucher -->
                                                                <div class="mb-3">
                                                                    <label class="form-label">Voucher (nếu có)</label>
                                                                    <select class="form-select" name="voucherCode" id="voucherSelect${order.id}" onchange="applyVoucher(${order.id})">
                                                                        <option value="">-- Không sử dụng voucher --</option>
                                                                        <c:forEach items="${availableVouchers}" var="voucher">
                                                                            <option value="${voucher.voucherCode}" 
                                                                                    data-discount="${voucher.discount}"
                                                                                    data-type="${voucher.discountType}"
                                                                                    data-max="${voucher.maxDiscountAmount}"
                                                                                    data-min="${voucher.minOrderAmount}">
                                                                                ${voucher.name} - 
                                                                                <c:choose>
                                                                                    <c:when test="${voucher.discountType == 'PERCENTAGE'}">
                                                                                        Giảm ${voucher.discount}% (Tối đa <fmt:formatNumber value="${voucher.maxDiscountAmount}" currencyCode="VND" type="currency"/>)
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        Giảm <fmt:formatNumber value="${voucher.discount}" type="currency" currencyCode="VND"/>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>

                                                                <!-- Hiển thị giá trị đơn hàng -->
                                                                <div class="mb-3">
                                                                    <label class="form-label">Tổng tiền ban đầu</label>
                                                                    <input type="text" class="form-control" value="<fmt:formatNumber value="${order.price}" type="currency" currencyCode="VND"/>" readonly>
                                                                </div>

                                                                <!-- Hiển thị số tiền giảm giá -->
                                                                <div class="mb-3">
                                                                    <label class="form-label">Giảm giá</label>
                                                                    <input type="text" class="form-control" id="discountAmount${order.id}" value="0 VND" readonly>
                                                                </div>

                                                                <!-- Hiển thị tổng tiền sau giảm giá -->
                                                                <div class="mb-3">
                                                                    <label class="form-label">Tổng tiền thanh toán</label>
                                                                    <input type="text" class="form-control" id="totalAfterDiscount${order.id}" 
                                                                           value="<fmt:formatNumber value="${order.price}" type="currency" currencyCode="VND"/>" readonly>
                                                                </div>

                                                                <!-- Phương thức thanh toán -->
                                                                <div class="mb-3">
                                                                    <label class="form-label">Phương thức thanh toán</label>
                                                                    <select class="form-select" name="paymentMethod" id="paymentMethod${order.id}" required>
                                                                        <option value="">-- Chọn phương thức --</option>
                                                                        <option value="cash">Tiền mặt</option>
                                                                        <option value="transfer">Chuyển khoản</option>
                                                                    </select>
                                                                </div>

                                                                <!-- Phần QR code và thông tin chuyển khoản -->
                                                                <div id="qrCodeContainer${order.id}" style="display: none; text-align: center;">
                                                                    <div class="mb-3">
                                                                        <p>Vui lòng quét mã QR để thanh toán</p>
                                                                        <img id="qrCodeImage${order.id}" src="" alt="Mã QR thanh toán" 
                                                                             style="max-width: 300px; margin: 0 auto;">
                                                                        <div class="mt-2">
                                                                            <p class="text-muted">Hoặc chuyển khoản đến:</p>
                                                                            <p><strong>Ngân hàng Vietcombank</strong></p>
                                                                            <p>Số tài khoản: <strong>1013367685</strong></p>
                                                                            <p>Tên tài khoản: <strong>TRAN THANH HAI</strong></p>
                                                                            <p>Số tiền: <strong><span id="qrAmount${order.id}"><fmt:formatNumber value="${order.price}" type="currency" currencyCode="VND" groupingUsed="false" maxFractionDigits="0"/></span></strong></p>
                                                                            <p>Nội dung: <strong>DH${order.id}</strong></p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                                <button type="submit" class="btn btn-primary">Xác nhận</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>

                                            <script>
                                                function updateQRCode(orderId, amount) {
                                                    const accountName = 'TRAN THANH HAI';
                                                    const encodedAccountName = encodeURIComponent(accountName);
                                                    const qrUrl = 'https://img.vietqr.io/image/VCB-1013367685-compact2.png?amount=' + amount +
                                                            '&addInfo=DH' + orderId +
                                                            '&accountName=' + encodedAccountName;

                                                    document.getElementById('qrCodeImage' + orderId).src = qrUrl;
                                                    document.getElementById('qrAmount' + orderId).textContent = formatCurrency(amount) + ' VND';
                                                }
                                                function safeParseNumber(value, defaultValue = 0) {
                                                    const num = parseFloat(value);
                                                    return isNaN(num) ? defaultValue : num;
                                                }

                                                function formatCurrency(amount) {
                                                    const num = safeParseNumber(amount);
                                                    return new Intl.NumberFormat('vi-VN').format(num);
                                                }

                                                function applyVoucher(orderId) {
                                                    const voucherSelect = document.getElementById('voucherSelect' + orderId);
                                                    const selectedOption = voucherSelect.options[voucherSelect.selectedIndex];
                                                    const finalPriceInput = document.getElementById('finalPrice' + orderId);

                                                    // Lấy giá gốc từ thuộc tính data-original-price
                                                    const originalPrice = parseFloat(finalPriceInput.getAttribute('data-original-price')) || parseFloat(finalPriceInput.defaultValue);

                                                    // Reset về giá gốc ban đầu
                                                    let discountAmount = 0;
                                                    let finalPrice = originalPrice;

                                                    // Nếu có chọn voucher hợp lệ
                                                    if (selectedOption.value && selectedOption.value !== "") {
                                                        const discount = parseFloat(selectedOption.getAttribute('data-discount')) || 0;
                                                        const discountType = selectedOption.getAttribute('data-type');
                                                        const maxDiscount = parseFloat(selectedOption.getAttribute('data-max')) || Infinity;
                                                        const minOrder = parseFloat(selectedOption.getAttribute('data-min')) || 0;

                                                        // Kiểm tra điều kiện tối thiểu
                                                        if (originalPrice < minOrder) {
                                                            alert('Voucher yêu cầu đơn hàng tối thiểu ' + formatCurrency(minOrder) + ' VND');
                                                            voucherSelect.value = '';
                                                            applyVoucher(orderId); // Gọi lại hàm để reset
                                                            return;
                                                        }

                                                        // Tính toán giảm giá
                                                        if (discountType === 'PERCENTAGE') {
                                                            discountAmount = Math.min(originalPrice * discount / 100, maxDiscount);
                                                        } else {
                                                            discountAmount = Math.min(discount, maxDiscount);
                                                        }

                                                        finalPrice = Math.max(originalPrice - discountAmount, 0);
                                                    }

                                                    // Cập nhật giá trị
                                                    finalPriceInput.value = finalPrice;
                                                    document.getElementById('discountAmount' + orderId).value = formatCurrency(discountAmount) + ' VND';
                                                    document.getElementById('totalAfterDiscount' + orderId).value = formatCurrency(finalPrice) + ' VND';

                                                    // Cập nhật QR code nếu cần
                                                    const qrContainer = document.getElementById('qrCodeContainer' + orderId);
                                                    if (qrContainer && qrContainer.style.display === 'block') {
                                                        updateQRCode(orderId, finalPrice);
                                                    }
                                                }

                                                document.addEventListener('DOMContentLoaded', function () {
                                                    const paymentMethod = document.getElementById('paymentMethod' + ${order.id});
                                                    if (paymentMethod) {
                                                        paymentMethod.addEventListener('change', function () {
                                                            const qrContainer = document.getElementById('qrCodeContainer' + ${order.id});
                                                            if (this.value === 'transfer') {
                                                                qrContainer.style.display = 'block';
                                                                const finalPrice = document.getElementById('finalPrice' + ${order.id}).value;
                                                                updateQRCode(${order.id}, finalPrice);
                                                            } else {
                                                                qrContainer.style.display = 'none';
                                                            }
                                                        });
                                                    }
                                                });
                                            </script>
                                        </c:if>

                                        <c:if test="${order.orderStatus == 'pending'}">
                                            <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" 
                                                    data-bs-target="#receiveCarModal${order.id}">
                                                Nhận xe
                                            </button>
                                            <div class="modal fade" id="receiveCarModal${order.id}" tabindex="-1" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Xác nhận nhận xe cho đơn #${order.id}</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <form action="${pageContext.request.contextPath}/ordermanagement" method="post">
                                                            <input type="hidden" name="action" value="confirmReceived">
                                                            <input type="hidden" name="orderId" value="${order.id}">
                                                            <div class="modal-body">
                                                                <div class="mb-3">
                                                                    <label class="form-label">Ngày nhận xe</label>
                                                                    <input type="date" class="form-control" name="receivedDate" required min="${today}">
                                                                </div>

                                                                <c:if test="${sessionScope.user.userRole == 'manager'}">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">Kỹ thuật viên phụ trách</label>
                                                                        <select class="form-select" name="repairerId" required>
                                                                            <option value="">-- Chọn kỹ thuật viên --</option>
                                                                            <c:forEach items="${repairers}" var="repairer">
                                                                                <option value="${repairer.id}">${repairer.username}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </c:if>

                                                                <c:if test="${sessionScope.user.userRole == 'repairer'}">
                                                                    <input type="hidden" name="repairerId" value="${sessionScope.user.id}">
                                                                    <div class="alert alert-info">
                                                                        Kỹ thuật viên phụ trách: ${sessionScope.user.username}
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                                <button type="submit" class="btn btn-primary">Xác nhận</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>

                                        <c:if test="${order.orderStatus == 'missed'}">                                            
                                            <button type="button" class="btn btn-warning btn-sm" data-bs-toggle="modal" 
                                                    data-bs-target="#rescheduleModal${order.id}">
                                                Đặt lại lịch hẹn
                                            </button>
                                            <div class="modal fade" id="rescheduleModal${order.id}" tabindex="-1" aria-hidden="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Đổi lịch hẹn cho đơn #${order.id}</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <form action="${pageContext.request.contextPath}/ordermanagement" method="post">
                                                            <input type="hidden" name="action" value="reschedule">
                                                            <input type="hidden" name="orderId" value="${order.id}">
                                                            <div class="modal-body">
                                                                <div class="mb-3">
                                                                    <label class="form-label">Ngày hẹn mới</label>
                                                                    <input type="date" class="form-control" name="newAppointmentDate" required
                                                                           min="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>">
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>        
                                        <a href="${pageContext.request.contextPath}/orderDetail?orderId=${order.id}" 
                                           class="btn btn-info btn-sm">Details</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
