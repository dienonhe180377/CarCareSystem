<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý Voucher</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .form-container {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        .table-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h2 class="mb-4">
            <i class="fas fa-ticket-alt"></i> Quản lý Voucher
        </h2>

        <!-- Messages -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Add/Edit Form -->
        <div class="form-container">
            <h4>
                <c:choose>
                    <c:when test="${isEditing}">
                        <i class="fas fa-edit"></i> Sửa Voucher
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-plus"></i> Thêm Voucher Mới
                    </c:otherwise>
                </c:choose>
            </h4>
            
            <form method="post" action="VoucherServlet">
                <c:if test="${isEditing}">
                    <input type="hidden" name="id" value="${voucher.id}">
                    <input type="hidden" name="service" value="edit">
                </c:if>
                <c:if test="${not isEditing}">
                    <input type="hidden" name="service" value="add">
                </c:if>

                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Tên Voucher *</label>
                            <input type="text" class="form-control" id="name" name="name" 
                                   value="${voucher.name}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="discount" class="form-label">Discount (%) *</label>
                            <input type="number" class="form-control" id="discount" name="discount" 
                                   value="${voucher.discount}" min="0" max="100" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="campaignId" class="form-label">Campaign *</label>
                            <select class="form-select" id="campaignId" name="campaignId" required>
                                <option value="">Chọn Campaign</option>
                                <c:forEach var="campaign" items="${campaigns}">
                                    <option value="${campaign.id}" 
                                            <c:if test="${voucher.campaign.id == campaign.id}">selected</c:if>>
                                        ${campaign.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="serviceId" class="form-label">Service *</label>
                            <select class="form-select" id="serviceId" name="serviceId" required>
                                <option value="">Chọn Service</option>
                                <c:forEach var="service" items="${services}">
                                    <option value="${service.id}" 
                                            <c:if test="${voucher.service.id == service.id}">selected</c:if>>
                                        ${service.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="startDate" class="form-label">Ngày Bắt Đầu *</label>
                            <input type="date" class="form-control" id="startDate" name="startDate" 
                                   value="${voucher.startDate}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="endDate" class="form-label">Ngày Kết Thúc *</label>
                            <input type="date" class="form-control" id="endDate" name="endDate" 
                                   value="${voucher.endDate}" required>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Mô Tả</label>
                    <textarea class="form-control" id="description" name="description" rows="3">${voucher.description}</textarea>
                </div>

                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="status" name="status" 
                           <c:if test="${voucher.status or not isEditing}">checked</c:if>>
                    <label class="form-check-label" for="status">Kích hoạt</label>
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        <c:choose>
                            <c:when test="${isEditing}">Cập nhật</c:when>
                            <c:otherwise>Thêm mới</c:otherwise>
                        </c:choose>
                    </button>
                    
                    <c:if test="${isEditing}">
                        <a href="VoucherServlet" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Hủy
                        </a>
                    </c:if>
                </div>
            </form>
        </div>

        <!-- Voucher List -->
        <div class="table-container">
            <h4><i class="fas fa-list"></i> Danh Sách Voucher</h4>
            
            <c:if test="${empty vouchers}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> Chưa có voucher nào được tạo.
                </div>
            </c:if>

            <c:if test="${not empty vouchers}">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Tên</th>
                                <th>Campaign</th>
                                <th>Service</th>
                                <th>Discount</th>
                                <th>Ngày BĐ</th>
                                <th>Ngày KT</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="voucher" items="${vouchers}">
                                <tr>
                                    <td>${voucher.id}</td>
                                    <td>${voucher.name}</td>
                                    <td>${voucher.campaign.name}</td>
                                    <td>${voucher.service.name}</td>
                                    <td>${voucher.discount}%</td>
                                    <td>${voucher.startDate}</td>
                                    <td>${voucher.endDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${voucher.status}">
                                                <span class="badge bg-success">Kích hoạt</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Không kích hoạt</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="VoucherServlet?editId=${voucher.id}" 
                                               class="btn btn-sm btn-outline-primary">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-outline-danger" 
                                                    onclick="confirmDelete(${voucher.id}, '${voucher.name}')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Delete Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc chắn muốn xóa voucher "<span id="voucherName"></span>"?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <form method="post" action="VoucherServlet" style="display: inline;">
                        <input type="hidden" name="service" value="delete">
                        <input type="hidden" name="id" id="deleteId">
                        <button type="submit" class="btn btn-danger">Xóa</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(id, name) {
            document.getElementById('deleteId').value = id;
            document.getElementById('voucherName').textContent = name;
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }

        // Set minimum date to today
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('startDate').min = today;
            document.getElementById('endDate').min = today;
            
            // Update end date minimum when start date changes
            document.getElementById('startDate').addEventListener('change', function() {
                document.getElementById('endDate').min = this.value;
            });
        });
    </script>
</body>
</html>
