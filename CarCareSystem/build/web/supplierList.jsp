<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh sách nhà cung cấp – Car Care System</title>
        <link rel="stylesheet" href="${contextPath}/css/supplierList.css" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>

        <jsp:include page="header_emp.jsp"></jsp:include>

            <div class="container">
                <!-- Header -->
                <div class="header">
                    <h1>Danh sách nhà cung cấp</h1>
                    <div class="search-box">

                        <!-- Dropdown filter -->
                        <select name="sort" id="sortSelect" onchange="filterRedirect(this.value)">
                            <option value="oldest" <c:if test="${not empty filteredValue and filteredValue eq 'oldest'}">selected</c:if>>
                                Cũ nhất
                            </option>
                            <option value="newest" <c:if test="${not empty filteredValue and filteredValue eq 'newest'}">selected</c:if>>
                                Mới nhất
                            </option>
                        </select>

                        <form action="${contextPath}/SupplierController" method="get">
                        <input type="hidden" name="service" value="search" />
                        <input
                            type="text"
                            id="searchInput"
                            name="search"
                            placeholder="Tìm kiếm theo tên..."
                            <c:if test="${not empty searchedValue}">value="${searchedValue}"</c:if>
                                />
                        </form>
                        <a href="${contextPath}/supplierDetail.jsp" class="btn-add">
                        Thêm
                    </a>
                </div>
            </div>

            <!-- Table -->
            <div class="table-container">
                <table id="supplierTable">
                    <thead>
                        <tr>
                            <th style="width: 180px;">Nhà cung cấp</th>
                            <th style="width: 250px;">Mô tả</th>
                            <th style="width: 80px;">Logo</th>
                            <th>Email</th>
                            <th style="width: 180px;">Chức năng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="supplier" items="${supplierList}">
                            <tr>
                                <td>${supplier.name}</td>
                                <td>${supplier.description}</td>
                                <td>
                                    <img src="image/${supplier.logo}" class="supplier-logo" />
                                </td>
                                <td>${supplier.email}</td>
                                <td class="manage-cell">
                                    <button
                                        class="btn-view"
                                        data-id="${supplier.id}"
                                        data-name="${supplier.name}"
                                        data-description="${supplier.description}"
                                        data-logo="image/${supplier.logo}"
                                        data-email="${supplier.email}"
                                        data-phone="${supplier.phone}"
                                        data-address="${supplier.address}">
                                        View
                                    </button>
                                    <button class="btn-edit" data-id="${supplier.id}">
                                        Edit
                                    </button>
                                    <button class="btn-delete" data-id="${supplier.id}">
                                        Xóa
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
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
                                        window.location.href = '${contextPath}/SupplierController?service=list';
                                    });
                                } else {
                                    Swal.fire({
                                        icon: 'error',
                                        title: 'Có Lỗi Xảy Ra!',
                                        showConfirmButton: true
                                    }).then(() => {
                                        window.location.href = '${contextPath}/SupplierController?service=list';
                                    });
                                }
                            });
                        </script>
                    </c:if>
                    </tbody>
                </table>
                <div id="pagination" class="pagination"></div>

            </div>

            <!-- View Modal -->
            <div id="viewModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <h2>Thông tin nhà cung cấp</h2>
                    <div class="modal-body">
                        <div class="modal-left">
                            <img id="modalLogo" src="" alt="Logo Nhà cung cấp" />
                        </div>
                        <div class="modal-right">
                            <p><strong>Tên:</strong> <span id="modalName"></span></p>
                            <p>
                                <strong>Mô tả:</strong><br />
                                <textarea id="modalDescription" readonly></textarea>
                            </p>
                            <p><strong>Email:</strong> <span id="modalEmail"></span></p>
                            <p><strong>Điện thoại:</strong> <span id="modalPhone"></span></p>
                            <p><strong>Địa chỉ:</strong> <span id="modalAddress"></span></p>
                        </div>
                    </div>
                    <button id="modalEdit" class="btn-edit">Edit</button>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const modal = document.getElementById('viewModal');
                const spanClose = modal.querySelector('.close');
                const btnViews = document.querySelectorAll('.btn-view');
                const btnEdit = document.querySelectorAll('.btn-edit');
                const btnDelete = document.querySelectorAll('.btn-delete');

                const modalLogo = document.getElementById('modalLogo');
                const modalName = document.getElementById('modalName');
                const modalDescription = document.getElementById('modalDescription');
                const modalEmail = document.getElementById('modalEmail');
                const modalPhone = document.getElementById('modalPhone');
                const modalAddress = document.getElementById('modalAddress');
                const modalEditButton = document.getElementById('modalEdit');

                btnViews.forEach(function (btn) {
                    btn.addEventListener('click', function () {
                        const id = this.getAttribute('data-id');
                        modalLogo.src = this.getAttribute('data-logo') || '';
                        modalName.textContent = this.getAttribute('data-name') || '';
                        modalDescription.value = this.getAttribute('data-description') || '';
                        modalEmail.textContent = this.getAttribute('data-email') || '';
                        modalPhone.textContent = this.getAttribute('data-phone') || '';
                        modalAddress.textContent = this.getAttribute('data-address') || '';

                        modalEditButton.onclick = function () {
                            window.location.href = '${contextPath}/SupplierController?service=edit&action=load&id=' + id;
                        };

                        modal.style.display = 'flex';
                    });
                });

                btnEdit.forEach(function (btn) {
                    btn.addEventListener('click', function () {
                        const id = this.getAttribute('data-id');
                        window.location.href = '${contextPath}/SupplierController?service=edit&action=load&id=' + id;
                    });
                });

                btnDelete.forEach(function (btn) {
                    btn.addEventListener('click', function () {
                        const id = this.getAttribute('data-id');
                        if (confirm('Bạn có chắc chắn muốn xóa dữ liệu này không?')) {
                            window.location.href = '${contextPath}/SupplierController?service=delete&id=' + id;
                        }
                    });
                });

                spanClose.addEventListener('click', function () {
                    modal.style.display = 'none';
                });

                window.addEventListener('click', function (event) {
                    if (event.target === modal) {
                        modal.style.display = 'none';
                    }
                });
            });

            function filterRedirect(selectedValue) {
                if (!selectedValue) {
                    return;
                }
                window.location.href = '${contextPath}/SupplierController?service=filter&filterValue=' + selectedValue;
            }
        </script>
        <script src="js/supplierList.js"></script>
    </body>
</html>
