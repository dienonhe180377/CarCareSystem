<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách Campaign</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6fa;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        .container {
            max-width: 1000px;
            margin: auto;
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #667eea;
            color: #fff;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .status-active {
            color: green;
            font-weight: bold;
        }

        .status-inactive {
            color: red;
            font-weight: bold;
        }

        .no-data {
            text-align: center;
            color: #888;
            font-style: italic;
            padding: 40px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📋 Danh sách Campaign</h1>

        <c:choose>
            <c:when test="${empty campaigns}">
                <div class="no-data">Chưa có campaign nào được tạo.</div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Trạng thái</th>
                            <th>Mô tả</th>
                            <th>Bắt đầu</th>
                            <th>Kết thúc</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${campaigns}">
                            <tr>
                                <td>${c.id}</td>
                                <td>${c.name}</td>
                                <td>
                                    <span class="${c.status ? 'status-active' : 'status-inactive'}">
                                        ${c.status ? 'Kích hoạt' : 'Tạm dừng'}
                                    </span>
                                </td>
                                <td>${c.description}</td>
                                <td><fmt:formatDate value="${c.startDate}" pattern="dd/MM/yyyy"/></td>
                                <td><fmt:formatDate value="${c.endDate}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
