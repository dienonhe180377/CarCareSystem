<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Container phân trang */
            #pagination {
                margin-top: 1.5rem;
            }
            /* Toàn bộ nút trong pagination */
            #pagination button {
                margin: 0 0.25rem;
                padding: 0.5rem 0.75rem;
                font-size: 1rem;
                border-radius: 0.375rem;
                min-width: 2.5rem;
            }
            /* Nút active */
            #pagination .btn-primary {
                background-color: #0d6efd;
                border-color: #0d6efd;
            }
            /* Hover trên nút outline */
            #pagination .btn-outline-primary:hover {
                background-color: #0d6efd;
                color: #fff;
            }

            .test-btn-view {
                background-color: #007bff;
                color: white;
                padding: 4px 11px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }
            .test-btn-view:hover {
                background-color: #0056b3;
            }

            .test-modal {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.6);
                display: none;
                justify-content: center;
                align-items: center;
                z-index: 1000;
                overflow: auto;
            }
            .test-modal-content {
                background: #fff;
                width: 90%;
                max-width: 800px;
                max-height: 90vh;
                border-radius: 8px;
                overflow-y: auto;
                box-shadow: 0 5px 15px rgba(0,0,0,0.3);
                animation: fadeIn 0.3s ease-out;
                position: relative;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .test-modal-header {
                background: #007bff;
                color: #fff;
                padding: 16px;
                font-size: 20px;
                position: sticky;
                top: 0;
                z-index: 1;
            }
            .test-modal-body {
                padding: 20px;
            }
            .test-modal-body img {
                display: block;
                width: 100%;
                max-width: 200px;
                height: auto;
                border-radius: 4px;
                margin: 0 auto 20px;
            }
            .test-section {
                margin-bottom: 20px;
            }
            .test-section h3 {
                margin-bottom: 10px;
                color: #333;
                font-size: 18px;
            }

            /* Chỉ định CSS cho các bảng mang class test-table */
            .test-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 10px;
            }
            .test-table th,
            .test-table td {
                text-align: left;
                padding: 8px;
                border-bottom: 1px solid #ddd;
            }
            .test-table th {
                background-color: #f1f1f1;
            }

            .test-close-btn {
                position: absolute;
                top: 16px;
                right: 16px;
                background: transparent;
                border: none;
                font-size: 24px;
                color: #fff;
                cursor: pointer;
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        
        <jsp:include page="header_emp.jsp"></jsp:include>

        <div class="container mt-5">
            <div class="row mb-3">
                <div class="col">
                    <h2>Part List</h2>
                </div>
                <div class="col text-end">
                    <a href="${contextPath}/PartController?service=add&action=load" class="btn btn-primary">Add New Product</a>
                </div>
            </div>

            <!-- Form filter -->
            <form method="get" action="PartController" class="mb-4">
                <input type="hidden" name="service" value="filter" />
                <div class="row g-3">
                    <div class="col-md-3">
                        <input type="text" name="search" class="form-control" placeholder="Search by name" value="${textInputted}">
                    </div>
                    <div class="col-md-3">
                        <select name="categoryId" class="form-select">
                            <option value="0">Tất cả Category</option>
                            <c:forEach var="category" items="${categoryList}">
                                <option value="${category.id}"
                                        <c:if test="${not empty choosenCategory && choosenCategory == category.id}">selected</c:if>>${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select name="supplierId" class="form-select">
                            <option value="0">Tất cả Supplier</option>
                            <c:forEach var="supplier" items="${supplierList}">
                                <option value="${supplier.id}" 
                                        <c:if test="${not empty choosenSupplier && choosenSupplier == supplier.id}">selected</c:if>>${supplier.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <div class="form-check">
                            <input 
                                type="checkbox" 
                                name="outOfStock" 
                                class="form-check-input" 
                                id="outOfStock"
                                <c:if test="${not empty outOfStock}">checked</c:if>/>
                                <label class="form-check-label" for="outOfStock">Out of Stock</label>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <button type="submit" class="btn btn-primary w-100">Filter</button>
                        </div>
                    </div>
                </form>

                <!-- Bảng sản phẩm -->
                <table id="productTable" class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Image</th>
                            <th>Category</th>
                            <th>Suppliers</th>
                            <th>Size Quantity</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="part" items="${filterList}">
                        <tr>
                            <td>${part.name}</td>
                            <td>
                                <img src="${contextPath}/image/${part.image}" width="50"/>
                            </td>
                            <td>${part.category.name}</td>
                            <td>
                                <button
                                    tabindex="0"
                                    class="text-decoration-none btn btn-link p-0"
                                    type="button"
                                    data-bs-toggle="popover"
                                    data-bs-trigger="focus"
                                    title="Supplier"
                                    data-bs-html="true"
                                    data-bs-content="
                                    <ul class='list-unstyled mb-0'>
                                    <c:forEach var="partSupplier" items="${part.suppliers}">
                                        <li>${partSupplier.name}</li>
                                    </c:forEach>
                                    </ul>
                                    ">
                                    ${part.suppliers.size()} Supplier
                                </button>
                            </td>
                            <td>
                                <button
                                    tabindex="0"
                                    class="text-decoration-none btn btn-link p-0"
                                    type="button"
                                    data-bs-toggle="popover"
                                    data-bs-trigger="focus"
                                    title="Available Sizes"
                                    data-bs-html="true"
                                    data-bs-content="
                                    <ul class='list-unstyled mb-0'>
                                    <c:forEach var="sizes" items="${part.sizes}">
                                        <li><strong>${sizes.name}</strong> : ${sizes.quantity}</li>
                                    </c:forEach>
                                    </ul>
                                    ">
                                    ${part.sizes.size()} Size
                                </button>
                            </td>
                            <td>
                                <!-- Chuyển View thành button test-btn-view để mở popup -->
                                <a href="${contextPath}/PartController?service=view&id=${part.id}" type="button" class="btn btn-info btn-sm test-btn-view">View</a>
                                <a href="${contextPath}/PartController?service=edit&action=load&id=${part.id}" class="btn btn-warning btn-sm">Edit</a>
                                <a href="${contextPath}/PartController?service=delete&id=${part.id}" 
                                   class="btn btn-danger btn-sm" 
                                   onclick="return confirm('Are you sure you want to delete this product?')">
                                    Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty filterList}">
                        <tr>
                            <td colspan="6" class="text-center">
                                Không có kết quả nào
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
            <!-- Nơi render các nút phân trang -->
            <div id="pagination" class="d-flex justify-content-center mt-3" style="padding-bottom: 5%;"></div>

            <c:if test="${not empty choosenPart}">
                <div class="test-modal" id="testDetailModal" style="display: flex;">
                    <div class="test-modal-content">
                        <div class="test-modal-header">
                            <span>Part Details</span>
                            <button class="test-close-btn" id="testCloseModalBtn">&times;</button>
                        </div>
                        <div class="test-modal-body">
                            <div class="test-section">
                                <h3 id="testPartName">${choosenPart.name}</h3>
                                <img id="testPartImage"
                                     src="${contextPath}/image/${choosenPart.image}"
                                     alt="Part Image">
                            </div>

                            <div class="test-section">
                                <table class="test-table">
                                    <thead>
                                        <tr><th>Dịch vụ đang sử dụng</th></tr>
                                    </thead>
                                    <tbody id="testServicesListNames">
                                        <c:forEach var="service" items="${choosenPart.services}">
                                            <tr><td>${service.name}</td></tr>
                                        </c:forEach>

                                    </tbody>
                                </table>
                            </div>

                            <div class="test-section">
                                <table class="test-table">
                                    <thead>
                                        <tr><th>Category</th></tr>
                                    </thead>
                                    <tbody id="testServicesListCategories">
                                        <tr><td>${choosenPart.category.name}</td></tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="test-section">
                                <table class="test-table">
                                    <thead>
                                        <tr><th>Nhà cung cấp</th></tr>
                                    </thead>
                                    <tbody id="testSuppliersListNames">
                                        <c:forEach var="suppliers" items="${choosenPart.suppliers}">
                                            <tr><td>${suppliers.name}</td></tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="test-section">
                                <table class="test-table">
                                    <thead>
                                        <tr><th>Kích cỡ</th></tr>
                                    </thead>
                                    <tbody id="testSuppliersListSizes">
                                        <c:forEach var="sizes" items="${choosenPart.sizes}">
                                            <tr><td>${sizes.name}: ${sizes.quantity}</td></tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="test-section">
                                <table class="test-table">
                                    <thead>
                                        <tr><th>Giá</th></tr>
                                    </thead>
                                    <tbody id="testSuppliersListPrices">
                                        <tr><td>${choosenPart.price}</td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
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
        <script>
                // Popover Bootstrap
                document.addEventListener('DOMContentLoaded', function () {
                    var popoverTriggerList = Array.from(document.querySelectorAll('[data-bs-toggle="popover"]'));
                    popoverTriggerList.forEach(function (el) {
                        new bootstrap.Popover(el);
                    });
                });

                const closeBtn = document.getElementById('testCloseModalBtn');
                const modal = document.getElementById('testDetailModal');
                closeBtn.addEventListener('click', () => modal.style.display = 'none');
                window.addEventListener('click', e => {
                    if (e.target === modal)
                        modal.style.display = 'none';
                });
        </script>
        <script src="${contextPath}/js/partList.js"></script>
    </body>
</html>
