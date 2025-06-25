<%-- 
    Document   : addCarType
    Created on : Jun 9, 2025, 9:33:01 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm loại xe mới</title>
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
                background-color: #fff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
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
                margin: 12px 0 20px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }

            button {
                background-color: #b2dff7;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: bold;
            }

            button:hover {
                opacity: 0.9;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="container">
            <h2>Thêm loại xe mới</h2>
            <form action="${pageContext.request.contextPath}/manager/addCarType" method="post">
                <label>Tên loại xe:</label><br/>
                <input type="text" name="name" value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>" required/><br/>

                <label>Trạng thái:</label>
                <input type="checkbox" name="status" <%= (request.getAttribute("status") != null && (Boolean)request.getAttribute("status")) ? "checked" : "" %> /><br/><br/>

                <button type="submit">Thêm loại xe</button><br/>

                <div style="color:red;">
                    <%
                        String errorMessage = (String) request.getAttribute("errorMessage");
                        if (errorMessage != null) {
                            out.print(errorMessage);
                        }
                    %>
                </div><br/>

                <a href="${pageContext.request.contextPath}/manager/carTypeList">Quay lại danh sách</a>
            </form>
        </div>
    </body>
</html>