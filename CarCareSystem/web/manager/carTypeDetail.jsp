<%-- 
    Document   : carTypeDetail
    Created on : Jun 9, 2025, 9:33:31 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="entity.CarType" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết loại xe</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f7f9fc;
                margin: 0;
            }

            header {
                background-color: #b2dff7;
                padding: 20px;
            }

            header h1 {
                margin: 0;
                color: #333;
            }

            .container {
                max-width: 600px;
                margin: 40px auto;
                background-color: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
            }

            .detail {
                font-size: 16px;
                margin-bottom: 20px;
            }

            .detail strong {
                display: inline-block;
                width: 150px;
            }

            a.btn-back {
                display: inline-block;
                padding: 10px 18px;
                background-color: #b2dff7;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <%
            CarType carType = (CarType) request.getAttribute("carType");
        %>

        <div class="container">
            <h2>Chi tiết loại xe</h2>
            <div class="detail"><strong>ID:</strong> <%= carType.getId() %></div>
            <div class="detail"><strong>Tên loại xe:</strong> <%= carType.getName() %></div>
            <div class="detail"><strong>Trạng thái:</strong> <%= carType.isStatus() ? "Kích hoạt" : "Không kích hoạt" %></div>

            <a class="btn-back" href="${pageContext.request.contextPath}/manager/carTypeList">Quay lại danh sách</a>
        </div>
    </body>
</html>