<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách loại bảo hiểm</title>
        <link rel="stylesheet" href="InsuranceType/InsuranceType.css">
    </head>
    <body>
        <jsp:include page="/header_emp.jsp" />
        <div class="container">
            <h2>Danh sách loại bảo hiểm</h2>
            <form action="instype" method="get" style="margin-bottom:18px;">
                <input type="hidden" name="action" value="list">
                <input type="text" name="keyword" value="${keyword}" placeholder="Tìm theo tên loại bảo hiểm" class="form-input" style="width:220px;">
                <button type="submit" class="btn btn-submit">Tìm kiếm</button>
                <c:if test="${role == 'admin' || role == 'manager'}">
                    <a href="instype?action=add" class="btn add-link" style="margin-left:12px;">Thêm mới</a>
                </c:if>
            </form>
            <table border="1" cellpadding="8" cellspacing="0" style="width:100%; background:#fff;">
                <tr style="background:#e0eafc;">
                    <th>STT</th>
                    <th>Tên loại bảo hiểm</th>
                    <th>Mô tả</th>
                    <th>Giá</th>
                        <c:if test="${role == 'admin' || role == 'manager'}">
                        <th>Hành động</th>
                        </c:if>
                </tr>
                <c:forEach var="t" items="${list}" varStatus="status">
                    <tr>
                        <td>${(currentPage-1)*5 + status.index + 1}</td>
                        <td>${t.name}</td>
                        <td>${t.description}</td>
                        <td><fmt:formatNumber value="${t.price}" type="number" groupingUsed="true" maxFractionDigits="0" />
</td>
                        <c:if test="${role == 'manager'}">
                            <td>
                                <div class="action-buttons">
                                    <a href="instype?action=edit&id=${t.id}" class="btn btn-submit">Sửa</a>
                                    <a href="instype?action=delete&id=${t.id}" class="btn btn-reset" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                                </div>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr><td colspan="5" style="text-align:center;">Không có dữ liệu</td></tr>
                </c:if>
            </table>
            <!-- Phân trang -->
            <div style="margin-top:18px; text-align:center;">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span style="font-weight:bold; color:#3895d3; margin:0 4px;">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="instype?action=list&page=${i}&keyword=${keyword}" style="margin:0 4px;">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </div>
    </body>
</html>