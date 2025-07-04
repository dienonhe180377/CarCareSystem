<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm Nhà Cung Cấp</title>
        <link rel="stylesheet" href="${contextPath}/css/supplierDetail.css"/>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <jsp:include page="header_emp.jsp"></jsp:include>

            <div class="container-wrapper">
                <!-- Nút Quay về danh sách, nằm ngoài .form-container -->
                <a href="${contextPath}/SupplierController?service=list" class="btn-back">
                ← Quay về danh sách
            </a>

            <div class="form-container">
                <h2>${supplier != null ? 'Sửa' : 'Thêm'} Nhà Cung Cấp</h2>
                <form id="addSupplierForm"
                      action="<c:choose>
                          <c:when test='${not empty supplier}'>
                              ${contextPath}/SupplierController?service=edit&action=edit
                          </c:when>
                          <c:otherwise>
                              ${contextPath}/SupplierController?service=add
                          </c:otherwise>
                      </c:choose>"
                      method="post"
                      enctype="multipart/form-data">

                    <c:if test="${not empty supplier}">
                        <input type="hidden" name="id" value="${supplier.id}"/>
                        <input type="hidden" name="oldLogo" value="${supplier.logo}"/>
                    </c:if>

                    <!-- Hàng 1: Tên và Email -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="name">Tên nhà cung cấp</label>
                            <input type="text" id="name" name="name" placeholder="Nhập tên" required
                                   <c:if test="${not empty supplier}">value="${supplier.name}"</c:if> />
                            </div>
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" placeholder="Nhập email" required
                                <c:if test="${not empty supplier}">value="${supplier.email}"</c:if>/>
                            </div>
                        </div>

                        <!-- Hàng 2: Mô tả và Logo -->
                        <div class="form-group" style="margin-bottom:16px;">
                            <label for="description">Mô tả</label>
                            <textarea id="description" name="description" placeholder="Nhập mô tả" required><c:if test="${not empty supplier}">${supplier.description}</c:if></textarea>
                        </div>
                        <div class="form-group" style="margin-bottom:16px;">
                            <label for="logo">Logo</label>
                            <input type="file" id="logo" name="logo" accept="image/*" />
                        <c:choose>
                            <c:when test="${not empty supplier}">
                                <img id="logoPreview"
                                     class="logo-preview"
                                     alt="Logo của supplier"
                                     src="${contextPath}/image/${supplier.logo}"
                                     style="display: block;"/>
                            </c:when>
                            <c:otherwise>
                                <img id="logoPreview"
                                     class="logo-preview"
                                     alt="Xem trước logo"
                                     style="display: none;"/>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Hàng 3: Điện thoại và Địa chỉ -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="phone">Điện thoại</label>
                            <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại" required
                                   <c:if test="${not empty supplier}">value="${supplier.phone}"</c:if>/>
                            </div>
                            <div class="form-group">
                                <label for="address">Địa chỉ</label>
                                <textarea id="address" name="address" placeholder="Nhập địa chỉ" required><c:if test="${not empty supplier}">${supplier.address}</c:if></textarea>
                            </div>
                        </div>

                        <button type="submit" class="btn-submit">${supplier != null ? 'Sửa' : 'Thêm'} nhà cung cấp</button>
                </form>
            </div> <!-- /.form-container -->

            <!-- Xử lý thông báo kết quả -->
            <c:if test="${successCheck != null}">
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        var successCheck = ${successCheck};
                        if (successCheck > 0) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Thêm Thành Công!',
                                showConfirmButton: false,
                                timer: 1500
                            }).then(() => {
                                window.location.href = '${contextPath}/SupplierController?service=list';
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Có Lỗi Xảy Ra Hoặc Supplier Đã Tồn Tại!',
                                showConfirmButton: true
                            }).then(() => {
                                window.location.href = '${contextPath}/SupplierController?service=list';
                            });
                        }
                    });
                </script>
            </c:if>

            <c:if test="${changeSuccess != null}">
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        var changeSuccess = ${changeSuccess};
                        const id = ${supplier.id};
                        if (changeSuccess > 0) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Sửa Thành Công!',
                                showConfirmButton: false,
                                timer: 1500
                            }).then(() => {
                                window.location.href = '${contextPath}/SupplierController?service=edit&action=load&id=' + id;
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Có Lỗi Xảy Ra!',
                                showConfirmButton: true
                            }).then(() => {
                                window.location.href = '${contextPath}/SupplierController?service=edit&action=load&id=' + id;
                            });
                        }
                    });
                </script>
            </c:if>

            <c:if test="${phoneInvalid != null}">
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        Swal.fire({
                            icon: 'error',
                            title: 'Số Điện Thoại Không Hợp Lệ!',
                            showConfirmButton: true
                        });
                    });
                </script>
            </c:if>
        </div> <!-- /.container-wrapper -->

        <!-- Script preview logo -->
        <script>
            document.getElementById('logo').addEventListener('change', function (event) {
                const file = event.target.files[0];
                const preview = document.getElementById('logoPreview');
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        preview.src = e.target.result;
                        preview.style.display = 'block';
                    };
                    reader.readAsDataURL(file);
                } else {
                    preview.src = '';
                    preview.style.display = 'none';
                }
            });
        </script>
    </body>
</html>
