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
        .table-container {
            margin-top: 20px;
        }
        .btn-group {
            gap: 5px;
        }
        .content-preview {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .form-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <h1 class="text-center mb-4">
                    <i class="fas fa-blog"></i> Quản Lý Blog
                </h1>

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