<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Cập nhật bảo hiểm</title>
        <link rel="stylesheet" href="Insurance/Insurance.css">
    </head>
    <body class="update-insurance-page">
        <jsp:include page="/header_emp.jsp" />
        <div class="form-container">
            <div class="form-title">Cập nhập bảo hiểm cho khách hàng</div>
            <form action="insurance" method="POST" autocomplete="off">
                <input type="hidden" name="service" value="updateInsurance">
                <input type="hidden" name="id" value="${insurance.id}">
                <c:if test="${not empty error}">
                    <div style="color: red; font-weight: bold; margin-bottom: 10px; text-align: center;">
                        ${error}
                    </div>
                </c:if>
                <table class="form-table" style="width:100%;">
                    <tr>
                        <td class="form-label">Khách Hàng</td>
                        <td>
                            <select class="form-select" name="userId">
                                <c:forEach var="u" items="${userList}">
                                    <option value="${u.id}" <c:if test="${u.id == insurance.userId}">selected</c:if>>${u.username}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-label">Loại Xe</td>
                        <td>
                            <select class="form-select" name="carTypeId">
                                <c:forEach var="c" items="${carType}">
                                    <option value="${c.id}" <c:if test="${c.id == insurance.carTypeId}">selected</c:if>>${c.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-label">Bảo Hiểm</td>
                        <td>
                            <select class="form-select" name="insuranceTypeId">
                                <c:forEach var="t" items="${insType}">
                                    <option value="${t.id}" <c:if test="${t.id == insurance.insuranceTypeId}">selected</c:if>>${t.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-label">Ngày Bắt Đầu</td>
                        <td><input class="form-input" type="date" name="startDate" value="${insurance.startDate}"></td>
                    </tr>
                    <tr>
                        <td class="form-label">Ngày Kết Thúc</td>
                        <td><input class="form-input" type="date" name="endDate" value="${insurance.endDate}"></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="form-actions">
                            <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px;">
                                <a href="insurance?service=listInsurance" class="btn btn-back">Danh sách bảo hiểm</a>
                                <div>
                                    <input class="btn btn-submit" type="submit" name="submit" value="Cập nhật">
                                    <input class="btn btn-reset" type="reset" value="Đặt lại">
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>