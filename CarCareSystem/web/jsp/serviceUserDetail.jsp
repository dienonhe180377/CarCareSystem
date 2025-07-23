<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết dịch vụ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            background: #fff;
            font-family: Arial, sans-serif;
            margin: 0;
            min-height: 100vh;
        }
        .container {
            max-width: 950px;
            margin: 40px auto;
            background: none;
            padding: 0 18px 34px 18px;
        }
        .service-header {
            display: flex;
            gap: 32px;
            align-items: flex-start;
            margin-bottom: 38px;
        }
        .service-img {
            flex: 0 0 340px;
        }
        .service-img img {
            width: 100%;
            max-width: 340px;
            max-height: 220px;
            border-radius: 14px;
            object-fit: cover;
            display: block;
        }
        .img-note {
            color: #999;
            font-size: 15px;
            font-style: italic;
            margin-bottom: 14px;
        }
        .service-info {
            flex: 1 1 0;
        }
        .service-title {
            font-size: 2rem;
            font-weight: bold;
            color: #1368ce;
            margin-bottom: 10px;
        }
        .service-price {
            font-size: 1.25rem;
            color: #e74c3c;
            font-weight: 700;
            margin-bottom: 16px;
        }
        .service-section-title {
            font-weight: 700;
            color: #1368ce;
            margin-bottom: 7px;
            font-size: 1.15rem;
            margin-top: 18px;
        }
        .service-info-list {
            list-style: none;
            padding: 0;
            margin: 0 0 18px 0;
        }
        .service-info-list li {
            margin-bottom: 7px;
            font-size: 1.10rem;
        }
        .service-info-label {
            min-width: 120px;
            color: #3470b7;
            font-weight: 600;
            display: inline-block;
        }
        .service-info-value {
            color: #222;
            font-weight: 400;
            margin-left: 6px;
        }
        /* PHỤ TÙNG THEO HÀNG NGANG - CĂN TRÁI */
        .part-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 24px;
            margin: 24px 0 0 0;
            justify-content: flex-start;
        }
        .part-card {
            flex: 1 1 calc(25% - 24px);
            max-width: calc(25% - 24px);
            min-width: 180px;
            background: none;
            border: none;
            display: flex;
            flex-direction: column;
            align-items: flex-start; /* căn trái toàn bộ */
            margin-bottom: 24px;
        }
        .part-img {
            width: 100%;
            max-width: 110px;
            max-height: 66px;
            object-fit: cover;
            border-radius: 10px;
            border: none;
            background: none;
            display: block;
            margin-bottom: 10px;
        }
        .part-name, .part-price {
            text-align: left;
            width: 100%;
        }
        .part-name {
            font-weight: bold;
            color: #1368ce;
            font-size: 1.07rem;
            margin-bottom: 4px;
            word-break: break-word;
        }
        .part-price {
            color: #e67e22;
            font-size: 1.03rem;
        }
        .no-parts-row {
            color: #aaa;
            font-style: italic;
            text-align: left;
            margin: 18px 0;
            padding-left: 10px;
        }
        .action-row {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 30px;
            margin-top: 30px;
        }
        .order-btn, .back-btn {
            background: #1368ce;
            color: #fff;
            padding: 10px 28px;
            border-radius: 6px;
            font-size: 1.12rem;
            font-weight: 600;
            border: none;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: background 0.2s;
        }
        .order-btn {
            background: #e74c3c;
        }
        .order-btn:hover {
            background: #b62a13;
        }
        .back-btn:hover {
            background: #0d4f97;
        }
        @media (max-width: 1050px) {
            .service-header {
                flex-direction: column;
                gap: 10px;
            }
            .service-img {
                max-width: 100vw;
            }
            .service-img img {
                max-width: 100%;
                max-height: 160px;
            }
            .part-card {
                min-width: 160px;
            }
        }
        @media (max-width: 900px) {
            .part-card {
                flex: 1 1 calc(50% - 24px);
                max-width: calc(50% - 24px);
            }
            .part-img {
                max-width: 90vw;
                max-height: 80px;
            }
        }
        @media (max-width: 600px) {
            .part-card {
                flex: 1 1 100%;
                max-width: 100%;
            }
            .part-img {
                max-width: 100vw;
            }
            .action-row {
                flex-direction: column;
                gap: 12px;
            }
        }
    </style>
</head>
<body>
    <%@include file="/header.jsp" %>
    <div class="container">
        <!-- PHẦN ĐẦU: ẢNH VÀ THÔNG TIN DỊCH VỤ -->
        <div class="service-header">
            <div class="service-img">
                <c:choose>
                    <c:when test="${not empty service.img}">
                        <img src="${pageContext.request.contextPath}/img/${service.img}" alt="Ảnh dịch vụ"/>
                    </c:when>
                    <c:otherwise>
                        <div class="img-note">Chưa có ảnh dịch vụ</div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="service-info">
                <div class="service-title">${service.name}</div>
                <div class="service-price">
                    <fmt:formatNumber value="${service.totalPriceWithParts}" type="number" maxFractionDigits="0"/> VND
                </div>
                <div class="service-section-title">Thông tin dịch vụ</div>
                <ul class="service-info-list">
                    <li>
                        <span class="service-info-label">Mô tả:</span>
                        <span class="service-info-value">${service.description}</span>
                    </li>
                    <li>
                        <span class="service-info-label">Giá gốc:</span>
                        <span class="service-info-value">
                            <fmt:formatNumber value="${service.price}" type="number" maxFractionDigits="0"/> VND
                        </span>
                    </li>
                    <li>
                        <span class="service-info-label">Tổng giá phụ tùng:</span>
                        <span class="service-info-value">
                            <fmt:formatNumber value="${service.totalPriceWithParts - service.price}" type="number" maxFractionDigits="0"/> VND
                        </span>
                    </li>
                    <li>
                        <span class="service-info-label">Giá cuối:</span>
                        <span class="service-info-value" style="color:#e74c3c; font-weight:600;">
                            <fmt:formatNumber value="${service.totalPriceWithParts}" type="number" maxFractionDigits="0"/> VND
                        </span>
                    </li>
                </ul>
            </div>
        </div>

        <!-- DANH SÁCH PHỤ TÙNG: 4 cái 1 hàng, căn trái -->
        <div class="service-section-title">Phụ tùng kèm theo</div>
        <c:choose>
            <c:when test="${not empty service.parts}">
                <div class="part-grid">
                    <c:forEach var="part" items="${service.parts}">
                        <div class="part-card">
                            <c:if test="${not empty part.image}">
                                <img src="${pageContext.request.contextPath}/image/${part.image}" class="part-img" alt="Ảnh phụ tùng"/>
                            </c:if>
                            <div class="part-name">${part.name}</div>
                            <div class="part-price">
                                <fmt:formatNumber value="${part.price}" type="number" maxFractionDigits="0"/> VND
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-parts-row">Không có phụ tùng liên quan</div>
            </c:otherwise>
        </c:choose>

        <div class="action-row">
            <form action="order" method="post" style="margin:0;">
                <input type="hidden" name="serviceId" value="${service.id}"/>
                <button type="submit" class="order-btn">Đặt dịch vụ</button>
            </form>
            <a href="ServiceServlet_JSP?service=listService" class="back-btn">← Quay lại danh sách</a>
        </div>
    </div>
</body>
</html>