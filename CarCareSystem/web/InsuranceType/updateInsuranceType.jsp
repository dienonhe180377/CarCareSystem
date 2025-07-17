<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cập nhật loại bảo hiểm</title>
    <link rel="stylesheet" href="InsuranceType/InsuranceType.css">
</head>
<body>
    <jsp:include page="/header_emp.jsp" />
    <div class="form-container">
        <div class="form-title">Cập nhật loại bảo hiểm</div>
        <c:if test="${not empty error}">
            <div style="color:red; text-align:center; margin-bottom:10px;">${error}</div>
        </c:if>
        <form action="instype" method="post" autocomplete="off">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="${type.id}" />
            <table class="form-table" style="width:100%;">
                <tr>
                    <td class="form-label">Tên loại bảo hiểm</td>
                    <td>
                        <input class="form-input" type="text" name="name" required
                               value="${type.name}" maxlength="100" />
                    </td>
                </tr>
                <tr>
                    <td class="form-label">Mô tả</td>
                    <td>
                        <input class="form-input" type="text" name="description" required
                               value="${type.description}" maxlength="255" />
                    </td>
                </tr>
                <tr>
                    <td class="form-label">Giá</td>
                    <td>
                        <input class="form-input" type="number" name="price" min="1" step="0.01" required
                               value="${type.price}" />
                    </td>
                </tr>
            </table>
            <div class="form-actions">
                <button type="submit" name="submit" class="btn btn-submit">Cập nhật</button>
                <a href="instype?action=list" class="btn btn-reset">Hủy</a>
            </div>
        </form>
    </div>
</body>
</html>