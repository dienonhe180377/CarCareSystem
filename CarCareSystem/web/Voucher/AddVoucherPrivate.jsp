<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Voucher Riêng tư</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-4">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <h4><i class="fas fa-user-shield"></i> Thêm Voucher Riêng tư</h4>
                            <a href="voucher" class="btn btn-secondary btn-sm float-end">
                                <i class="fas fa-arrow-left"></i> Quay lại
                            </a>
                        </div>
                        <div class="card-body">
                            <div class="alert alert-warning">
                                <i class="fas fa-info-circle"></i> 
                                Voucher này sẽ được phát cho <strong>người dùng có vai trò được chọn</strong>.
                            </div>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger">
                                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                                </div>
                            </c:if>

                            <form action="voucher" method="post">
                                <input type="hidden" name="action" value="addPrivate">

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

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="maxDiscountAmount" class="form-label">Giảm tối đa (₫)</label>
                                                <input type="number" class="form-control" id="maxDiscountAmount" name="maxDiscountAmount" min="0" placeholder="Ví dụ: 100000">
                                                <div class="form-text">Để trống nếu không giới hạn</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="minOrderAmount" class="form-label">Đơn hàng tối thiểu (₫)</label>
                                                <input type="number" class="form-control" id="minOrderAmount" name="minOrderAmount" min="0" placeholder="Ví dụ: 50000">
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

                                    <!-- Chọn vai trò -->
                                    <div class="mb-3">
                                        <label class="form-label">Chọn vai trò <span class="text-danger">*</span></label>
                                        <div class="mb-2">
                                            <button type="button" class="btn btn-sm btn-outline-primary" onclick="selectAllRoles()">Chọn tất cả</button>
                                            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="deselectAllRoles()">Bỏ chọn tất cả</button>
                                        </div>
                                        <div class="border rounded p-3">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-check">
                                                        <input class="form-check-input role-checkbox" type="checkbox" 
                                                               value="admin" id="roleAdmin" name="roles">
                                                        <label class="form-check-label" for="roleAdmin">
                                                            <i class="fas fa-user-shield text-danger"></i> Admin
                                                        </label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input role-checkbox" type="checkbox" 
                                                               value="customer" id="roleCustomer" name="roles">
                                                        <label class="form-check-label" for="roleCustomer">
                                                            <i class="fas fa-user text-primary"></i> Customer
                                                        </label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input role-checkbox" type="checkbox" 
                                                               value="warehouse manager" id="roleWarehouse" name="roles">
                                                        <label class="form-check-label" for="roleWarehouse">
                                                            <i class="fas fa-warehouse text-info"></i> Warehouse Manager
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-check">
                                                        <input class="form-check-input role-checkbox" type="checkbox" 
                                                               value="manager" id="roleManager" name="roles">
                                                        <label class="form-check-label" for="roleManager">
                                                            <i class="fas fa-user-tie text-success"></i> Manager
                                                        </label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input role-checkbox" type="checkbox" 
                                                               value="marketing" id="roleMarketing" name="roles">
                                                        <label class="form-check-label" for="roleMarketing">
                                                            <i class="fas fa-bullhorn text-warning"></i> Marketing
                                                        </label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input role-checkbox" type="checkbox" 
                                                               value="repairer" id="roleRepairer" name="roles">
                                                        <label class="form-check-label" for="roleRepairer">
                                                            <i class="fas fa-wrench text-secondary"></i> Repairer
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="text-center">
                                        <button type="submit" class="btn btn-warning">
                                            <i class="fas fa-plus"></i> Thêm Voucher Riêng tư
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
                                                        discountHelp.textContent = 'Nhập số tiền cố định (VND)';
                                                    }
                                                }

                                                function selectAllRoles() {
                                                    const checkboxes = document.querySelectorAll('.role-checkbox');
                                                    checkboxes.forEach(checkbox => checkbox.checked = true);
                                                }

                                                function deselectAllRoles() {
                                                    const checkboxes = document.querySelectorAll('.role-checkbox');
                                                    checkboxes.forEach(checkbox => checkbox.checked = false);
                                                }

                                                // Set ngày hiện tại làm mặc định
                                                // Sử dụng Intl API để lấy ngày theo múi giờ Việt Nam
                                                document.addEventListener('DOMContentLoaded', function () {
                                                    // Lấy ngày hiện tại theo múi giờ Việt Nam
                                                    const today = new Intl.DateTimeFormat('sv-SE', {
                                                        timeZone: 'Asia/Ho_Chi_Minh'
                                                    }).format(new Date());

                                                    const startDateInput = document.getElementById('startDate');
                                                    const endDateInput = document.getElementById('endDate');

                                                    if (startDateInput && endDateInput) {
                                                        // Set giá trị mặc định
                                                        startDateInput.value = today;
                                                        startDateInput.min = today;

                                                        // Ngày kết thúc mặc định là 7 ngày sau
                                                        const nextWeekDate = new Date();
                                                        nextWeekDate.setDate(nextWeekDate.getDate() + 7);
                                                        const nextWeek = new Intl.DateTimeFormat('sv-SE', {
                                                            timeZone: 'Asia/Ho_Chi_Minh'
                                                        }).format(nextWeekDate);
                                                        endDateInput.value = nextWeek;

                                                        // Validation ngày
                                                        startDateInput.addEventListener('change', function () {
                                                            endDateInput.min = this.value;
                                                            if (endDateInput.value && endDateInput.value <= this.value) {
                                                                const nextDay = new Date(this.value);
                                                                nextDay.setDate(nextDay.getDate() + 1);
                                                                endDateInput.value = nextDay.toISOString().split('T')[0];
                                                            }
                                                        });

                                                        endDateInput.addEventListener('change', function () {
                                                            if (this.value <= startDateInput.value) {
                                                                alert('Ngày kết thúc phải sau ngày bắt đầu!');
                                                                const nextDay = new Date(startDateInput.value);
                                                                nextDay.setDate(nextDay.getDate() + 1);
                                                                this.value = nextDay.toISOString().split('T')[0];
                                                            }
                                                        });

                                                        console.log('Ngày hiện tại (VN):', today);
                                                    }
                                                });
        </script>
    </body>
</html>
