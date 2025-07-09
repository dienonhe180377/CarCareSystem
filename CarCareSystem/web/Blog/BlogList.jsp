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
        .table-container {
            margin-top: 40px;
        }
        .content-preview {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center mt-4 mb-4">
            <i class="fas fa-blog"></i> Danh Sách Blog
        </h1>

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
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${blogs}" var="blog">
                            <tr>
                                
                                <td><i class="fas fa-blog"></i> ${blog.title}</td>
                                <td><span class="badge bg-secondary">${blog.campaign.name}</span></td>
                                <td><div class="content-preview" title="${blog.content}">${blog.content}</div></td>
                                <td><fmt:formatDate value="${blog.createDate}" pattern="dd/MM/yyyy"/></td>
                                <td><fmt:formatDate value="${blog.updatedDate}" pattern="dd/MM/yyyy"/></td>
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
                            </tr>
                        </c:forEach>
                        <c:if test="${empty blogs}">
                            <tr>
                                <td colspan="7" class="text-center text-muted">
                                    <i class="fas fa-inbox"></i> Chưa có blog nào
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
