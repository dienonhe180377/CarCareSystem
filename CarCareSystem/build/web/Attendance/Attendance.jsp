<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Điểm danh nhân viên</title>
    <link rel="stylesheet" href="Attendance/Attendance.css">
</head>
<body>
    <jsp:include page="/header_emp.jsp" />
    <div class="container">
        <div class="attendance-title">Điểm danh nhân viên</div>
      
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
                        <td style="">${user.username}</td>
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
            <div class="action-buttons">
    <a href="attendance?action=list" class="btn btn-inline">Xem lịch sử điểm danh</a>
    <button type="submit" class="btn">Done</button>
</div>
        </form>
        <c:if test="${param.success == 1}">
            <div class="success-message">Successfully!</div>
        </c:if>
    </div>
</body>
</html>