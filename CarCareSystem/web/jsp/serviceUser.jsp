<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dịch vụ Garage NVT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f5f8fa; font-family: Arial, sans-serif; }
        .service-heading {
            font-size: 2.2rem;
            font-weight: bold;
            color: #1b72c2;
            text-align: center;
            margin: 40px 0 30px 0;
            letter-spacing: 1px;
        }
        .service-search-bar {
            max-width: 450px;
            margin: 0 auto 30px auto;
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        .service-search-bar input[type="text"] {
            font-size: 1.1rem;
            padding: 8px 15px;
            border-radius: 8px;
            border: 1.5px solid #b7c7d7;
            flex: 1;
        }
        .service-search-bar button {
            font-size: 1.1rem;
            padding: 8px 22px;
            border-radius: 8px;
            border: none;
            background: #2596ff;
            color: #fff;
            cursor: pointer;
            transition: background 0.2s;
        }
        .service-search-bar button:hover { background: #1976d2; }
        .service-cards-row {
            display: flex;
            flex-wrap: wrap;
            gap: 32px;
            justify-content: center;
        }
        .service-card {
            background: #fff;
            border-radius: 1.1rem;
            box-shadow: 0 2px 16px #e1e8f0;
            width: 320px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            margin-bottom: 30px;
            transition: transform 0.2s, box-shadow 0.2s;
            position: relative;
        }
        .service-card:hover {
            transform: translateY(-8px) scale(1.03);
            box-shadow: 0 8px 32px #bdbdbd;
        }
        .service-checkbox {
            position: absolute;
            top: 14px;
            left: 14px;
            width: 20px;
            height: 20px;
            z-index: 10;
        }
        .service-card-img {
            width: 100%;
            height: 210px;
            object-fit: cover;
            background: #f4f4f4;
        }
        .service-card-body {
            padding: 20px 18px 18px 18px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        .service-card-title {
            font-size: 1.32rem;
            font-weight: bold;
            color: #1b72c2;
            margin-bottom: 8px;
        }
        .service-card-desc {
            flex: 1;
            color: #444;
            font-size: 1.08rem;
            margin-bottom: 12px;
            min-height: 40px;
        }
        .service-card-price {
            color: #e67e22;
            font-size: 1.15rem;
            font-weight: 600;
            margin-bottom: 10px;
        }
        .service-card-btn {
            margin-top: auto;
            display: block;
            width: 100%;
            text-align: center;
            background: #2596ff;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 1.05rem;
            font-weight: 600;
            padding: 10px 0;
            text-decoration: none;
            transition: background 0.2s;
        }
        .service-card-btn:hover {
            background: #1976d2;
            color: #fff;
        }
        .empty-message {
            color: #888;
            font-style: italic;
            font-size: 1.15rem;
            text-align: center;
            margin: 40px 0;
        }
        .buy-btn {
            margin: 30px auto 40px auto;
            display: block;
            font-size: 1.15rem;
            padding: 10px 38px;
            background: #26be6b;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            transition: background 0.2s;
        }
        .buy-btn:hover { background: #1d9d55; }
    </style>
</head>
<body>
    <div class="container">
        <div class="service-heading">DANH SÁCH DỊCH VỤ</div>
        <form class="service-search-bar" action="ServiceServlet_JSP" method="get">
            <input type="hidden" name="service" value="listService">
            <input type="text" name="name" value="${param.name}" placeholder="Tìm kiếm dịch vụ">
            <button type="submit">Tìm</button>
        </form>
        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-success text-center">${message}</div>
        </c:if>
        <form action="ServiceServlet_JSP" method="post">
            <input type="hidden" name="service" value="buyService">
            <div class="service-cards-row">
                <c:forEach var="se" items="${data}">
                    <div class="service-card">
                        <input class="service-checkbox" type="checkbox" name="selectedServiceIds" value="${se.id}">
                        <c:choose>
                            <c:when test="${not empty se.img}">
                                <img class="service-card-img" src="${se.img}" alt="${se.name}">
                            </c:when>
                            <c:otherwise>
                                <img class="service-card-img" src="img/no-image.png" alt="Không ảnh">
                            </c:otherwise>
                        </c:choose>
                        <div class="service-card-body">
                            <div class="service-card-title">${se.name}</div>
                            <div class="service-card-desc">${se.description}</div>
                            <div class="service-card-price">
                                <fmt:formatNumber value="${se.price}" type="number" groupingUsed="true" minFractionDigits="0" /> đ
                            </div>
                            <a class="service-card-btn" href="ServiceServlet_JSP?service=previewService&id=${se.id}">
                                Xem chi tiết
                            </a>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty data}">
                    <div class="empty-message">Không có dịch vụ nào.</div>
                </c:if>
            </div>
            <button type="submit" class="buy-btn">
                Mua dịch vụ đã chọn
            </button>
        </form>
    </div>
</body>
</html>