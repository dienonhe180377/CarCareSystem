<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <!-- Bootstrap 5 CSS & Google Fonts -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:600,700&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(120deg, #e0eafc, #cfdef3 100%);
            min-height: 100vh;
            font-family: 'Montserrat', Arial, sans-serif;
        }
        .container {
            background: #fff;
            padding: 40px 44px 34px 44px;
            border-radius: 26px;
            margin-top: 48px;
            box-shadow: 0 8px 42px 0 rgba(31,38,135,0.13);
        }
        h2 {
            font-weight: 700;
            color: #2563eb;
            margin-bottom: 32px;
            letter-spacing: 2px;
            text-shadow: 0 2px 8px #c3dafe;
        }
        .table thead th {
            background: linear-gradient(90deg,#47b5ff, #3895d3 60%);
            color: #fff;
            font-weight: 700;
            text-align: center;
            font-size: 1.06rem;
            border-bottom: none;
        }
        .table td, .table th {
            vertical-align: middle;
            text-align: center;
        }
        .btn-custom {
            min-width: 96px;
            font-weight: 600;
            letter-spacing: 1px;
            border-radius: 22px;
            transition: background 0.22s, color 0.17s, box-shadow 0.17s;
            font-size: 1rem;
        }
        .btn-warning {
            background: linear-gradient(90deg,#ffd97d, #f9c846);
            color: #222f3e;
            border: none;
        }
        .btn-warning:hover {
            background: linear-gradient(90deg,#fda085,#f6d365);
            color: #fff;
        }
        .btn-danger {
            background: linear-gradient(90deg,#e84545,#ff5858);
            color: #fff;
            border: none;
        }
        .btn-danger:hover {
            background: linear-gradient(90deg,#b02a37,#e84545);
            color: #fff;
        }
        .btn-success {
            background: linear-gradient(90deg,#38f9d7,#43e97b);
            color: #222f3e;
            border: none;
            font-weight: 700;
        }
        .btn-success:hover {
            background: linear-gradient(90deg,#43e97b,#38f9d7);
        }
        .btn-primary {
            background: linear-gradient(90deg,#47b5ff,#3895d3);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg,#3895d3,#47b5ff);
        }
        .btn-secondary {
            background: #cfd9df;
            color: #222f3e;
            border: none;
        }
        .btn-secondary:hover {
            background: #b0bec5;
            color: #222f3e;
        }
        .form-inline .form-control {
            width: 260px;
            border-radius: 18px;
        }
        .form-inline .btn, .form-inline a {
            margin-right: 12px;
        }
        .form-inline a.btn-success {
            margin-left: 10px;
        }
        .table tbody tr:hover {
            background: #e3f6fc;
            transition: background 0.17s;
        }
        .caption-style {
            caption-side: top;
            font-size: 1.19rem;
            font-weight: 500;
            color: #636e72;
            margin-bottom: 12px;
        }
        .price-vnd {
            color: #636e72;
            font-size: 13px;
            margin-left: 3px;
        }
        .search-highlight {
            color: #1abc9c;
            font-weight: 600;
        }
        .empty-message {
            color: #636e72;
            font-style: italic;
            font-size: 1.08rem;
        }
        @media (max-width: 700px) {
            .container { padding: 16px 3px 16px 3px; margin-top: 16px; border-radius: 11px; }
            .form-inline .form-control { width: 100%; margin-bottom: 12px; }
            .form-inline .btn, .form-inline a { width: 100%; margin-bottom: 10px; }
            .btn-custom { min-width: 62px; font-size: 0.97rem; }
            h2 { font-size: 1.5rem; }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Service Management</h2>
    <form class="form-inline row g-2 mb-4 align-items-center" action="ServiceServlet_JSP" method="get">
        <input type="hidden" name="service" value="listService">
        <div class="col-auto flex-grow-1">
            <input type="text" class="form-control" name="name" value="${param.name}" placeholder="Search service by name" autocomplete="off">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary btn-custom">Search</button>
        </div>
        <c:if test="${not empty param.name}">
            <div class="col-auto">
                <a href="ServiceServlet_JSP?service=listService" class="btn btn-secondary btn-custom">Reset</a>
            </div>
        </c:if>
        <div class="col-auto">
            <a href="ServiceServlet_JSP?service=addService" class="btn btn-success btn-custom">+ Add Service</a>
        </div>
    </form>
    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <caption class="caption-style">${tableTitle}</caption>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Part ID</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty param.name}">
                        <c:choose>
                            <c:when test="${not empty data}">
                                <c:forEach var="se" items="${data}">
                                    <tr>
                                        <td>${se.id}</td>
                                        <td>${se.name}</td>
                                        <td>${se.partId}</td>
                                        <td>${se.description}</td>
                                        <td>
                                            <fmt:formatNumber value="${se.price}" type="number" groupingUsed="true" minFractionDigits="0" />
                                            <span class="price-vnd">VND</span>
                                        </td>
                                        <td>
                                            <a class="btn btn-warning btn-sm btn-custom" href="ServiceServlet_JSP?service=updateService&id=${se.id}">
                                                <i class="bi bi-pencil-square"></i> Update
                                            </a>
                                        </td>
                                        <td>
                                            <a class="btn btn-danger btn-sm btn-custom" href="ServiceServlet_JSP?service=deleteService&id=${se.id}" onclick="return confirm('Bạn chắc chắn muốn xóa?');">
                                                <i class="bi bi-trash"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="empty-message">No service found for "<b>${param.name}</b>".</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="se" items="${data}">
                            <tr>
                                <td>${se.id}</td>
                                <td>${se.name}</td>
                                <td>${se.partId}</td>
                                <td>${se.description}</td>
                                <td>
                                    <fmt:formatNumber value="${se.price}" type="number" groupingUsed="true" minFractionDigits="0" />
                                    <span class="price-vnd">VND</span>
                                </td>
                                <td>
                                    <a class="btn btn-warning btn-sm btn-custom" href="ServiceServlet_JSP?service=updateService&id=${se.id}">
                                        <i class="bi bi-pencil-square"></i> Update
                                    </a>
                                </td>
                                <td>
                                    <a class="btn btn-danger btn-sm btn-custom" href="ServiceServlet_JSP?service=deleteService&id=${se.id}" onclick="return confirm('Bạn chắc chắn muốn xóa?');">
                                        <i class="bi bi-trash"></i> Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty data}">
                            <tr>
                                <td colspan="7" class="empty-message">No service found.</td>
                            </tr>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>
<!-- Bootstrap 5 JS Bundle, Bootstrap Icons -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</body>
</html>