<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Điểm danh nhân viên</title>
    <style>
        body {
            background: linear-gradient(120deg, #e0eafc, #cfdef3 100%);
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .container {
            background: #fff;
            max-width: 700px;
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
        .btn {
            padding: 9px 30px;
            border-radius: 8px;
            border: none;
            font-size: 1.06rem;
            font-weight: 500;
            margin-top: 10px;
            cursor: pointer;
            background: linear-gradient(90deg, #3895d3, #47b5ff);
            color: #fff;
            transition: box-shadow 0.16s, background 0.16s, color 0.16s;
            box-shadow: 0 2px 6px rgba(56,149,211,0.09);
        }
        .btn:hover {
            background: linear-gradient(90deg,#47b5ff,#3895d3);
            box-shadow: 0 4px 16px rgba(56,149,211,0.16);
        }
        .success-message {
            color: #28a745;
            font-weight: bold;
            margin-top: 16px;
            text-align: center;
        }
        @media (max-width: 700px) {
            .container { padding: 18px 4px; }
            .attendance-title { font-size: 1.3rem; }
            .btn { padding: 8px 16px; }
        }
    </style>
</head>
<body>
    <div class="header-link">
        <a href="index.html">&larr; Trang chủ</a>
    </div>
    <div class="container">
        <div class="attendance-title">Attendance check</div>
        <form method="post" action="attendance">
            <table>
                <tr>
                    <th>STT</th>
                    <th>User Name</th>
                    <th>Present</th>
                    <th>Absent</th>
                </tr>
                <c:forEach var="user" items="${users}" varStatus="loop">
                    <tr>
                        <td>${loop.index + 1}</td>
                        <td style="text-align:left;">${user.username}</td>
                        <td>
                            <input type="radio" name="status_${user.id}" value="present"
                                <c:if test="${todayStatus[user.id] != null && todayStatus[user.id]}">checked</c:if> >
                        </td>
                        <td>
                            <input type="radio" name="status_${user.id}" value="absent"
                                <c:if test="${todayStatus[user.id] != null && !todayStatus[user.id]}">checked</c:if> >
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <div style="text-align:center;">
                <button type="submit" class="btn">Done</button>
            </div>
        </form>
        <c:if test="${param.success == 1}">
            <div class="success-message">successfully!</div>
        </c:if>
    </div>
</body>
</html>