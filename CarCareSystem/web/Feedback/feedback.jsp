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
        <jsp:include page="/header.jsp" />
        <div class="fb-container">
            <h2>Gửi Feedback</h2>

            <!-- Hiển thị form nếu người dùng đã đăng nhập -->
            <c:if test="${not empty sessionScope.user}">
                <form method="post" action="feedback" class="fb-form">
                    <!-- Chọn dịch vụ -->
                    <label for="serviceId">Chọn dịch vụ:</label>
                    <select name="serviceId" required>
                        <c:forEach var="s" items="${serviceList}">
                            <option value="${s.id}">${s.name}</option>
                        </c:forEach>
                    </select>
                    <br><br>

                    <!-- Nhập mô tả -->
                    <textarea name="description" rows="3" placeholder="Feedback của bạn..." required></textarea>
                    <br>

                    <!-- Chọn đánh giá -->
                    <!-- Chọn đánh giá bằng sao -->
<label for="rating">Đánh giá:</label>
<input type="hidden" name="rating" id="rating-value" value="0"/>
<div class="star-rating" id="rating-stars">
    <span class="star" data-value="1">★</span>
    <span class="star" data-value="2">★</span>
    <span class="star" data-value="3">★</span>
    <span class="star" data-value="4">★</span>
    <span class="star" data-value="5">★</span>
</div>

                    <br><br>

                    <button type="submit" class="btn">Gửi</button>
                </form>
            </c:if>

            <!-- Nếu chưa đăng nhập -->
            <c:if test="${empty sessionScope.user}">
                <p>Bạn cần <a href="login">đăng nhập</a>
                    để gửi feedback.</p>
                </c:if>

            <hr>
            <h3>Danh sách Feedback</h3>

            <c:forEach var="fb" items="${feedbackList}">
                <div class="feedback-item" id="fb-${fb.id}">
                    <div class="fb-username">
                        <strong>${fb.username}</strong>
                    </div>
                    <div class="fb-date">
                        <fmt:formatDate value="${fb.createDate}" pattern="dd/MM/yyyy HH:mm"/>
                    </div>
                    <div class="fb-service">
                        Dịch vụ: <c:out value="${fb.serviceName}" />
                    </div>
                    <div class="fb-rating">
                        Đánh giá:
                        <span class="stars">
                            <c:forEach var="i" begin="1" end="${fb.rating}">
                                ★
                            </c:forEach>
                        </span>
                    </div>

                    <div class="fb-desc" id="desc-${fb.id}">
                        <c:out value="${fb.description}" />
                    </div>

                    <!-- Nếu là người viết feedback -->
                    <c:if test="${fb.userId == sessionScope.user.id}">
                        <button class="dot-btn" type="button" onclick="showMenu(${fb.id}, event)">...</button>
                        <div class="action-menu" id="menu-${fb.id}">
                            <button type="button" onclick="showEditForm(${fb.id}, '${fb.description}')">Sửa</button>
                            <form method="post" action="feedback" style="margin:0;">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="id" value="${fb.id}"/>
                                <button type="submit" onclick="return confirm('Bạn có chắc muốn xóa feedback này?')">Xóa</button>
                            </form>
                        </div>
                    </c:if>

                    <!-- Form sửa -->
                    <form method="post" action="feedback" class="edit-form" id="edit-form-${fb.id}" style="display:none;">
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="id" value="${fb.id}"/>
                        <textarea name="description" rows="2" required>${fb.description}</textarea>
                        <br>
                        
                        <input type="hidden" name="rating" value="${fb.rating}"/>
                        <br>
                        <button type="submit" class="btn">Lưu</button>
                        <button type="button" class="btn" onclick="hideEditForm(${fb.id})">Hủy</button>
                    </form>

                    <hr>
                </div>
            </c:forEach>
        </div>
<script>
    // Rating bằng sao cho form gửi feedback mới
    const ratingStars = document.querySelectorAll("#rating-stars .star");
    const ratingValue = document.getElementById("rating-value");

    ratingStars.forEach(star => {
        star.addEventListener("click", () => {
            const value = parseInt(star.dataset.value);
            ratingValue.value = value;

            // Tô màu sao đã chọn
            ratingStars.forEach(s => {
                s.style.color = (parseInt(s.dataset.value) <= value) ? "gold" : "#ccc";
            });
        });
    });
</script>

        <script src="Feedback/feedback.js"></script>
    </body>
</html>
