<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DANH SÁCH PHỤ TÙNG</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body { background: #f5f8fa; font-family: Arial, sans-serif; }
        .part-heading { font-size: 2.2rem; font-weight: bold; color: #b9001f; text-align: center; margin: 40px 0 30px 0; letter-spacing: 1px;}
        .part-search-bar {
            max-width: 450px; margin: 0 auto 30px auto; display: flex; gap: 10px; justify-content: center;
        }
        .part-search-bar input[type="text"] {
            font-size: 1.1rem; padding: 8px 15px; border-radius: 8px; border: 1.5px solid #b7c7d7; flex: 1;
        }
        .part-search-bar button {
            font-size: 1.1rem; padding: 8px 22px; border-radius: 8px; border: none;
            background: #b9001f; color: #fff; cursor: pointer; transition: background 0.2s;
        }
        .part-search-bar button:hover { background: #900016; }
        .part-search-bar .reset-btn {
            background: #e67e22 !important;
            color: #fff !important;
        }
        .part-search-bar .reset-btn:hover {
            background: #c96a0a !important;
        }
        .part-cards-row { display: flex; flex-wrap: wrap; gap: 32px; justify-content: center;}
        .part-card { background: #fff; border-radius: 1.1rem; box-shadow: 0 2px 16px #e1e8f0; width: 320px; overflow: hidden; display: flex; flex-direction: column; margin-bottom: 30px; transition: transform 0.2s, box-shadow 0.2s; position: relative;}
        .part-card:hover { transform: translateY(-8px) scale(1.03); box-shadow: 0 8px 32px #bdbdbd;}
        .part-card-img { width: 100%; height: 200px; object-fit: cover; background: #f4f4f4;}
        .part-card-body { padding: 18px 16px 16px 16px; display: flex; flex-direction: column; flex: 1;}
        .part-card-title { font-size: 1.22rem; font-weight: bold; color: #b9001f; margin-bottom: 8px;}
        .part-card-price { color: #e67e22; font-size: 1.15rem; font-weight: 600; margin-bottom: 10px;}
        .overlay-icons { position: absolute; top: 0; left: 0; width: 100%; height: 200px; display: flex; align-items: center; justify-content: center; gap: 16px; background: rgba(185,0,31,0.60); opacity: 0; transition: opacity 0.2s; z-index: 2;}
        .part-card:hover .overlay-icons { opacity: 1; }
        .part-icon-btn { display: inline-flex; align-items: center; justify-content: center; background: rgba(255,255,255,0.92); border: none; border-radius: 50%; width: 48px; height: 48px; color: #b9001f; font-size: 1.35rem; box-shadow: 0 2px 8px rgba(31,38,135,0.16); cursor: pointer; transition: background 0.18s; position: relative; text-decoration: none;}
        .part-icon-btn:hover { background: #fff; color: #a10019;}
        .empty-message { color: #888; font-style: italic; font-size: 1.15rem; text-align: center; margin: 40px 0;}
        .pagination { justify-content: center; margin: 24px 0 32px 0; }
        .pagination .page-link { color: #b9001f; border-radius: 6px !important;}
        .pagination .active .page-link { background: #b9001f; border-color: #b9001f; color: #fff;}
        .pagination .page-link:hover { background: #e5f1fb; }
        @media (max-width: 900px) { .part-card, .part-card-img { width: 98vw; min-width: 0;} .part-card-img, .overlay-icons { height: 140px; } }
    </style>
</head>
<body>
      <%@include file="/header.jsp" %>
<div class="container">
    <div class="part-heading">MUA PHỤ TÙNG</div>
    <!-- Thanh tìm kiếm phụ tùng -->
    <form class="part-search-bar" action="part" method="get" id="partSearchForm">
        <input type="text" name="keyword" value="${keyword}" placeholder="Tìm kiếm phụ tùng">
        <button type="submit">Tìm</button>
        <c:if test="${not empty keyword}">
            <button type="button" class="reset-btn" id="resetBtn">Reset</button>
        </c:if>
    </form>
    <script>
    if (document.getElementById('resetBtn')) {
        document.getElementById('resetBtn').onclick = function() {
            window.location.href = 'part';
        };
    }
    </script>
    <div class="part-cards-row">
        <c:forEach var="part" items="${parts}">
            <div class="part-card">
                <c:choose>
                    <c:when test="${not empty part.image}">
                        <img class="part-card-img" src="${pageContext.request.contextPath}/${part.image}" alt="${part.name}">
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
                    <form class="d-flex align-items-center mt-3" action="order" method="post">
                        <input type="hidden" name="partId" value="${part.id}">
                        <input type="number" name="quantity" min="1" value="1" style="width:90px;" class="form-control me-2"/>
                        <button type="submit" class="part-icon-btn" title="Mua ngay" data-bs-toggle="modal">
                            <i class="fas fa-cart-plus"></i>
                        </button>
                    </form>
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
                                    <img src="${pageContext.request.contextPath}/${part.image}" class="img-fluid rounded" alt="Ảnh phụ tùng" style="max-width:320px;max-height:220px;"/>
                                </div>
                                <div class="col-md-6">
                                    <div style="color:#e67e22; font-size:1.25rem; font-weight:bold;">
                                        <fmt:formatNumber value="${part.price}" type="number" groupingUsed="true" minFractionDigits="0" /> đ
                                    </div>
                                        <form class="d-flex align-items-center mt-3" action="order" method="post">
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
                                    <img src="${pageContext.request.contextPath}/${part.image}" class="img-fluid rounded" alt="Ảnh phụ tùng" style="max-width:320px;max-height:220px;"/>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3" style="color:#e67e22; font-size:1.25rem; font-weight:bold;">
                                        <fmt:formatNumber value="${part.price}" type="number" groupingUsed="true" minFractionDigits="0" /> đ
                                    </div>
                                        <form class="d-flex align-items-center mt-3" action="order" method="post">
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
        <c:if test="${empty parts}">
            <div class="empty-message">Không có phụ tùng nào!</div>
        </c:if>
    </div>
    <!-- Pagination -->
    <c:if test="${totalPage > 1}">
        <nav>
            <ul class="pagination">
                <li class="page-item <c:if test='${currentPage == 1}'>disabled</c:if>'">
                    <a class="page-link" href="part?page=${currentPage - 1}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">&laquo;</a>
                </li>
                <c:forEach var="i" begin="1" end="${totalPage}">
                    <li class="page-item <c:if test='${i == currentPage}'>active</c:if>'">
                        <a class="page-link" href="part?page=${i}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item <c:if test='${currentPage == totalPage}'>disabled</c:if>'">
                    <a class="page-link" href="part?page=${currentPage + 1}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if>">&raquo;</a>
                </li>
            </ul>
        </nav>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>