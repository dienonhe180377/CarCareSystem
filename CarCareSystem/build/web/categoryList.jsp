<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Quản Lý Danh Mục</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --success-color: #4cc9f0;
                --danger-color: #f72585;
                --warning-color: #f8961e;
                --light-color: #f8f9fa;
                --dark-color: #212529;
                --border-radius: 8px;
                --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                --transition: all 0.3s ease;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Roboto', sans-serif;
            }

            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                padding: 20px;
                color: var(--dark-color);
            }

            .container {
                max-width: 1400px;
                margin: 30px auto;
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
            }

            .header {
                background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 25px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .header h1 {
                font-size: 28px;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .header h1 i {
                font-size: 32px;
            }

            .main-content {
                padding: 30px;
            }

            .search-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                flex-wrap: wrap;
                gap: 20px;
            }

            .search-box {
                flex: 1;
                min-width: 300px;
                max-width: 500px;
            }

            .search-box form {
                display: flex;
                gap: 10px;
            }

            .search-box input {
                flex: 1;
                padding: 12px 18px;
                border: 1px solid #ced4da;
                border-radius: var(--border-radius);
                font-size: 16px;
                transition: var(--transition);
            }

            .search-box input:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            }

            .search-box button {
                background: var(--primary-color);
                color: white;
                border: none;
                padding: 0 24px;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-weight: 500;
                transition: var(--transition);
            }

            .search-box button:hover {
                background: var(--secondary-color);
                transform: translateY(-2px);
            }

            .columns-layout {
                display: flex;
                gap: 30px;
                flex-wrap: wrap;
            }

            .left-column {
                flex: 1;
                min-width: 350px;
                background: #f8f9fa;
                padding: 25px;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
            }

            .right-column {
                flex: 2;
                min-width: 600px;
            }

            .section-title {
                font-size: 22px;
                color: var(--primary-color);
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 2px solid var(--primary-color);
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .section-title i {
                background: var(--primary-color);
                color: white;
                width: 36px;
                height: 36px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 16px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #495057;
                font-size: 15px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ced4da;
                border-radius: var(--border-radius);
                font-size: 15px;
                transition: var(--transition);
            }

            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            }

            .form-group textarea {
                min-height: 120px;
                resize: vertical;
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
                margin-top: 10px;
                transition: var(--transition);
                box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(67, 97, 238, 0.4);
            }

            .filters-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                flex-wrap: wrap;
                gap: 15px;
            }

            .filter-box {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .filter-box label {
                font-weight: 500;
                color: #495057;
            }

            .filter-box select {
                padding: 10px 15px;
                border: 1px solid #ced4da;
                border-radius: var(--border-radius);
                font-size: 15px;
                background: white;
                cursor: pointer;
                transition: var(--transition);
            }

            .filter-box select:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            }

            .table-container {
                overflow-x: auto;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                margin-bottom: 25px;
            }

            .category-table {
                width: 100%;
                border-collapse: collapse;
                background: white;
            }

            .category-table th {
                background: var(--primary-color);
                color: white;
                text-align: left;
                padding: 16px 20px;
                font-weight: 500;
                position: sticky;
                top: 0;
            }

            .category-table td {
                padding: 14px 20px;
                border-bottom: 1px solid #e9ecef;
            }

            .category-table tbody tr {
                transition: var(--transition);
            }

            .category-table tbody tr:hover {
                background-color: rgba(67, 97, 238, 0.05);
            }

            .status-active {
                background: #e8f5e9;
                color: #2e7d32;
                padding: 6px 12px;
                border-radius: 20px;
                font-weight: 500;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }

            .status-inactive {
                background: #ffebee;
                color: #c62828;
                padding: 6px 12px;
                border-radius: 20px;
                font-weight: 500;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }

            .manage-buttons {
                display: flex;
                gap: 10px;
            }

            .btn-edit {
                background: var(--primary-color);
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-size: 14px;
                transition: var(--transition);
                display: flex;
                align-items: center;
                gap: 6px;
            }

            .btn-edit:hover {
                background: var(--secondary-color);
                transform: translateY(-2px);
            }

            .btn-delete {
                background: var(--danger-color);
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-size: 14px;
                transition: var(--transition);
                display: flex;
                align-items: center;
                gap: 6px;
            }

            .btn-delete:hover {
                background: #d50000;
                transform: translateY(-2px);
            }

            .pagination {
                display: flex;
                justify-content: center;
                list-style: none;
                margin: 25px 0;
                gap: 8px;
            }

            .pagination li {
                display: inline-block;
            }

            .pagination a {
                display: block;
                padding: 8px 16px;
                background: #f8f9fa;
                border: 1px solid #dee2e6;
                border-radius: var(--border-radius);
                color: var(--primary-color);
                text-decoration: none;
                transition: var(--transition);
            }

            .pagination a:hover {
                background: var(--primary-color);
                color: white;
            }

            .pagination a.active {
                background: var(--primary-color);
                color: white;
                font-weight: bold;
            }

            .note {
                background: #fff8e1;
                padding: 15px;
                border-radius: var(--border-radius);
                border-left: 4px solid var(--warning-color);
                font-size: 14px;
                margin-top: 20px;
            }

            .note a {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 500;
            }

            .note a:hover {
                text-decoration: underline;
            }

            .pagination-info {
                text-align: center;
                margin: 15px 0;
                font-size: 14px;
                color: #6c757d;
            }

            /* Modal styles */
            .modal-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 1000;
                justify-content: center;
                align-items: center;
            }

            .modal-content {
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                width: 100%;
                max-width: 500px;
                padding: 30px;
                position: relative;
                animation: modalFadeIn 0.3s ease;
            }

            @keyframes modalFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .close-btn {
                position: absolute;
                top: 15px;
                right: 20px;
                font-size: 28px;
                cursor: pointer;
                color: #6c757d;
                transition: var(--transition);
            }

            .close-btn:hover {
                color: var(--danger-color);
            }

            .btn-cancel {
                background: #6c757d;
                color: white;
                border: none;
                padding: 12px 20px;
                border-radius: var(--border-radius);
                cursor: pointer;
                font-size: 15px;
                transition: var(--transition);
                margin-top: 10px;
                width: 100%;
            }

            .btn-cancel:hover {
                background: #5a6268;
            }

            @media (max-width: 992px) {
                .columns-layout {
                    flex-direction: column;
                }

                .left-column, .right-column {
                    min-width: 100%;
                }

                .header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 15px;
                }

                .search-container {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .search-box {
                    width: 100%;
                }

                .search-box form {
                    width: 100%;
                }

                .filters-container {
                    flex-direction: column;
                    align-items: flex-start;
                }
            }

            @media (max-width: 768px) {
                .container {
                    margin: 15px;
                }

                .main-content {
                    padding: 20px;
                }

                .manage-buttons {
                    flex-direction: column;
                }

                .modal-content {
                    width: 95%;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="header_emp.jsp"></jsp:include>

            <div class="container">
                <div class="header">
                    <h1><i class="fas fa-folder-open"></i> Quản Lý Danh Mục</h1>
                </div>

                <div class="main-content">
                    <div class="search-container">
                        <div class="search-box">
                            <form>
                                <input type="search" name="search" placeholder="Tìm kiếm danh mục..." 
                                <c:if test="${not empty categorySearch}">value="${categorySearch}"</c:if> />
                                <input type="hidden" name="service" value="search"/>
                                <button type="submit"><i class="fas fa-search"></i> Tìm Kiếm</button>
                            </form>
                        </div>
                    </div>

                    <div class="columns-layout">
                        <!-- Phần thêm mới -->
                        <div class="left-column">
                            <h2 class="section-title"><i class="fas fa-plus-circle"></i> Thêm Danh Mục Mới</h2>
                            <form action="${contextPath}/CategoryController" method="post">
                            <div class="form-group">
                                <label for="cat-name"><i class="fas fa-tag"></i> Tên danh mục</label>
                                <input type="text" id="cat-name" name="name" placeholder="Nhập tên danh mục" required/>
                            </div>

                            <div class="form-group">
                                <label for="cat-status"><i class="fas fa-toggle-on"></i> Trạng thái</label>
                                <select id="cat-status" name="status">
                                    <option value="active">Hoạt Động</option>
                                    <option value="inactive">Không Hoạt Động</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="cat-description"><i class="fas fa-info-circle"></i> Mô tả</label>
                                <textarea id="cat-description" name="description" placeholder="Mô tả về danh mục (tùy chọn)"></textarea>
                            </div>

                            <input type="hidden" name="service" value="add"/>
                            <button type="submit" class="btn-submit"><i class="fas fa-plus"></i> Thêm mới</button>
                        </form>
                    </div>

                    <c:if test="${not empty checkError}">
                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                var checkError = `${checkError}`;
                                if (checkError === 'success') {
                                    Swal.fire({
                                        icon: 'success',
                                        title: 'Thêm Danh Mục Thành Công!',
                                        showConfirmButton: false,
                                        timer: 1500
                                    }).then(() => {
                                        window.location.href = '${contextPath}/CategoryController?service=list';
                                    });
                                } else {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Danh Mục Đã Tồn Tại!',
                                        showConfirmButton: true
                                    }).then(() => {
                                        window.location.href = '${contextPath}/CategoryController?service=list';
                                    });
                                }
                            });
                        </script>
                    </c:if>

                    <!-- Phần hiển thị bảng -->
                    <div class="right-column">
                        <div class="filters-container">
                            <h2 class="section-title"><i class="fas fa-list"></i> Danh Sách Danh Mục</h2>

                            <div class="filter-box">
                                <label><i class="fas fa-filter"></i> Lọc theo:</label>
                                <select name="bulk-action-top" id="bulk-action-top" onchange="filterRedirect(this.value)">
                                    <option value="all" <c:if test="${not empty all}">selected</c:if>>Tất cả trạng thái</option>
                                    <option value="active" <c:if test="${not empty active}">selected</c:if>>Đang Hoạt Động</option>
                                    <option value="inactive" <c:if test="${not empty inactive}">selected</c:if>>Không Hoạt Động</option>
                                    <option value="newest" <c:if test="${not empty newest}">selected</c:if>>Mới nhất</option>
                                    <option value="oldest" <c:if test="${not empty oldest}">selected</c:if>>Cũ nhất</option>
                                    </select>
                                </div>
                            </div>

                            <div class="table-container">
                                <table class="category-table" id="categoryTable">
                                    <thead>
                                        <tr>
                                            <th width="28%">Tên</th>
                                            <th width="30%">Mô tả</th>
                                            <th width="20%">Trạng Thái</th>
                                            <th width="20%">Chức năng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:set var="currentPage" value="${empty param.page ? 1 : param.page}" />
                                    <c:set var="itemsPerPage" value="7" />
                                    <c:set var="startIndex" value="${(currentPage-1) * itemsPerPage}" />
                                    <c:set var="endIndex" value="${currentPage * itemsPerPage - 1}" />
                                    <c:set var="totalItems" value="${fn:length(categoryList)}" />

                                    <!-- FIX: Đảm bảo endIndex không vượt quá tổng số phần tử -->
                                    <c:if test="${endIndex >= totalItems}">
                                        <c:set var="endIndex" value="${totalItems - 1}" />
                                    </c:if>

                                    <c:forEach var="category" items="${categoryList}" varStatus="loop">
                                        <c:if test="${loop.index >= startIndex && loop.index <= endIndex}">
                                            <tr>
                                                <td style="display: none;">${category.id}</td>
                                                <td>${category.name}</td>
                                                <td>${category.description}</td>
                                                <c:if test="${category.status}">
                                                    <td><span class="status-active"><i class="fas fa-check-circle"></i> Đang hoạt động</span></td>
                                                </c:if>
                                                <c:if test="${!category.status}">
                                                    <td><span class="status-inactive"><i class="fas fa-times-circle"></i> Không hoạt động</span></td>
                                                </c:if>
                                                <td>
                                                    <div class="manage-buttons">
                                                        <button class="btn-edit" type="button"><i class="fas fa-edit"></i> Sửa</button>
                                                        <button id="delete-btn-${category.id}" class="btn-delete" type="button"><i class="fas fa-trash"></i> Xóa</button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination Controls -->
                        <c:set var="totalPages" value="${(totalItems + itemsPerPage - 1) / itemsPerPage}" />
                        <fmt:parseNumber var="totalPages" integerOnly="true" value="${totalPages}" />


                        <ul class="pagination" id="pagination">
                            <c:if test="${currentPage > 1}">
                                <c:url var="prevUrl" value="">
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'page'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="page" value="${currentPage - 1}" />
                                </c:url>
                                <li><a href="${prevUrl}"><i class="fas fa-chevron-left"></i></a></li>
                                    </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:url var="pageUrl" value="">
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'page'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="page" value="${i}" />
                                </c:url>
                                <li>
                                    <a href="${pageUrl}" <c:if test="${i == currentPage}">class="active"</c:if>>${i}</a>
                                    </li>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <c:url var="nextUrl" value="">
                                    <c:forEach items="${param}" var="entry">
                                        <c:if test="${entry.key != 'page'}">
                                            <c:param name="${entry.key}" value="${entry.value}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:param name="page" value="${currentPage + 1}" />
                                </c:url>
                                <li><a href="${nextUrl}"><i class="fas fa-chevron-right"></i></a></li>
                                    </c:if>
                        </ul>

                        <c:if test="${not empty successCheck}">
                            <script>
                                document.addEventListener("DOMContentLoaded", function () {
                                    var successCheck = ${successCheck};
                                    if (successCheck === 1) {
                                        Swal.fire({
                                            icon: 'success',
                                            title: 'Xóa Thành Công!',
                                            showConfirmButton: false,
                                            timer: 1500
                                        }).then(() => {
                                            window.location.href = '${contextPath}/CategoryController?service=list';
                                        });
                                    } else {
                                        Swal.fire({
                                            icon: 'error',
                                            title: 'Danh Mục Không Thể Xóa!',
                                            showConfirmButton: true
                                        }).then(() => {
                                            window.location.href = '${contextPath}/CategoryController?service=list';
                                        });
                                    }
                                });
                            </script>
                        </c:if>

                        <!-- Ghi chú -->
                        <div class="note">
                            <i class="fas fa-info-circle"></i> Danh mục không đính với linh kiện nào mới có thể xóa.
                            <a href="${contextPath}/PartController?service=list">Xem các linh kiện tại đây</a>.
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal chỉnh sửa -->
        <div class="modal-overlay" id="modalOverlay">
            <div class="modal-content">
                <span class="close-btn" id="closeModal">&times;</span>
                <h2 class="section-title"><i class="fas fa-edit"></i> Chỉnh Sửa Danh Mục</h2>
                <form id="detail-form" action="${contextPath}/CategoryController" method="post">
                    <input type="hidden" name="service" value="edit"/>
                    <input type="hidden" name="detail-id" id="detail-id"/>

                    <div class="form-group">
                        <label for="detail-name"><i class="fas fa-tag"></i> Tên</label>
                        <input type="text" id="detail-name" name="detail-name" placeholder="Tên danh mục" required/>
                    </div>

                    <div class="form-group">
                        <label for="detail-status"><i class="fas fa-toggle-on"></i> Trạng thái</label>
                        <select id="detail-status" name="detail-status">
                            <option value="active">Đang Hoạt Động</option>
                            <option value="inactive">Không Hoạt Động</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="detail-description"><i class="fas fa-info-circle"></i> Mô tả</label>
                        <textarea id="detail-description" name="detail-description" placeholder="Mô tả về danh mục (tùy chọn)"></textarea>
                    </div>

                    <button type="submit" class="btn-submit"><i class="fas fa-save"></i> Lưu thay đổi</button>
                    <button class="btn-cancel" type="button" id="cancelModal"><i class="fas fa-times"></i> Hủy</button>
                </form>
                <c:if test="${editCheck > 0}">
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            Swal.fire({
                                icon: 'success',
                                title: 'Đã Chỉnh Sửa Danh Mục!',
                                showConfirmButton: false,
                                timer: 1500
                            }).then(() => {
                                window.location.href = '${contextPath}/CategoryController?service=list';
                            });
                        });
                    </script>
                </c:if>
                <c:if test="${editCheck == 0}">
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            Swal.fire({
                                icon: 'error',
                                title: 'Có Lỗi Xảy Ra Hoặc Danh Mục Đã Tồn Tại!',
                                showConfirmButton: false,
                                timer: 1500
                            }).then(() => {
                                window.location.href = '${contextPath}/CategoryController?service=list';
                            });
                        });
                    </script>
                </c:if>
            </div>
        </div>

        <script>
            //Filter 
            function filterRedirect(selectedValue) {
                if (!selectedValue)
                    return;
                window.location.href = '${contextPath}/CategoryController?service=filter&filterValue=' + selectedValue;
            }

            //Delete a row
            document.querySelectorAll('.btn-delete').forEach(btn => {
                btn.addEventListener('click', function () {
                    Swal.fire({
                        title: 'Xác nhận xóa',
                        text: "Bạn có chắc chắn muốn xóa danh mục này không?",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Xóa',
                        cancelButtonText: 'Hủy'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            const rawId = this.id;
                            const categoryId = rawId.split('delete-btn-')[1];
                            window.location.href = '${contextPath}/CategoryController?service=delete&categoryId=' + categoryId;
                        }
                    });
                });
            });

            // Edit/Popup
            document.querySelectorAll('.btn-edit').forEach(btn => {
                btn.addEventListener('click', () => {
                    const row = btn.closest('tr');
                    const id = row.children[0].textContent.trim();
                    const name = row.children[1].textContent.trim();
                    const description = row.children[2].textContent.trim();
                    const status = row.children[3].textContent.trim().toLowerCase();

                    document.getElementById('detail-id').value = id;
                    document.getElementById('detail-name').value = name;
                    document.getElementById('detail-description').value = (description === '—') ? '' : description;
                    document.getElementById('detail-status').value = (status === 'active') ? 'active' : 'inactive';

                    document.getElementById('modalOverlay').style.display = 'flex';
                });
            });

            // Close modal
            document.getElementById('closeModal').addEventListener('click', () => {
                document.getElementById('modalOverlay').style.display = 'none';
            });
            document.getElementById('cancelModal').addEventListener('click', () => {
                document.getElementById('modalOverlay').style.display = 'none';
            });
            document.getElementById('modalOverlay').addEventListener('click', function (e) {
                if (e.target === this) {
                    this.style.display = 'none';
                }
            });
        </script>
    </body>
</html>