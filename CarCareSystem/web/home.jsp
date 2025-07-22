<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', Arial, sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e8f0fe 100%);
        }
        .carousel-item img { width: 100%; height: 750px; object-fit: cover; }
        .section-title { font-size: 2.2rem; font-weight: 700; color: #0b436c; margin-bottom: 2.5rem; letter-spacing: 1px; }
        .card, .service-card, .part-card {
            border-radius: 1.3rem;
            overflow: hidden;
            box-shadow: 0 4px 24px #e1e8f0;
            margin-bottom: 2rem;
            transition: transform 0.22s, box-shadow 0.18s;
            background: #fff;
            position: relative;
            border: none;
        }
        .card:hover, .service-card:hover, .part-card:hover {
            transform: translateY(-10px) scale(1.03);
            box-shadow: 0 12px 32px #bdbdbd66;
        }
        .service-card-img, .card-img-top, .part-card-img {
            width: 100%; height: 200px; object-fit: cover; background: #f4f4f4;
            border-top-left-radius: 1.3rem;
            border-top-right-radius: 1.3rem;
        }
        .service-card-body, .part-card-body, .card-body {
            padding: 20px 18px 18px 18px;
            display: flex; flex-direction: column; flex: 1;
        }
        .service-card-title, .card-title, .part-card-title {
            font-size: 1.35rem; font-weight: bold; color: #1b72c2; margin-bottom: 8px;
        }
        .service-card-price, .card-text.text-warning, .part-card-price {
            color: #e67e22; font-size: 1.15rem; font-weight: 600; margin-bottom: 10px;
        }
        .part-card-title { color: #b9001f; }
        .overlay-icons {
            position: absolute; top: 0; left: 0; width: 120%; height: 200px;
            display: flex; align-items: center; justify-content: center; gap: 16px;
            background: rgba(185,0,31,0.60); opacity: 0; transition: opacity 0.2s; z-index: 2;
        }
        .service-card:hover .overlay-icons, .part-card:hover .overlay-icons { opacity: 1; }
        .service-icon-btn, .part-icon-btn {
            display: inline-flex; align-items: center; justify-content: center;
            background: rgba(255,255,255,0.95); border: none; border-radius: 50%;
            width: 48px; height: 48px; color: #b9001f; font-size: 1.28rem;
            box-shadow: 0 2px 8px rgba(31,38,135,0.13); cursor: pointer;
            transition: background 0.18s, color 0.12s;
            text-decoration: none;
        }
        .service-icon-btn:hover, .part-icon-btn:hover { background: #fff; color: #a10019; }
        .quickview-img {
            width: 100%; max-width: 440px; max-height: 320px; object-fit: cover;
            border-radius: 14px; display: block; margin: 0 auto 18px auto;
        }
        .empty-message {
            color: #888; font-style: italic; font-size: 1.17rem; text-align: center; margin: 40px 0;
        }
        .part-cards-row {
            display: flex;
            flex-wrap: nowrap;
            gap: 32px;
            justify-content: center;
            align-items: stretch;
            margin-bottom: 2rem;
        }
        .part-card {
            width: 260px;
            min-width: 0;
            flex: 0 0 18%;
            display: flex;
            flex-direction: column;
        }
        .part-card-img, .overlay-icons { height: 200px; }
        .part-card-body { padding: 18px 16px 16px 16px; }

        /* Quick Action Buttons: 2 cột to, mỗi bên 1 nút */
        .quick-action-row {
            display: flex;
            justify-content: center;
            gap: 42px;
            margin-top: 28px;
            margin-bottom: 36px;
            width: 100%;
        }
        .quick-action-col {
            flex: 1 1 45%;
            display: flex;
            justify-content: center;
        }
        .quick-action-btn {
            width: 100%;
            max-width: 420px;
            min-height: 110px;
            font-size: 2rem;
            font-weight: 700;
            border-radius: 2rem;
            border: none;
            box-shadow: 0 2px 12px #e1e8f0;
            transition: background 0.18s, color 0.12s, box-shadow 0.17s, filter 0.13s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 18px;
            padding: 0;
        }
        .quick-booking-btn {
            background: linear-gradient(90deg, #1b72c2, #3be8b0);
            color: #fff;
        }
        .quick-booking-btn:hover { filter: brightness(1.07);}
        .voucher-btn {
            background: linear-gradient(90deg, #b9001f, #fa7382);
            color: #fff;
        }
        .voucher-btn:hover { filter: brightness(1.07);}
        @media (max-width: 1200px) {
            .part-card { width: 210px; flex: 0 0 19%; }
        }
        @media (max-width: 991.98px) {
            .carousel-item img { height: 200px; }
            .service-card, .service-card-img, .part-card, .part-card-img { width: 98vw; min-width: 0;}
            .service-card-img, .part-card-img, .overlay-icons { height: 140px; }
            .quickview-img { max-width: 95vw; max-height: 200px; }
            .section-title { font-size: 1.4rem; }
            .part-cards-row { flex-wrap: wrap; gap: 14px; }
            .part-card { width: 44vw; min-width: 120px; flex: 0 0 44vw;}
            .quick-action-row { flex-direction: column; gap: 20px;}
            .quick-action-col { width: 100%; }
            .quick-action-btn { max-width: 100%; min-height: 60px; font-size: 1.08rem; }
        }
        @media (max-width: 600px) {
            .part-cards-row { flex-direction: column; gap: 16px;}
            .part-card { width: 90vw; flex: 1 1 100%; }
            .quick-action-btn { font-size: 1rem; min-height: 46px; }
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>

    <!-- Carousel Banner -->
    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active"><img src="${pageContext.request.contextPath}/img/1.jpg" class="d-block w-100" alt="Slide 1"></div>
            <div class="carousel-item"><img src="${pageContext.request.contextPath}/img/2.jpg" class="d-block w-100" alt="Slide 2"></div>
            <div class="carousel-item"><img src="${pageContext.request.contextPath}/img/3.jpg" class="d-block w-100" alt="Slide 3"></div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

    <!-- DỊCH VỤ NỔI BẬT -->
    <div class="container my-5">
        <h2 class="section-title text-center">DỊCH VỤ NỔI BẬT</h2>
        <c:if test="${not empty errorService}">
            <div class="alert alert-danger text-center">${errorService}</div>
        </c:if>
        <c:if test="${not empty messageService}">
            <div class="alert alert-success text-center">${messageService}</div>
        </c:if>
        <div class="row justify-content-center">
            <c:forEach var="se" items="${top3Services}">
                <div class="col-md-4 mb-4 d-flex">
                    <div class="service-card flex-fill position-relative">
                        <!-- Ảnh dịch vụ -->
                        <c:choose>
                            <c:when test="${not empty se.img}">
                                <img class="service-card-img" src="${pageContext.request.contextPath}/img/${se.img}" alt="${se.name}" />
                            </c:when>
                            <c:otherwise>
                                <img class="service-card-img" src="img/no-image.png" alt="Không ảnh" />
                            </c:otherwise>
                        </c:choose>
                        <!-- Overlay icons -->
                        <div class="overlay-icons">
                            <button type="button" class="service-icon-btn" title="Xem nhanh"
                                data-bs-toggle="modal" data-bs-target="#quickViewModal${se.id}">
                                <i class="fas fa-eye"></i>
                            </button>
                            <a class="service-icon-btn" title="Xem chi tiết"
                                href="ServiceServlet_JSP?service=detailService&id=${se.id}">
                                <i class="fas fa-link"></i>
                            </a>
                            <button type="button" class="service-icon-btn" title="Mua ngay"
                                data-bs-toggle="modal" data-bs-target="#buyModal${se.id}">
                                <i class="fas fa-shopping-cart"></i>
                            </button>
                        </div>
                        <div class="service-card-body">
                            <div class="service-card-title">${se.name}</div>
                            <div class="service-card-price">
                                <fmt:formatNumber value="${se.totalPriceWithParts}" type="number" groupingUsed="true" minFractionDigits="0" /> đ
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Quick View Modal -->
                <div class="modal fade" id="quickViewModal${se.id}" tabindex="-1" aria-labelledby="quickViewLabel${se.id}" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header border-0">
                                <h5 class="modal-title" style="color:#1b72c2;" id="quickViewLabel${se.id}">Xem nhanh: ${se.name}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6 text-center">
                                        <c:choose>
                                            <c:when test="${not empty se.img}">
                                                <img src="${pageContext.request.contextPath}/img/${se.img}" class="quickview-img" alt="Ảnh dịch vụ" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="img/no-image.png" class="quickview-img" alt="Không ảnh" />
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-6">
                                        <div style="color:#e67e22; font-size:1.25rem; font-weight:bold;">
                                            <fmt:formatNumber value="${se.totalPriceWithParts}" type="number" groupingUsed="true" minFractionDigits="0" /> đ
                                        </div>
                                        <div class="mt-2"><b>Mô tả:</b> ${se.description}</div>
                                        <c:if test="${not empty se.parts}">
                                            <div class="mt-3">
                                                <b>Phụ tùng đi kèm:</b>
                                                <ul>
                                                    <c:forEach var="part" items="${se.parts}">
                                                        <li>${part.name} (<fmt:formatNumber value="${part.price}" type="number" groupingUsed="true" minFractionDigits="0" /> đ)</li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </c:if>
                                        <div class="mt-3">
                                            <a class="btn btn-primary" href="ServiceServlet_JSP?service=detailService&id=${se.id}">
                                                Xem chi tiết
                                            </a>
                                            <button type="button" class="btn btn-danger ms-2" data-bs-toggle="modal" data-bs-target="#buyModal${se.id}" data-bs-dismiss="modal">
                                                Đặt dịch vụ
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Buy Modal -->
                <div class="modal fade" id="buyModal${se.id}" tabindex="-1" aria-labelledby="buyModalLabel${se.id}" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header border-0">
                                <h5 class="modal-title" style="color:#b9001f;" id="buyModalLabel${se.id}">${se.name}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6 text-center">
                                        <c:choose>
                                            <c:when test="${not empty se.img}">
                                                <img src="${pageContext.request.contextPath}/img/${se.img}" class="quickview-img" alt="Ảnh dịch vụ" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="img/no-image.png" class="quickview-img" alt="Không ảnh" />
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3" style="color:#b9001f; font-size:1.5rem;">
                                            <fmt:formatNumber value="${se.totalPriceWithParts}" type="number" groupingUsed="true" minFractionDigits="0" />đ
                                        </div>
                                        <div><b>Mô tả:</b> ${se.description}</div>
                                        <form class="d-flex align-items-center mt-3" action="ServiceServlet_JSP?service=buyService" method="post">
                                            <input type="hidden" name="selectedServiceIds" value="${se.id}">
                                            <button type="submit" class="btn btn-danger">Đặt dịch vụ</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty top3Services}">
                <div class="empty-message">Không có dịch vụ nổi bật!</div>
            </c:if>
        </div>
    </div>

    <!-- PHỤ TÙNG NỔI BẬT -->
    <div class="container my-5">
        <h2 class="section-title text-center" style="color:#b9001f;">PHỤ TÙNG NỔI BẬT</h2>
        <div class="part-cards-row">
            <c:forEach var="part" items="${top5Parts}">
                <div class="part-card">
                    <c:choose>
                        <c:when test="${not empty part.image}">
                            <img class="part-card-img" src="${pageContext.request.contextPath}/image/${part.image}" alt="${part.name}">
                        </c:when>
                        <c:otherwise>
                            <img class="part-card-img" src="img/no-image.png" alt="Không ảnh">
                        </c:otherwise>
                    </c:choose>
                    <!-- Overlay icons -->
                    <div class="overlay-icons">
                        <button type="button" class="part-icon-btn" title="Xem nhanh" data-bs-toggle="modal" data-bs-target="#quickViewModal${part.id}">
                            <i class="fas fa-eye"></i>
                        </button>
                        <button type="button" class="part-icon-btn" title="Mua ngay" data-bs-toggle="modal" data-bs-target="#buyModal${part.id}">
                            <i class="fas fa-cart-plus"></i>
                        </button>
                    </div>
                    <div class="part-card-body">
                        <div class="part-card-title">${part.name}</div>
                        <div class="part-card-price">
                            <fmt:formatNumber value="${part.price}" type="number" groupingUsed="true" minFractionDigits="0" /> đ
                        </div>
                    </div>
                </div>
                <!-- Quick View Modal -->
                <div class="modal fade" id="quickViewModal${part.id}" tabindex="-1" aria-labelledby="quickViewLabel${part.id}" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header border-0">
                                <h5 class="modal-title" style="color:#b9001f;" id="quickViewLabel${part.id}">Xem nhanh: ${part.name}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6 text-center">
                                        <img src="${pageContext.request.contextPath}/image/${part.image}" class="img-fluid rounded" alt="Ảnh phụ tùng" style="max-width:320px;max-height:220px;"/>
                                    </div>
                                    <div class="col-md-6">
                                        <div style="color:#e67e22; font-size:1.25rem; font-weight:bold;">
                                            <fmt:formatNumber value="${part.price}" type="number" groupingUsed="true" minFractionDigits="0" /> đ
                                        </div>
                                        <div class="mt-3">
                                            <button type="button" class="btn btn-danger ms-2" data-bs-toggle="modal" data-bs-target="#buyModal${part.id}" data-bs-dismiss="modal">Mua ngay</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Buy Modal -->
                <div class="modal fade" id="buyModal${part.id}" tabindex="-1" aria-labelledby="buyModalLabel${part.id}" aria-hidden="true">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header border-0">
                                <h5 class="modal-title" style="color:#b9001f;" id="buyModalLabel${part.id}">${part.name}</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6 text-center">
                                        <img src="${pageContext.request.contextPath}/image/${part.image}" class="img-fluid rounded" alt="Ảnh phụ tùng" style="max-width:320px;max-height:220px;"/>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3" style="color:#e67e22; font-size:1.25rem; font-weight:bold;">
                                            <fmt:formatNumber value="${part.price}" type="number" groupingUsed="true" minFractionDigits="0" /> đ
                                        </div>
                                        <form class="d-flex align-items-center mt-3" action="OrderServlet" method="post">
                                            <input type="hidden" name="partId" value="${part.id}">
                                            <input type="number" name="quantity" min="1" value="1" style="width:90px;" class="form-control me-2"/>
                                            <button type="submit" class="btn btn-danger">Mua ngay</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty top5Parts}">
                <div class="empty-message">Không có phụ tùng nổi bật!</div>
            </c:if>
        </div>
        <!-- Quick Action Buttons: 2 cột to, mỗi bên 1 nút chuyển trang -->
        <div class="quick-action-row">
            <div class="quick-action-col">
                <a href="quick-booking.jsp" class="quick-action-btn quick-booking-btn">
                    <i class="fas fa-calendar-check me-3"></i> Đặt lịch nhanh
                </a>
            </div>
            <div class="quick-action-col">
                <a href="voucher.jsp" class="quick-action-btn voucher-btn">
                    <i class="fas fa-gift me-3"></i> Mã giảm giá
                </a>
            </div>
        </div>
    </div>

    <%@include file="footer.jsp" %>

    <!-- Back to Top Button -->
    <button onclick="topFunction()" id="backToTopBtn" title="Lên đầu trang" style="display:none; position:fixed; right:24px; bottom:36px; z-index:999; padding:0.7em 1em; border-radius:50%; border:none; background:#1b72c2; color:#fff; box-shadow:0 2px 8px #1b72c233;">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-arrow-up" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M8 12a.5.5 0 0 0 .5-.5V3.707l3.147 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 3.707V11.5A.5.5 0 0 0 8 12z"/>
        </svg>
    </button>
    <script>
        var backToTopBtn = document.getElementById("backToTopBtn");
        window.onscroll = function() {scrollFunction();};
        function scrollFunction() {
            if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
                backToTopBtn.style.display = "block";
            } else {
                backToTopBtn.style.display = "none";
            }
        }
        function topFunction() {
            window.scrollTo({top: 0, behavior: 'smooth'});
        }
    </script>
</body>
</html>