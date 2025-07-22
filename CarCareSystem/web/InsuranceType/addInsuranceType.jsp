<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thêm loại bảo hiểm</title>
    <link rel="stylesheet" href="InsuranceType/InsuranceType.css">
</head>
<body>
    <jsp:include page="/header_emp.jsp" />
    <div class="form-container">
        <div class="form-title">Thêm loại bảo hiểm</div>
        <c:if test="${not empty error}">
            <div style="color:red; text-align:center; margin-bottom:10px;">${error}</div>
        </c:if>
        <form action="instype" method="post" autocomplete="off">
            <input type="hidden" name="action" value="add">
            <table class="form-table" style="width:100%;">
                <tr>
                    <td class="form-label">Tên loại bảo hiểm</td>
                    <td>
                        <input class="form-input" type="text" name="name" required
                               value="${name != null ? name : ''}" maxlength="100" />
                    </td>
                </tr>
                <tr>
                    <td class="form-label">Mô tả</td>
                    <td>
                        <input class="form-input" type="text" name="description" required
                               value="${description != null ? description : ''}" maxlength="255" />
                    </td>
                </tr>
                <tr>
                    <td class="form-label">Giá</td>
                    <td>
                        <input class="form-input" type="number" name="price" min="1" step="0.01" required
                               value="${price != null ? price : ''}" />
                    </td>
                </tr>
            </table>
            <div class="form-actions">
                <button type="submit" name="submit" class="btn btn-submit">Thêm mới</button>
                <a href="instype?action=list" class="btn btn-reset">Hủy</a>
            </div>
        </form>
    </div>
</body>
</html>