<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Voucher theo User</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <h4><i class="fas fa-users"></i> Thêm Voucher theo User</h4>
                            <a href="voucher" class="btn btn-secondary btn-sm float-end">
                                <i class="fas fa-arrow-left"></i> Quay lại
                            </a>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger">
                                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                                </div>
                            </c:if>

                            <form action="voucher" method="post">
                                <input type="hidden" name="action" value="addByUser">

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

                                <!-- Chọn user -->
                                <div class="mb-3">
                                    <label class="form-label">Chọn người dùng <span class="text-danger">*</span></label>
                                    <div class="mb-2">
                                        <button type="button" class="btn btn-sm btn-outline-primary" onclick="selectAll()">Chọn tất cả</button>
                                        <button type="button" class="btn btn-sm btn-outline-secondary" onclick="deselectAll()">Bỏ chọn tất cả</button>
                                    </div>
                                    <div class="border rounded p-3" style="max-height: 300px; overflow-y: auto;">
                                        <c:forEach var="user" items="${users}">
                                            <div class="form-check">
                                                <input class="form-check-input user-checkbox" type="checkbox" 
                                                       value="${user.id}" id="user${user.id}" name="userIds">
                                                <label class="form-check-label" for="user${user.id}">
                                                    ${user.username} (${user.email}) - <span class="badge bg-info">${user.userRole}</span>
                                                </label>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Thêm Voucher
                                    </button>
                                    <a href="voucher" class="btn btn-secondary">
                                        <i class="fas fa-times"></i> Hủy
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                            function toggleDiscountType() {
                                                const discountType = document.getElementById('discountType').value;
                                                const discountInput = document.getElementById('discount');
                                                const discountHelp = document.getElementById('discountHelp');

                                                if (discountType === 'PERCENTAGE') {
                                                    discountInput.max = '100';
                                                    discountHelp.textContent = 'Nhập giá trị từ 0-100 cho phần trăm';
                                                } else {
                                                    discountInput.removeAttribute('max');
                                                    discountHelp.textContent = 'Nhập số tiền giảm giá';
                                                }
                                            }

                                            function selectAll() {
                                                const checkboxes = document.querySelectorAll('.user-checkbox');
                                                checkboxes.forEach(checkbox => checkbox.checked = true);
                                            }

                                            function deselectAll() {
                                                const checkboxes = document.querySelectorAll('.user-checkbox');
                                                checkboxes.forEach(checkbox => checkbox.checked = false);
                                            }

                                            // Set ngày hiện tại làm mặc định
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
