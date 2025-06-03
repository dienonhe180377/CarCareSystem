<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>my attendance</title>
    <style>
        body {
            background: linear-gradient(120deg, #e0eafc, #cfdef3 100%);
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .container {
            background: #fff;
            max-width: 500px;
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
        .attendance-title {
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
        .status-present {
            color: #28a745;
            font-weight: 600;
        }
        .status-absent {
            color: #e84545;
            font-weight: 600;
        }
        @media (max-width: 600px) {
            .container { padding: 18px 4px; }
            .attendance-title { font-size: 1.3rem; }
        }
    </style>
</head>
<body>
    <div class="header-link">
        <a href="index.html">&larr; Trang chủ</a>
    </div>
    <div class="container">
        <div class="attendance-title">my attendance</div>
        <table>
            <tr>
                <th>date</th>
                <th>status</th>
            </tr>
            <c:forEach var="att" items="${myAttendance}">
                <tr>
                    <td>${att.date}</td>
                    <td>
                        <c:choose>
                            <c:when test="${att.status}">
                                <span class="status-present">present</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-absent">absent</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>