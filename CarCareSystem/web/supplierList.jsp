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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            :root {
                --primary: #3498db;
                --primary-dark: #2980b9;
                --secondary: #2c3e50;
                --success: #27ae60;
                --danger: #e74c3c;
                --warning: #f39c12;
                --light: #f8f9fa;
                --gray: #6c757d;
                --border: #dee2e6;
                --bg-light: #f5f7fa;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: var(--bg-light);
                color: var(--secondary);
                line-height: 1.6;
            }

            .container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 20px;
            }

            .header {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 1px solid var(--border);
            }

            .header h1 {
                color: var(--secondary);
                margin: 0;
                font-size: 28px;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .header h1 i {
                color: var(--primary);
                background-color: rgba(52, 152, 219, 0.1);
                padding: 10px;
                border-radius: 10px;
            }

            .header-controls {
                display: flex;
                gap: 15px;
                align-items: center;
                margin-top: 15px;
                flex-wrap: wrap;
            }

            .search-form {
                position: relative;
                flex-grow: 1;
                max-width: 400px;
            }

            .search-form i {
                position: absolute;
                left: 12px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--gray);
            }

            #searchInput {
                width: 100%;
                padding: 12px 15px 12px 40px;
                border: 1px solid var(--border);
                border-radius: 8px;
                font-size: 16px;
                transition: all 0.3s;
                background-color: white;
            }

            #searchInput:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
            }

            .btn {
                padding: 12px 20px;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                transition: all 0.3s;
                font-size: 15px;
                border: none;
            }

            .btn-add {
                background-color: var(--success);
                color: white;
                box-shadow: 0 4px 6px rgba(39, 174, 96, 0.2);
            }

            .btn-add:hover {
                background-color: #219653;
                transform: translateY(-2px);
                box-shadow: 0 6px 8px rgba(39, 174, 96, 0.3);
            }

            .filter-container {
                display: flex;
                gap: 10px;
                align-items: center;
                background: white;
                padding: 8px 15px;
                border-radius: 8px;
                border: 1px solid var(--border);
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .filter-label {
                font-weight: 600;
                color: var(--gray);
                white-space: nowrap;
            }

            .filter-select {
                padding: 8px 15px;
                border: none;
                border-radius: 6px;
                background-color: transparent;
                font-size: 15px;
                cursor: pointer;
                transition: all 0.3s;
                appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%236c757d' viewBox='0 0 16 16'%3E%3Cpath d='M1.646 4.646a.5.5 0 0 1 .708 0L8 10.293l5.646-5.647a.5.5 0 0 1 .708.708l-6 6a.5.5 0 0 1-.708 0l-6-6a.5.5 0 0 1 0-.708z'/%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 8px center;
                background-size: 14px;
                padding-right: 30px;
                font-weight: 500;
                color: var(--secondary);
            }

            .filter-select:hover {
                background-color: var(--light);
            }

            .filter-select:focus {
                outline: none;
                box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
            }

            .table-container {
                background-color: white;
                border-radius: 12px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
                overflow: hidden;
                margin-bottom: 30px;
            }

            #supplierTable {
                width: 100%;
                border-collapse: collapse;
                min-width: 1000px;
            }

            #supplierTable thead {
                background: linear-gradient(135deg, var(--secondary), #1a2530);
                color: white;
            }

            #supplierTable th {
                padding: 16px 20px;
                text-align: left;
                font-weight: 600;
                font-size: 16px;
            }

            #supplierTable tbody tr {
                border-bottom: 1px solid var(--border);
                transition: background-color 0.2s;
            }

            #supplierTable tbody tr:nth-child(even) {
                background-color: #fafafa;
            }

            #supplierTable tbody tr:hover {
                background-color: rgba(52, 152, 219, 0.08);
            }

            #supplierTable td {
                padding: 14px 20px;
                vertical-align: middle;
            }

            .supplier-logo {
                width: 60px;
                height: 60px;
                object-fit: contain;
                border-radius: 8px;
                background-color: #f8f9fa;
                padding: 5px;
                border: 1px solid var(--border);
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .action-group {
                display: flex;
                gap: 8px;
            }

            .action-btn {
                width: 36px;
                height: 36px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.3s;
                border: none;
                color: white;
                font-size: 14px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .action-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 6px rgba(0,0,0,0.15);
            }

            .view-btn {
                background-color: var(--primary);
            }

            .view-btn:hover {
                background-color: var(--primary-dark);
            }

            .edit-btn {
                background-color: var(--warning);
            }

            .edit-btn:hover {
                background-color: #e67e22;
            }

            .delete-btn {
                background-color: var(--danger);
            }

            .delete-btn:hover {
                background-color: #c0392b;
            }

            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                align-items: center;
                justify-content: center;
                backdrop-filter: blur(3px);
            }

            .modal-content {
                background-color: white;
                width: 90%;
                max-width: 700px;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
                transform: scale(0.95);
                animation: modalOpen 0.3s forwards;
            }

            @keyframes modalOpen {
                to {
                    transform: scale(1);
                    opacity: 1;
                }
            }

            .modal-header {
                padding: 20px;
                background: linear-gradient(135deg, var(--secondary), #1a2530);
                color: white;
                position: relative;
            }

            .modal-header h2 {
                margin: 0;
                font-size: 22px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .close {
                position: absolute;
                right: 20px;
                top: 20px;
                font-size: 28px;
                font-weight: bold;
                color: white;
                cursor: pointer;
                transition: all 0.3s;
            }

            .close:hover {
                transform: rotate(90deg);
                color: var(--danger);
            }

            .modal-body {
                display: flex;
                padding: 25px;
                gap: 25px;
            }

            .modal-left {
                flex: 0 0 150px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .modal-left img {
                width: 100%;
                max-height: 150px;
                object-fit: contain;
                border-radius: 8px;
                border: 1px solid var(--border);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                background-color: white;
                padding: 10px;
            }

            .modal-right {
                flex: 1;
            }

            .info-group {
                margin-bottom: 18px;
            }

            .info-group label {
                display: block;
                font-weight: 600;
                color: var(--secondary);
                margin-bottom: 8px;
                font-size: 15px;
            }

            .info-group p {
                margin: 0;
                padding: 12px;
                background-color: #f8f9fa;
                border-radius: 8px;
                min-height: 22px;
                font-size: 16px;
                border: 1px solid var(--border);
                box-shadow: inset 0 1px 2px rgba(0,0,0,0.05);
            }

            .modal-footer {
                padding: 15px 25px;
                background-color: #f8f9fa;
                text-align: right;
                border-top: 1px solid var(--border);
            }

            /* Pagination Styles */
            .pagination-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 20px;
                background-color: white;
                border-top: 1px solid var(--border);
                border-radius: 0 0 12px 12px;
            }

            .pagination-info {
                font-size: 14px;
                color: var(--gray);
            }

            .pagination {
                display: flex;
                gap: 5px;
            }

            .page-btn {
                width: 36px;
                height: 36px;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 1px solid var(--border);
                border-radius: 8px;
                background-color: white;
                color: var(--secondary);
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
            }

            .page-btn:hover:not(.active):not(.disabled) {
                background-color: var(--light);
                border-color: var(--primary);
                color: var(--primary);
            }

            .page-btn.active {
                background-color: var(--primary);
                border-color: var(--primary);
                color: white;
            }

            .page-btn.disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }

            /* Responsive */
            @media (max-width: 992px) {
                .header {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .header-controls {
                    width: 100%;
                }

                .filter-container {
                    width: 100%;
                    justify-content: flex-end;
                }
            }

            @media (max-width: 768px) {
                .modal-body {
                    flex-direction: column;
                }

                .modal-left {
                    flex: 0 0 auto;
                    margin-bottom: 20px;
                }

                .pagination-container {
                    flex-direction: column;
                    gap: 15px;
                }
            }

            @media (max-width: 576px) {
                .header h1 {
                    font-size: 24px;
                }

                .filter-container {
                    flex-wrap: wrap;
                }

                .search-form {
                    max-width: 100%;
                }

                .action-group {
                    flex-wrap: wrap;
                    justify-content: center;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="header_emp.jsp"></jsp:include>

            <div class="container">
                <!-- Header -->
                <div class="header">
                    <h1><i class="fas fa-truck-loading"></i> Danh sách nhà cung cấp</h1>
                    <div class="header-controls">
                        <div class="filter-container">
                            <span class="filter-label">Sắp xếp:</span>
                            <select name="sort" id="sortSelect" class="filter-select" onchange="filterRedirect(this.value)">
                                <option value="oldest" <c:if test="${not empty filteredValue and filteredValue eq 'oldest'}">selected</c:if>>
                                    Cũ nhất
                                </option>
                                <option value="newest" <c:if test="${not empty filteredValue and filteredValue eq 'newest'}">selected</c:if>>
                                    Mới nhất
                                </option>
                            </select>
                        </div>

                        <form class="search-form" action="${contextPath}/SupplierController" method="get">
                        <i class="fas fa-search"></i>
                        <input type="hidden" name="service" value="search" />
                        <input
                            type="text"
                            id="searchInput"
                            name="search"
                            placeholder="Tìm theo tên nhà cung cấp..."
                            <c:if test="${not empty searchedValue}">value="${searchedValue}"</c:if>
                                />
                        </form>

                        <a href="${contextPath}/supplierDetail.jsp" class="btn btn-add">
                        <i class="fas fa-plus"></i> Thêm mới
                    </a>
                </div>
            </div>

            <!-- Table -->
            <div class="table-container">
                <table id="supplierTable">
                    <thead>
                        <tr>
                            <th>Nhà cung cấp</th>
                            <th>Mô tả</th>
                            <th>Logo</th>
                            <th>Email</th>
                            <th>Chức năng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="supplier" items="${supplierList}">
                            <tr>
                                <td>${supplier.name}</td>
                                <td>${supplier.description}</td>
                                <td>
                                    <img src="image/${supplier.logo}" class="supplier-logo" alt="${supplier.name}"/>
                                </td>
                                <td>${supplier.email}</td>
                                <td>
                                    <div class="action-group">
                                        <button class="action-btn view-btn" 
                                                data-id="${supplier.id}"
                                                data-name="${supplier.name}"
                                                data-description="${supplier.description}"
                                                data-logo="image/${supplier.logo}"
                                                data-email="${supplier.email}"
                                                data-phone="${supplier.phone}"
                                                data-address="${supplier.address}"
                                                title="Xem chi tiết">
                                            <i class="fas fa-eye"></i>
                                        </button>

                                        <button class="action-btn edit-btn" 
                                                data-id="${supplier.id}"
                                                title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </button>

                                        <button class="action-btn delete-btn" 
                                                data-id="${supplier.id}"
                                                title="Xóa">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </div>
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
                                        text: 'Không thể xóa nhà cung cấp này',
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

                <!-- Phân trang động -->
                <div class="pagination-container">
                    <div class="pagination-info" id="paginationInfo">
                        <!-- Thông tin sẽ được cập nhật bởi JavaScript -->
                    </div>
                    <div id="pagination" class="pagination">
                        <!-- Các nút phân trang sẽ được tạo bởi JavaScript -->
                    </div>
                </div>
            </div>

            <!-- View Modal -->
            <div id="viewModal" class="modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2><i class="fas fa-building"></i> Thông tin nhà cung cấp</h2>
                        <span class="close">&times;</span>
                    </div>
                    <div class="modal-body">
                        <div class="modal-left">
                            <img id="modalLogo" src="" alt="Logo Nhà cung cấp" />
                        </div>
                        <div class="modal-right">
                            <div class="info-group">
                                <label>Tên nhà cung cấp</label>
                                <p id="modalName"></p>
                            </div>

                            <div class="info-group">
                                <label>Mô tả</label>
                                <p id="modalDescription"></p>
                            </div>

                            <div class="info-group">
                                <label>Email</label>
                                <p id="modalEmail"></p>
                            </div>

                            <div class="info-group">
                                <label>Điện thoại</label>
                                <p id="modalPhone"></p>
                            </div>

                            <div class="info-group">
                                <label>Địa chỉ</label>
                                <p id="modalAddress"></p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="modalEdit" class="btn btn-edit">
                            <i class="fas fa-edit"></i> Chỉnh sửa
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const modal = document.getElementById('viewModal');
                const spanClose = modal.querySelector('.close');
                const btnViews = document.querySelectorAll('.view-btn');
                const btnEdit = document.querySelectorAll('.edit-btn');
                const btnDelete = document.querySelectorAll('.delete-btn');

                const modalLogo = document.getElementById('modalLogo');
                const modalName = document.getElementById('modalName');
                const modalDescription = document.getElementById('modalDescription');
                const modalEmail = document.getElementById('modalEmail');
                const modalPhone = document.getElementById('modalPhone');
                const modalAddress = document.getElementById('modalAddress');
                const modalEditButton = document.getElementById('modalEdit');

                // Xử lý sự kiện xem chi tiết
                btnViews.forEach(function (btn) {
                    btn.addEventListener('click', function () {
                        const id = this.getAttribute('data-id');
                        modalLogo.src = this.getAttribute('data-logo') || '';
                        modalName.textContent = this.getAttribute('data-name') || '';
                        modalDescription.textContent = this.getAttribute('data-description') || '';
                        modalEmail.textContent = this.getAttribute('data-email') || '';
                        modalPhone.textContent = this.getAttribute('data-phone') || '';
                        modalAddress.textContent = this.getAttribute('data-address') || '';

                        modalEditButton.onclick = function () {
                            window.location.href = '${contextPath}/SupplierController?service=edit&action=load&id=' + id;
                        };

                        modal.style.display = 'flex';
                        document.body.style.overflow = 'hidden';
                    });
                });

                // Xử lý sự kiện chỉnh sửa
                btnEdit.forEach(function (btn) {
                    btn.addEventListener('click', function () {
                        const id = this.getAttribute('data-id');
                        window.location.href = '${contextPath}/SupplierController?service=edit&action=load&id=' + id;
                    });
                });

                // Xử lý sự kiện xóa
                btnDelete.forEach(function (btn) {
                    btn.addEventListener('click', function () {
                        const id = this.getAttribute('data-id');

                        Swal.fire({
                            title: 'Xác nhận xóa',
                            text: "Bạn có chắc chắn muốn xóa nhà cung cấp này?",
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#e74c3c',
                            cancelButtonColor: '#6c757d',
                            confirmButtonText: 'Xóa',
                            cancelButtonText: 'Hủy',
                            customClass: {
                                popup: 'custom-swal'
                            }
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.href = '${contextPath}/SupplierController?service=delete&id=' + id;
                            }
                        });
                    });
                });

                // Đóng modal
                spanClose.addEventListener('click', function () {
                    modal.style.display = 'none';
                    document.body.style.overflow = 'auto';
                });

                // Đóng modal khi click bên ngoài
                window.addEventListener('click', function (event) {
                    if (event.target === modal) {
                        modal.style.display = 'none';
                        document.body.style.overflow = 'auto';
                    }
                });

                // ================ PHÂN TRANG ================
                const rowsPerPage = 7;
                const table = document.getElementById('supplierTable');
                const tbody = table.tBodies[0];
                const rows = Array.from(tbody.querySelectorAll('tr'));
                const pageCount = Math.ceil(rows.length / rowsPerPage);
                let currentPage = 1;
                const paginationInfo = document.getElementById('paginationInfo');
                const paginationContainer = document.getElementById('pagination');

                function renderTable(page) {
                    const start = (page - 1) * rowsPerPage;
                    const end = Math.min(start + rowsPerPage, rows.length);

                    // Ẩn tất cả các hàng
                    rows.forEach(row => row.style.display = 'none');

                    // Hiển thị các hàng trong trang hiện tại
                    for (let i = start; i < end; i++) {
                        rows[i].style.display = '';
                    }

                    // Cập nhật thông tin phân trang
                    if (paginationInfo) {
                        paginationInfo.textContent = `Hiển thị ${start + 1} - ${end} của ${rows.length} nhà cung cấp`;
                    }
                }

                function renderPagination() {
                    paginationContainer.innerHTML = '';

                    // Nút Previous
                    const prevBtn = document.createElement('button');
                    prevBtn.className = 'page-btn';
                    prevBtn.innerHTML = '<i class="fas fa-chevron-left"></i>';
                    prevBtn.disabled = currentPage === 1;
                    if (prevBtn.disabled)
                        prevBtn.classList.add('disabled');
                    prevBtn.addEventListener('click', () => changePage(currentPage - 1));
                    paginationContainer.appendChild(prevBtn);

                    // Các nút trang
                    for (let i = 1; i <= pageCount; i++) {
                        const pageBtn = document.createElement('button');
                        pageBtn.className = 'page-btn';
                        pageBtn.textContent = i;
                        if (i === currentPage)
                            pageBtn.classList.add('active');
                        pageBtn.addEventListener('click', () => changePage(i));
                        paginationContainer.appendChild(pageBtn);
                    }

                    // Nút Next
                    const nextBtn = document.createElement('button');
                    nextBtn.className = 'page-btn';
                    nextBtn.innerHTML = '<i class="fas fa-chevron-right"></i>';
                    nextBtn.disabled = currentPage === pageCount;
                    if (nextBtn.disabled)
                        nextBtn.classList.add('disabled');
                    nextBtn.addEventListener('click', () => changePage(currentPage + 1));
                    paginationContainer.appendChild(nextBtn);
                }

                function changePage(page) {
                    if (page < 1 || page > pageCount)
                        return;
                    currentPage = page;
                    renderTable(page);
                    renderPagination();
                }

                // Khởi tạo phân trang
                if (rows.length > 0) {
                    renderTable(currentPage);
                    renderPagination();
                } else {
                    paginationInfo.textContent = "Không có nhà cung cấp nào";
                }
                // ================ END PHÂN TRANG ================
            });

            function filterRedirect(selectedValue) {
                if (!selectedValue) {
                    return;
                }
                window.location.href = '${contextPath}/SupplierController?service=filter&filterValue=' + selectedValue;
            }
        </script>
    </body>
</html>