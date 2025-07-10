<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem nhanh dịch vụ</title>
    <style>
        body { background: #f6faff; font-family: Arial, sans-serif; margin:0; }
        .preview-container {
            background: #fff;
            max-width: 940px;
            margin: 60px auto 32px auto;
            border-radius: 18px;
            box-shadow: 0 8px 36px rgba(0,0,0,0.13);
            padding: 48px 36px 36px 36px;
        }
        .preview-row {
            display: flex;
            gap: 48px;
            align-items: flex-start;
        }
        .preview-img-col {
            flex: 0 0 370px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .preview-img {
            width: 340px;
            height: 240px;
            border-radius: 14px;
            object-fit: cover;
            background: #f4f6fa;
            border: 2px solid #eaeaea;
            margin-bottom: 18px;
            box-shadow: 0 4px 22px #e0e0e0;
        }
        .img-note {
            color: #aaa;
            font-size: 17px;
            font-style: italic;
            text-align: center;
            margin-bottom: 12px;
        }
        .preview-data-col {
            flex: 1 1 0;
        }
        .preview-title {
            font-size: 2.05rem;
            font-weight: bold;
            color: #1455a2;
            margin-bottom: 13px;
        }
        .preview-price {
            color: #e74c3c;
            font-size: 1.45rem;
            font-weight: bold;
            margin-bottom: 16px;
        }
        .preview-section-title {
            font-weight:700;
            color:#1368ce;
            margin-bottom:8px;
            font-size:1.23rem;
            margin-top:26px;
        }
        .preview-desc {
            color:#234;
            font-size:1.17rem;
            margin-bottom: 14px;
        }
        .preview-parts-list {
            margin:0;
            padding:0;
            list-style:none;
        }
        .preview-parts-list li {
            font-size:1.09rem;
            margin-bottom:9px;
            display:flex;
            align-items:center;
            gap:14px;
        }
        .part-img {
            width: 70px;
            height: 48px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #eaeaea;
            background: #f6f6f6;
        }
        .no-parts { color: #aaa; font-size:1.05rem; font-style:italic;}
        .preview-actions {
            display:flex;
            gap:18px;
            margin-top:32px;
        }
        .btn-detail, .btn-back {
            background: #1565c0;
            color: #fff;
            padding: 12px 28px;
            border-radius: 7px;
            border: none;
            font-size: 1.08rem;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.18s, box-shadow 0.18s;
            display: inline-block;
            box-shadow: 0 2px 10px #e4e4e4;
        }
        .btn-detail:hover { background: #0d4587;}
        .btn-back { background: #aaa;}
        .btn-back:hover { background: #444; }
        @media (max-width: 1100px) {
            .preview-container { max-width: 98vw; padding:28px 5vw;}
            .preview-row { gap:18px; }
            .preview-img-col { flex-basis: 200px; }
            .preview-img { width: 180px; height: 120px;}
        }
        @media (max-width: 700px) {
            .preview-row { flex-direction: column; gap:0;}
            .preview-img-col { margin-bottom: 28px;}
            .preview-container { padding:18px 1vw;}
            .preview-title { font-size: 1.3rem;}
            .preview-img { width:98vw; max-width: 96vw; height: 180px;}
        }
    </style>
</head>
<body>
    <div class="preview-container">
        <div class="preview-row">
            <!-- Cột trái: Ảnh dịch vụ -->
            <div class="preview-img-col">
                <c:choose>
                    <c:when test="${not empty service.img}">
                        <img src="${pageContext.request.contextPath}/${service.img}" class="preview-img" alt="Ảnh dịch vụ">
                    </c:when>
                    <c:otherwise>
                        <span class="img-note">Chưa có ảnh dịch vụ</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Cột phải: Dữ liệu dịch vụ -->
            <div class="preview-data-col">
                <div class="preview-title">${service.name}</div>
                <div class="preview-price">
                    <fmt:formatNumber value="${service.price}" type="number" maxFractionDigits="0"/> đ
                </div>
                <div class="preview-section-title">Mô tả dịch vụ</div>
                <div class="preview-desc">${service.description}</div>
                <div class="preview-section-title">Phụ tùng kèm theo</div>
                <c:choose>
                    <c:when test="${not empty service.parts}">
                        <ul class="preview-parts-list">
                            <c:forEach var="part" items="${service.parts}">
                                <li>
                                    <c:choose>
                                        <c:when test="${not empty part.image}">
                                            <img src="${pageContext.request.contextPath}/image/${part.image}" alt="${part.name}" class="part-img">
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color:#bbb;font-size:15px;">Không ảnh</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <span>${part.name}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <span class="no-parts">Không có phụ tùng kèm theo</span>
                    </c:otherwise>
                </c:choose>
                <div class="preview-actions">
                    <a href="ServiceServlet_JSP?service=detailService&id=${service.id}" class="btn-detail">Xem chi tiết</a>
                    <a href="ServiceServlet_JSP?service=listService" class="btn-back">Quay lại</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>