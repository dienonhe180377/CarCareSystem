<%-- 
    Document   : BlogDetail
    Created on : Jul 2, 2025, 4:19:40 PM
    Author     : NTN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi Tiết Blog - ${blog.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .blog-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 60px 0;
            margin-bottom: 40px;
        }
        .blog-content {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            line-height: 1.8;
            font-size: 1.1em;
        }
        .blog-meta {
            color: #6c757d;
            font-size: 0.95em;
            margin-bottom: 30px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
            border-left: 4px solid #007bff;
        }
        .back-btn {
            margin-bottom: 30px;
        }
        .content-text {
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- Nút quay lại -->
        <div class="back-btn">
            <a href="bloglist" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách
            </a>
        </div>

        <!-- Thông báo lỗi nếu không tìm thấy blog -->
        <c:if test="${empty blog}">
            <div class="alert alert-warning text-center" role="alert">
                <i class="fas fa-exclamation-triangle fa-2x mb-3"></i>
                <h4>Không tìm thấy blog</h4>
                <p>Blog bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                <a href="bloglist" class="btn btn-primary">
                    <i class="fas fa-home"></i> Về danh sách blog
                </a>
            </div>
        </c:if>

        <!-- Nội dung blog -->
        <c:if test="${not empty blog}">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <!-- Thông tin meta -->
                    <div class="blog-meta">
                        <div class="row">
                            <div class="col-md-6">
                                <i class="fas fa-calendar-plus text-primary"></i>
                                <strong>Ngày tạo:</strong> 
                                <fmt:formatDate value="${blog.createDate}" pattern="dd/MM/yyyy"/>
                            </div>
                            <div class="col-md-6">
                                <i class="fas fa-bullhorn text-info"></i>
                                <strong>Campaign:</strong> ${blog.campaign.name}
                            </div>
                        </div>
                    </div>

                    <!-- Nội dung chính -->
                    <div class="blog-content">
                        <!-- Tiêu đề -->
                        <h1 class="mb-4 text-primary">${blog.title}</h1>
                        
                        <!-- Nội dung -->
                        <div class="content-text">
                            <c:choose>
                                <c:when test="${not empty blog.content}">
                                    ${blog.content}
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted fst-italic text-center">
                                        <i class="fas fa-info-circle"></i> 
                                        Chưa có nội dung cho blog này.
                                    </p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Nút quay lại dưới cùng -->
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Xử lý nội dung blog để hiển thị đẹp hơn
        document.addEventListener('DOMContentLoaded', function() {
            const contentText = document.querySelector('.content-text');
            if (contentText) {
                // Thay thế xuống dòng bằng thẻ <br> nếu cần
                let content = contentText.innerHTML;
                content = content.replace(/\n/g, '<br>');
                contentText.innerHTML = content;
            }
        });
    </script>
</body>
</html>
