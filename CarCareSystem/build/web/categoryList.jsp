<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Categories – Active Page Highlighted</title>
        <link rel="stylesheet" href="css/categoryList.css"/>
        <script src="${contextPath}/js/categoryList.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body>
        <div class="wrap">
            <div class="heading">
                <h1>Categories</h1>
                <div class="search-box">
                    <form>
                        <input type="search" name="search" placeholder="Search Categories" <c:if test="${not empty categorySearch}">value="${categorySearch}"</c:if>/>
                            <input type="hidden" name="service" value="search"/>
                            <button type="submit">Search Categories</button>
                        </form>
                    </div>
                </div>
                
                <div class="main-columns">
                    <!--ADD-->
                    <div class="left-column">
                        <h2>Add New Category</h2>
                        <form action="${contextPath}/CategoryController" method="post">
                        <label for="cat-name">Name</label>
                        <input type="text" id="cat-name" name="name" placeholder="Tên category" required/>

                        <label for="cat-status">Status</label>
                        <select id="cat-status" name="status">
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>

                        <label for="cat-description">Description</label>
                        <textarea id="cat-description" name="description" placeholder="Mô tả (tùy chọn)" required></textarea>
                        <input type="hidden" name="service" value="add"/>
                        <button type="submit">Add New Category</button>
                    </form>
                </div>
                <c:if test="${not empty checkError}">
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            var checkError = `${checkError}`;
                            if (checkError === 'success') {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Thêm Category Thành Công!',
                                    showConfirmButton: false,
                                    timer: 1500
                                }).then(() => {
                                    window.location.href = '${contextPath}/CategoryController?service=list';
                                });
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Category Đã Tồn Tại!',
                                    showConfirmButton: true
                                }).then(() => {
                                    window.location.href = '${contextPath}/CategoryController?service=list';
                                });
                            }
                        });
                    </script>
                </c:if>

                <!--TABLE-->
                <div class="right-column">
                    
                    <div class="bulk-actions">
                        <select name="bulk-action-top" id="bulk-action-top" onchange="filterRedirect(this.value)">
                            <option value="all" <c:if test="${not empty all}">selected</c:if>>Tất cả trạng thái</option>
                            <option value="active" <c:if test="${not empty active}">selected</c:if>>Active</option>
                            <option value="inactive" <c:if test="${not empty inactive}">selected</c:if>>Inactive</option>
                            <option value="newest" <c:if test="${not empty newest}">selected</c:if>>Newest</option>
                            <option value="oldest" <c:if test="${not empty oldest}">selected</c:if>>Oldest</option>
                            </select>
                        </div>

                        <table class="category-table" id="categoryTable">
                            <thead>
                                <tr>
                                    <th width="28%">Name</th>
                                    <th width="30%">Description</th>
                                    <th width="20%">Status</th>
                                    <th width="20%">Manage</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="category" items="${categoryList}">
                                <tr>
                                    <td style="display: none;">${category.id}</td>
                                    <td>${category.name}</td>
                                    <td>${category.description}</td>
                                    <c:if test="${category.status}">
                                        <td>Active</td>
                                    </c:if>
                                    <c:if test="${!category.status}">
                                        <td>Inactive</td>
                                    </c:if>
                                    <td>
                                        <div class="manage-buttons">
                                            <button class="btn-edit" type="button">Edit</button>
                                            <button id="delete-btn-${category.id}" class="btn-delete" type="button">Delete</button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Pagination Controls -->
                    <ul class="pagination" id="pagination"></ul>

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
                                        title: 'Category Không Thể Xóa!',
                                        showConfirmButton: true
                                    }).then(() => {
                                        window.location.href = '${contextPath}/CategoryController?service=list';
                                    });
                                }
                            });
                        </script>
                    </c:if>

                    <!-- Note bên dưới bảng -->
                    <div class="note">
                        Category không đính với linh kiện nào mới có thể xóa.
                        <a href="#">Xem các linh kiện tại đây</a>.
                    </div>
                </div>
            </div>
        </div>

        <!--EDIT-->
        <div class="modal-overlay" id="modalOverlay">
            <div class="modal-content">
                <span class="close-btn" id="closeModal">&times;</span>
                <h2>Category Detail</h2>
                <form id="detail-form" action="${contextPath}/CategoryController" method="post">
                    <input type="hidden" name="service" value="edit"/>

                    <input type="hidden" name="detail-id" id="detail-id"/>

                    <label for="detail-name">Name</label>
                    <input type="text" id="detail-name" name="detail-name" placeholder="Tên category" required/>

                    <label for="detail-status">Status</label>
                    <select id="detail-status" name="detail-status">
                        <option value="active">Active</option>
                        <option value="inactive">Inactive</option>
                    </select>

                    <label for="detail-description">Description</label>
                    <textarea id="detail-description" name="detail-description" placeholder="Mô tả (tùy chọn)" required></textarea>

                    <button type="submit">Save Changes</button>
                    <button class="btn-cancel" type="button" id="cancelModal">Cancel</button>
                </form>
                <c:if test="${editCheck > 0}">
                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            Swal.fire({
                                icon: 'success',
                                title: 'Đã Chỉnh Sửa Category!',
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
                    const ok = confirm('Bạn có chắc chắn muốn xóa dữ liệu này không?');
                    if (ok) {
                        const rawId = this.id;                   // e.g. "delete-btn-123"
                        const categoryId = rawId.split('delete-btn-')[1];
                        
                        window.location.href = '${contextPath}/CategoryController?service=delete&categoryId=' + categoryId;
                    }
                });
            });

            // ===== Xử lý Edit/Popup =====
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
