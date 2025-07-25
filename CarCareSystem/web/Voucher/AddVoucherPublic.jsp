<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm Voucher Công khai</title>
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

            .main-header {
                background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
                color: #333;
                padding: 30px 0;
                margin-bottom: 30px;
                box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
                border-radius: 0 0 20px 20px;
            }

            .main-header h1 {
                font-weight: bold;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
                text-align: center;
                font-size: 2.2rem;
                margin: 0;
            }

            .container {
                max-width: 900px;
                margin: 0 auto;
            }

            .card {
                background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
                border-radius: 20px;
                box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
                border: 2px solid var(--accent-blue);
                overflow: hidden;
            }

            .card-header {
                background: linear-gradient(135deg, var(--accent-blue) 0%, var(--primary-blue) 100%);
                color: #333;
                padding: 20px 25px;
                border-bottom: 2px solid var(--primary-blue);
            }

            .card-header h4 {
                margin: 0;
                font-weight: bold;
                font-size: 1.5rem;
            }

            .card-body {
                padding: 30px;
            }

            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 25px;
                font-weight: 600;
                text-decoration: none;
                display: inline-block;
                transition: all 0.3s ease;
                cursor: pointer;
                box-shadow: 0 4px 15px rgba(173, 216, 230, 0.2);
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

            .btn-secondary {
                background: #6c757d;
                color: white;
            }

            .btn-secondary:hover {
                background: #5a6268;
                transform: translateY(-2px);
            }

            .btn-sm {
                padding: 8px 16px;
                font-size: 0.9rem;
            }

            .float-end {
                float: right;
            }

            .form-label {
                font-weight: 600;
                color: var(--dark-blue);
                margin-bottom: 8px;
                display: block;
            }

            .form-control, .form-select {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid var(--accent-blue);
                border-radius: 10px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: #fafafa;
            }

            .form-control:focus, .form-select:focus {
                outline: none;
                border-color: var(--primary-blue);
                background: white;
                box-shadow: 0 0 0 3px rgba(173, 216, 230, 0.25);
                transform: translateY(-1px);
            }

            .mb-3 {
                margin-bottom: 20px;
            }

            .row {
                display: flex;
                flex-wrap: wrap;
                margin: 0 -10px;
            }

            .col-md-6 {
                flex: 0 0 50%;
                max-width: 50%;
                padding: 0 10px;
            }

            .alert {
                padding: 15px 20px;
                margin-bottom: 20px;
                border: 1px solid transparent;
                border-radius: 15px;
                font-weight: 600;
                box-shadow: 0 4px 15px rgba(173, 216, 230, 0.2);
            }

            .alert-info {
                color: #0c5460;
                background: linear-gradient(135deg, #d1ecf1 0%, var(--light-blue) 100%);
                border-color: var(--primary-blue);
            }

            .alert-danger {
                color: #721c24;
                background: linear-gradient(135deg, #f8d7da 0%, #ffebee 100%);
                border-color: #dc3545;
            }

            .text-danger {
                color: #dc3545 !important;
            }

            .form-text {
                font-size: 0.875rem;
                color: #6c757d;
                margin-top: 5px;
            }

            .fa-globe, .fa-arrow-left, .fa-exclamation-circle, .fa-info-circle,
            .fa-plus, .fa-times {
                color: var(--secondary-blue);
                margin-right: 8px;
            }

            @media (max-width: 768px) {
                .col-md-6 {
                    flex: 0 0 100%;
                    max-width: 100%;
                }

                .main-header h1 {
                    font-size: 1.8rem;
                }

                .card-body {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <div class="main-header">
            <h1><i class="fas fa-globe"></i> Thêm Voucher Công khai</h1>
        </div>

        <div class="container">
            <div class="card">
                <div class="card-header">
                    <h4><i class="fas fa-globe"></i> Thêm Voucher Công khai</h4>
                    <a href="voucher" class="btn btn-secondary btn-sm float-end">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                </div>
                <div class="card-body">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i> 
                        Voucher này sẽ được phát cho <strong>tất cả người dùng</strong> trong hệ thống.
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                        </div>
                    </c:if>

                    <form action="voucher" method="post">
                        <input type="hidden" name="action" value="addPublic">

                        <!-- Thông tin voucher -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Tên voucher <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="name" name="name" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="voucherCode" class="form-label">Mã voucher <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="voucherCode" name="voucherCode" 
                                           pattern="[a-zA-Z0-9]+" title="Chỉ được chứa chữ cái và số" required>
                                    <div class="form-text">Chỉ được chứa chữ cái và số, không có dấu cách</div>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="serviceId" class="form-label">Dịch vụ</label>
                            <select class="form-select" id="serviceId" name="serviceId" >
                                <option value="0">Tất cả các dịch vụ</option>
                                <c:forEach var="service" items="${services}">
                                    <option value="${service.id}">${service.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="campaignId" class="form-label">Chiến dịch</label>
                            <select class="form-select" id="campaignId" name="campaignId">
                                <option value="0">Không thuộc chiến dịch nào</option>
                                <c:forEach var="campaign" items="${campaigns}">
                                    <option value="${campaign.id}">${campaign.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="discountType" class="form-label">Loại giảm giá <span class="text-danger">*</span></label>
                                    <select class="form-select" id="discountType" name="discountType" onchange="toggleDiscountType()" required>
                                        <option value="PERCENTAGE">Phần trăm (%)</option>
                                        <option value="FIXED_AMOUNT">Số tiền cố định (₫)</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="discount" class="form-label">Giá trị giảm giá <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="discount" name="discount" 
                                           min="0" step="0.01" required>
                                    <div class="form-text" id="discountHelp">Nhập giá trị từ 0-100 cho phần trăm</div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="maxDiscountAmount" class="form-label">Giảm tối đa (₫)</label>
                                    <input type="number" class="form-control" id="maxDiscountAmount" name="maxDiscountAmount" min="0">
                                    <div class="form-text">Để trống nếu không giới hạn</div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="minOrderAmount" class="form-label">Đơn hàng tối thiểu (₫)</label>
                                    <input type="number" class="form-control" id="minOrderAmount" name="minOrderAmount" min="0">
                                    <div class="form-text">Để trống nếu không yêu cầu</div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="startDate" class="form-label">Ngày bắt đầu <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="startDate" name="startDate" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="endDate" class="form-label">Ngày kết thúc <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="endDate" name="endDate" required>
                                </div>
                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Tạo Voucher
                            </button>
                            <a href="voucher" class="btn btn-secondary">
                                <i class="fas fa-times"></i> Hủy
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            function toggleDiscountType() {
                const discountType = document.getElementById('discountType').value;
                const discountHelp = document.getElementById('discountHelp');
                const discountInput = document.getElementById('discount');

                if (discountType === 'PERCENTAGE') {
                    discountHelp.textContent = 'Nhập giá trị từ 0-100 cho phần trăm';
                    discountInput.max = '100';
                } else {
                    discountHelp.textContent = 'Nhập số tiền cố định (VND)';
                    discountInput.removeAttribute('max');
                }
            }
            document.addEventListener('DOMContentLoaded', function () {
                const today = new Date().toISOString().split('T')[0];
                document.getElementById('startDate').value = today;

                const tomorrow = new Date();
                tomorrow.setDate(tomorrow.getDate() + 7);
                document.getElementById('endDate').value = tomorrow.toISOString().split('T')[0];
            });
        </script>
    </body>
</html>
