<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <style>
        body { background: #f3f5f8; font-family: Arial, sans-serif;}
        .container {
            max-width: 1300px;
            margin: 40px auto 0 auto;
            background: #fff;
            padding: 48px 44px 36px 44px;
            border-radius: 16px;
            box-shadow: 0 8px 42px 0 rgba(31,38,135,0.13);
        }
        h2 { margin-bottom: 30px; color: #1b72c2; font-size: 2.5rem; font-weight: 800; letter-spacing: 1.5px; }
        .search-bar {
            margin-bottom: 18px; display: flex; gap: 16px; align-items: center;
        }
        .search-bar input[type="text"] {
            font-size: 1.2rem; padding: 10px 20px; border-radius: 7px; border: 1.5px solid #b7c7d7; width: 330px;
        }
        .search-bar button, .search-bar a {
            font-size: 1.2rem; padding: 10px 32px; border-radius: 7px; border: none; background: #26be6b;
            color: #fff; text-decoration: none; cursor: pointer;
        }
        .search-bar button { background: #2596ff; }
        .search-bar a.add { background: #26be6b;}
        .search-bar a.add:hover { background: #1d9d55;}
        .search-bar a.reset { background: #888;}
        .table { width: 100%; border-collapse: collapse; font-size: 1.25rem; }
        .table th, .table td { padding: 18px 10px; border-bottom: 1.5px solid #e2e9f3; text-align: center; }
        .table th { background: #e2f0ff; font-weight: bold; font-size: 1.25rem; }
        .table td img.service-img {
            max-width: 100px; max-height: 70px; border-radius: 8px; background: #f0f0f0;
        }
        .btn {
            font-size: 1.15rem; padding: 8px 20px; border-radius: 6px; border: none;
            color: #fff; cursor: pointer; margin: 0 2px; min-width: 70px;
        }
        .btn-info { background: #2596ff;}
        .btn-warning { background: #ffd600; color: #333;}
        .btn-danger { background: #e74c3c;}
        .alert { margin: 10px 0; padding: 12px 0; text-align: center;}
        .alert-danger { color: #e74c3c; font-size: 1.2rem;}
        .alert-success { color: #26be6b; font-size: 1.2rem;}
        .empty-message { color: #888; font-style: italic; font-size: 1.15rem;}
    </style>
</head>
<body>
    <div class="container">
        <h2>Quản lý dịch vụ</h2>
        <form class="search-bar" action="ServiceServlet_JSP" method="get">
            <input type="hidden" name="service" value="listService">
            <input type="text" name="name" value="${param.name}" placeholder="Tìm kiếm dịch vụ">
            <button type="submit">Tìm</button>
            <c:if test="${not empty param.name}">
                <a href="ServiceServlet_JSP?service=listService" class="reset">Reset</a>
            </c:if>
            <c:if test="${role eq 'admin' || role eq 'manager' || role eq 'maketing'}">
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
                    <th>Ảnh</th>
                    <th>Tên</th>
                    <th>Mô tả</th>
                    <th>Giá</th>
                    <th>Chi tiết</th>
                    <th>Sửa</th>
                    <th>Xóa</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="se" items="${data}">
                    <tr>
                        <td>
                            <c:choose>
                                <c:when test="${not empty se.img}">
                                    <img class="service-img" src="${se.img}" alt="Service Image">
                                </c:when>
                                <c:otherwise>
                                    <span class="empty-message">Không ảnh</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${se.name}</td>
                        <td>${se.description}</td>
                        <td>
                            <fmt:formatNumber value="${se.price}" type="number" groupingUsed="true" minFractionDigits="0" /> đ
                        </td>
                        <td>
                            <a class="btn btn-info" href="ServiceServlet_JSP?service=detailService&id=${se.id}">Chi tiết</a>
                        </td>
                        <td>
                            <a class="btn btn-warning" href="ServiceServlet_JSP?service=updateService&id=${se.id}">Sửa</a>
                        </td>
                        <td>
                            <a class="btn btn-danger" href="ServiceServlet_JSP?service=deleteService&id=${se.id}" onclick="return confirm('Bạn chắc chắn muốn xóa?');">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty data}">
                    <tr>
                        <td colspan="7" class="empty-message">Không có dịch vụ nào.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>