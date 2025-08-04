<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đơn hàng chưa đánh giá</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --success-color: #4cc9f0;
                --light-color: #f8f9fa;
                --dark-color: #212529;
                --gray-color: #6c757d;
                --border-color: #dee2e6;
                --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            }

            body {
                background-color: #f5f7fb;
                color: var(--dark-color);
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
            }

            /* Header */
            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 1px solid var(--border-color);
            }

            .logo {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .logo i {
                font-size: 28px;
                color: var(--primary-color);
            }

            .logo h1 {
                font-size: 24px;
                font-weight: 700;
                color: var(--primary-color);
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .user-info .avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: var(--success-color);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: bold;
            }

            .user-info .name {
                font-weight: 600;
            }

            /* Filter Section */
            .filters {
                background: white;
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 30px;
                box-shadow: var(--card-shadow);
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
            }

            .filter-group {
                flex: 1;
                min-width: 200px;
            }

            .filter-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: var(--gray-color);
            }

            .filter-group select,
            .filter-group input {
                width: 100%;
                padding: 10px 15px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-size: 15px;
                background: white;
            }

            .filter-group input {
                background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%236c757d"><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/></svg>');
                background-repeat: no-repeat;
                background-position: right 15px center;
                background-size: 18px;
            }

            /* Stats */
            .stats {
                display: flex;
                gap: 20px;
                margin-bottom: 30px;
                flex-wrap: wrap;
            }

            .stat-card {
                flex: 1;
                min-width: 200px;
                background: white;
                border-radius: 12px;
                padding: 20px;
                box-shadow: var(--card-shadow);
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .stat-icon {
                width: 50px;
                height: 50px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
            }

            .stat-icon.blue {
                background: rgba(67, 97, 238, 0.15);
                color: var(--primary-color);
            }

            .stat-icon.green {
                background: rgba(76, 201, 240, 0.15);
                color: var(--success-color);
            }

            .stat-info h3 {
                font-size: 24px;
                font-weight: 700;
                margin-bottom: 5px;
            }

            .stat-info p {
                color: var(--gray-color);
                font-size: 14px;
            }

            /* Orders List */
            .orders-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .orders-header h2 {
                font-size: 20px;
                font-weight: 600;
            }

            .order-list {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .order-card {
                background: white;
                border-radius: 12px;
                padding: 20px;
                box-shadow: var(--card-shadow);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .order-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
            }

            .order-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
                padding-bottom: 15px;
                border-bottom: 1px solid var(--border-color);
            }

            .order-id {
                font-weight: 600;
                color: var(--primary-color);
            }

            .order-date {
                color: var(--gray-color);
                font-size: 14px;
            }

            .order-status {
                background: #fff9db;
                color: #e67700;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 500;
            }

            .order-products {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }

            .product-item {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 10px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                flex: 1;
                min-width: 250px;
            }

            .product-image {
                width: 60px;
                height: 60px;
                border-radius: 8px;
                background: #f1f3f9;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
                color: var(--primary-color);
            }

            .product-info h4 {
                font-weight: 600;
                margin-bottom: 5px;
            }

            .product-info p {
                color: var(--gray-color);
                font-size: 14px;
            }

            .order-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 15px;
                padding-top: 15px;
                border-top: 1px solid var(--border-color);
            }

            .order-total {
                font-weight: 700;
                font-size: 18px;
                color: var(--dark-color);
            }

            .order-actions {
                display: flex;
                gap: 10px;
            }

            .btn {
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                border: none;
                font-size: 15px;
            }

            .btn-primary {
                background: var(--primary-color);
                color: white;
            }

            .btn-primary:hover {
                background: var(--secondary-color);
            }

            .btn-outline {
                background: transparent;
                border: 1px solid var(--border-color);
                color: var(--gray-color);
            }

            .btn-outline:hover {
                background: #f8f9fa;
            }

            .empty-state {
                text-align: center;
                padding: 40px;
                background: white;
                border-radius: 12px;
                box-shadow: var(--card-shadow);
            }

            .empty-state i {
                font-size: 64px;
                color: #adb5bd;
                margin-bottom: 20px;
            }

            .empty-state h3 {
                font-size: 24px;
                margin-bottom: 10px;
                color: var(--gray-color);
            }

            .empty-state p {
                color: var(--gray-color);
                margin-bottom: 20px;
            }

            /* Rating Popup */
            .rating-popup {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 1000;
                justify-content: center;
                align-items: center;
            }

            .rating-content {
                background: white;
                border-radius: 16px;
                width: 90%;
                max-width: 500px;
                padding: 30px;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
                position: relative;
                animation: popupFadeIn 0.3s ease;
            }

            @keyframes popupFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .rating-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .rating-header h3 {
                font-size: 22px;
                font-weight: 600;
                color: var(--dark-color);
            }

            .close-popup {
                background: none;
                border: none;
                font-size: 24px;
                cursor: pointer;
                color: var(--gray-color);
                transition: color 0.2s;
            }

            .close-popup:hover {
                color: var(--dark-color);
            }

            .rating-stars {
                position: relative;
                display: flex;
                justify-content: center;
                width: 100%;
                margin: 25px 0;
            }

            .star-select {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                opacity: 0;
                cursor: pointer;
                z-index: 10;
            }

            .star-display {
                display: flex;
                justify-content: center;
                gap: 12px;
                pointer-events: none;
            }

            .star-display i {
                font-size: 36px;
                color: #ddd;
                transition: color 0.2s, transform 0.2s;
            }

            .star-display i.active {
                color: #ffc107;
            }

            .rating-text {
                text-align: center;
                font-size: 16px;
                color: var(--gray-color);
                margin-bottom: 20px;
                min-height: 24px;
            }

            .rating-comment {
                width: 100%;
                min-height: 120px;
                padding: 15px;
                border: 1px solid var(--border-color);
                border-radius: 10px;
                font-size: 15px;
                resize: vertical;
                margin-bottom: 20px;
            }

            .rating-comment:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
            }

            .rating-actions {
                display: flex;
                gap: 15px;
            }

            .rating-actions .btn {
                flex: 1;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .filters {
                    flex-direction: column;
                }

                .order-header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .order-footer {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 15px;
                }

                .order-actions {
                    width: 100%;
                }

                .order-actions .btn {
                    flex: 1;
                    text-align: center;
                }

                .rating-content {
                    padding: 20px;
                }

                .star-display i {
                    font-size: 30px;
                }
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp"></jsp:include>

            <div class="container" style="margin-top: 4%;">
                <!-- Stats -->
                <div class="stats">
                    <div class="stat-card">
                        <div class="stat-icon blue">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <div class="stat-info">
                            <h3>${feedbackList.size()}</h3>
                        <p>Tổng số feedback</p>
                    </div>
                </div>

                <c:set var="unrated" value="0"></c:set>
                <c:forEach var="task" items="${feedbackList}">
                    <c:if test="${task.status == false}">
                        <c:set var="unrated" value="${unrated + 1}" />
                    </c:if>
                </c:forEach>
                <div class="stat-card">
                    <div class="stat-icon green">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-info">
                        <h3>${unrated}</h3>
                        <p>Đơn chưa đánh giá</p>
                    </div>
                </div>
            </div>

            <!-- Filters -->
            <div class="filters">
                <div class="filter-group">
                    <label for="status-filter">Trạng thái</label>
                    <select id="status-filter">
                        <option>Tất cả trạng thái</option>
                        <option selected>Chưa đánh giá</option>
                        <option>Đã đánh giá</option>
                    </select>
                </div>
            </div>

            <!-- Orders List -->
            <div class="orders-container">
                <div class="orders-header">
                    <h2><i class="fas fa-list"></i> Danh sách đơn hàng</h2>
                </div>

                <div class="order-list" id="order-list">

                    <c:forEach var="feedbacks" items="${feedbackList}">
                        <div class="order-card">
                            <div class="order-header">
                                <div>
                                    <div class="order-date">${feedbacks.createDate}</div>
                                </div>
                                <c:if test="${feedbacks.status == false}">
                                    <div class="order-status">Chưa đánh giá</div>
                                </c:if>
                            </div>
                            <div class="order-products">

                                <c:forEach var="service" items="${feedbacks.order.services}">
                                    <div class="product-item">
                                        <div class="product-image">
                                            <i class="fas fa-cog"></i>
                                        </div>
                                        <div class="product-info">
                                            <h4>${service.name}</h4>
                                            <p>Dịch vụ</p>
                                        </div>
                                    </div>
                                </c:forEach>

                                <c:forEach var="part" items="${feedbacks.order.parts}">
                                    <div class="product-item">
                                        <div class="product-image">
                                            <i class="fas fa-plug"></i>
                                        </div>
                                        <div class="product-info">
                                            <h4>${part.name}</h4>
                                            <p>Linh kiện</p>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>
                            <div class="order-footer">
                                <div class="order-total">Tổng tiền: ${feedbacks.order.price} ₫</div>
                                <div class="order-actions">
                                    <button class="btn btn-primary btn-rate" data-order-id="${feedbacks.id}" 
                                            <c:if test="${feedbacks.status == true}">disabled</c:if>>
                                        <c:if test="${feedbacks.status == false}">Đánh giá ngay</c:if>
                                        <c:if test="${feedbacks.status == true}">Bạn đã đánh giá đơn hàng này</c:if>
                                        </button>
                                    </div>
                                </div>
                            </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <form action="${contextPath}/EmployeeFeedbackController" method="post">
            <!-- Rating Popup -->
            <div class="rating-popup" id="ratingPopup">
                <input type="hidden" name="service" value="rate">
                <div class="rating-content">
                    <div class="rating-header">
                        <h3 id="popupTitle">Đánh giá đơn hàng</h3>
                        <button type="button" class="close-popup">&times;</button>
                    </div>

                    <!-- Input ẩn chứa ID đơn hàng -->
                    <input type="hidden" id="orderIdInput" name="feedbackId">

                    <div class="rating-stars">
                        <select id="starSelect" class="star-select" name="rating">
                            <option value="0">Vui lòng chọn sao</option>
                            <option value="1">★☆☆☆☆ (1 sao)</option>
                            <option value="2">★★☆☆☆ (2 sao)</option>
                            <option value="3">★★★☆☆ (3 sao)</option>
                            <option value="4">★★★★☆ (4 sao)</option>
                            <option value="5">★★★★★ (5 sao)</option>
                        </select>
                        <div class="star-display">
                            <i class="far fa-star"></i>
                            <i class="far fa-star"></i>
                            <i class="far fa-star"></i>
                            <i class="far fa-star"></i>
                            <i class="far fa-star"></i>
                        </div>
                    </div>
                    <div class="rating-text" id="ratingText">Vui lòng chọn số sao</div>
                    <textarea class="rating-comment" id="ratingComment" name="comment" placeholder="Chia sẻ cảm nhận của bạn về sản phẩm/dịch vụ..."></textarea>
                    <div class="rating-actions">
                        <button type="button" class="btn btn-outline" id="cancelRating">Hủy bỏ</button>
                        <button type="submit" class="btn btn-primary" id="submitRating">Gửi đánh giá</button>
                    </div>
                </div>
            </div>
        </form>
        <c:if test="${not empty checkError}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    var checkError = `${checkError}`;
                    if (checkError === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: 'Đánh giá Thành Công!',
                            showConfirmButton: false,
                            timer: 1500
                        }).then(() => {
                            window.location.href = '${contextPath}/EmployeeFeedbackController?service=customer_list';
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Có lỗi xảy ra!',
                            showConfirmButton: true
                        }).then(() => {
                            window.location.href = '${contextPath}/EmployeeFeedbackController?service=customer_list';
                        });
                    }
                });
            </script>
        </c:if>

        <script>
            
            //Filter 
            function filterRedirect(selectedValue) {
                if (!selectedValue)
                    return;
                window.location.href = '${contextPath}/EmployeeFeedbackController?service=filter&filterValue=' + selectedValue;
            }
            
            document.addEventListener('DOMContentLoaded', () => {
                // Get popup elements
                const ratingPopup = document.getElementById('ratingPopup');
                const closePopup = document.querySelector('.close-popup');
                const cancelRating = document.getElementById('cancelRating');
                const submitRating = document.getElementById('submitRating');
                const popupTitle = document.getElementById('popupTitle');
                const orderIdInput = document.getElementById('orderIdInput');
                const starSelect = document.getElementById('starSelect');
                const starIcons = document.querySelectorAll('.star-display i');
                const ratingText = document.getElementById('ratingText');

                let selectedRating = 0;

                // Rating texts based on number of stars
                const ratingMessages = {
                    0: "Vui lòng chọn số sao",
                    1: "Rất không hài lòng",
                    2: "Không hài lòng",
                    3: "Bình thường",
                    4: "Hài lòng",
                    5: "Rất hài lòng"
                };

                // Add event listeners to rating buttons
                document.querySelectorAll('.btn-rate').forEach(button => {
                    button.addEventListener('click', function () {
                        // Lấy ID đơn hàng từ thuộc tính data-order-id
                        const orderId = this.getAttribute('data-order-id');

                        // Gán ID đơn hàng vào input ẩn
                        orderIdInput.value = orderId;

                        // Cập nhật tiêu đề popup
                        popupTitle.textContent = `Đánh giá đơn hàng ${orderId}`;

                        // Đặt lại trạng thái popup
                        resetRatingPopup();

                        // Hiển thị popup
                        ratingPopup.style.display = 'flex';
                    });
                });

                // Close popup when clicking close button
                closePopup.addEventListener('click', () => {
                    ratingPopup.style.display = 'none';
                });

                // Close popup when clicking cancel button
                cancelRating.addEventListener('click', () => {
                    ratingPopup.style.display = 'none';
                });

                // Close popup when clicking outside the content
                ratingPopup.addEventListener('click', (e) => {
                    if (e.target === ratingPopup) {
                        ratingPopup.style.display = 'none';
                    }
                });

                // Star rating functionality using select
                starSelect.addEventListener('change', function () {
                    const value = parseInt(this.value);
                    selectedRating = value;

                    // Update stars appearance
                    starIcons.forEach((star, index) => {
                        if (index < value) {
                            star.classList.remove('far');
                            star.classList.add('fas', 'active');
                        } else {
                            star.classList.remove('fas', 'active');
                            star.classList.add('far');
                        }
                    });

                    // Update rating text
                    ratingText.textContent = ratingMessages[value];
                });

                // Reset the rating popup to initial state
                function resetRatingPopup() {
                    starSelect.value = '0';
                    selectedRating = 0;
                    starIcons.forEach(star => {
                        star.classList.remove('fas', 'active');
                        star.classList.add('far');
                    });
                    ratingText.textContent = ratingMessages[0];
                    document.getElementById('ratingComment').value = '';
                }
            });
        </script>
    </body>
</html>