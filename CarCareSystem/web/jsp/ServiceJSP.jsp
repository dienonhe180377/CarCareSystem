<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${pageTitle}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: #f3f5f8;
                font-family: Arial, sans-serif;
            }
            .container {
                max-width: 1300px;
                margin: 40px auto 0 auto;
                background: #fff;
                padding: 48px 44px 36px 44px;
                border-radius: 16px;
                box-shadow: 0 8px 42px 0 rgba(31,38,135,0.13);
            }
            h2 {
                margin-bottom: 30px;
                color: #1b72c2;
            }
            .search-bar {
                margin-bottom: 18px;
                display: flex;
                gap: 16px;
                align-items: center;
            }
            .search-bar input[type="text"] {
                font-size: 1.2rem;
                padding: 10px 20px;
                border-radius: 7px;
                border: 1.5px solid #b7c7d7;
                width: 330px;
            }
            .search-bar button, .search-bar a {
                font-size: 1.2rem;
                padding: 10px 32px;
                border-radius: 7px;
                border: none;
                background: #26be6b;
                color: #fff;
                text-decoration: none;
                cursor: pointer;
            }
            .search-bar button {
                background: #2596ff;
            }
            .search-bar a.add {
                background: #26be6b;
            }
            .search-bar a.add:hover {
                background: #1d9d55;
            }
            .search-bar a.reset {
                background: #888;
            }
            .table {
                width: 100%;
                border-collapse: collapse;
                font-size: 1.25rem;
            }
            .table th, .table td {
                padding: 18px 10px;
                border-bottom: 1.5px solid #e2e9f3;
                text-align: center;
            }
            .table th {
                background: #e6f0fb;
                font-weight: bold;
                font-size: 1.25rem;
            }
            .table td img.service-img {
                max-width: 100px;
                max-height: 70px;
                border-radius: 8px;
                background: #f0f0f0;
            }
            .btn {
                font-size: 1.15rem;
                padding: 8px 20px;
                border-radius: 6px;
                border: none;
                color: #fff;
                cursor: pointer;
                margin: 0 2px;
                min-width: 70px;
            }
            .btn-info {
                background: #2596ff;
            }
            .btn-warning {
                background: #ffd600;
                color: #333;
            }
            .btn-danger {
                background: #e74c3c;
            }
            .alert {
                margin: 10px 0;
                padding: 12px 0;
                text-align: center;
            }
            .alert-danger {
                color: #e74c3c;
                font-size: 1.2rem;
            }
            .alert-success {
                color: #26be6b;
                font-size: 1.2rem;
            }
            .empty-message {
                color: #888;
                font-style: italic;
                font-size: 1.15rem;
            }
            .pagination-container {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 32px;
                gap: 16px;
            }
            .pagination {
                margin: 0;
            }
            .pagination .page-link {
                color: #1b72c2;
                font-weight: 500;
                border-radius: 8px !important;
                margin: 0 2px;
                border: none;
                min-width: 42px;
                text-align: center;
                transition: background 0.15s;
            }
            .pagination .active .page-link, .pagination .page-link.active {
                background: #2596ff;
                border-color: #2596ff;
                color: #fff;
                font-weight: bold;
            }
            .pagination .page-link:hover,
            .pagination .page-link:focus {
                background: #e5f1fb;
                color: #1b72c2;
            }
            .pagination .disabled .page-link {
                color: #b7c7d7;
                pointer-events: none;
                background: #f3f5f8;
            }
            .pagination-summary {
                color: #444;
                font-size: 1.1rem;
                font-style: italic;
                letter-spacing: .5px;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="container">
            <h2>Quản lý dịch vụ</h2>
            <form class="search-bar" action="ServiceServlet_JSP" method="get">
                <input type="hidden" name="service" value="listService">
                <input type="text" name="name" value="${param.name}" placeholder="Tìm kiếm dịch vụ">
                <button type="submit">Tìm</button>
                <c:if test="${not empty param.name}">
                    <a href="ServiceServlet_JSP?service=listService" class="reset">Reset</a>
                </c:if>
                <c:if test="${fn:toLowerCase(role) eq 'admin' || fn:toLowerCase(role) eq 'manager' || fn:toLowerCase(role) eq 'marketing'}">
                    <a href="ServiceServlet_JSP?service=addService" class="add">+ Thêm</a>
                </c:if>
            </form>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Ảnh</th>
                        <th>Tên</th>
                        <th>Mô tả</th>
                        <th>Giá</th>
                        <th>Chi tiết</th>
                        <th>
                            <c:if test="${fn:toLowerCase(role) eq 'admin' || fn:toLowerCase(role) eq 'manager' || fn:toLowerCase(role) eq 'marketing'}">Sửa</c:if>
                        </th>
<!--                        <th>
                            <c:if test="${fn:toLowerCase(role) eq 'admin' || fn:toLowerCase(role) eq 'manager'}">Xóa</c:if>
                        </th>-->
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="se" items="${data}">
                        <tr>
                            <td>${se.id}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty se.img}">
                                        <img class="service-img" src="${pageContext.request.contextPath}/img/${se.img}" alt="Service Image">
                                    </c:when>
                                    <c:otherwise>
                                        <span class="empty-message">Không ảnh</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${se.name}</td>
                            <td>${se.description}</td>
                            <td>
                                <fmt:formatNumber value="${se.totalPriceWithParts}" type="number" groupingUsed="true" minFractionDigits="0" /> đ
                            </td>
                            <td>
                                <a class="btn btn-info" href="ServiceServlet_JSP?service=detailService&id=${se.id}">Chi tiết</a>
                            </td>
                            <td>
                                <c:if test="${fn:toLowerCase(role) eq 'admin' || fn:toLowerCase(role) eq 'manager' || fn:toLowerCase(role) eq 'marketing'}">
                                    <a class="btn btn-warning" href="ServiceServlet_JSP?service=updateService&id=${se.id}">Sửa</a>
                                </c:if>
                            </td>
