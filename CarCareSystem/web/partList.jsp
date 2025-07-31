<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Linh kiện</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary: #4361ee;
                --secondary: #3f37c9;
                --success: #4cc9f0;
                --light: #f8f9fa;
                --dark: #212529;
                --border: #dee2e6;
                --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                --transition: all 0.3s ease;
            }

            body {
                background-color: #f5f7fb;
                color: #344767;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .card {
                border-radius: 12px;
                border: none;
                box-shadow: var(--card-shadow);
                transition: var(--transition);
                margin-bottom: 1.5rem;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 16px rgba(0, 0, 0, 0.1);
            }

            .card-header {
                background: linear-gradient(120deg, var(--primary), var(--secondary));
                color: white;
                border-radius: 12px 12px 0 0 !important;
                padding: 1.2rem 1.5rem;
                font-weight: 600;
            }

            .btn-primary {
                background-color: var(--primary);
                border-color: var(--primary);
                transition: var(--transition);
            }

            .btn-primary:hover {
                background-color: var(--secondary);
                border-color: var(--secondary);
                transform: translateY(-2px);
            }

            .btn-outline-primary {
                color: var(--primary);
                border-color: var(--primary);
            }

            .btn-outline-primary:hover {
                background-color: var(--primary);
                color: white;
            }

            .table thead th {
                background-color: var(--primary);
                color: white;
                font-weight: 600;
                border-top: none;
            }

            .table-hover tbody tr:hover {
                background-color: rgba(67, 97, 238, 0.05);
            }

            .badge-light {
                background-color: #e9ecef;
                color: #495057;
                font-weight: 500;
            }

            .filter-section {
                background-color: white;
                border-radius: 12px;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                box-shadow: var(--card-shadow);
            }

            .section-title {
                color: var(--primary);
                font-weight: 600;
                margin-bottom: 1.5rem;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid var(--primary);
                display: inline-block;
            }

            .action-buttons .btn {
                margin-right: 5px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                transition: var(--transition);
            }

            .action-buttons .btn:hover {
                transform: translateY(-2px);
            }

            .img-thumbnail {
                border-radius: 8px;
                border: 1px solid var(--border);
                transition: var(--transition);
            }

            .img-thumbnail:hover {
                transform: scale(1.05);
            }

            .info-badge {
                cursor: pointer;
                transition: var(--transition);
                padding: 0.5em 1em;
                border-radius: 8px;
            }

            .info-badge:hover {
                background-color: var(--primary) !important;
                color: white !important;
                transform: translateY(-2px);
            }

            .pagination .page-item .page-link {
                border-radius: 8px;
                margin: 0 3px;
                border: none;
                color: var(--primary);
                transition: var(--transition);
            }

            .pagination .page-item.active .page-link {
                background-color: var(--primary);
                border-color: var(--primary);
            }

            .pagination .page-item .page-link:hover {
                background-color: #eaeefd;
            }

            .modal-header {
                background: linear-gradient(120deg, var(--primary), var(--secondary));
                color: white;
                border-radius: 12px 12px 0 0;
            }

            .modal-content {
                border-radius: 12px;
                overflow: hidden;
                border: none;
            }

            .detail-section {
                margin-bottom: 1.5rem;
            }

            .detail-section h5 {
                color: var(--primary);
                font-weight: 600;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
            }

            .detail-section h5 i {
                margin-right: 10px;
            }

            .no-results {
                text-align: center;
                padding: 2rem;
                color: #6c757d;
            }

            .no-results i {
                font-size: 3rem;
                margin-bottom: 1rem;
                color: #dee2e6;
            }

            .sort-badge {
                background-color: #e9f7fe;
                color: #0d6efd;
                padding: 0.25rem 0.5rem;
                border-radius: 4px;
                font-size: 0.85rem;
                margin-left: 0.5rem;
            }

            .sort-badge i {
                margin-right: 3px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="header_emp.jsp"></jsp:include>

            <div class="container py-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <div>
                            <i class="fas fa-microchip me-2"></i>
                            <span>Quản lý Linh kiện</span>
                        </div>
                        <a href="${contextPath}/PartController?service=add&action=load" class="btn btn-light">
                        <i class="fas fa-plus me-2"></i>Thêm linh kiện
                    </a>
                </div>

                <div class="card-body">
                    <!-- Form filter -->
                    <div class="filter-section">
                        <h5 class="section-title"><i class="fas fa-filter"></i> Bộ lọc và Sắp xếp</h5>
                        <form method="get" action="PartController">
                            <input type="hidden" name="service" value="filter" />
                            <div class="row g-3">
                                <div class="col-md-2">
                                    <div class="form-floating">
                                        <input type="text" name="search" class="form-control" placeholder="Tên linh kiện" value="${textInputted}" id="searchInput">
                                        <label for="searchInput"><i class="fas fa-search me-2"></i>Tên linh kiện</label>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-floating">
                                        <select name="categoryId" class="form-select" id="categorySelect">
                                            <option value="0">Tất cả Category</option>
                                            <c:forEach var="category" items="${categoryList}">
                                                <option value="${category.id}"
                                                        <c:if test="${not empty choosenCategory && choosenCategory == category.id}">selected</c:if>>${category.name}</option>
                                            </c:forEach>
                                        </select>
                                        <label for="categorySelect"><i class="fas fa-tag me-2"></i>Danh mục</label>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-floating">
                                        <select name="supplierId" class="form-select" id="supplierSelect">
                                            <option value="0">Tất cả Supplier</option>
                                            <c:forEach var="supplier" items="${supplierList}">
                                                <option value="${supplier.id}" 
                                                        <c:if test="${not empty choosenSupplier && choosenSupplier == supplier.id}">selected</c:if>>${supplier.name}</option>
                                            </c:forEach>
                                        </select>
                                        <label for="supplierSelect"><i class="fas fa-truck me-2"></i>Nhà cung cấp</label>
                                    </div>
                                </div>
                                <!-- Dropdown sắp xếp mới -->
                                <div class="col-md-3">
                                    <div class="form-floating">
                                        <select name="orderBy" class="form-select" id="orderBySelect">
                                            <option value="">Sắp xếp mặc định</option>
                                            <option value="newest" <c:if test="${param.orderBy == 'newest'}">selected</c:if>>Mới nhất</option>
                                            <option value="most_orders" <c:if test="${param.orderBy == 'most_orders'}">selected</c:if>>Số đơn hàng (cao nhất)</option>
                                            <option value="most_services" <c:if test="${param.orderBy == 'most_services'}">selected</c:if>>Số dịch vụ (cao nhất)</option>
                                            </select>
                                            <label for="orderBySelect"><i class="fas fa-sort me-2"></i>Sắp xếp</label>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="form-check form-switch mt-3 pt-1">
                                            <input 
                                                type="checkbox" 
                                                name="outOfStock" 
                                                class="form-check-input" 
                                                id="outOfStock"
                                            <c:if test="${not empty outOfStock}">checked</c:if>/>
                                            <label class="form-check-label" for="outOfStock">Hết hàng</label>
                                        </div>
                                    </div>
                                    <div class="col-md-1">
                                        <button type="submit" class="btn btn-primary h-100 w-100">
                                            <i class="fas fa-filter me-2"></i>Lọc
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Bảng sản phẩm -->
                        <div class="table-responsive">
                            <table id="productTable" class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>
                                            Tên linh kiện
                                        <c:if test="${param.orderBy == 'newest'}">
                                            <span class="sort-badge"><i class="fas fa-sort-amount-down"></i> Mới nhất</span>
                                        </c:if>
                                    </th>
                                    <th>Hình ảnh</th>
                                    <th>Danh mục</th>
                                    <th>
                                        Số lượng đơn
                                        <c:if test="${param.orderBy == 'most_orders'}">
                                            <span class="sort-badge"><i class="fas fa-sort-amount-down"></i> Đơn hàng</span>
                                        </c:if>
                                    </th>
                                    <th>
                                        Dịch vụ sử dụng
                                        <c:if test="${param.orderBy == 'most_services'}">
                                            <span class="sort-badge"><i class="fas fa-sort-amount-down"></i> Dịch vụ</span>
                                        </c:if>
                                    </th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="part" items="${filterList}">
                                    <tr>
                                        <td>
                                            <strong>${part.name}</strong>
                                        </td>
                                        <td>
                                            <img src="${contextPath}/image/${part.image}" width="60" class="img-thumbnail"/>
                                        </td>
                                        <td>
                                            <span class="badge bg-light text-dark">${part.category.name}</span>
                                        </td>
                                        <td>
                                            <span class="badge info-badge bg-light text-primary" 
                                                  data-bs-toggle="popover" 
                                                  data-bs-trigger="focus"
                                                  title="Nhà cung cấp"
                                                  data-bs-html="true"
                                                  data-bs-content="
                                                  <ul class='list-group list-group-flush'>
                                                  </ul>">
                                                ${part.orderAmount} Đơn hàng
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge info-badge bg-light text-primary" 
                                                  data-bs-toggle="popover" 
                                                  data-bs-trigger="focus"
                                                  title="Kích cỡ & Số lượng"
                                                  data-bs-html="true"
                                                  data-bs-content="
                                                  <div class='table-responsive'>
                                                  <table class='table table-sm'>
                                                  <thead>
                                                  <tr>
                                                  <th>Kích cỡ</th>
                                                  <th>Số lượng</th>
                                                  </tr>
                                                  </thead>
                                                  <tbody>
                                                  
                                                  </tbody>
                                                  </table>
                                                  </div>">
                                                ${part.services.size()} Dịch vụ
                                            </span>
                                        </td>
                                        <td class="action-buttons">
                                            <a href="${contextPath}/PartController?service=view&id=${part.id}" 
                                               class="btn btn-sm btn-primary">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="${contextPath}/PartController?service=edit&action=load&id=${part.id}" 
                                               class="btn btn-sm btn-warning">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${contextPath}/PartController?service=delete&id=${part.id}" 
                                               class="btn btn-sm btn-danger" 
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa linh kiện này?')">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty filterList}">
                                    <tr>
                                        <td colspan="6" class="no-results">
                                            <i class="fas fa-inbox"></i>
                                            <h5>Không tìm thấy linh kiện nào</h5>
                                            <p class="text-muted">Hãy thử thay đổi tiêu chí lọc của bạn</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <div id="pagination" class="d-flex justify-content-center mt-3"></div>
                </div>
            </div>
        </div>

        <!-- Bootstrap Modal for Part Details -->
        <c:if test="${not empty choosenPart}">
            <div class="modal fade" id="partDetailModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="fas fa-info-circle me-2"></i>Chi tiết linh kiện
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-4 text-center">
                                    <img src="${contextPath}/image/${choosenPart.image}" 
                                         class="img-fluid rounded mb-3"
                                         alt="Part Image">
                                    <h4 class="mb-0">${choosenPart.name}</h4>
                                    <p class="text-muted">ID: ${choosenPart.id}</p>
                                </div>

                                <div class="col-md-8">
                                    <div class="detail-section">
                                        <h5><i class="fas fa-tags"></i> Danh mục</h5>
                                        <div class="d-flex align-items-center">
                                            <span class="badge bg-primary p-2">
                                                ${choosenPart.category.name}
                                            </span>
                                        </div>
                                    </div>

                                    <div class="detail-section">
                                        <h5><i class="fas fa-truck"></i> Nhà cung cấp</h5>
                                        <div class="row">
                                            <c:forEach var="supplier" items="${choosenPart.suppliers}">
                                                <div class="col-md-6 mb-2">
                                                    <div class="card border">
                                                        <div class="card-body py-2">
                                                            <i class="fas fa-building me-2 text-primary"></i>
                                                            ${supplier.name}
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="detail-section">
                                                <h5><i class="fas fa-ruler-combined"></i> Kích cỡ</h5>
                                                <div class="table-responsive">
                                                    <table class="table table-sm">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th>Kích cỡ</th>
                                                                <th>Số lượng</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="size" items="${choosenPart.sizes}">
                                                                <tr>
                                                                    <td>${size.name}</td>
                                                                    <td>
                                                                        <span class="badge bg-primary">
                                                                            ${size.quantity}
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="detail-section">
                                                <h5><i class="fas fa-cogs"></i> Dịch vụ sử dụng</h5>
                                                <div class="table-responsive">
                                                    <table class="table table-sm">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th>Tên dịch vụ</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="service" items="${choosenPart.services}">
                                                                <tr>
                                                                    <td>
                                                                        <i class="fas fa-wrench me-2 text-success"></i>
                                                                        ${service.name}
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="detail-section">
                                        <h5><i class="fas fa-money-bill-wave"></i> Giá</h5>
                                        <div class="d-flex align-items-center">
                                            <h3 class="text-success mb-0">
                                                ${choosenPart.price} VND
                                            </h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${successDelete != null}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    var successDelete = ${successDelete};
                    if (successDelete > 0) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Xóa Thành Công!',
                            showConfirmButton: false,
                            timer: 1500
                        }).then(() => {
                            window.location.href = '${contextPath}/PartController?service=list';
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Vẫn Còn Service Sử Dụng Linh Kiện Này!',
                            showConfirmButton: true
                        }).then(() => {
                            window.location.href = '${contextPath}/PartController?service=list';
                        });
                    }
                });
            </script>
        </c:if>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
                // Initialize popovers
                document.addEventListener('DOMContentLoaded', function () {
                    var popoverTriggerList = Array.from(document.querySelectorAll('[data-bs-toggle="popover"]'));
                    popoverTriggerList.forEach(function (el) {
                        new bootstrap.Popover(el);
                    });

                    // Show detail modal if part data exists
            <c:if test="${not empty choosenPart}">
                    var partModal = new bootstrap.Modal(document.getElementById('partDetailModal'));
                    partModal.show();
            </c:if>

                    // Highlight selected sort option
                    const orderBySelect = document.getElementById('orderBySelect');
                    if (orderBySelect) {
                        orderBySelect.addEventListener('change', function () {
                            // Visual feedback for selected sort option
                            this.classList.add('border-primary');
                            setTimeout(() => this.classList.remove('border-primary'), 500);
                        });
                    }
                });
        </script>
        <script src="${contextPath}/js/partList.js"></script>
    </body>
</html>