<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Điểm danh của tôi</title>
        <link rel="stylesheet" href="Attendance/Attendance.css">
    </head>
    <body>
        <jsp:include page="/header_emp.jsp" />
        <div class="container">
            <div class="attendance-title">Điểm danh của tôi</div>
            <form method="get" action="attendance">
                <input type="hidden" name="action" value="list" />
                <label for="date">Tìm theo ngày: </label>
                <input type="date" id="date" name="date" value="${selectedDate}" />
                <button type="submit">Tìm kiếm</button>
            </form>
            <div class="container">
                <div class="attendance-title">Điểm danh của tôi</div>
                <table>
                    <tr>
                        <th>Ngày</th>
                        <th>Trạng thái</th>
                    </tr>
                    <c:forEach var="att" items="${myAttendance}">
                        <tr>
                            <td><fmt:formatDate value="${att.date}" pattern="dd-MM-yyyy" /></td>
                            <td>
                                <c:choose>
                                    <c:when test="${att.status}">
                                        <span class="status-present">Có mặt</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-absent">Vắng mặt</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
    </body>
</html>