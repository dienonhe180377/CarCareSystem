<%-- 
    Document   : AddVoucherByUser
    Created on : Jul 31, 2025, 11:30:00 PM
    Author     : NTN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setTimeZone value="Asia/Ho_Chi_Minh"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm Voucher theo User</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-blue: #add8e6;
                --secondary-blue: #87ceeb;
                --light-blue: #e6f3ff;
                --dark-blue: #4682b4;
                --accent-blue: #b0e0e6;
                --success-green: #28a745;
                --error-red: #dc3545;
                --warning-orange: #fd7e14;
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
                max-width: 1000px;
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

            .form-section {
                background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
                border: 2px solid var(--accent-blue);
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-row {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
            }

            .form-row .form-group {
                flex: 1;
                min-width: 250px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: var(--dark-blue);
                font-size: 0.95rem;
            }

            .required {
                color: var(--error-red);
            }

            input[type="text"],
            input[type="number"],
            input[type="date"],
            input[type="datetime-local"],
            textarea,
            select {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid var(--accent-blue);
                border-radius: 10px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: #fafafa;
            }

            input:focus,
            textarea:focus,
            select:focus {
                outline: none;
                border-color: var(--primary-blue);
                background: white;
                box-shadow: 0 0 0 3px rgba(173, 216, 230, 0.25);
                transform: translateY(-1px);
            }

            textarea {
                resize: vertical;
                min-height: 100px;
            }

            .checkbox-group {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-top: 10px;
            }

            input[type="checkbox"] {
                width: 20px;
                height: 20px;
                accent-color: var(--primary-blue);
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
                background: linear-gradient(135deg, var(--success-green), #20c997);
                color: white;
                margin-right: 15px;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #20c997, #17a2b8);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
            }

            .btn-secondary {
                background: #6c757d;
                color: white;
            }

            .btn-secondary:hover {
                background: #5a6268;
                transform: translateY(-2px);
            }

            .btn-back {
                background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
                color: #333;
                margin-bottom: 20px;
            }

            .btn-back:hover {
                background: linear-gradient(135deg, var(--secondary-blue), var(--dark-blue));
                color: white;
                transform: translateY(-2px);
            }

            .btn-sm {
                padding: 8px 15px;
                font-size: 0.85rem;
                margin-right: 10px;
                margin-bottom: 10px;
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 10px;
                font-weight: 600;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .alert-success {
                background: linear-gradient(135deg, #d4edda, #c3e6cb);
                color: #155724;
                border: 2px solid #c3e6cb;
            }

            .alert-error {
                background: linear-gradient(135deg, #f8d7da, #f5c6cb);
                color: #721c24;
                border: 2px solid #f5c6cb;
            }

            .form-help {
                font-size: 0.85rem;
                color: #6c757d;
                margin-top: 5px;
                font-style: italic;
            }

            .voucher-type-info {
                background: linear-gradient(135deg, #fff3cd, #ffeaa7);
                border: 2px solid #ffc107;
                border-radius: 10px;
                padding: 15px;
                margin-bottom: 20px;
                color: #856404;
            }

            .voucher-type-info h3 {
                margin-bottom: 10px;
                color: var(--warning-orange);
            }

            .form-actions {
                display: flex;
                justify-content: flex-start;
                gap: 15px;
                margin-top: 30px;
                padding-top: 20px;
                border-top: 2px solid var(--accent-blue);
            }

            .user-selection {
                border: 2px solid var(--accent-blue);
                border-radius: 10px;
                padding: 20px;
                background: #f8f9fa;
                max-height: 350px;
                overflow-y: auto;
            }

            .user-item {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 10px;
                border-bottom: 1px solid #dee2e6;
                transition: background 0.2s ease;
            }

            .user-item:hover {
                background: rgba(173, 216, 230, 0.1);
            }

            .user-item:last-child {
                border-bottom: none;
            }

            .user-info {
                flex: 1;
            }

            .user-name {
                font-weight: 600;
                color: var(--dark-blue);
            }

            .user-email {
                font-size: 0.9rem;
                color: #6c757d;
            }

            .user-role {
                background: var(--primary-blue);
                color: #333;
                padding: 2px 8px;
                border-radius: 12px;
                font-size: 0.8rem;
                font-weight: 500;
            }

            @media (max-width: 768px) {
                .form-row {
                    flex-direction: column;
                }

                .form-actions {
                    flex-direction: column;
                }

                .btn {
                    width: 100%;
                    margin-bottom: 10px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1><i class="fas fa-users"></i> Thêm Voucher theo User</h1>
                <p>Tạo voucher và gán trực tiếp cho người dùng cụ thể</p>
            </div>

            <div class="content">
                <!-- ✅ NÚT QUAY LẠI -->
                <a href="voucher" class="btn btn-back">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách
                </a>

                <!-- ✅ HIỂN THỊ THÔNG BÁO -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> ${successMessage}
                    </div>
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                    </div>
                </c:if>

                <!-- ✅ THÔNG TIN LOẠI VOUCHER -->
                <div class="voucher-type-info">
                    <h3><i class="fas fa-info-circle"></i> Voucher theo User</h3>
                    <p>Loại voucher này được gán trực tiếp cho những người dùng được chọn. 
                        Voucher sẽ tự động xuất hiện trong tài khoản của họ và có thể sử dụng ngay.</p>
                </div>

                <!-- ✅ FORM THÊM VOUCHER BY USER -->
                <div class="form-section">
                    <form action="voucher" method="post">
                        <input type="hidden" name="action" value="addByUser">
                        <input type="hidden" id="totalVoucherCount" name="totalVoucherCount" value="0">
                        <input type="hidden" id="campaignId" name="campaignId" value="0">

                        <!-- ✅ THÔNG TIN Cơ BẢN -->
                        <div class="form-row">
                            <div class="form-group">
                                <label for="name">Tên Voucher <span class="required">*</span></label>
                                <input type="text" id="name" name="name" 
                                       placeholder="VD: Voucher sinh nhật khách hàng VIP" required>
                            </div>
                            <div class="form-group">
                                <label for="voucherCode">Mã Voucher <span class="required">*</span></label>
                                <input type="text" id="voucherCode" name="voucherCode" 
                                       placeholder="VD: BIRTHDAY2024" required>
                                <div class="form-help">Mã voucher duy nhất, chỉ chứa chữ cái và số</div>
                            </div>
                        </div>

                        <!-- ✅ MÔ TẢ -->
                        <div class="form-group">
                            <label for="description">Mô tả Voucher</label>
                            <textarea id="description" name="description" 
                                      placeholder="Mô tả chi tiết về voucher, điều kiện sử dụng..."></textarea>
                        </div>

                        <!-- ✅ LOẠI GIẢM GIÁ -->
                        <div class="form-row">
                            <div class="form-group">
                                <label for="discountType">Loại giảm giá <span class="required">*</span></label>
                                <select id="discountType" name="discountType" required onchange="toggleDiscountFields()">
                                    <option value="PERCENTAGE">Phần trăm (%)</option>
                                    <option value="FIXED_AMOUNT">Số tiền cố định (₫)</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="discount">Giá trị giảm <span class="required">*</span></label>
                                <input type="number" id="discount" name="discount" 
                                       min="0" step="0.01" placeholder="VD: 50000 hoặc 10" required>
                                <div class="form-help" id="discountHelp">Nhập giá trị giảm giá</div>
                            </div>
                        </div>

                        <!-- ✅ ĐIỀU KIỆN SỬ DỤNG -->
                        <div class="form-row">
                            <div class="form-group">
                                <label for="minOrderAmount">Giá trị đơn hàng tối thiểu</label>
                                <input type="number" id="minOrderAmount" name="minOrderAmount" 
                                       min="0" step="1000" placeholder="VD: 100000">
                                <div class="form-help">Để trống nếu không có điều kiện tối thiểu</div>
                            </div>
                            <div class="form-group">
                                <label for="maxDiscountAmount">Giảm tối đa (VNĐ)</label>
                                <input type="number" id="maxDiscountAmount" name="maxDiscountAmount" 
                                       min="0" step="1000" placeholder="VD: 200000">
                                <div class="form-help">Áp dụng cho voucher giảm theo %</div>
                            </div>
                        </div>

                        <!-- ✅ THỜI GIAN -->
                        <div class="form-row">
                            <div class="form-group">
                                <label for="startDate">Ngày bắt đầu <span class="required">*</span></label>
                                <input type="datetime-local" id="startDate" name="startDate" required>
                            </div>
                            <div class="form-group">
                                <label for="endDate">Ngày kết thúc <span class="required">*</span></label>
                                <input type="datetime-local" id="endDate" name="endDate" required>
                            </div>
                        </div>

                        <!-- ✅ LIÊN KẾT DỊCH VỤ VÀ CAMPAIGN -->
                        <div class="form-row">
                            <div class="form-group">
                                <label for="serviceId">Dịch vụ</label>
                                <select id="serviceId" name="serviceId">
                                    <option value="0">Tất cả các dịch vụ</option>
                                    <c:forEach var="service" items="${services}">
                                        <option value="${service.id}">${service.name}</option>
                                    </c:forEach>
                                </select>
                                <div class="form-help">Chọn dịch vụ áp dụng voucher</div>
                            </div>
                        </div>

                        <!-- ✅ CHỌN NGƯỜI DÙNG -->
                        <div class="form-group">
                            <label>Chọn người dùng <span class="required">*</span></label>
                            <div class="mb-2">
                                <button type="button" class="btn btn-sm btn-secondary" onclick="selectAll()">
                                    <i class="fas fa-check-double"></i> Chọn tất cả
                                </button>
                                <button type="button" class="btn btn-sm btn-secondary" onclick="deselectAll()">
                                    <i class="fas fa-times"></i> Bỏ chọn tất cả
                                </button>
                            </div>
                            <div class="user-selection">
                                <c:forEach var="user" items="${users}">
                                    <div class="user-item">
                                        <input type="checkbox" id="user${user.id}" name="userIds" 
                                               value="${user.id}" class="user-checkbox">
                                        <label for="user${user.id}" class="user-info">
                                            <div class="user-name">${user.username}</div>
                                            <div class="user-email">${user.email}</div>
                                        </label>
                                        <span class="user-role">${user.userRole}</span>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- ✅ CÁC NÚT HÀNH ĐỘNG -->
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Tạo Voucher cho User
                            </button>
                            <a href="voucher" class="btn btn-secondary">
                                <i class="fas fa-times"></i> Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- ✅ JAVASCRIPT XỬ LÝ FORM -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // ✅ SET NGÀY MẶC ĐỊNH
                const now = new Date();
                // ✅ HÀM FORMAT DATETIME-LOCAL
                function formatDateTimeLocal(date) {
                    const year = date.getFullYear();
                    const month = String(date.getMonth() + 1).padStart(2, '0');
                    const day = String(date.getDate()).padStart(2, '0');
                    const hours = String(date.getHours()).padStart(2, '0');
                    const minutes = String(date.getMinutes()).padStart(2, '0');
                    return `${year}-${month}-${day}T${hours}:${minutes}`;
                            }
                            // Ngày bắt đầu: hiện tại
                            const startDate = new Date(now);
                            const startDateInput = document.getElementById('startDate');
                            startDateInput.value = formatDateTimeLocal(startDate);
                            startDateInput.min = formatDateTimeLocal(now);

                            // Ngày kết thúc: 7 ngày sau
                            const endDate = new Date(now.getTime() + 7 * 24 * 60 * 60 * 1000);
                            const endDateInput = document.getElementById('endDate');
                            endDateInput.value = formatDateTimeLocal(endDate);

                            // ✅ VALIDATION NGÀY
                            startDateInput.addEventListener('change', function () {
                                const startValue = new Date(this.value);
                                const endValue = new Date(endDateInput.value);

                                if (endValue <= startValue) {
                                    const newEndDate = new Date(startValue.getTime() + 24 * 60 * 60 * 1000);
                                    endDateInput.value = formatDateTimeLocal(newEndDate);
                                }
                                endDateInput.min = this.value;
                            });

                            endDateInput.addEventListener('change', function () {
                                const startValue = new Date(startDateInput.value);
                                const endValue = new Date(this.value);

                                if (endValue <= startValue) {
                                    alert('Ngày kết thúc phải sau ngày bắt đầu!');
                                    const newEndDate = new Date(startValue.getTime() + 24 * 60 * 60 * 1000);
                                    this.value = formatDateTimeLocal(newEndDate);
                                }
                            });
                        });



                        // ✅ TOGGLE DISCOUNT FIELDS
                        function toggleDiscountFields() {
                            const discountType = document.getElementById('discountType').value;
                            const helpText = document.getElementById('discountHelp');
                            const maxDiscountGroup = document.getElementById('maxDiscountAmount').closest('.form-group');

                            if (discountType === 'PERCENTAGE') {
                                helpText.textContent = 'Nhập phần trăm giảm (VD: 10 = giảm 10%)';
                                maxDiscountGroup.style.display = 'block';
                            } else if (discountType === 'FIXED_AMOUNT') {
                                helpText.textContent = 'Nhập số tiền giảm cố định (VD: 50000 = giảm 50,000 VNĐ)';
                                maxDiscountGroup.style.display = 'none';
                            }
                        }

                        // ✅ XỬ LÝ FORM SUBMIT - CHUYỂN ĐỔI FORMAT NGÀY
                        document.querySelector('form').addEventListener('submit', function (e) {
                            const startDateInput = document.getElementById('startDate');
                            const endDateInput = document.getElementById('endDate');

                            // Chuyển từ "2025-07-31T23:30" thành "2025-07-31 23:30:00"
                            if (startDateInput.value) {
                                const hiddenStartDate = document.createElement('input');
                                hiddenStartDate.type = 'hidden';
                                hiddenStartDate.name = 'startDate';
                                hiddenStartDate.value = startDateInput.value.replace('T', ' ') + ':00';
                                this.appendChild(hiddenStartDate);
                                startDateInput.name = 'startDate_display'; // Đổi tên để không conflict
                            }

                            if (endDateInput.value) {
                                const hiddenEndDate = document.createElement('input');
                                hiddenEndDate.type = 'hidden';
                                hiddenEndDate.name = 'endDate';
                                hiddenEndDate.value = endDateInput.value.replace('T', ' ') + ':00';
                                this.appendChild(hiddenEndDate);
                                endDateInput.name = 'endDate_display'; // Đổi tên để không conflict
                            }

                            // ✅ VALIDATION CƠ BẢN
                            const startDate = new Date(startDateInput.value);
                            const endDate = new Date(endDateInput.value);
                            const discountType = document.getElementById('discountType').value;
                            const discountValue = parseFloat(document.getElementById('discount').value);

                            // Kiểm tra thời gian
                            if (startDate >= endDate) {
                                alert('Ngày bắt đầu phải trước ngày kết thúc!');
                                e.preventDefault();
                                return false;
                            }

                            // Kiểm tra giá trị giảm giá
                            if (discountType === 'PERCENTAGE' && (discountValue <= 0 || discountValue > 100)) {
                                alert('Phần trăm giảm giá phải từ 0.01% đến 100%!');
                                e.preventDefault();
                                return false;
                            }

                            if (discountType === 'FIXED_AMOUNT' && discountValue <= 0) {
                                alert('Số tiền giảm phải lớn hơn 0!');
                                e.preventDefault();
                                return false;
                            }

                            return true;
                        });

                        // ✅ KHỞI TẠO TOGGLE FIELDS
                        toggleDiscountFields();
        </script>
    </body>
</html>
