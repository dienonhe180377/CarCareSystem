<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Góp ý & Đánh giá dịch vụ</title>
        <style>
            body {
                background: linear-gradient(120deg,#e3f1fd 0%,#f7fbff 100%);
                font-family: 'Segoe UI', Arial, sans-serif;
                margin: 0;
                min-height: 100vh;
                font-size: 18px;
            }

            .fb-container {
                max-width: 800px;
                width: 100%;
                margin: 32px auto;
                background: #fff;
                border-radius: 24px;
                box-shadow: 0 8px 32px rgba(56,149,211,0.14);
                padding: 40px 32px;
                box-sizing: border-box;
            }

            h2 {
                color: #2696e8;
                font-size: 2.2rem;
                font-weight: 700;
                text-align: center;
                margin: 0 0 28px 0;
                letter-spacing: 0.5px;
            }
            h3 {
                color: #276678;
                font-size: 1.25rem;
                font-weight: 700;
                margin-top: 40px;
                margin-bottom: 20px;
                letter-spacing: 0.5px;
            }

            label {
                font-size: 1.08em;
                font-weight: 600;
                margin-bottom: 8px;
                color: #1e78c2;
                display: block;
            }

            .fb-form {
                margin-bottom: 24px;
            }
            .fb-form select {
                font-size: 1.12em;
                padding: 12px;
                border-radius: 8px;
                margin-bottom: 16px;
                border: 1.5px solid #b0c4de;
                background: #f5fcff;
                width: 100%;
            }

            .fb-form textarea {
                width: 100%;
                min-height: 140px;
                border-radius: 14px;
                border: 2px solid #cde3f6;
                padding: 22px;
                font-size: 1.12em;
                resize: vertical;
                margin-bottom: 18px;
                box-sizing: border-box;
                background: #f7fbff;
                transition: border 0.23s;
                line-height: 1.6;
            }
            .fb-form textarea:focus {
                border-color: #3895d3;
                outline: none;
            }

            .star-rating {
                font-size: 28px;
                cursor: pointer;
                display: inline-block;
                margin-bottom: 12px;
            }
            .star {
                color: #ccc;
                margin-right: 7px;
                transition: color 0.2s, transform 0.18s;
            }
            .star.selected,
            .star:hover,
            .star:hover ~ .star {
                color: #FFD700;
                transform: scale(1.18);
            }

            .btn {
                padding: 13px 32px;
                border-radius: 12px;
                border: none;
                font-size: 1.08em;
                font-weight: 600;
                background: linear-gradient(90deg,#2696e8 50%,#47b5ff 90%);
                color: #fff;
                cursor: pointer;
                margin-top: 8px;
                margin-right: 10px;
                box-shadow: 0 2px 10px rgba(56,149,211,0.09);
                transition: background 0.2s, box-shadow 0.2s;
                float: right;
                margin-left: 16px;
            }
            .btn:hover {
                background: linear-gradient(90deg, #276678, #2696e8);
                box-shadow: 0 6px 24px rgba(56,149,211,0.13);
            }

            /* feedback hiển thị */
            .feedback-item {
                position: relative;
                margin-bottom: 28px;
                padding: 22px 18px 8px 18px;
                background: #f8faff;
                border-radius: 14px;
                box-shadow: 0 2px 12px rgba(56,149,211,0.09);
            }
            .feedback-item:hover {
                box-shadow: 0 6px 18px rgba(56,149,211,0.13);
            }
            .fb-username {
                font-weight: 700;
                color: #2696e8;
                font-size: 1.07em;
                margin-bottom: 2px;
            }
            .fb-date {
                color: #888;
                font-size: 0.98em;
                margin-bottom: 6px;
            }
            .fb-service {
                color: #3895d3;
                font-size: 1em;
                margin-bottom: 4px;
            }
            .fb-rating {
                font-size: 1em;
                margin-bottom: 6px;
            }
            .stars {
                color: gold;
                font-size: 1.35em;
                letter-spacing: 2px;
            }
            .fb-desc {
                margin: 10px 0 16px 0;
                white-space: pre-line;
                font-size: 1.1em;
                color: #222;
                background: #e3f1fd;
                border-radius: 8px;
                padding: 12px 16px;
            }

            .dot-btn {
                background: none;
                border: none;
                font-size: 22px;
                cursor: pointer;
                position: absolute;
                top: 18px;
                right: 18px;
                color: #3895d3;
                z-index: 11;
                transition: color 0.2s;
            }
            .dot-btn:hover {
                color: #276678;
            }

            .action-menu {
                display: none;
                position: absolute;
                top: 44px;
                right: 18px;
                background: #fff;
                border: 2px solid #b0c4de;
                border-radius: 10px;
                z-index: 20;
                min-width: 120px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.13);
                overflow: hidden;
            }
            .action-menu button, .action-menu form {
                display: block;
                width: 100%;
                border: none;
                background: none;
                padding: 8px 16px;
                cursor: pointer;
                text-align: left;
                margin: 0;
                font-size: 1em;
                color: #276678;
                transition: background 0.18s, color 0.18s;
            }
            .action-menu button:hover, .action-menu form:hover {
                background: #e3f1fd;
                color: #3895d3;
            }

            .edit-form {
                margin-top: 14px;
                background: #e3f1fd;
                border-radius: 11px;
                padding: 14px 16px;
            }
            .edit-form textarea {
                width: 100%;
                min-height: 110px;
                border-radius: 12px;
                border: 2px solid #3895d3;
                padding: 20px;
                font-size: 1.07em;
                background: #f7fbff;
                margin-bottom: 10px;
                box-sizing: border-box;
                line-height: 1.4;
            }
            .edit-form textarea:focus {
                border-color: #276678;
                outline: none;
            }

            a {
                color: #3895d3;
                text-decoration: none;
                font-weight: 500;
                font-size: 1em;
            }
            a:hover {
                color: #276678;
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/header.jsp" />
        <div class="fb-container">
            <h2>Góp ý & Đánh giá dịch vụ</h2>

            <!-- Hiển thị form nếu người dùng đã đăng nhập -->
            <c:if test="${not empty sessionScope.user}">
                <form method="post" action="feedback" class="fb-form">
                    <label for="serviceId">Dịch vụ bạn đã sử dụng:</label>
                    <select name="serviceId" required>
                        <c:forEach var="s" items="${serviceList}">
                            <option value="${s.id}">${s.name}</option>
                        </c:forEach>
                    </select>

                    <label for="description">Ý kiến của bạn về dịch vụ:</label>
                    <textarea name="description" rows="6" placeholder="Nhập ý kiến, đánh giá, góp ý..." required></textarea>

                    <label for="rating">Đánh giá chất lượng:</label>
                    <input type="hidden" name="rating" id="rating-value" value="0"/>
                    <div class="star-rating" id="rating-stars">
                        <span class="star" data-value="1">★</span>
                        <span class="star" data-value="2">★</span>
                        <span class="star" data-value="3">★</span>
                        <span class="star" data-value="4">★</span>
                        <span class="star" data-value="5">★</span>
                    </div>
                    <button type="submit" class="btn">Gửi góp ý</button>
                </form>
            </c:if>

            <!-- Nếu chưa đăng nhập -->
            <c:if test="${empty sessionScope.user}">
                <p style="text-align:center;font-size:1.08em;">
                    Bạn cần <a href="login">đăng nhập</a> để gửi góp ý & đánh giá dịch vụ.
                </p>
            </c:if>

            <h3>Phản hồi từ khách hàng</h3>
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
                        <button class="dot-btn" type="button" onclick="showMenu(${fb.id}, event)">&#8942;</button>
                        <div class="action-menu" id="menu-${fb.id}">
                            <button type="button" onclick="showEditForm(${fb.id}, '${fb.description}')">Sửa</button>
                            <form method="post" action="feedback" style="margin:0;">
                                <input type="hidden" name="action" value="delete"/>
                                <input type="hidden" name="id" value="${fb.id}"/>
                                <button type="submit" onclick="return confirm('Bạn có chắc muốn xóa phản hồi này?')">Xóa</button>
                            </form>
                        </div>
                    </c:if>

                    <!-- Form sửa -->
                    <form method="post" action="feedback" class="edit-form" id="edit-form-${fb.id}" style="display:none;">
                        <input type="hidden" name="action" value="update"/>
                        <input type="hidden" name="id" value="${fb.id}"/>
                        <textarea name="description" rows="5" required>${fb.description}</textarea>
                        <input type="hidden" name="rating" value="${fb.rating}"/>
                        <button type="submit" class="btn">Lưu</button>
                        <button type="button" class="btn" onclick="hideEditForm(${fb.id})">Hủy</button>
                    </form>
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
                s.style.color = (parseInt(s.dataset.value) <= value) ? "#FFD700" : "#ccc";
            });
        });
    });

    // Đảm bảo người dùng đã chọn sao trước khi submit
    const feedbackForm = document.querySelector(".fb-form");
    feedbackForm && feedbackForm.addEventListener("submit", function (e) {
        const rating = parseInt(document.getElementById("rating-value").value);
        if (rating === 0) {
            alert("Vui lòng chọn số sao đánh giá trước khi gửi góp ý!");
            e.preventDefault(); // Ngăn submit
        }
    });

    // Menu hành động
    function showMenu(id, event) {
        event.stopPropagation();
        document.querySelectorAll('.action-menu').forEach(e => e.style.display = 'none');
        var menu = document.getElementById('menu-' + id);
        if(menu) menu.style.display = 'block';
        document.addEventListener('click', function hideMenu(e) {
            menu.style.display = 'none';
            document.removeEventListener('click', hideMenu);
        });
    }
    function showEditForm(id, desc) {
        document.getElementById('edit-form-' + id).style.display = 'block';
        document.getElementById('menu-' + id).style.display = 'none';
        document.querySelector('#edit-form-' + id + ' textarea').value = desc;
    }
    function hideEditForm(id) {
        document.getElementById('edit-form-' + id).style.display = 'none';
    }
</script>
    </body>
</html>