<!--                            <td>
                                <c:if test="${fn:toLowerCase(role) eq 'admin' || fn:toLowerCase(role) eq 'manager'}">
                                    <a class="btn btn-danger"
                                       href="ServiceServlet_JSP?service=deleteService&id=${se.id}"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa dịch vụ này không?');">
                                        Xóa
                                    </a>
                                </c:if>
                            </td>-->
                        </tr>
                    </c:forEach>
                    <c:if test="${empty data}">
                        <tr>
                            <td colspan="8" class="empty-message">Không có dịch vụ nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
            <c:if test="${totalPage > 1}">
                <div class="pagination-container">
                    <ul class="pagination">
                        <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>'">
                            <a class="page-link" href="ServiceServlet_JSP?service=listService&name=${fn:escapeXml(param.name)}&page=${currentPage - 1}" tabindex="-1" aria-label="Trước">
                                &laquo;
                            </a>
                        </li>
                        <c:set var="startPage" value="${currentPage - 2 > 0 ? currentPage - 2 : 1}" />
                        <c:set var="endPage" value="${currentPage + 2 <= totalPage ? currentPage + 2 : totalPage}" />
                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <li class="page-item <c:if test='${i == currentPage}'>active</c:if>'">
                                <a class="page-link <c:if test='${i == currentPage}'>active</c:if>'" href="ServiceServlet_JSP?service=listService&name=${fn:escapeXml(param.name)}&page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item <c:if test='${currentPage == totalPage}'>disabled</c:if>'">
                            <a class="page-link" href="ServiceServlet_JSP?service=listService&name=${fn:escapeXml(param.name)}&page=${currentPage + 1}" aria-label="Sau">
                                &raquo;
                            </a>
                        </li>
                    </ul>
                </div>
            </c:if>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>