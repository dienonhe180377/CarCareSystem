

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lỗi hệ thống</title>
        <style>
            .error-container {
                max-width: 800px;
                margin: 50px auto;
                padding: 30px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                text-align: center;
            }
            .error-icon {
                font-size: 80px;
                color: #dc3545;
                margin-bottom: 20px;
            }
            .error-actions {
                margin-top: 30px;
            }
        </style>
    </head>
    <body>
        <%@include file="/header.jsp" %>
        <div class="error-container">
            <div class="error-icon">⚠️</div>
            <h1>Đã xảy ra lỗi</h1>
            <p class="text-danger">${error}</p>
            <div class="error-actions">
                <a href="home" class="btn btn-primary">Về trang chủ</a>
                <a href="javascript:history.back()" class="btn btn-secondary">Quay lại</a>
            </div>
        </div>
        <%@include file="/footer.jsp" %>
    </body>
</html>
