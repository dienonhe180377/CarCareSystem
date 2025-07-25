<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Loại bảo hiểm</title>
    <link rel="stylesheet" href="InsuranceType/InsuranceTypeCustomer.css">
</head>
<body>
    <jsp:include page="/header.jsp" />
    <div class="container">
        <h2 class="page-title">Loại bảo hiểm</h2>

        <form class="search-bar" action="instype" method="get">
            <input type="hidden" name="action" value="list" />
            <input type="text" name="keyword" value="${keyword}" placeholder="Tìm loại bảo hiểm..." />
            <button type="submit">Tìm</button>
        </form>

        <div class="card-grid">
            <c:forEach var="t" items="${list}">
                <div class="card">
                    <div class="card-title">${t.name}</div>
                    <div class="card-desc">${t.description}</div>
                    <div class="card-price">
                        <fmt:formatNumber value="${t.price}" type="number" groupingUsed="true" maxFractionDigits="0" /> VND

                    </div>
                    <a href="" class="buy-btn">Mua ngay</a>

                </div>
            </c:forEach>
        </div>

        <c:if test="${empty list}">
            <p style="text-align:center; margin-top:20px;">Không có dữ liệu bảo hiểm nào.</p>
        </c:if>

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
