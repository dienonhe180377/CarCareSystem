<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh sách bảo hiểm</title>
    <link rel="stylesheet" href="Insurance/Insurance.css">
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
                <th>STT</th>
                <th>Car Type ID</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Chi tiết</th>
                <th>Hành động</th>
            </tr>
            <c:forEach var="i" items="${data}" varStatus="status">
                <tr>
                    <td>${(currentPage-1)*5 + status.index + 1}</td>
                    <td>${i.carTypeId}</td>
                    <td>${i.startDate}</td>
                    <td>${i.endDate}</td>
                    <td>
                        <button class="btn" onclick="showDetail(
                            '${i.id}',
                            '${i.userId}',
                            '${i.carTypeId}',
                            '${i.startDate}',
                            '${i.endDate}',
                            '${i.price}',
                            '${i.description}'
                        )">Chi tiết</button>
                    </td>
                    <c:if test="${role == 'admin' || role == 'manager' || role == 'maketing'}">
                <td>
                    <a href="insurance?service=updateInsurance&id=${i.id}" class="btn">Sửa</a>
                    <a href="insurance?service=deleteInsurance&id=${i.id}" class="btn btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?');">Xóa</a>
                </td>
            </c:if>
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