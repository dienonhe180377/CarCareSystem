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
                border: 1px solid transparent;
                border-radius: 15px;
                font-weight: 600;
                box-shadow: 0 4px 15px rgba(173, 216, 230, 0.2);
            }

            .alert-success {
                color: #155724;
                background: linear-gradient(135deg, #d4edda 0%, var(--light-blue) 100%);
                border-color: var(--primary-blue);
            }

            .alert-error {
                color: #721c24;
                background: linear-gradient(135deg, #f8d7da 0%, #ffebee 100%);
                border-color: #dc3545;
            }

            .fa-bullhorn, .fa-edit, .fa-plus, .fa-save, .fa-times, .fa-trash, .fa-check-circle, .fa-exclamation-triangle {
                margin-right: 8px;
                color: var(--secondary-blue);
            }

            @media (max-width: 768px) {
                .form-row {
                    flex-direction: column;
                }

                .actions {
                    flex-direction: column;
                }

                .btn {
                    margin: 2px 0;
                }
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
                    <!-- Hiển thị thông báo -->
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

                <!-- Form thêm/sửa Campaign -->
                <div class="form-section">
                    <h2 id="form-title">
                        <c:choose>
                            <c:when test="${isEditing}"><i class="fas fa-edit"></i> Sửa Campaign</c:when>
                            <c:otherwise><i class="fas fa-plus"></i> Thêm Campaign Mới</c:otherwise>
                        </c:choose>
                    </h2>

                    <form id="campaign-form" method="post" action="campaign">
                        <input type="hidden" name="service" value="${isEditing ? 'edit' : 'add'}">
                        <c:if test="${isEditing}">
                            <input type="hidden" name="id" value="${campaign.id}">
                        </c:if>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="campaign-name">Tên Campaign *</label>
                                <input type="text" id="campaign-name" name="name" required 
                                       placeholder="Nhập tên campaign" 
                                       value="${campaign.name}">
                            </div>

                            <div class="form-group">
                                <label for="campaign-status">Trạng thái</label>
                                <div class="checkbox-group">
                                    <input type="checkbox" id="campaign-status" name="status" 
                                           ${campaign.status ? 'checked' : ''}>
                                    <label for="campaign-status">Kích hoạt</label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="campaign-description">Mô tả</label>
                            <textarea id="campaign-description" name="description" 
                                      placeholder="Nhập mô tả chi tiết về campaign">${campaign.description}</textarea>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="start-date">Ngày bắt đầu *</label>
                                <input type="date" id="start-date" name="startDate" required 
                                       value="<fmt:formatDate value='${campaign.startDate}' pattern='yyyy-MM-dd' timeZone='Asia/Ho_Chi_Minh'/>">
                            </div>

                            <div class="form-group">
                                <label for="end-date">Ngày kết thúc *</label>
                                <input type="date" id="end-date" name="endDate" required 
                                       value="<fmt:formatDate value='${campaign.endDate}' pattern='yyyy-MM-dd' timeZone='Asia/Ho_Chi_Minh'/>">
                            </div>
                        </div>

                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <c:choose>
                                    <c:when test="${isEditing}"><i class="fas fa-save"></i> Cập nhật</c:when>
                                    <c:otherwise><i class="fas fa-plus"></i> Thêm mới</c:otherwise>
                                </c:choose>
                            </button>

                            <c:if test="${isEditing}">
                                <a href="campaign" class="btn btn-cancel"><i class="fas fa-times"></i> Hủy</a>
                            </c:if>
                        </div>
                    </form>
                </div>

                <!-- Danh sách Campaign -->
                <div class="table-section">
                    <h2><i class="fas fa-list"></i> Danh sách Campaign</h2>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Tên Campaign</th>
                                    <th>Trạng thái</th>
                                    <th>Mô tả</th>
                                    <th>Ngày bắt đầu</th>
                                    <th>Ngày kết thúc</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty campaigns}">
                                        <tr class="no-data">
                                            <td colspan="7"><i class="fas fa-inbox"></i> Chưa có campaign nào được tạo</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="c" items="${campaigns}">
                                            <tr ${c.id == campaign.id ? 'style="background-color: var(--light-blue);"' : ''}>
                                                <td>${c.id}</td>
                                                <td><strong>${c.name}</strong></td>
                                                <td>
                                                    <span class="${c.status ? 'status-active' : 'status-inactive'}">
                                                        ${c.status ? '✅ Kích hoạt' : '❌ Tạm dừng'}
                                                    </span>
                                                </td>
                                                <td>${c.description}</td>
                                                <td><fmt:formatDate value="${c.startDate}" pattern="dd/MM/yyyy" timeZone="Asia/Ho_Chi_Minh"/></td>
                                                <td><fmt:formatDate value="${c.endDate}" pattern="dd/MM/yyyy" timeZone="Asia/Ho_Chi_Minh"/></td>
                                                <td>
                                                    <div class="actions">
                                                        <a href="campaign?editId=${c.id}" class="btn btn-edit">
                                                            <i class="fas fa-edit"></i> Sửa
                                                        </a>
                                                        <form method="post" action="campaign" style="display:inline">
                                                            <input type="hidden" name="id" value="${c.id}"/>
                                                            <input type="hidden" name="service" value="delete"/>
                                                            <button type="submit" class="btn btn-danger" 
                                                                    onclick="return confirm('Bạn có chắc chắn muốn xóa campaign ${c.name}?')">
                                                                <i class="fas fa-trash"></i> Xóa
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script>
        // ĐỒNG BỘ - Xử lý ngày tháng theo múi giờ Việt Nam
        document.addEventListener('DOMContentLoaded', function () {
            // Lấy ngày hiện tại theo múi giờ Việt Nam
            const today = new Intl.DateTimeFormat('sv-SE', {
                timeZone: 'Asia/Ho_Chi_Minh'
            }).format(new Date());

            const startDateInput = document.getElementById('start-date');
            const endDateInput = document.getElementById('end-date');

            if (startDateInput && endDateInput) {
                // Chỉ set giá trị mặc định khi không phải chế độ edit
                const isEditing = ${isEditing ? 'true' : 'false'};
                
                if (!isEditing) {
                    // Set giá trị mặc định cho campaign mới
                    startDateInput.value = today;
                    
                    // Ngày kết thúc mặc định là 30 ngày sau (campaign thường dài hơn voucher)
                    const nextMonthDate = new Date();
                    nextMonthDate.setDate(nextMonthDate.getDate() + 30);
                    const nextMonth = new Intl.DateTimeFormat('sv-SE', {
                        timeZone: 'Asia/Ho_Chi_Minh'
                    }).format(nextMonthDate);
                    endDateInput.value = nextMonth;
                }

                // Set ngày tối thiểu
                startDateInput.min = today;

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

                console.log('Campaign - Ngày hiện tại (VN):', today);
            }
        });

        // Validation form trước khi submit
        document.getElementById('campaign-form').addEventListener('submit', function(e) {
            const startDate = document.getElementById('start-date').value;
            const endDate = document.getElementById('end-date').value;
            const name = document.getElementById('campaign-name').value.trim();

            if (!name) {
                alert('Vui lòng nhập tên campaign!');
                e.preventDefault();
                return;
            }

            if (!startDate || !endDate) {
                alert('Vui lòng chọn đầy đủ ngày bắt đầu và kết thúc!');
                e.preventDefault();
                return;
            }

            if (endDate <= startDate) {
                alert('Ngày kết thúc phải sau ngày bắt đầu!');
                e.preventDefault();
                return;
            }

            console.log('Campaign form validated successfully');
        });
    </script>
    </body>
</html>
