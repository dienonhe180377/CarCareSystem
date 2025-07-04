<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${choosedPart != null ? 'Sửa' : 'Thêm'} Linh Kiện</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- TinyMCE CDN -->
        <script src="https://cdn.tiny.cloud/1/bpczrech1jam3gtdjv4btw4n34ryl064yvnd260pxmaonk1b/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>

        <jsp:include page="header_emp.jsp"></jsp:include>
        
        <div class="container mt-5" style="margin-bottom: 5%;">
            <div class="row mb-3">
                <div class="col">
                    <h2>${choosedPart != null ? 'Sửa' : 'Thêm'} Linh Kiện</h2>
                </div>
                <div class="col text-end">
                    <a href="${contextPath}/PartController?service=list" class="btn btn-secondary">Quay về</a>
                </div>
            </div>

            <div class="card">
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
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="name" class="form-label">Product Name</label>
                                <input type="text" class="form-control" id="name" name="name" value="${choosedPart != null ? choosedPart.name : ''}" maxlength="25" required>
                            </div>
                            <div class="col-md-3">
                                <label for="categoryId" class="form-label">Category</label>
                                <select class="form-select" id="categoryId" name="categoryId" required>
                                    <c:forEach var="category" items="${categoryList}">
                                        <option value="${category.id}"<c:if test="${category.id == choosedPart.category.id}">selected</c:if>>${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="typeId" class="form-label">Supplier</label>
                                <select class="form-select" name="supplierId" multiple size="5" required>
                                    <c:forEach var="supplier" items="${supplierList}">
                                        <option value="${supplier.id}"
                                                <c:forEach var="choosenPartSup" items="${choosedPart.suppliers}">
                                                    <c:if test="${supplier.id == choosenPartSup.id}">selected</c:if>
                                                </c:forEach>
                                                >${supplier.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="price" class="form-label">Giá Linh Kiện</label>
                            <input 
                                type="number" 
                                class="form-control" 
                                id="price" 
                                name="price"
                                value="${choosedPart.price}"
                                required>
                        </div>

                        <div class="mb-3">
                            <label for="productImage" class="form-label">Product Image</label>
                            <input type="file" class="form-control" id="productImage" name="image" accept="image/*">
                            <small class="text-muted">You can select multiple images</small>
                        </div>

                        <c:if test="${not empty choosedPart}">
                            <div class="mb-3">
                                <label class="form-label">Current Image</label>
                                <div class="row">
                                    <div class="col-md-2 mb-2">
                                        <img src="${contextPath}/image/${choosedPart.image}" class="img-thumbnail" alt="Product Image">
                                    </div>
                                </div>
                                <small class="text-muted">Uploading new images will replace the current ones</small>
                            </div>
                        </c:if>



                        <h4 class="mt-4">Kích cỡ</h4>
                        <div id="sizeContainer">
                            <!-- Nếu là thêm mới, hiển thị 1 hàng trống -->
                            <c:if test="${empty choosedPart}">
                                <div class="row mb-2 size-row">
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" name="sizeName" placeholder="Size Name" required>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="number" class="form-control" name="quantity" placeholder="Quantity" required>
                                    </div>
                                    <div class="col-md-3">
                                        <select class="form-control" name="status" required>
                                            <option value="1">Active</option>
                                            <option value="0">Inactive</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="button" class="btn btn-danger remove-size">Xóa Size</button>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Nếu là chỉnh sửa, lặp qua từng size để tạo từng hàng riêng -->
                            <c:if test="${not empty choosedPart}">
                                <c:forEach var="size" items="${choosedPart.sizes}">
                                    <div class="row mb-2 size-row">
                                        <input type="hidden" name="sizeId" value="${size.id}">
                                        <div class="col-md-4">
                                            <input type="text" class="form-control" name="sizeName"
                                                   value="${size.name}" placeholder="Size Name" required>
                                        </div>
                                        <div class="col-md-3">
                                            <input type="number" class="form-control" name="quantity"
                                                   value="${size.quantity}" placeholder="Quantity" required>
                                        </div>
                                        <div class="col-md-3">
                                            <select class="form-control" name="status" required>
                                                <option value="1" <c:if test="${size.status}">selected</c:if>>Active</option>
                                                <option value="0" <c:if test="${!size.status}">selected</c:if>>Inactive</option>
                                                </select>
                                            </div>
                                            <div class="col-md-2">
                                                <button type="button" class="btn btn-danger remove-size">Xóa Size</button>
                                            </div>
                                        </div>
                                </c:forEach>
                            </c:if>
                        </div>

                        <button type="button" class="btn btn-info mb-3" id="addSize">Add Size</button>

                        <div class="text-end">
                            <button type="submit" class="btn btn-primary">${choosedPart != null ? 'Sửa' : 'Thêm'} Linh Kiện</button>
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
                            showConfirmButton: true
                        }).then(() => {
                            window.location.href = '${contextPath}/PartController?service=list';
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
                        newRow.className = 'row mb-2 size-row';
                        newRow.innerHTML = `
            <div class="col-md-4">
                <input type="text" class="form-control" name="sizeName" placeholder="Size Name" required>
            </div>
            <div class="col-md-3">
                <input type="number" class="form-control" name="quantity" placeholder="Quantity" required>
            </div>
            <div class="col-md-3">
                <select class="form-control" name="status" required>
                <option value="1">Active</option>
                <option value="0">Inactive</option>
                </select>
            </div>
            <div class="col-md-2">
                <button type="button" class="btn btn-danger remove-size">Xóa Size</button>
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
                        newRow.className = 'row mb-2 size-row';
                        newRow.innerHTML = `
            <input type="hidden" name="sizeId" value="0">
            <div class="col-md-4">
                <input type="text" class="form-control" name="sizeName" placeholder="Size Name" required>
            </div>
            <div class="col-md-3">
                <input type="number" class="form-control" name="quantity" placeholder="Quantity" required>
            </div>
            <div class="col-md-3">
                <select class="form-control" name="status" required>
                <option value="1">Active</option>
                <option value="0">Inactive</option>
                </select>
            </div>
            <div class="col-md-2">
                <button type="button" class="btn btn-danger remove-size">Xóa Size</button>
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