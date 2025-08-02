<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setTimeZone value="Asia/Ho_Chi_Minh"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Campaign</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            /* CSS giữ nguyên như cũ */
            :root {
                --primary-blue: #add8e6;
                --secondary-blue: #87ceeb;
                --light-blue: #e6f3ff;
                --dark-blue: #4682b4;
                --accent-blue: #b0e0e6;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #f0f8ff 0%, #e6f3ff 100%);
                min-height: 100vh;
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: rgba(255, 255, 255, 0.95);
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(173, 216, 230, 0.2);
                overflow: hidden;
                backdrop-filter: blur(10px);
                border: 2px solid var(--accent-blue);
            }

            .header {
                background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
                color: #333;
                padding: 30px;
                text-align: center;
                box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
            }

            .header h1 {
                font-size: 2.5rem;
                margin-bottom: 10px;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
                font-weight: bold;
            }

            .content {
                padding: 30px;
            }

            .form-section {
                background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 30px;
                box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
                border: 2px solid var(--accent-blue);
            }

            .form-section h2 {
                color: var(--dark-blue);
                margin-bottom: 20px;
                font-size: 1.8rem;
                position: relative;
                padding-bottom: 10px;
                font-weight: bold;
            }

            .form-section h2::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 50px;
                height: 3px;
                background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
                border-radius: 2px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-row {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
            }

            .form-row .form-group {
                flex: 1;
                min-width: 200px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: var(--dark-blue);
                font-size: 0.9rem;
            }

            input[type="text"],
            input[type="date"],
            input[type="file"],
            textarea,
            select {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid var(--accent-blue);
                border-radius: 10px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: #fafafa;
            }

            input[type="text"]:focus,
            input[type="date"]:focus,
            input[type="file"]:focus,
            textarea:focus,
            select:focus {
                outline: none;
                border-color: var(--primary-blue);
                background: white;
                box-shadow: 0 0 0 3px rgba(173, 216, 230, 0.25);
                transform: translateY(-1px);
            }

            textarea {
                resize: vertical;
                min-height: 100px;
            }

            .checkbox-group {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            input[type="checkbox"] {
                width: 20px;
                height: 20px;
                accent-color: var(--primary-blue);
            }

            .btn {
                padding: 12px 25px;
                border: none;
                border-radius: 25px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                text-decoration: none;
                display: inline-block;
                text-align: center;
                box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
            }

            .btn-primary {
                background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
                color: #333;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, var(--secondary-blue), var(--dark-blue));
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(173, 216, 230, 0.4);
                color: white;
            }

            .btn-secondary {
                background: #6c757d;
                color: white;
                margin-left: 10px;
            }

            .btn-secondary:hover {
                background: #5a6268;
                transform: translateY(-2px);
            }

            .btn-danger {
                background: linear-gradient(135deg, #dc3545, #c82333);
                color: white;
                padding: 8px 15px;
                font-size: 0.9rem;
            }

            .btn-danger:hover {
                background: linear-gradient(135deg, #c82333, #a71e2a);
                transform: translateY(-1px);
            }

            .btn-edit {
                background: linear-gradient(135deg, var(--accent-blue), var(--primary-blue));
                color: #333;
                padding: 8px 15px;
                font-size: 0.9rem;
                margin-right: 5px;
            }

            .btn-edit:hover {
                background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
                transform: translateY(-1px);
            }

            .btn-cancel {
                background: #6c757d;
                color: white;
                margin-left: 10px;
            }

            .btn-cancel:hover {
                background: #5a6268;
                transform: translateY(-2px);
            }

            .table-section {
                background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
                border-radius: 15px;
                padding: 25px;
                box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
                border: 2px solid var(--accent-blue);
            }

            .table-container {
                overflow-x: auto;
                margin-top: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 0.9rem;
            }

            th {
                background: linear-gradient(135deg, var(--dark-blue), var(--secondary-blue));
                color: white;
                padding: 15px 10px;
                text-align: left;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            th:first-child {
                border-top-left-radius: 10px;
            }

            th:last-child {
                border-top-right-radius: 10px;
            }

            td {
                padding: 12px 10px;
                border-bottom: 1px solid var(--accent-blue);
                vertical-align: middle;
            }

            tr:hover {
                background: var(--light-blue);
                transform: scale(1.01);
                transition: all 0.2s ease;
            }

            .status-active {
                background: linear-gradient(135deg, #28a745, #20c997);
                color: white;
                padding: 4px 8px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
            }

            .status-inactive {
                background: linear-gradient(135deg, #dc3545, #c82333);
                color: white;
                padding: 4px 8px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
            }

            .no-data {
                text-align: center;
                padding: 40px;
                color: var(--dark-blue);
                font-style: italic;
            }

            .actions {
                display: flex;
                gap: 5px;
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 10px;
                font-weight: 600;
            }

            .alert-success {
                background: linear-gradient(135deg, #d4edda, #c3e6cb);
                color: #155724;
                border: 2px solid #c3e6cb;
            }

            .alert-error {
                background: linear-gradient(135deg, #f8d7da, #f5c6cb);
                color: #721c24;
                border: 2px solid #f5c6cb;
            }

            .image-preview {
                max-width: 100px;
                max-height: 100px;
                border-radius: 5px;
                border: 1px solid var(--accent-blue);
            }

            .current-image {
                margin-top: 10px;
            }

            .current-image img {
                max-width: 150px;
                max-height: 150px;
                border-radius: 10px;
                border: 2px solid var(--accent-blue);
            }
        </style>
    </head>
    <body>
        <jsp:include page="/header_emp.jsp"></jsp:include>
        <div class="container">
            <div class="header">
                <h1><i class="fas fa-bullhorn"></i> Quản lý Campaign</h1>
            </div>

            <div class="content">
                <!-- ✅ HIỂN THỊ THÔNG BÁO -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> ${successMessage}
                    </div>
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                    </div>
                </c:if>

                <!-- ✅ FORM THÊM/SỬA CAMPAIGN -->
                <div class="form-section">
                    <h2>
                        <c:choose>
                            <c:when test="${isEditing}">
                                <i class="fas fa-edit"></i> Sửa Campaign
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-plus"></i> Thêm Campaign Mới
                            </c:otherwise>
                        </c:choose>
                    </h2>

                    <!-- ✅ FORM VỚI ENCTYPE CHO FILE UPLOAD -->
                    <form method="post" action="campaign" enctype="multipart/form-data">
                        <!-- ✅ HIDDEN FIELDS CHO EDIT -->
                        <c:if test="${isEditing}">
                            <input type="hidden" name="service" value="edit">
                            <input type="hidden" name="id" value="${campaign.id}">
                            <input type="hidden" name="currentImg" value="${campaign.img}">
                            <input type="hidden" name="currentThumbnail" value="${campaign.thumbnail}">
                        </c:if>
                        <c:if test="${not isEditing}">
                            <input type="hidden" name="service" value="add">
                        </c:if>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="name">Tên Campaign *</label>
                                <input type="text" id="name" name="name" 
                                       value="${campaign.name}" required>
                            </div>
                            <div class="form-group">
                                <label for="status">Trạng thái</label>
                                <div class="checkbox-group">
                                    <input type="checkbox" id="status" name="status" 
                                           ${campaign.status ? 'checked' : ''}>
                                    <label for="status">Kích hoạt</label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="description">Mô tả</label>
                            <textarea id="description" name="description" 
                                      placeholder="Nhập mô tả campaign...">${campaign.description}</textarea>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="startDate">Ngày bắt đầu *</label>
                                <input type="date" id="startDate" name="startDate" 
                                       value="<fmt:formatDate value='${campaign.startDate}' pattern='yyyy-MM-dd'/>" required>
                            </div>
                            <div class="form-group">
                                <label for="endDate">Ngày kết thúc *</label>
                                <input type="date" id="endDate" name="endDate" 
                                       value="<fmt:formatDate value='${campaign.endDate}' pattern='yyyy-MM-dd'/>" required>
                            </div>
                        </div>

                        <!-- ✅ UPLOAD IMAGES -->
                        <div class="form-row">
                            <div class="form-group">
                                <label for="imageFile">Ảnh Campaign</label>
                                <input type="file" id="imageFile" name="imageFile" 
                                       accept="image/*">
                                <c:if test="${isEditing and not empty campaign.img}">
                                    <div class="current-image">
                                        <p>Ảnh hiện tại:</p>
                                        <img src="${pageContext.request.contextPath}/${campaign.img}" 
                                             alt="Current Image" class="image-preview">
                                    </div>
                                </c:if>
                            </div>
                            <div class="form-group">
                                <label for="thumbnailFile">Ảnh Thumbnail</label>
                                <input type="file" id="thumbnailFile" name="thumbnailFile" 
                                       accept="image/*">
                                <c:if test="${isEditing and not empty campaign.thumbnail}">
                                    <div class="current-image">
                                        <p>Thumbnail hiện tại:</p>
                                        <img src="${pageContext.request.contextPath}/${campaign.thumbnail}" 
                                             alt="Current Thumbnail" class="image-preview">
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <c:choose>
                                    <c:when test="${isEditing}">
                                        <i class="fas fa-save"></i> Cập nhật
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-plus"></i> Thêm mới
                                    </c:otherwise>
                                </c:choose>
                            </button>

                            <c:if test="${isEditing}">
                                <a href="campaign" class="btn btn-cancel">
                                    <i class="fas fa-times"></i> Hủy
                                </a>
                            </c:if>
                        </div>
                    </form>
                </div>

                <!-- ✅ DANH SÁCH CAMPAIGN -->
                <div class="table-section">
                    <h2><i class="fas fa-list"></i> Danh sách Campaign</h2>

                    <div class="table-container">
                        <c:choose>
                            <c:when test="${empty campaigns}">
                                <div class="no-data">
                                    <i class="fas fa-inbox"></i>
                                    <p>Chưa có campaign nào</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên</th>
                                            <th>Mô tả</th>
                                            <th>Ngày bắt đầu</th>
                                            <th>Ngày kết thúc</th>
                                            <th>Trạng thái</th>
                                            <th>Ảnh</th>
                                            <th>Thumbnail</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="camp" items="${campaigns}">
                                            <tr>
                                                <td>${camp.id}</td>
                                                <td><strong>${camp.name}</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${empty camp.description}">
                                                            <em>Chưa có mô tả</em>
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${camp.description.length() > 50 ? 
                                                              camp.description.substring(0, 50).concat("...") : 
                                                              camp.description}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${camp.startDate}" pattern="dd/MM/yyyy"/>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${camp.endDate}" pattern="dd/MM/yyyy"/>
                                                </td>
                                                <td>
                                                    <span class="${camp.status ? 'status-active' : 'status-inactive'}">
                                                        ${camp.status ? 'Hoạt động' : 'Không hoạt động'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty camp.img}">
                                                        <img src="${pageContext.request.contextPath}/${camp.img}" 
                                                             alt="Campaign Image" class="image-preview">
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty camp.thumbnail}">
                                                        <img src="${pageContext.request.contextPath}/${camp.thumbnail}" 
                                                             alt="Thumbnail" class="image-preview">
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <div class="actions">
                                                        <!-- ✅ LINK SỬA -->
                                                        <a href="campaign?editId=${camp.id}" class="btn btn-edit">
                                                            <i class="fas fa-edit"></i> Sửa
                                                        </a>

                                                        <!-- ✅ FORM XÓA -->
                                                        <form method="post" action="campaign" style="display: inline;">
                                                            <input type="hidden" name="service" value="delete">
                                                            <input type="hidden" name="id" value="${camp.id}">
                                                            <button type="submit" class="btn btn-danger" 
                                                                    onclick="return confirm('Bạn có chắc muốn xóa campaign này?')">
                                                                <i class="fas fa-trash"></i> Xóa
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <!-- ✅ JAVASCRIPT XỬ LÝ FORM -->
        <script>
            // Validate form trước khi submit
            document.querySelector('form').addEventListener('submit', function (e) {
                const startDate = new Date(document.getElementById('startDate').value);
                const endDate = new Date(document.getElementById('endDate').value);
                const today = new Date();
                today.setHours(0, 0, 0, 0);

                if (startDate >= endDate) {
                    alert('Ngày bắt đầu phải trước ngày kết thúc!');
                    e.preventDefault();
                    return false;
                }

                if (endDate < today) {
                    alert('Ngày kết thúc phải từ hôm nay trở đi!');
                    e.preventDefault();
                    return false;
                }

                return true;
            });

            // Set ngày hiện tại làm mặc định
            document.addEventListener('DOMContentLoaded', function () {
                // Lấy ngày hiện tại theo múi giờ Việt Nam
                const today = new Intl.DateTimeFormat('sv-SE', {
                    timeZone: 'Asia/Ho_Chi_Minh'
                }).format(new Date());

                const startDateInput = document.getElementById('startDate');
                const endDateInput = document.getElementById('endDate');

                if (startDateInput && endDateInput) {
                    // Set giá trị mặc định
                    startDateInput.value = today;
                    startDateInput.min = today;

                    // Ngày kết thúc mặc định là 15 ngày sau (campaign nó thế)
                    const nextWeekDate = new Date();
                    nextWeekDate.setDate(nextWeekDate.getDate() + 15);
                    const nextWeek = new Intl.DateTimeFormat('sv-SE', {
                        timeZone: 'Asia/Ho_Chi_Minh'
                    }).format(nextWeekDate);
                    endDateInput.value = nextWeek;

                    // Validation ngày
                    startDateInput.addEventListener('change', function () {
                        endDateInput.min = this.value;
                        if (endDateInput.value && endDateInput.value <= this.value) {
                            const nextDay = new Date(this.value);
                            nextDay.setDate(nextDay.getDate() + 1);
                            endDateInput.value = nextDay.toISOString().split('T')[0];
                        }
                    });

                    endDateInput.addEventListener('change', function () {
                        if (this.value <= startDateInput.value) {
                            alert('Ngày kết thúc phải sau ngày bắt đầu!');
                            const nextDay = new Date(startDateInput.value);
                            nextDay.setDate(nextDay.getDate() + 1);
                            this.value = nextDay.toISOString().split('T')[0];
                        }
                    });

                    console.log('Ngày hiện tại (VN):', today);
                }
            });
            // Preview ảnh khi chọn file
            function previewImage(input, previewId) {
                if (input.files && input.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        const preview = document.getElementById(previewId);
                        if (preview) {
                            preview.src = e.target.result;
                            preview.style.display = 'block';
                        }
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }

            document.getElementById('imageFile').addEventListener('change', function () {
                previewImage(this, 'imagePreview');
            });

            document.getElementById('thumbnailFile').addEventListener('change', function () {
                previewImage(this, 'thumbnailPreview');
            });
        </script>
    </body>
</html>
