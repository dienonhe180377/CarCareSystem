<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${supplier != null ? 'Sửa' : 'Thêm'} Nhà Cung Cấp</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --light-color: #f8f9fa;
                --dark-color: #212529;
                --border-radius: 8px;
                --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                --transition: all 0.3s ease;
            }

            body {
                background: #f5f7fa;
                min-height: 100vh;
                padding: 20px;
                color: var(--dark-color);
                font-family: 'Roboto', sans-serif;
            }

            .container-wrapper {
                max-width: 1000px;
                margin: 40px auto;
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
            }

            .form-header {
                background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 25px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .form-header h1 {
                font-size: 24px;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .form-header h1 i {
                font-size: 28px;
            }

            .btn-back {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                background: white;
                color: var(--primary-color);
                text-decoration: none;
                padding: 10px 20px;
                border-radius: 50px;
                font-weight: 500;
                box-shadow: var(--box-shadow);
                transition: var(--transition);
            }

            .btn-back:hover {
                background: var(--primary-color);
                color: white;
                transform: translateY(-2px);
            }

            .form-container {
                padding: 30px;
            }

            .form-title {
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 1px solid #e9ecef;
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .form-title h2 {
                font-size: 22px;
                color: var(--primary-color);
                font-weight: 600;
            }

            .form-title i {
                background: var(--primary-color);
                color: white;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 18px;
            }

            .form-row {
                display: flex;
                gap: 25px;
                margin-bottom: 20px;
            }

            .form-group {
                flex: 1;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #495057;
                font-size: 15px;
            }

            .form-group input,
            .form-group textarea {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ced4da;
                border-radius: var(--border-radius);
                font-size: 15px;
                transition: var(--transition);
            }

            .form-group input:focus,
            .form-group textarea:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            }

            .form-group textarea {
                min-height: 100px;
                resize: vertical;
            }

            .logo-upload-container {
                margin-bottom: 20px;
            }

            .logo-upload-label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #495057;
                font-size: 15px;
            }

            .logo-upload-box {
                border: 2px dashed #ced4da;
                border-radius: var(--border-radius);
                padding: 20px;
                text-align: center;
                cursor: pointer;
                transition: var(--transition);
            }

            .logo-upload-box:hover {
                border-color: var(--primary-color);
            }

            .logo-upload-box i {
                font-size: 40px;
                color: #adb5bd;
                margin-bottom: 10px;
            }

            .logo-upload-box p {
                margin: 5px 0;
                font-size: 14px;
                color: #6c757d;
            }

            .logo-preview {
                width: 100%;
                max-height: 200px;
                object-fit: contain;
                margin-top: 15px;
                border-radius: var(--border-radius);
                border: 1px solid #e9ecef;
                display: block;
            }

            .btn-submit {
                background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
                color: white;
                border: none;
                padding: 14px 30px;
                font-size: 16px;
                font-weight: 500;
                border-radius: var(--border-radius);
                cursor: pointer;
                display: block;
                width: 100%;
                margin-top: 20px;
                transition: var(--transition);
            }

            .btn-submit:hover {
                opacity: 0.9;
                transform: translateY(-2px);
            }

            @media (max-width: 768px) {
                .form-row {
                    flex-direction: column;
                    gap: 15px;
                }

                .container-wrapper {
                    margin: 20px;
                }

                .form-header {
                    padding: 20px;
                }

                .form-container {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="header_emp.jsp"></jsp:include>

            <div class="container-wrapper">
                <div class="form-header">
                    <h1><i class="fas fa-truck-loading"></i> ${supplier != null ? 'Sửa' : 'Thêm'} Nhà Cung Cấp</h1>
                <a href="${contextPath}/SupplierController?service=list" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Quay về danh sách
                </a>
            </div>

            <div class="form-container">
                <div class="form-title">
                    <i class="fas fa-${supplier != null ? 'edit' : 'plus'}"></i>
                    <h2>${supplier != null ? 'Chỉnh sửa thông tin nhà cung cấp' : 'Thêm nhà cung cấp mới'}</h2>
                </div>

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
                            <label for="name"><i class="fas fa-building"></i> Tên nhà cung cấp</label>
                            <input type="text" id="name" name="name" placeholder="Nhập tên nhà cung cấp" required
                                   <c:if test="${not empty supplier}">value="${supplier.name}"</c:if> />
                            </div>
                            <div class="form-group">
                                <label for="email"><i class="fas fa-envelope"></i> Email</label>
                                <input type="email" id="email" name="email" placeholder="Nhập địa chỉ email" required
                                <c:if test="${not empty supplier}">value="${supplier.email}"</c:if>/>
                            </div>
                        </div>

                        <!-- Hàng 2: Mô tả -->
                        <div class="form-group">
                            <label for="description"><i class="fas fa-info-circle"></i> Mô tả</label>
                            <textarea id="description" name="description" placeholder="Nhập mô tả về nhà cung cấp" required><c:if test="${not empty supplier}">${supplier.description}</c:if></textarea>
                        </div>

                        <!-- Hàng 3: Logo -->
                        <div class="logo-upload-container">
                            <label class="logo-upload-label"><i class="fas fa-image"></i> Logo nhà cung cấp</label>
                            <div class="logo-upload-box" onclick="document.getElementById('logo').click()">
                                <i class="fas fa-cloud-upload-alt"></i>
                                <p>Nhấn để tải lên logo</p>
                                <small>Chấp nhận JPG, PNG, GIF (tối đa 5MB)</small>
                            </div>
                            <input type="file" id="logo" name="logo" accept="image/*" style="display: none;" />
                        <c:choose>
                            <c:when test="${not empty supplier}">
                                <img id="logoPreview"
                                     class="logo-preview"
                                     alt="Logo của nhà cung cấp"
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

                    <!-- Hàng 4: Điện thoại và Địa chỉ -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="phone"><i class="fas fa-phone"></i> Điện thoại</label>
                            <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại" required
                                   <c:if test="${not empty supplier}">value="${supplier.phone}"</c:if>/>
                            </div>
                            <div class="form-group">
                                <label for="address"><i class="fas fa-map-marker-alt"></i> Địa chỉ</label>
                                <textarea id="address" name="address" placeholder="Nhập địa chỉ đầy đủ" required><c:if test="${not empty supplier}">${supplier.address}</c:if></textarea>
                            </div>
                        </div>

                        <button type="submit" class="btn-submit">
                            <i class="fas fa-${supplier != null ? 'save' : 'plus-circle'}"></i> ${supplier != null ? 'Cập nhật' : 'Thêm mới'} nhà cung cấp
                    </button>
                </form>
            </div>
        </div>

        <!-- Xử lý thông báo kết quả (GIỮ NGUYÊN) -->
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

        <!-- Script preview logo (GIỮ NGUYÊN) -->
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