<%-- 
    Document   : carTypeList
    Created on : Jun 9, 2025, 9:32:32 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.CarType" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách loại xe</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f7f9fc;
                margin: 0;
                padding: 0;
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
                width: 90%;
                max-width: 800px;
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

            .top-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                gap: 10px;
            }

            .add-btn {
                padding: 0 16px;
                background-color: #b2dff7;
                color: #fff;
                border-radius: 6px;
                text-decoration: none;
                font-weight: bold;
                height: 40px;
                display: flex;
                align-items: center;
            }

            .add-btn:hover {
                background-color: #7fc1d3;
            }

            .search-container {
                display: flex;
            }

            .search-form {
                display: flex;
                align-items: center;
                gap: 6px;
                height: 40px;
            }

            .search-form input[type="text"] {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                height: 100%;
            }

            .search-form button {
                padding: 8px 12px;
                border: none;
                border-radius: 5px;
                background-color: #b2dff7;
                color: black;
                cursor: pointer;
                height: 100%;
            }

            .search-form button:hover {
                background-color: #7fc1d3;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            table th, table td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: center;
            }

            table th {
                background-color: #f0f0f0;
            }

            .actions form {
                display: inline;
            }

            .actions button {
                padding: 6px 12px;
                background-color: #b2dff7;
                color: #333;
                border: none;
                border-radius: 4px;
                margin: 2px;
                cursor: pointer;
            }

            .actions button:hover {
                background-color: #7fc1d3;
            }

            .no-data {
                text-align: center;
                padding: 20px;
                color: #888;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="container">
            <h2>Danh sách loại xe</h2>

            <div class="top-bar">
                <a class="add-btn" href="${pageContext.request.contextPath}/manager/addCarType">+ Thêm loại xe mới</a>

                <div class="search-container">
                    <form class="search-form" method="get" action="${pageContext.request.contextPath}/manager/carTypeList">
                        <input type="text" name="search" placeholder="Tìm loại xe..." value="${param.search != null ? param.search : ''}">
                        <button type="submit">Tìm</button>
                    </form>
                </div>               
            </div>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Tên loại xe</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                <%
                    List<CarType> carTypes = (List<CarType>) request.getAttribute("carTypes");
                    if (carTypes != null && !carTypes.isEmpty()) {
                        for (CarType carType : carTypes) {
                %>
                <tr>
                    <td><%= carType.getId() %></td>
                    <td><%= carType.getName() %></td>
                    <td><%= carType.isStatus() ? "Kích hoạt" : "Không kích hoạt" %></td>
                    <td class="actions">
                        <form action="<%= request.getContextPath() %>/manager/carTypeDetail" method="get">
                            <input type="hidden" name="id" value="<%= carType.getId() %>"/>
                            <button type="submit">Xem</button>
                        </form>
                        <form action="<%= request.getContextPath() %>/manager/editCarType" method="get">
                            <input type="hidden" name="id" value="<%= carType.getId() %>"/>
                            <button type="submit">Sửa</button>
                        </form>
                        <form action="<%= request.getContextPath() %>/manager/deleteCarType" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn xóa loại xe này?');">
                            <input type="hidden" name="id" value="<%= carType.getId() %>"/>
                            <button type="submit">Xóa</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="4" class="no-data">Không có loại xe nào.</td>
                </tr>
                <% } %>
            </table>
        </div>
    </body>
</html>