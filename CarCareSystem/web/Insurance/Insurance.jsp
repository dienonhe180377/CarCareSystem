<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh sách bảo hiểm</title>
    <link rel="stylesheet" href="Insurance/Insurance.css">
</head>
<body class="list-insurance-page">
    <jsp:include page="/header_emp.jsp" />
    <div class="container">
        <div class="insurance-title">Danh sách bảo hiểm khách hàng</div>
        <div style="margin-bottom: 18px;">
        <a href="instype?action=list" class="btn btn-submit">Danh sách loại bảo hiểm</a>
    </div>
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; margin-bottom: 18px;">
    <c:if test="${role == 'admin' || role == 'manager' || role == 'maketing'}">
        <a href="insurance?service=addInsurance" class="btn add-link">Thêm mới bảo hiểm</a>
    </c:if>
    <form action="insurance" method="get" style="display: flex; gap: 8px; align-items: center;">
        <input type="hidden" name="service" value="listInsurance">
        <input type="text" name="keyword" value="${param.keyword}" placeholder="Tìm theo tên khách hàng hoặc loại xe"
               class="form-input" style="width: 310px;">
        <button type="submit" class="btn btn-submit">Tìm kiếm</button>
    </form>
</div>
            
        <table>
            <tr>
                <th>STT</th>
                <th>Khách Hàng</th>
                <th>Loại Xe</th>
                <th>Ngày Bắt Đầu</th>
                <th>Ngày Kết Thúc</th>
                <th>Chi tiết</th>
                <th>Hành động</th>
            </tr>
            <c:forEach var="i" items="${data}" varStatus="status">
                <c:set var="userName" value="" />
                <c:forEach var="u" items="${userList}">
                    <c:if test="${u.id == i.userId}">
                        <c:set var="userName" value="${u.username}" />
                    </c:if>
                </c:forEach>

                <c:set var="carTypeName" value="" />
                <c:forEach var="c" items="${carTypeList}">
                    <c:if test="${c.id == i.carTypeId}">
                        <c:set var="carTypeName" value="${c.name}" />
                    </c:if>
                </c:forEach>

                <c:set var="typeName" value="" />
                <c:set var="typePrice" value="" />
                <c:set var="typeDescription" value="" />
                <c:forEach var="t" items="${insType}">
                    <c:if test="${t.id == i.insuranceTypeId}">
                        <c:set var="typeName" value="${t.name}" />
                        <c:set var="typePrice" value="${t.price}" />
                        <c:set var="typeDescription" value="${t.description}" />
                    </c:if>
                </c:forEach>

                <tr>
                    <td>${(currentPage-1)*5 + status.index + 1}</td>
                    <td>${userName}</td>
                    <td>${carTypeName}</td>
                    <td><fmt:formatDate value="${i.startDate}" pattern="dd-MM-yyyy" /></td>
                    <td><fmt:formatDate value="${i.endDate}" pattern="dd-MM-yyyy" /></td>
                    <td>
                        <button class="btn" onclick="showDetail(
                            '${userName}',
                            '${carTypeName}',
                            '${typeName}',
                            '${i.startDate}',
                            '${i.endDate}',
                            '${typePrice}',
                            '${typeDescription}'
                        )">Chi tiết</button>
                    </td>
                    <td>
                        <c:if test="${role == 'admin' || role == 'manager' || role == 'maketing'}">
                            <a href="insurance?service=updateInsurance&id=${i.id}" class="btn">Sửa</a>
                            <a href="insurance?service=deleteInsurance&id=${i.id}" class="btn btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?');">Xóa</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <div style="text-align:center; margin-top:16px;">
            <c:if test="${currentPage > 1}">
                <a href="insurance?service=listInsurance&page=${currentPage - 1}" class="btn">Trang trước</a>
            </c:if>
            <span>Trang ${currentPage} / ${totalPages}</span>
            <c:if test="${currentPage < totalPages}">
                <a href="insurance?service=listInsurance&page=${currentPage + 1}" class="btn">Trang sau</a>
            </c:if>
        </div>
    </div>

    <!-- Modal chi tiết -->
    <div id="detailModal" class="modal-bg">
        <div class="modal-content">
            <h2>Chi tiết bảo hiểm</h2>
            <div id="modalContent"></div>
            <button class="btn" onclick="closeModal()">Đóng</button>
        </div>
    </div>

    <script src="Insurance/Insurance.js"></script>
</body>
</html>