<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Xác nhận xóa dịch vụ</title>
    <style>
        body { 
            background: #f4f7fb; 
            font-family: Arial, sans-serif; 
            margin: 0;
            padding: 20px;
        }
        .confirm-container {
            background: #fff;
            max-width: 600px;
            margin: 48px auto;
            border-radius: 18px;
            padding: 48px 56px 30px 56px;
            box-shadow: 0 8px 32px 0 rgba(31,38,135,0.12);
            text-align: center;
        }
        .confirm-title { 
            font-size: 2.2rem; 
            color: #e74c3c; 
            font-weight: 700; 
            margin-bottom: 28px; 
        }
        .service-info {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 24px;
            margin: 24px 0;
            text-align: left;
        }
        .service-info h3 {
            color: #2563eb;
            margin-bottom: 16px;
            font-size: 1.4rem;
        }
        .service-info p {
            margin: 8px 0;
            font-size: 1.1rem;
            color: #555;
        }
        .service-info img {
            max-width: 150px;
            max-height: 100px;
            border-radius: 8px;
            margin: 12px 0;
        }
        .warning-message {
            color: #e74c3c;
            font-size: 1.25rem;
            font-weight: 600;
            margin: 24px 0;
            padding: 16px;
            background: #fdeded;
            border-radius: 8px;
            border-left: 4px solid #e74c3c;
        }
        .btn { 
            padding: 14px 32px; 
            border-radius: 8px; 
            border: none; 
            font-size: 1.2rem; 
            font-weight: 700; 
            margin: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-danger { 
            background: #e74c3c; 
            color: #fff; 
        }
        .btn-danger:hover { 
            background: #c0392b; 
        }
        .btn-cancel {
            background: #6c757d;
            color: #fff;
        }
        .btn-cancel:hover {
            background: #5a6268;
        }
    </style>
</head>
<body>
    <%@include file="/header_emp.jsp" %>
    <div class="confirm-container">
        <div class="confirm-title">⚠️ Xác nhận xóa dịch vụ</div>
        
        <div class="service-info">
            <h3>Thông tin dịch vụ sẽ bị xóa:</h3>
            <p><strong>ID:</strong> ${service.id}</p>
            <p><strong>Tên dịch vụ:</strong> ${service.name}</p>
            <p><strong>Mô tả:</strong> ${service.description}</p>
            <p><strong>Giá:</strong> <fmt:formatNumber value="${service.price}" type="number" groupingUsed="true" minFractionDigits="0" /> đ</p>
            <c:if test="${not empty service.img}">
                <p><strong>Ảnh:</strong></p>
                <img src="${pageContext.request.contextPath}/img/${service.img}" alt="Service Image">
            </c:if>
        </div>
        
        <div class="warning-message">
            Bạn có chắc chắn muốn xóa dịch vụ này không?<br>
            <strong>Hành động này không thể hoàn tác!</strong>
        </div>
        
        <div>
            <a href="ServiceServlet_JSP?service=deleteService&id=${service.id}&confirm=true" class="btn btn-danger">
                Xác nhận xóa
            </a>
            <a href="ServiceServlet_JSP?service=listService" class="btn btn-cancel">
                Hủy bỏ
            </a>
        </div>
    </div>
</body>
</html>