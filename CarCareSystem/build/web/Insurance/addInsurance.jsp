<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm bảo hiểm</title>
        <link rel="stylesheet" href="Insurance/Insurance.css">
    </head>
    <body class="add-insurance-page">
        <jsp:include page="/header_emp.jsp" />

        <div class="form-container">
            <div class="form-title">Thêm bảo hiểm cho khách hàng</div>
            <c:if test="${not empty error}">
                <div style="color:red; text-align:center; margin-bottom:10px;">${error}</div>
            </c:if>
            <form action="insurance" method="POST" autocomplete="off">
                <table class="form-table" style="width:100%;">
                    <tr>
                        <td class="form-label">Khách Hàng</td>
                        <td>
                            <select class="form-select" name="userId" required>
                                <c:forEach var="u" items="${userList}">
                                    <option value="${u.id}">${u.username}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-label">Loại Xe</td>
                        <td>
                            <select class="form-select" name="carTypeId" required>
                                <c:forEach var="c" items="${carType}">
                                    <option value="${c.id}">${c.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-label">Bảo Hiểm</td>
                        <td>
                            <select class="form-select" name="insuranceTypeId" required>
                                <c:forEach var="t" items="${insType}">
                                    <option value="${t.id}">${t.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-label">Ngày Bắt Đầu</td>
                        <td><input class="form-input" type="date" name="startDate" required></td>
                    </tr>
                    <tr>
                        <td class="form-label">Ngày Kết Thúc</td>
                        <td><input class="form-input" type="date" name="endDate" required></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="form-actions">
                            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px;">
                                <a href="insurance?service=listInsurance" class="btn btn-back">Danh sách bảo hiểm</a>
                                <div>
                                    <input class="btn btn-submit" type="submit" name="submit" value="Thêm">
                                    <input class="btn btn-reset" type="reset" value="Đặt lại">
                                </div>
                            </div>
                            <input type="hidden" name="service" value="addInsurance">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>