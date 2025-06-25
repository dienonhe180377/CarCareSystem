<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Campaign</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: rgba(255, 255, 255, 0.95);
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                backdrop-filter: blur(10px);
            }

            .header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 30px;
                text-align: center;
            }

            .header h1 {
                font-size: 2.5rem;
                margin-bottom: 10px;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            }

            .content {
                padding: 30px;
            }

            .form-section {
                background: white;
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 30px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                border: 1px solid #e0e0e0;
            }

            .form-section h2 {
                color: #333;
                margin-bottom: 20px;
                font-size: 1.8rem;
                position: relative;
                padding-bottom: 10px;
            }

            .form-section h2::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 50px;
                height: 3px;
                background: linear-gradient(135deg, #667eea, #764ba2);
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
                color: #555;
                font-size: 0.9rem;
            }

            input[type="text"],
            input[type="date"],
            textarea,
            select {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid #e0e0e0;
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
                border-color: #667eea;
                background: white;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
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
                accent-color: #667eea;
            }

            .btn {
                padding: 12px 25px;
                border: none;
                border-radius: 10px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                text-decoration: none;
                display: inline-block;
                text-align: center;
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #5a6fd8, #6a4190);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
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
                background: #dc3545;
                color: white;
                padding: 8px 15px;
                font-size: 0.9rem;
            }

            .btn-danger:hover {
                background: #c82333;
                transform: translateY(-1px);
            }

            .btn-edit {
                background: #28a745;
                color: white;
                padding: 8px 15px;
                font-size: 0.9rem;
                margin-right: 5px;
            }

            .btn-edit:hover {
                background: #218838;
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
                background: white;
                border-radius: 15px;
                padding: 25px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                border: 1px solid #e0e0e0;
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
                background: linear-gradient(135deg, #667eea, #764ba2);
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
                border-bottom: 1px solid #e0e0e0;
                vertical-align: middle;
            }

            tr:hover {
                background: #f8f9ff;
                transform: scale(1.01);
                transition: all 0.2s ease;
            }

            .status-active {
                background: #28a745;
                color: white;
                padding: 4px 8px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
            }

            .status-inactive {
                background: #dc3545;
                color: white;
                padding: 4px 8px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
            }

            .no-data {
                text-align: center;
                padding: 40px;
                color: #666;
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
                border-radius: 10px;
                font-weight: 600;
            }

            .alert-success {
                color: #155724;
                background-color: #d4edda;
                border-color: #c3e6cb;
            }

            .alert-error {
                color: #721c24;
                background-color: #f8d7da;
                border-color: #f5c6cb;
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
        <div class="container">
            <div class="header">
                <h1>🎯 Quản lý Campaign</h1>
            </div>

            <div class="content">
                <!-- Hiển thị thông báo -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">
                        ✅ ${successMessage}
                    </div>
                </c:if>
                
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error">
                        ❌ ${errorMessage}
                    </div>
                </c:if>

                <!-- Form thêm/sửa Campaign -->
                <div class="form-section">
                    <h2 id="form-title">
                        <c:choose>
                            <c:when test="${isEditing}">✏️ Sửa Campaign</c:when>
                            <c:otherwise>➕ Thêm Campaign Mới</c:otherwise>
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
                                       value="<fmt:formatDate value='${campaign.startDate}' pattern='yyyy-MM-dd'/>">
                            </div>

                            <div class="form-group">
                                <label for="end-date">Ngày kết thúc *</label>
                                <input type="date" id="end-date" name="endDate" required 
                                       value="<fmt:formatDate value='${campaign.endDate}' pattern='yyyy-MM-dd'/>">
                            </div>
                        </div>

                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <c:choose>
                                    <c:when test="${isEditing}">💾 Cập nhật</c:when>
                                    <c:otherwise>✨ Thêm mới</c:otherwise>
                                </c:choose>
                            </button>
                            
                            <c:if test="${isEditing}">
                                <a href="campaign" class="btn btn-cancel">❌ Hủy</a>
                            </c:if>
                        </div>
                    </form>
                </div>

                <!-- Danh sách Campaign -->
                <div class="table-section">
                    <h2>📋 Danh sách Campaign</h2>
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
                                            <td colspan="7">Chưa có campaign nào được tạo</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="c" items="${campaigns}">
                                            <tr ${c.id == campaign.id ? 'style="background-color: #fff3cd;"' : ''}>
                                                <td>${c.id}</td>
                                                <td><strong>${c.name}</strong></td>
                                                <td>
                                                    <span class="${c.status ? 'status-active' : 'status-inactive'}">
                                                        ${c.status ? '✅ Kích hoạt' : '❌ Tạm dừng'}
                                                    </span>
                                                </td>
                                                <td>${c.description}</td>
                                                <td><fmt:formatDate value="${c.startDate}" pattern="dd/MM/yyyy"/></td>
                                                <td><fmt:formatDate value="${c.endDate}" pattern="dd/MM/yyyy"/></td>
                                                <td>
                                                    <div class="actions">
                                                        <a href="campaign?editId=${c.id}" class="btn btn-edit">✏️ Sửa</a>
                                                        <form method="post" action="campaign" style="display:inline">
                                                            <input type="hidden" name="id" value="${c.id}"/>
                                                            <input type="hidden" name="service" value="delete"/>
                                                            <button type="submit" class="btn btn-danger" 
                                                                    onclick="return confirm('Bạn có chắc chắn muốn xóa campaign ${c.name}?')">
                                                                🗑️ Xóa
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
            // Auto-hide alerts after 5 seconds
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
                    alert.style.transition = 'opacity 0.5s';
                    alert.style.opacity = '0';
                    setTimeout(function() {
                        alert.remove();
                    }, 500);
                });
            }, 5000);
        </script>
    </body>
</html>