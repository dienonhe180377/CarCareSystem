<%-- 
    Document   : editCarType
    Created on : Jun 10, 2025, 8:01:12 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="entity.CarType" %>
<%
    CarType carType = (CarType) request.getAttribute("carType");
%>
<html>
    <head>
        <title>Chỉnh sửa loại xe</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                padding: 20px;
            }
            .container {
                width: 500px;
                margin: 50px auto;
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h2 {
                text-align: center;
                margin-bottom: 30px;
            }
            label {
                font-weight: bold;
            }
            input[type="text"], select {
                width: 100%;
                padding: 10px;
                margin: 12px 0 20px 0;
                border: 1px solid #ccc;
                border-radius: 6px;
            }
            button {
                background-color: #98d1e0;
                border: none;
                padding: 10px 25px;
                border-radius: 6px;
                font-weight: bold;
                cursor: pointer;
            }
            button:hover {
                background-color: #7fc1d3;
            }
            a {
                display: inline-block;
                margin-top: 15px;
                color: #007bff;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="container">
            <h2>Chỉnh sửa loại xe</h2>
            <form method="post" action="${pageContext.request.contextPath}/manager/editCarType">
                <input type="hidden" name="id" value="<%= carType.getId() %>" />

                <label for="name">Tên loại xe:</label>
                <input type="text" name="name" id="name"
                       value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : carType.getName() %>"
                       required />

                <label for="description">Mô tả:</label>
                <input type="text" name="description" id="description"
                       value="<%= request.getAttribute("description") != null ? request.getAttribute("description") : (carType.getDescription() != null ? carType.getDescription() : "") %>"
                       required />

                <label for="status">Trạng thái:</label>
                <input type="checkbox" name="status"
                       <%
                           boolean statusChecked = false;
                           if (request.getAttribute("status") != null) {
                               statusChecked = (Boolean) request.getAttribute("status");
                           } else {
                               statusChecked = carType.isStatus();
                           }
                           if (statusChecked) out.print("checked");
                       %> /> Kích hoạt<br/><br/>

                <button type="submit">Lưu</button><br/><br/>

                <div style="color:red;">
                    <%
                        String errorMessage = (String) request.getAttribute("errorMessage");
                        if (errorMessage != null) {
                            out.print(errorMessage);
                        }
                    %>
                </div>

                <a href="${pageContext.request.contextPath}/manager/carTypeList">Quay lại danh sách</a>
            </form>

        </div>
    </body>
</html>