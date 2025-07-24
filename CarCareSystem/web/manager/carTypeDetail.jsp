<%-- 
    Document   : carTypeDetail
    Created on : Jun 9, 2025, 9:33:31 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="entity.CarType" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    CarType carType = (CarType) request.getAttribute("carType");
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

    String createdAt = (carType.getCreatedAt() != null) ? sdf.format(new Date(carType.getCreatedAt().getTime())) : "";
    String updatedAt = (carType.getUpdatedAt() != null) ? sdf.format(new Date(carType.getUpdatedAt().getTime())) : "";
%>
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

            .row {
                display: flex;
                margin-bottom: 20px;
            }

            .label {
                width: 150px;
                font-weight: bold;
                color: #333;
            }

            .value {
                flex: 1;
                line-height: 1.2;
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
        <div class="container">
            <h2>Chi tiết loại xe</h2>

            <div class="row"><div class="label">ID:</div><div class="value"><%= carType.getId() %></div></div>
            <div class="row"><div class="label">Tên loại xe:</div><div class="value"><%= carType.getName() %></div></div>
            <div class="row"><div class="label">Mô tả:</div><div class="value"><%= carType.getDescription() != null ? carType.getDescription() : "Không có" %></div></div>
            <div class="row"><div class="label">Trạng thái:</div><div class="value"><%= carType.isStatus() ? "Kích hoạt" : "Không kích hoạt" %></div></div>
            <div class="row"><div class="label">Ngày tạo:</div><div class="value"><%= createdAt %></div></div>
            <div class="row"><div class="label">Cập nhật gần nhất:</div><div class="value"><%= updatedAt %></div></div>

            <a class="btn-back" href="${pageContext.request.contextPath}/manager/carTypeList">Quay lại danh sách</a>
        </div>
    </body>
</html>