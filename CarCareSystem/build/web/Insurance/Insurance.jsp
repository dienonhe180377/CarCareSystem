<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh sách bảo hiểm</title>
    <style>
        body {
            background: linear-gradient(120deg, #e0eafc, #cfdef3 100%);
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .container {
            background: #fff;
            max-width: 900px;
            margin: 50px auto;
            padding: 36px 40px 28px 40px;
            border-radius: 20px;
            box-shadow: 0 6px 32px rgba(0,0,0,0.12);
            animation: floatIn 0.9s cubic-bezier(.55,.06,.68,.19);
        }
        @keyframes floatIn {
            from { transform: translateY(60px) scale(0.95); opacity: 0; }
            to { transform: translateY(0) scale(1); opacity: 1; }
        }
        .header-link {
            text-align: left;
            margin: 18px 0 0 32px;
        }
        .header-link a {
            color: #3895d3;
            font-weight: 500;
            text-decoration: none;
        }
        .insurance-title {
            text-align: center;
            font-size: 2rem;
            font-weight: 600;
            color: #276678;
            letter-spacing: 1px;
            margin-bottom: 22px;
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
            margin-bottom: 18px;
        }
        th, td {
            text-align: center;
            padding: 8px 0;
        }
        th {
            background: #3895d3;
            color: #fff;
            font-weight: 600;
            border-radius: 8px 8px 0 0;
        }
        tr {
            background: #f7fbff;
            border-radius: 8px;
        }
        .btn {
            padding: 7px 18px;
            border-radius: 8px;
            border: none;
            font-size: 1rem;
            font-weight: 500;
            margin: 0 2px;
            cursor: pointer;
            background: linear-gradient(90deg, #3895d3, #47b5ff);
            color: #fff;
            transition: box-shadow 0.16s, background 0.16s, color 0.16s;
            box-shadow: 0 2px 6px rgba(56,149,211,0.09);
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background: linear-gradient(90deg,#47b5ff,#3895d3);
            box-shadow: 0 4px 16px rgba(56,149,211,0.16);
            color: #fff;
        }
        .btn-danger {
            background: #e84545;
        }
        .btn-danger:hover {
            background: #b02a37;
        }
        .add-link {
            display: inline-block;
            margin-bottom: 18px;
            margin-top: 8px;
        }
        @media (max-width: 900px) {
            .container { padding: 18px 4px; }
            .insurance-title { font-size: 1.3rem; }
            .btn { padding: 8px 10px; }
        }
    </style>
</head>
<body>
    <div class="header-link">
        <a href="index.html">&larr; Trang chủ</a>
    </div>
    <div class="container">
        <div class="insurance-title">Danh sách bảo hiểm</div>
        <c:if test="${role == 'admin' || role == 'manager' || role == 'maketing'}">
            <a href="insurance?service=addInsurance" class="btn add-link">Thêm mới bảo hiểm</a>
        </c:if>
        <table>
            <tr>
                <th>ID</th>
                <th>User ID</th>
                <th>Car Type ID</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Price</th>
                <th>Description</th>
                <c:if test="${role == 'admin' || role == 'manager' || role == 'maketing'}">
                    <th>Action</th>
                </c:if>
            </tr>
            <c:forEach var="i" items="${data}">
                <tr>
                    <td>${i.id}</td>
                    <td>${i.userId}</td>
                    <td>${i.carTypeId}</td>
                    <td>${i.startDate}</td>
                    <td>${i.endDate}</td>
                    <td>${i.price}</td>
                    <td>${i.description}</td>
                    <c:if test="${role == 'admin' || role == 'manager' || role == 'maketing'}">
                        <td>
                            <a href="insurance?service=updateInsurance&id=${i.id}" class="btn">update</a>
                            <a href="insurance?service=deleteInsurance&id=${i.id}" class="btn btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?');">delete</a>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>