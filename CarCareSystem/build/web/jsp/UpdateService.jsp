<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${pageTitle}</title>
    <style>
        body { background: #f4f7fb; font-family: Arial, sans-serif; }
        .form-container {
            background: #fff;
            max-width: 520px;
            margin: 44px auto;
            border-radius: 14px;
            padding: 36px 34px 22px 34px;
            box-shadow: 0 8px 32px 0 rgba(31,38,135,0.11);
        }
        .form-title { font-size: 2rem; color: #2563eb; font-weight: 700; text-align: center; margin-bottom: 18px; }
        .tieu-de { font-size: 1.3rem; color: #166bb3; font-weight: 600; text-align: center; margin-bottom: 20px; }
        table { width: 100%; border-collapse: separate; border-spacing: 0 13px;}
        .form-label { width: 120px; color: #333; font-weight: 500; vertical-align: top; }
        .form-input[type="text"], .form-input[type="number"] {
            width: 100%; padding: 8px 10px; border-radius: 7px;
            border: 1.3px solid #b7c7d7; font-size: 1.1rem;
        }
        .form-input[type="file"] { font-size: 1rem; }
        .form-actions { text-align: right; }
        .btn { padding: 8px 22px; border-radius: 6px; border: none; font-size: 1rem; font-weight: 600; }
        .btn-submit { background: #2563eb; color: #fff; }
        .btn-submit:hover { background: #1746a2; }
        .btn-reset { background: #888; color: #fff; margin-left: 8px; }
        .alert { text-align: center; margin-bottom: 12px;}
        .alert-error { color: #e74c3c; }
        .alert-success { color: #27ae60; }
        .checkbox-list { display: flex; flex-wrap: wrap; gap: 8px; }
        .checkbox-item { background: #f1f6ff; border-radius: 6px; padding: 4px 8px; }
        @media (max-width: 600px) {
            .form-container { padding: 12px 3vw; max-width: 97vw;}
            table { font-size: 0.98rem;}
            .form-title { font-size: 1.2rem;}
            .checkbox-list { flex-direction: column; }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="form-title">${pageTitle}</div>
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <h2 class="tieu-de">Cập nhật dịch vụ</h2>
        <c:choose>
            <c:when test="${role == 'admin' || role == 'manager' || role == 'maketing'}">
                <form action="ServiceServlet_JSP" method="POST" enctype="multipart/form-data" autocomplete="off">
                    <input type="hidden" name="id" value="${service.id}">
                    <table>
                        <tr>
                            <td class="form-label">Tên dịch vụ</td>
                            <td>
                                <input class="form-input" type="text" name="name" required minlength="3" maxlength="29"
                                       pattern="^[\p{L} ]+$"
                                       title="Chỉ nhập chữ cái, không số, không ký tự đặc biệt"
                                       value="${service != null ? service.name : ''}" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label">Mô tả</td>
                            <td>
                                <input class="form-input" type="text" name="description" required minlength="3" maxlength="29"
                                       pattern="^[\p{L} ]+$"
                                       title="Chỉ nhập chữ cái, không số, không ký tự đặc biệt"
                                       value="${service != null ? service.description : ''}" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label">Giá dịch vụ</td>
                            <td>
                                <input class="form-input" type="number" name="price" required 
                                       min="1" max="999999999" step="1"
                                       value="${service.price}" autocomplete="off">
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label">Ảnh dịch vụ</td>
                            <td>
                                <input class="form-input" type="file" name="img" accept="image/*">
                                <c:if test="${not empty service.img}">
                                    <div style="margin-top:10px">
                                        <img src="${pageContext.request.contextPath}/${service.img}" width="120" alt="Ảnh dịch vụ hiện tại">
                                        <div style="font-size:12px;color:#888;">Ảnh hiện tại</div>
                                    </div>
                                </c:if>
                                <input type="hidden" name="imgOld" value="${service.img}" />
                            </td>
                        </tr>
                        <tr>
                            <td class="form-label" style="vertical-align:top;">Phụ tùng liên quan</td>
                            <td>
                                <div class="checkbox-list">
                                    <c:forEach var="part" items="${allParts}">
                                        <label class="checkbox-item">
                                            <input type="checkbox" name="partIds" value="${part.id}"
                                                <c:if test="${selectedPartIds != null && selectedPartIds.contains(part.id)}">checked</c:if>
                                            >
                                            ${part.name}
                                        </label>
                                    </c:forEach>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="form-actions">
                                <input class="btn btn-submit" type="submit" name="submit" value="Cập nhật dịch vụ">
                                <input class="btn btn-reset" type="reset" value="Làm lại">
                                <input type="hidden" name="service" value="updateService">
                            </td>
                        </tr>
                    </table>
                </form>
            </c:when>
            <c:otherwise>
                <div style="color:red;text-align:center;margin-top:16px">
                    Bạn không có quyền truy cập chức năng này.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>