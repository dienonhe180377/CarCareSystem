<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback</title>
    <link rel="stylesheet" href="Feedback/feedback.css">
</head>
<body>
    <div class="fb-container">
        <h2>Gửi feedback</h2>
        <form method="post" action="feedback" class="fb-form">
            <textarea name="description" rows="3" placeholder="Feedback của bạn..." required></textarea>
            <br>
            <button type="submit" class="btn">Gửi</button>
        </form>
        <hr>
        <h3>Danh sách feedback</h3>
        <c:forEach var="fb" items="${feedbackList}">
            <div class="feedback-item" id="fb-${fb.id}">
                <div class="fb-username">
                    <c:out value="${feedbackDAO.getUsernameByUserId(fb.userId)}" />
                </div>
                <div class="fb-date">
                    <fmt:formatDate value="${fb.createDate}" pattern="dd/MM/yyyy H:mm"/>
                </div>
                <div class="fb-desc" id="desc-${fb.id}">
                    <c:out value="${fb.description}" />
                </div>
                <!-- Nút ... -->
                <button class="dot-btn" type="button" onclick="showMenu(${fb.id}, event)">...</button>
                <!-- Menu sửa/xóa -->
                <div class="action-menu" id="menu-${fb.id}">
                    <button type="button" onclick="showEditForm(${fb.id}, '${fb.description}')">Sửa</button>
                    <form method="post" action="feedback" style="margin:0;">
                        <input type="hidden" name="action" value="delete"/>
                        <input type="hidden" name="id" value="${fb.id}"/>
                        <button type="submit" onclick="return confirm('Bạn có chắc muốn xóa feedback này?')">Xóa</button>
                    </form>
                </div>
                <!-- Form sửa -->
                <form method="post" action="feedback" class="edit-form" id="edit-form-${fb.id}" style="display:none;">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id" value="${fb.id}"/>
                    <textarea name="description" rows="2" style="width:100%;" required></textarea>
                    <br>
                    <button type="submit" class="btn">Lưu</button>
                    <button type="button" class="btn" onclick="hideEditForm(${fb.id})">Hủy</button>
                </form>
                <hr>
            </div>
        </c:forEach>
    </div>
    <script src="Feedback/feedback.js"></script>
</body>
</html>