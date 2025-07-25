<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dịch vụ CarCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f5f8fa; font-family: Arial, sans-serif; }
        .service-heading {
            font-size: 2.2rem; font-weight: bold; color: #1b72c2;
            text-align: center; margin: 40px 0 30px 0; letter-spacing: 1px;
        }
        .service-search-bar {
            max-width: 450px; margin: 0 auto 30px auto; display: flex; gap: 10px; justify-content: center;
        }
        .service-search-bar input[type="text"] {
            font-size: 1.1rem; padding: 8px 15px; border-radius: 8px; border: 1.5px solid #b7c7d7; flex: 1;
        }
        .service-search-bar button {
            font-size: 1.1rem; padding: 8px 22px; border-radius: 8px; border: none;
            background: #2596ff; color: #fff; cursor: pointer; transition: background 0.2s;
        }
        .service-search-bar button:hover { background: #1976d2; }
        .service-search-bar .reset-btn {
            background: #e67e22 !important;
            color: #fff !important;
        }
        .service-search-bar .reset-btn:hover {
            background: #c96a0a !important;
        }
        .service-cards-row {
            display: flex; flex-wrap: wrap; gap: 32px; justify-content: center;
        }
        .service-card {
            background: #fff; border-radius: 1.1rem; box-shadow: 0 2px 16px #e1e8f0; width: 320px;
            overflow: hidden; display: flex; flex-direction: column; margin-bottom: 30px;
            transition: transform 0.2s, box-shadow 0.2s; position: relative;
        }
        .service-card:hover {
            transform: translateY(-8px) scale(1.03); box-shadow: 0 8px 32px #bdbdbd;
        }
        .service-card-img {
            width: 100%; height: 230px; object-fit: cover; background: #f4f4f4;
        }
        .service-card-body { padding: 20px 18px 18px 18px; display: flex; flex-direction: column; flex: 1; }
        .service-card-title { font-size: 1.32rem; font-weight: bold; color: #1b72c2; margin-bottom: 8px; }
        .service-card-price {
            color: #e67e22; font-size: 1.15rem; font-weight: 600; margin-bottom: 10px;
        }
        .overlay-icons {
            position: absolute; top: 0; left: 0; width: 100%; height: 230px;
            display: flex; align-items: center; justify-content: center; gap: 16px;
            background: rgba(185,0,31,0.60); opacity: 0; transition: opacity 0.2s; z-index: 2;
        }
        .service-card:hover .overlay-icons { opacity: 1; }
        .service-icon-btn {
            display: inline-flex; align-items: center; justify-content: center;
            background: rgba(255,255,255,0.92); border: none; border-radius: 50%;
            width: 48px; height: 48px; color: #b9001f; font-size: 1.35rem;
            box-shadow: 0 2px 8px rgba(31,38,135,0.16); cursor: pointer;
            transition: background 0.18s; position: relative; text-decoration: none;
        }
        .service-icon-btn:hover { background: #fff; color: #a10019; }
        .empty-message { color: #888; font-style: italic; font-size: 1.15rem; text-align: center; margin: 40px 0; }
        .pagination { justify-content: center; margin: 24px 0 32px 0; }
        .pagination .page-link { color: #1b72c2; border-radius: 6px !important; }
        .pagination .active .page-link { background: #2596ff; border-color: #2596ff; color: #fff; }
        .pagination .page-link:hover { background: #e5f1fb; }
        .quickview-img {
            width: 100%; max-width: 440px; max-height: 320px; object-fit: cover;
            border-radius: 14px; display: block; margin: 0 auto 18px auto;
        }
        @media (max-width: 900px) {
            .service-card, .service-card-img { width: 98vw; min-width: 0; }
            .service-card-img, .overlay-icons { height: 180px; }
            .quickview-img { max-width: 95vw; max-height: 200px; }
        }
    </style>
</head>
<body>
    <%@include file="/header.jsp" %>
    <div class="container">
        <div class="service-heading">DANH SÁCH DỊCH VỤ</div>
        <form class="service-search-bar" action="ServiceServlet_JSP" method="get" id="searchForm">
            <input type="hidden" name="service" value="listService">
            <input type="text" name="name" value="${param.name}" placeholder="Tìm kiếm dịch vụ">
            <button type="submit">Tìm</button>
            <c:if test="${not empty param.name}">
                <button type="button" class="reset-btn" id="resetBtn">Reset</button>
            </c:if>
        </form>
        <script>
        // Chỉ gắn sự kiện nếu nút reset tồn tại
        if (document.getElementById('resetBtn')) {
            document.getElementById('resetBtn').onclick = function() {
                window.location.href = 'ServiceServlet_JSP?service=listService';
            };
        }
        </script>
        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-success text-center">${message}</div>
        </c:if>
        <div class="service-cards-row">
            <c:forEach var="se" items="${data}">
                <div class="service-card">
                    <c:choose>
                        <c:when test="${not empty se.img}">
                            <img class="service-card-img" src="${pageContext.request.contextPath}/img/${se.img}" alt="${se.name}">
                        </c:when>
                        <c:otherwise>
                            <img class="service-card-img" src="img/no-image.png" alt="Không ảnh">
                        </c:otherwise>
                    </c:choose>
                    <div class="overlay-icons">
                        <button type="button" class="service-icon-btn" title="Xem nhanh"
                                data-bs-toggle="modal" data-bs-target="#quickViewModal${se.id}">
                            <i class="fas fa-eye"></i>
                        </button>
                        <a class="service-icon-btn" title="Xem chi tiết"
                           href="ServiceServlet_JSP?service=detailService&id=${se.id}">
                            <i class="fas fa-link"></i>
                        </a>
                           <form class="d-flex align-items-center mt-3" action="order" method="post">
                               <input type="hidden" name="selectedServiceIds" value="${se.id}">
                               <button type="submit" class="service-icon-btn" data-bs-toggle="modal" title="Mua ngay">
                                   <i class="fas fa-shopping-cart"></i>
                               </button>
                           </form>
                    </div>
                    <div class="service-card-body">
                        <div class="service-card-title">${se.name}</div>
                        <div class="service-card-price">
                            <fmt:formatNumber value="${se.totalPriceWithParts}" type="number" groupingUsed="true" minFractionDigits="0" /> đ
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
                                            <form class="d-flex align-items-center mt-3" action="order" method="post">
                                                <input type="hidden" name="selectedServiceIds" value="${se.id}">
                                                <button type="submit" class="btn btn-danger">Đặt dịch vụ</button>
                                            </form>
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
                                        <form class="d-flex align-items-center mt-3" action="order" method="post">
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
            <c:if test="${empty data}">
                <div class="empty-message">Không có dịch vụ nào.</div>
            </c:if>
        </div>
        <c:if test="${totalPage > 1}">
            <nav>
                <ul class="pagination">
                    <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>'">
                        <a class="page-link" href="?service=listService&name=${fn:escapeXml(param.name)}&page=${currentPage - 1}">Trước</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${totalPage}">
                        <li class="page-item <c:if test='${i == currentPage}'>active</c:if>'">
                            <a class="page-link" href="?service=listService&name=${fn:escapeXml(param.name)}&page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item <c:if test='${currentPage == totalPage}'>disabled</c:if>'">
                        <a class="page-link" href="?service=listService&name=${fn:escapeXml(param.name)}&page=${currentPage + 1}">Sau</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <%@include file="/footer.jsp" %>
</body>
</html>