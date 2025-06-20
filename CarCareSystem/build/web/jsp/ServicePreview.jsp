<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Chi tiết dịch vụ</title>
    <style>
        .service-detail {
            border: 1px solid #ccc; 
            border-radius: 8px; 
            padding: 24px; 
            width: 400px; 
            margin: 40px auto; 
            box-shadow: 0 2px 12px rgba(0,0,0,0.08);
            background: #fff;
        }
        .service-detail img {
            width: 100%; max-width: 300px; border-radius: 4px; margin-bottom: 16px;
        }
        .service-detail h3 { margin-bottom: 10px; }
        .service-detail p { margin-bottom: 8px; }
        .service-detail a { display: inline-block; margin-top: 16px; color: #0066cc; text-decoration: underline; }
    </style>
</head>
<body>
    <div class="service-detail">
        <img src="${service.img}" alt="${service.name}" />
        <h3>${service.name}</h3>
        <p><b>Mô tả:</b> ${service.description}</p>
        <p><b>Giá:</b> ${service.price} VNĐ</p>
        <!-- Nếu Service có danh sách Parts -->
        <c:if test="${not empty service.parts}">
            <h4>Các linh kiện sử dụng:</h4>
            <ul>
                <c:forEach var="part" items="${service.parts}">
                    <li>${part.name} - Giá: ${part.price} VNĐ</li>
                </c:forEach>
            </ul>
        </c:if>
        <a href="home">Quay lại trang chủ</a>
    </div>
</body>
</html>