<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${choosedPart != null ? 'Sửa' : 'Thêm'} Linh Kiện</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <script src="https://cdn.tiny.cloud/1/bpczrech1jam3gtdjv4btw4n34ryl064yvnd260pxmaonk1b/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            /* CSS mới chỉ áp dụng trong container .content-container */
            .content-container {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --accent-color: #4895ef;
                --success-color: #4cc9f0;
                --light-color: #f8f9fa;
                --dark-color: #212529;
                --border-color: #dee2e6;
                --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);

                font-family: 'Roboto', sans-serif;
                background-color: #f5f7fb;
                color: #333;
                padding-top: 20px;
            }

            .content-container .card {
                border-radius: 12px;
                box-shadow: var(--shadow);
                border: none;
                margin-bottom: 30px;
            }

            .content-container .card-header {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                border-radius: 12px 12px 0 0 !important;
                padding: 15px 20px;
                font-weight: 500;
            }

            .content-container .form-label {
                font-weight: 500;
                color: #495057;
                margin-bottom: 8px;
            }

            .content-container .form-control,
            .content-container .form-select {
                border: 1px solid var(--border-color);
                border-radius: 8px;
                padding: 10px 15px;
                transition: all 0.3s;
            }

            .content-container .form-control:focus,
            .content-container .form-select:focus {
                border-color: var(--accent-color);
                box-shadow: 0 0 0 3px rgba(72, 149, 239, 0.2);
            }

            .content-container .btn-primary {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                border: none;
                border-radius: 8px;
                padding: 10px 25px;
                font-weight: 500;
                transition: all 0.3s;
            }

            .content-container .btn-primary:hover {
                background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(67, 97, 238, 0.3);
            }

            .content-container .btn-secondary {
                background: #6c757d;
                border: none;
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: 500;
                transition: all 0.3s;
            }

            .content-container .btn-secondary:hover {
                background: #5a6268;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(108, 117, 125, 0.3);
            }

            .content-container .btn-info {
                background: linear-gradient(135deg, var(--success-color), var(--accent-color));
                border: none;
                border-radius: 8px;
                padding: 8px 20px;
                font-weight: 500;
                transition: all 0.3s;
            }

            .content-container .btn-info:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(76, 201, 240, 0.3);
            }

            .content-container .btn-danger {
                border-radius: 8px;
                padding: 8px 15px;
                transition: all 0.3s;
            }

            .content-container .btn-danger:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
            }

            .content-container .section-title {
                color: var(--primary-color);
                border-bottom: 2px solid var(--accent-color);
                padding-bottom: 10px;
                margin: 25px 0 15px;
                font-weight: 600;
            }

            .content-container .img-thumbnail {
                border-radius: 8px;
                border: 1px solid var(--border-color);
                padding: 5px;
                max-width: 120px;
                transition: transform 0.3s;
            }

            .content-container .img-thumbnail:hover {
                transform: scale(1.05);
            }

            .content-container .form-section {
                background-color: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                margin-bottom: 20px;
            }

            .content-container .size-row {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 12px 15px;
                margin-bottom: 10px;
                align-items: center;
                transition: background-color 0.3s;
            }

            .content-container .size-row:hover {
                background-color: #e9ecef;
            }

            .content-container .add-size-btn i {
                margin-right: 8px;
            }

            .content-container .current-image-label {
                display: block;
                margin-bottom: 8px;
            }

            .content-container .header-container {
                background: white;
                border-radius: 12px;
                padding: 20px;
                box-shadow: var(--shadow);
                margin-bottom: 25px;
            }

            .content-container .form-note {
                font-size: 13px;
                color: #6c757d;
                margin-top: 5px;
                font-style: italic;
            }

            .content-container .supplier-select {
                height: auto;
                max-height: 200px;
                overflow-y: auto;
            }
        </style>
    </head>
    <body>
        <!-- Header sẽ nằm ngoài container nội dung -->
        <jsp:include page="header_emp.jsp"></jsp:include>

            <!-- Container nội dung chính với class mới -->
            <div class="content-container container">
                <div class="header-container">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="mb-0"><i class="fas fa-microchip me-2"></i>${choosedPart != null ? 'Sửa' : 'Thêm'} Linh Kiện</h2>
                        <p class="text-muted mb-0">Quản lý thông tin và chi tiết linh kiện</p>
                    </div>
                    <a href="${contextPath}/PartController?service=list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay về
                    </a>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h4 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin cơ bản</h4>
                </div>
                <div class="card-body">
                    <form action="PartController" method="post" enctype="multipart/form-data">
                        <c:if test="${empty choosedPart}">
                            <input type="hidden" name="service" value="add"/>
                            <input type="hidden" name="action" value="add"/>
                        </c:if>
                        <c:if test="${not empty choosedPart}">
                            <input type="hidden" name="service" value="edit"/>
                            <input type="hidden" name="action" value="edit"/>
                            <input type="hidden" name="id" value="${choosedPart.id}"/>
                        </c:if>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Tên Linh Kiện</label>
                                    <input type="text" class="form-control" id="name" name="name" 
                                           value="${choosedPart != null ? choosedPart.name : ''}" 
                                           maxlength="25" required>
                                    <div class="form-note">Tối đa 25 ký tự</div>
                                </div>

                                <div class="mb-3">
                                    <label for="price" class="form-label">Giá Linh Kiện (VNĐ)</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-money-bill-wave"></i></span>
                                        <input type="number" class="form-control" id="price" name="price"
                                               value="${choosedPart.price}" required>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="categoryId" class="form-label">Danh mục</label>
                                    <select class="form-select" id="categoryId" name="categoryId" required>
                                        <c:forEach var="category" items="${categoryList}">
                                            <option value="${category.id}"<c:if test="${category.id == choosedPart.category.id}">selected</c:if>>${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label for="supplierId" class="form-label">Nhà cung cấp</label>
                                    <select class="form-select supplier-select" name="supplierId" multiple size="5" required>
                                        <c:forEach var="supplier" items="${supplierList}">
                                            <option value="${supplier.id}"
                                                    <c:forEach var="choosenPartSup" items="${choosedPart.suppliers}">
                                                        <c:if test="${supplier.id == choosenPartSup.id}">selected</c:if>
                                                    </c:forEach>
                                                    >${supplier.name}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="form-note">Nhấn Ctrl để chọn nhiều nhà cung cấp</div>
                                </div>
                            </div>
                        </div>

                        <h4 class="section-title"><i class="fas fa-image me-2"></i>Hình ảnh linh kiện</h4>
                        <div class="form-section">
                            <div class="mb-3">
                                <label for="productImage" class="form-label">Ảnh Linh Kiện</label>
                                <input type="file" class="form-control" id="productImage" name="image" accept="image/*">
                            </div>

                            <c:if test="${not empty choosedPart}">
                                <div class="mb-3">
                                    <label class="form-label current-image-label">Ảnh hiện tại</label>
                                    <div class="d-flex align-items-center">
                                        <div class="me-3">
                                            <img src="${contextPath}/image/${choosedPart.image}" class="img-thumbnail" alt="Product Image">
                                        </div>
                                        <div>
                                            <small class="text-muted">Thêm ảnh mới sẽ thay thế ảnh hiện tại</small>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <h4 class="section-title"><i class="fas fa-ruler-combined me-2"></i>Quản lý kích cỡ</h4>
                        <div class="form-section">
                            <div id="sizeContainer">
                                <!-- Nếu là thêm mới, hiển thị 1 hàng trống -->
                                <c:if test="${empty choosedPart}">
                                    <div class="row size-row">
                                        <div class="col-md-4">
                                            <label class="form-label">Tên Size</label>
                                            <input type="text" class="form-control" name="sizeName" placeholder="Nhập tên size" required>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">Số lượng</label>
                                            <input type="number" class="form-control" name="quantity" placeholder="Số lượng" required>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">Trạng thái</label>
                                            <select class="form-select" name="status" required>
                                                <option value="1">Hoạt động</option>
                                                <option value="0">Ngừng hoạt động</option>
                                            </select>
                                        </div>
                                        <div class="col-md-2 d-flex align-items-end">
                                            <button type="button" class="btn btn-danger w-100 remove-size">
                                                <i class="fas fa-trash me-1"></i> Xóa
                                            </button>
                                        </div>
                                    </div>
                                </c:if>

                                <!-- Nếu là chỉnh sửa, lặp qua từng size để tạo từng hàng riêng -->
                                <c:if test="${not empty choosedPart}">
                                    <c:forEach var="size" items="${choosedPart.sizes}">
                                        <div class="row size-row">
                                            <input type="hidden" name="sizeId" value="${size.id}">
                                            <div class="col-md-4">
                                                <label class="form-label">Tên Size</label>
                                                <input type="text" class="form-control" name="sizeName"
                                                       value="${size.name}" placeholder="Nhập tên size" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">Số lượng</label>
                                                <input type="number" class="form-control" name="quantity"
                                                       value="${size.quantity}" placeholder="Số lượng" required>
                                            </div>
                                            <div class="col-md-3">
                                                <label class="form-label">Trạng thái</label>
                                                <select class="form-select" name="status" required>
                                                    <option value="1" <c:if test="${size.status}">selected</c:if>>Hoạt động</option>
                                                    <option value="0" <c:if test="${!size.status}">selected</c:if>>Ngừng hoạt động</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-2 d-flex align-items-end">
                                                    <button type="button" class="btn btn-danger w-100 remove-size">
                                                        <i class="fas fa-trash me-1"></i> Xóa
                                                    </button>
                                                </div>
                                            </div>
                                    </c:forEach>
                                </c:if>
                            </div>

                            <button type="button" class="btn btn-info mt-3 add-size-btn" id="addSize">
                                <i class="fas fa-plus-circle me-2"></i>Thêm Kích Cỡ
                            </button>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fas fa-save me-2"></i>${choosedPart != null ? 'Cập nhật' : 'Thêm mới'} Linh Kiện
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <c:if test="${successAdd != null}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    var successAdd = ${successAdd};
                    if (successAdd > 0) {
                        Swal.fire({
                            icon: 'success',
                            title: '${choosedPart != null ? 'Sửa' : 'Thêm'} Thành Công!',
                            showConfirmButton: false,
                            timer: 1500
                        }).then(() => {
                            window.location.href = '${contextPath}/PartController?service=list';
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Có Lỗi Xảy Ra!',
                            text: 'Vui lòng kiểm tra lại thông tin nhập',
                            showConfirmButton: true
                        });
                    }
                });
            </script>
        </c:if>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

        <c:if test="${empty choosedPart}">
            <script>
                // Add JavaScript for dynamic size fields
                document.addEventListener('DOMContentLoaded', function () {
                    const sizeContainer = document.getElementById('sizeContainer');
                    const addSizeBtn = document.getElementById('addSize');

                    // Add new size row
                    addSizeBtn.addEventListener('click', function () {
                        const newRow = document.createElement('div');
                        newRow.className = 'row size-row mt-3';
                        newRow.innerHTML = `
                            <div class="col-md-4">
                                <label class="form-label">Tên Size</label>
                                <input type="text" class="form-control" name="sizeName" placeholder="Nhập tên size" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Số lượng</label>
                                <input type="number" class="form-control" name="quantity" placeholder="Số lượng" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Trạng thái</label>
                                <select class="form-select" name="status" required>
                                    <option value="1">Hoạt động</option>
                                    <option value="0">Ngừng hoạt động</option>
                                </select>
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button type="button" class="btn btn-danger w-100 remove-size">
                                    <i class="fas fa-trash me-1"></i> Xóa
                                </button>
                            </div>
                        `;
                        sizeContainer.appendChild(newRow);

                        // Add event listener to the new remove button
                        newRow.querySelector('.remove-size').addEventListener('click', function () {
                            sizeContainer.removeChild(newRow);
                        });
                    });

                    // Add event listeners to existing remove buttons
                    document.querySelectorAll('.remove-size').forEach(button => {
                        button.addEventListener('click', function () {
                            const row = this.closest('.size-row');
                            sizeContainer.removeChild(row);
                        });
                    });
                });
            </script>                
        </c:if>
        <c:if test="${not empty choosedPart}">
            <script>
                // Add JavaScript for dynamic size fields
                document.addEventListener('DOMContentLoaded', function () {
                    const sizeContainer = document.getElementById('sizeContainer');
                    const addSizeBtn = document.getElementById('addSize');

                    // Add new size row
                    addSizeBtn.addEventListener('click', function () {
                        const newRow = document.createElement('div');
                        newRow.className = 'row size-row mt-3';
                        newRow.innerHTML = `
                            <input type="hidden" name="sizeId" value="0">
                            <div class="col-md-4">
                                <label class="form-label">Tên Size</label>
                                <input type="text" class="form-control" name="sizeName" placeholder="Nhập tên size" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Số lượng</label>
                                <input type="number" class="form-control" name="quantity" placeholder="Số lượng" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Trạng thái</label>
                                <select class="form-select" name="status" required>
                                    <option value="1">Hoạt động</option>
                                    <option value="0">Ngừng hoạt động</option>
                                </select>
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button type="button" class="btn btn-danger w-100 remove-size">
                                    <i class="fas fa-trash me-1"></i> Xóa
                                </button>
                            </div>
                        `;
                        sizeContainer.appendChild(newRow);

                        // Add event listener to the new remove button
                        newRow.querySelector('.remove-size').addEventListener('click', function () {
                            sizeContainer.removeChild(newRow);
                        });
                    });

                    // Add event listeners to existing remove buttons
                    document.querySelectorAll('.remove-size').forEach(button => {
                        button.addEventListener('click', function () {
                            const row = this.closest('.size-row');
                            sizeContainer.removeChild(row);
                        });
                    });
                });
            </script>                
        </c:if>
    </body>
</html>