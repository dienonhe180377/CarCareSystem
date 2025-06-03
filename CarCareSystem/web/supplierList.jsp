<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh sách nhà cung cấp – Car Care System</title>
        <link rel="stylesheet" href="${contextPath}/css/supplierList.css"/>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <div class="container">
            <!-- Header -->
            <div class="header">
                <h1>Danh sách nhà cung cấp</h1>
                <div class="search-box">
                    <form action="${contextPath}/SupplierController">
                        <input type="hidden" name="service" value="search" />
                        <input type="text"
                               id="searchInput" 
                               name="search" 
                               placeholder="Tìm kiếm theo tên..." 
                               <c:if test="${not empty searchedValue}">value="${searchedValue}"</c:if>
                                   />
                               <span class="icon">&#128269;</span>
                        </form>
                    </div>
                </div>

                
                <div class="table-container">
                    <table id="supplierTable">
                        <thead>
                            <tr>
                                <th style="width: 180px;">Supplier</th>
                                <th style="width: 250px;">Description</th>
                                <th style="width: 80px;">Logo</th>
                                <th>Email</th>
                                <th style="width: 180px;">Manage</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="supplier" items="${supplierList}">
                            <tr>
                                <td>${supplier.name}</td>
                                <td>${supplier.description}</td>
                                <td>
                                    <img src="image/${supplier.logo}" class="supplier-logo"/>
                                </td>
                                <td>${supplier.email}</td>
                                <td class="manage-cell">
                                    
                                    <button 
                                        class="btn-view"
                                        data-name="${supplier.name}"
                                        data-description="${supplier.description}"
                                        data-logo="image/${supplier.logo}"
                                        data-email="${supplier.email}"
                                        data-phone="${supplier.phone}"
                                        data-address="${supplier.address}"
                                        >
                                        View
                                    </button>
                                    <button class="btn-edit" data-id="1"> Edit </button>
                                    <button class="btn-delete"data-id="${supplier.id}">Delete </button>

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
            </div>

            <!--View-->
            <div id="viewModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <h2>Thông tin nhà cung cấp</h2>
                    <div class="modal-body">
                        <!-- Cột trái: logo -->
                        <div class="modal-left">
                            <img id="modalLogo" src="" alt="Logo Nhà cung cấp" />
                        </div>
                        <!-- Cột phải: các thông tin -->
                        <div class="modal-right">
                            <!-- Bạn cũng có thể hiển thị ID nếu muốn: -->
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
                const btnDelete = document.querySelectorAll('.btn-delete');

                // Các phần tử trong modal để đổ dữ liệu
                const modalLogo = document.getElementById('modalLogo');
                const modalName = document.getElementById('modalName');
                const modalDescription = document.getElementById('modalDescription');
                const modalEmail = document.getElementById('modalEmail');
                const modalPhone = document.getElementById('modalPhone');
                const modalAddress = document.getElementById('modalAddress');
                const modalEditButton = document.getElementById('modalEdit');

                // Khi bấm vào bất kỳ nút "View" ở hàng nào
                btnViews.forEach(function (btn) {
                    btn.addEventListener('click', function (event) {
                        // Lấy data-* từ chính button
                        const name = this.getAttribute('data-name');
                        const description = this.getAttribute('data-description');
                        const logoUrl = this.getAttribute('data-logo');
                        const email = this.getAttribute('data-email');
                        const phone = this.getAttribute('data-phone');
                        const address = this.getAttribute('data-address');

                        // Đổ dữ liệu vào modal
                        modalLogo.src = logoUrl || '';
                        modalName.textContent = name || '';
                        modalDescription.value = description || '';
                        modalEmail.textContent = email || '';
                        modalPhone.textContent = phone || '';
                        modalAddress.textContent = address || '';


                        modalEditButton.onclick = function () {
                           
                        };

                        // Hiển thị modal
                        modal.style.display = 'flex';
                    });
                });

                //Khi bam vao nut delete o hang bat ky
                btnDelete.forEach(function (btn) {
                    btn.addEventListener('click', function (event) {
                        
                        const id = this.getAttribute('data-id');
                        const ok = confirm('Bạn có chắc chắn muốn xóa dữ liệu này không?');
                        if (ok) {
                            window.location.href = '${contextPath}/SupplierController?service=delete&id=' + id;
                        }
                    });
                });

                // Khi bấm vào dấu "×" sẽ đóng modal
                spanClose.addEventListener('click', function () {
                    modal.style.display = 'none';
                });

                // Khi bấm ra ngoài vùng modal-content, cũng đóng modal
                window.addEventListener('click', function (event) {
                    if (event.target === modal) {
                        modal.style.display = 'none';
                    }
                });
            });
        </script>
    </body>
</html>
