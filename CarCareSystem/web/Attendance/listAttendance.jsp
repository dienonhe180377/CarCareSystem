<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Lịch sử điểm danh</title>
    <link rel="stylesheet" href="Attendance/Attendance.css">
</head>
<body>
    <jsp:include page="/header_emp.jsp" />
<div class="container">
    <h1 class="attendance-title">Lịch sử điểm danh</h1>
<div class="action-bar">
    <a href="${pageContext.request.contextPath}/attendance" class="btn">Điểm danh hôm nay</a>
    <form method="get" action="attendance" class="search-form">
        <input type="hidden" name="action" value="list">
        <input type="date" id="date" name="date" value="${selectedDate}">
        <button type="submit" class="btn">Tìm kiếm</button>
    </form>
</div>
    <!-- Hiển thị bảng điểm danh nếu có -->
    <c:if test="${not empty attendanceList}">
        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Nhân viên</th>
                    <th>Ngày</th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="attendance" items="${attendanceList}" varStatus="loop">
    <tr>
        <td>${loop.index + 1}</td>
        <td>${userMap[attendance.userId]}</td>
        <td><fmt:formatDate value="${attendance.date}" pattern="dd-MM-yyyy" /></td>
        <td>
            <span class="${attendance.status ? 'status-present' : 'status-absent'}">
                <c:choose>
                    <c:when test="${attendance.status}">Có mặt</c:when>
                    <c:otherwise>Vắng</c:otherwise>
                </c:choose>
            </span>
        </td>
    </tr>
</c:forEach>
            </tbody>
        </table>
    </c:if>

    <!-- Không có dữ liệu -->
    <c:if test="${empty attendanceList}">
        <p class="no-attendance">Không có dữ liệu điểm danh.</p>
    </c:if>
</div>
</body>
</html>
