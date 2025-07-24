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
            padding: 60px 0;
            margin-bottom: 40px;
            box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
            border-radius: 0 0 20px 20px;
        }

        .main-header h1 {
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .blog-content {
            background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
            margin-bottom: 30px;
            line-height: 1.8;
            font-size: 1.1em;
            border: 2px solid var(--accent-blue);
        }

        .blog-meta {
            background: linear-gradient(135deg, var(--light-blue) 0%, #FFFFFF 100%);
            color: #6c757d;
            font-size: 0.95em;
            margin-bottom: 30px;
            padding: 20px;
            border-radius: 15px;
            border-left: 6px solid var(--primary-blue);
            box-shadow: 0 4px 15px rgba(173, 216, 230, 0.2);
        }

        .back-btn {
            margin-bottom: 30px;
            margin-top: 20px;
        }

        .btn-outline-primary {
            border: 2px solid var(--primary-blue);
            color: var(--dark-blue);
            font-weight: bold;
            padding: 10px 25px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .btn-outline-primary:hover {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
            border-color: var(--secondary-blue);
            color: #333;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(173, 216, 230, 0.4);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
            border: none;
            color: #333;
            font-weight: bold;
            padding: 12px 30px;
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

        .content-text {
            margin-top: 20px;
        }

        .blog-content h1 {
            color: var(--dark-blue);
            font-weight: bold;
            margin-bottom: 30px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .alert-warning {
            background: linear-gradient(135deg, #fff3cd 0%, var(--light-blue) 100%);
            border-color: var(--primary-blue);
            color: #856404;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(173, 216, 230, 0.2);
        }

        .fa-exclamation-triangle, .fa-home, .fa-calendar-plus, .fa-bullhorn, .fa-info-circle, .fa-arrow-left {
            color: var(--secondary-blue);
            margin-right: 8px;
        }

        .text-primary {
            color: var(--dark-blue) !important;
        }

        .text-info {
            color: var(--secondary-blue) !important;
        }
    </style>
</head>
<body>
    <div class="main-header">
        <div class="container">
            <h1 class="text-center">
                <i class="fas fa-blog"></i> Chi Tiết Blog
            </h1>
        </div>
    </div>

    <div class="container">
        <!-- Nút quay lại -->
        <div class="back-btn">
            <a href="bloglist" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách
            </a>
        </div>

        <!-- Thông báo lỗi nếu không tìm thấy blog -->
        <c:if test="${empty blog}">
            <div class="alert alert-warning" role="alert">
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
                        <h1 class="mb-4">${blog.title}</h1>
                        
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
