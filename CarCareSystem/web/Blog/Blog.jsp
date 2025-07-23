<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Blog Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #add8e6;
            --secondary-blue: #87ceeb;
            --light-blue: #e6f3ff;
            --dark-blue: #4682b4;
            --accent-blue: #b0e0e6;
        }

        body {
            background: linear-gradient(135deg, #f0f8ff 0%, #e6f3ff 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-header {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
            color: #333;
            padding: 30px 0;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
            border-radius: 0 0 20px 20px;
        }

        .main-header h1 {
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .form-section {
            background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
            border: 2px solid var(--accent-blue);
        }

        .form-section h3 {
            color: var(--dark-blue);
            font-weight: bold;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 3px solid var(--primary-blue);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
            border: none;
            color: #333;
            font-weight: bold;
            padding: 10px 25px;
            border-radius: 25px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--secondary-blue) 0%, var(--dark-blue) 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(173, 216, 230, 0.4);
            color: white;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
            border: none;
            color: white;
            font-weight: bold;
            padding: 10px 25px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--accent-blue) 0%, var(--primary-blue) 100%);
            border: none;
            color: #333;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            border: none;
            color: white;
            transition: all 0.3s ease;
        }

        .table-container {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
            border: 2px solid var(--light-blue);
        }

        .table-container h3 {
            color: var(--dark-blue);
            font-weight: bold;
            margin-bottom: 20px;
        }

        .table-dark {
            background: linear-gradient(135deg, var(--dark-blue) 0%, var(--secondary-blue) 100%);
            color: white;
        }

        .table-dark th {
            border-color: var(--primary-blue);
            font-weight: bold;
        }

        .table-striped > tbody > tr:nth-of-type(odd) > td {
            background-color: var(--light-blue);
        }

        .table-hover > tbody > tr:hover > td {
            background-color: var(--accent-blue);
            transition: all 0.3s ease;
        }

        .badge {
            font-size: 0.8em;
            padding: 8px 12px;
            border-radius: 15px;
        }

        .badge.bg-info {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%) !important;
            color: #333;
        }

        .badge.bg-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%) !important;
        }

        .badge.bg-success {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%) !important;
        }

        .badge.bg-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%) !important;
        }

        .alert-success {
            background: linear-gradient(135deg, #d4edda 0%, var(--light-blue) 100%);
            border-color: var(--primary-blue);
            color: #155724;
        }

        .alert-danger {
            background: linear-gradient(135deg, #f8d7da 0%, #ffebee 100%);
            border-color: #dc3545;
            color: #721c24;
        }

        .form-control:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 0.2rem rgba(173, 216, 230, 0.25);
        }

        .form-select:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 0.2rem rgba(173, 216, 230, 0.25);
        }

        .content-preview {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .btn-group {
            gap: 5px;
        }

        .fa-blog, .fa-heading, .fa-campaign, .fa-align-left, .fa-eye {
            color: var(--secondary-blue);
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div class="main-header">
        <div class="container-fluid">
            <h1 class="text-center">
                <i class="fas fa-blog"></i> Quản Lý Blog
            </h1>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <!-- Thông báo -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Form thêm/sửa blog -->
                <div class="form-section">
                    <h3>
                        <c:choose>
                            <c:when test="${isEditing}">
                                <i class="fas fa-edit"></i> Sửa Blog
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-plus"></i> Thêm Blog Mới
                            </c:otherwise>
                        </c:choose>
                    </h3>
                    
                    <form method="post" action="blog">
                        <c:if test="${isEditing}">
                            <input type="hidden" name="id" value="${blog.id}">
                            <input type="hidden" name="createDate" value="${blog.createDate}">
                            <input type="hidden" name="service" value="edit">
                        </c:if>
                        <c:if test="${not isEditing}">
                            <input type="hidden" name="service" value="add">
                        </c:if>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="title" class="form-label">
                                        <i class="fas fa-heading"></i> Tiêu đề <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="title" name="title" 
                                           value="${blog.title}" required>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="campaignId" class="form-label">
                                        <i class="fas fa-campaign"></i> Campaign <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-select" id="campaignId" name="campaignId" required>
                                        <option value="">-- Chọn Campaign --</option>
                                        <c:forEach items="${campaigns}" var="campaign">
                                            <option value="${campaign.id}" 
                                                    <c:if test="${blog.campaign.id == campaign.id}">selected</c:if>>
                                                ${campaign.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="content" class="form-label">
                                <i class="fas fa-align-left"></i> Nội dung
                            </label>
                            <textarea class="form-control" id="content" name="content" rows="5">${blog.content}</textarea>
                        </div>

                        <div class="mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="status" name="status" 
                                       <c:if test="${blog.status or not isEditing}">checked</c:if>>
                                <label class="form-check-label" for="status">
                                    <i class="fas fa-eye"></i> Kích hoạt
                                </label>
                            </div>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i>
                                <c:choose>
                                    <c:when test="${isEditing}">Cập nhật</c:when>
                                    <c:otherwise>Thêm mới</c:otherwise>
                                </c:choose>
                            </button>
                            
                            <c:if test="${isEditing}">
                                <a href="blog" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Hủy
                                </a>
                            </c:if>
                        </div>
                    </form>
                </div>

                <!-- Danh sách blog -->
                <div class="table-container">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3><i class="fas fa-list"></i> Danh Sách Blog</h3>
                        <span class="badge bg-info">Tổng: ${blogs.size()} blog</span>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Tiêu đề</th>
                                    <th>Campaign</th>
                                    <th>Nội dung</th>
                                    <th>Ngày tạo</th>
                                    <th>Ngày cập nhật</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${blogs}" var="blog">
                                    <tr>
                                        <td>${blog.id}</td>
                                        <td>
                                            <i class="fas fa-blog"></i> ${blog.title}
                                        </td>
                                        <td>
                                            <span class="badge bg-secondary">${blog.campaign.name}</span>
                                        </td>
                                        <td>
                                            <div class="content-preview" title="${blog.content}">
                                                ${blog.content}
                                            </div>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${blog.createDate}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${blog.updatedDate}" pattern="dd/MM/yyyy"/>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${blog.status}">
                                                    <span class="badge bg-success">
                                                        <i class="fas fa-check"></i> Kích hoạt
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">
                                                        <i class="fas fa-times"></i> Tắt
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="btn-group" role="group">
                                                <a href="blog?editId=${blog.id}" 
                                                   class="btn btn-sm btn-warning" 
                                                   title="Sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="blog?service=delete&id=${blog.id}" 
                                                   class="btn btn-sm btn-danger" 
                                                   title="Xóa"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa blog này?')">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty blogs}">
                                    <tr>
                                        <td colspan="8" class="text-center">
                                            <i class="fas fa-inbox"></i> Chưa có blog nào
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Tự động ẩn alert sau 5 giây
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>
