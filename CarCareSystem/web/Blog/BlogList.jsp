<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh Sách Blog</title>
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
                padding: 40px 0;
                margin-bottom: 40px;
                box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
                border-radius: 0 0 20px 20px;
            }

            .main-header h1 {
                font-weight: bold;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
            }

            .table-container {
                background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
                border: 2px solid var(--accent-blue);
                margin-top: 20px;
            }

            .table-container h4 {
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

            .table-bordered {
                border-color: var(--primary-blue);
            }
            .table-bordered td, .table-bordered th {
                border-color: var(--primary-blue);
            }

            .content-preview {
                max-width: 200px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
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

            .blog-title-link {
                color: var(--dark-blue);
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .blog-title-link:hover {
                color: var(--secondary-blue);
                text-decoration: underline;
            }

            .fa-blog, .fa-list, .fa-check, .fa-times, .fa-inbox {
                color: var(--secondary-blue);
                margin-right: 5px;
            }

            .text-center.text-muted {
                color: var(--dark-blue) !important;
            }
        </style>
    </head>
    <body>
        <div class="main-header">
            <div class="container">
                <h1 class="text-center">
                    <i class="fas fa-blog"></i> Danh Sách Blog
                </h1>
            </div>
        </div>

        <div class="container">
            <div class="table-container">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4><i class="fas fa-list"></i> Blog</h4>
                    <span class="badge bg-info">Tổng: ${blogs.size()} blog</span>
                </div>

                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>Tiêu đề</th>
                                <th>Campaign</th>
                                <th>Nội dung</th>
                                <th>Ngày tạo</th>
                                <th>Ngày cập nhật</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${blogs}" var="blog">
                                <tr>
                                    <td>
                                        <a href="bloglist?id=${blog.id}" class="blog-title-link">
                                            <i class="fas fa-blog"></i> ${blog.title}
                                        </a>
                                    </td>
                                    <td><span class="badge bg-secondary">${blog.campaign.name}</span></td>
                                    <td><div class="content-preview" title="${blog.content}">${blog.content}</div></td>
                                    <td><fmt:formatDate value="${blog.createDate}" pattern="dd/MM/yyyy"/></td>
                                    <td><fmt:formatDate value="${blog.updatedDate}" pattern="dd/MM/yyyy"/></td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty blogs}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted">
                                        <i class="fas fa-inbox"></i> Chưa có blog nào
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
