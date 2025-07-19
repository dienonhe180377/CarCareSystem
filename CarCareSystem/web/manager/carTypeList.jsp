<%-- 
    Document   : carTypeList
    Created on : Jun 9, 2025, 9:32:32 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.CarType" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
%>
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
                width: 100%;
                max-width: 1200px;
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

            .sort-select {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                height: 100%;
                background-color: white;
                color: #333;
                font-size: 14px;
                cursor: pointer;
                transition: border-color 0.2s ease-in-out;
            }

            .sort-select:focus {
                border-color: #7fc1d3;
                outline: none;
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
                white-space: nowrap;
                overflow: hidden;
            }

            table th {
                background-color: #f0f0f0;
            }

            table tr:hover {
                background-color: #f5f5f5;
            }

            table td.actions {
                white-space: normal;
            }

            table td.desc {
                max-width: 250px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
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

            .pagination-container {
                text-align: center;
                margin-top: 30px;
            }

            .pagination {
                display: inline-flex;
                list-style: none;
                padding: 0;
                border-radius: 6px;
                overflow: hidden;
                background-color: #f1f1f1;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .pagination li {
                border-right: 1px solid #ccc;
            }

            .pagination li:last-child {
                border-right: none;
            }

            .pagination li a,
            .pagination li span {
                display: block;
                padding: 8px 16px;
                text-decoration: none;
                color: lightblue;
                font-weight: bold;
                transition: background-color 0.2s;
            }

            .pagination li a:hover {
                background-color: #e0f0ff;
            }

            .pagination li.active span {
                background-color: lightblue;
                color: white;
                font-weight: bold;
            }

            .pagination li.disabled span {
                color: #999;
                cursor: not-allowed;
            }

            .error{
                padding: 10px;
                margin-bottom: 20px;
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
                border-radius: 5px;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="container">
            <h2><i class="fa fa-car-side"></i> Danh sách loại xe</h2>
            <%
                String message = (String) session.getAttribute("message");
                if (message != null) {
            %>
            <div class="error"><%= message %></div>
            <%
                    session.removeAttribute("message");
                }
            %>
            <div class="top-bar">
                <a class="add-btn" href="${pageContext.request.contextPath}/manager/addCarType">+ Thêm loại xe mới</a>

                <div class="search-container">
                    <form class="search-form" method="get" action="${pageContext.request.contextPath}/manager/carTypeList">
                        <select name="sort" onchange="this.form.submit()" class="sort-select">
                            <option value="">-- Sắp xếp theo --</option>
                            <option value="nameAsc" <%= "nameAsc".equals(request.getParameter("sort")) ? "selected" : "" %>>Tên A → Z</option>
                            <option value="nameDesc" <%= "nameDesc".equals(request.getParameter("sort")) ? "selected" : "" %>>Tên Z → A</option>
                            <option value="createdAtAsc" <%= "createdAtAsc".equals(request.getParameter("sort")) ? "selected" : "" %>>Ngày tạo ↑</option>
                            <option value="createdAtDesc" <%= "createdAtDesc".equals(request.getParameter("sort")) ? "selected" : "" %>>Ngày tạo ↓</option>
                            <option value="updatedAtDesc" <%= "updatedAtDesc".equals(request.getParameter("sort")) ? "selected" : "" %>>Ngày cập nhật mới nhất</option>
                        </select>

                        <input type="text" name="search" placeholder="Tìm loại xe..." value="${param.search != null ? param.search : ''}">
                        <button type="submit">Tìm</button>
                    </form>
                </div>               
            </div>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Tên loại xe</th>
                    <th>Mô tả</th>
                    <th>Trạng thái</th>
                    <th>Ngày tạo</th>
                    <th>Cập nhật gần nhất</th>
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
                    <td class="desc"><%= carType.getDescription() != null ? carType.getDescription() : "" %></td>
                    <td style="color:<%= carType.isStatus() ? "green" : "red" %>;">
                        <%= carType.isStatus() ? "✔ Kích hoạt" : "✖ Không kích hoạt" %>
                    </td>
                    <td><%= carType.getCreatedAt() != null ? sdf.format(carType.getCreatedAt()) : "" %></td>
                    <td><%= carType.getUpdatedAt() != null ? sdf.format(carType.getUpdatedAt()) : "" %></td>
                    <td class="actions">
                        <form action="<%= request.getContextPath() %>/manager/carTypeDetail" method="get">
                            <input type="hidden" name="id" value="<%= carType.getId() %>"/>
                            <button type="submit" class="btn btn-info btn-sm"><i class="fa fa-eye"></i></button>
                        </form>
                        <form action="<%= request.getContextPath() %>/manager/editCarType" method="get">
                            <input type="hidden" name="id" value="<%= carType.getId() %>"/>
                            <button type="submit" class="btn btn-warning btn-sm"><i class="fa fa-edit"></i></button>
                        </form>
                        <form action="<%= request.getContextPath() %>/manager/deleteCarType" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn xóa loại xe này?');">
                            <input type="hidden" name="id" value="<%= carType.getId() %>"/>
                            <button type="submit" class="btn btn-danger btn-sm"><i class="fa fa-trash"></i></button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7" class="no-data">Không có loại xe nào.</td>
                </tr>
                <% } %>
            </table>
            <%
                int currentPage = request.getAttribute("currentPage") != null ? (Integer) request.getAttribute("currentPage") : 1;
                int totalPages = request.getAttribute("totalPages") != null ? (Integer) request.getAttribute("totalPages") : 1;
                String searchParam = request.getParameter("search") != null ? request.getParameter("search") : "";
                String sortParam = request.getParameter("sort") != null ? request.getParameter("sort") : "";
            %>

            <div class="pagination-container">
                <ul class="pagination">
                    <% if (currentPage > 1) { %>
                    <li><a href="carTypeList?page=<%= currentPage - 1 %>&search=<%= searchParam %>&sort=<%= sortParam %>">&laquo;</a></li>
                        <% } else { %>
                    <li class="disabled"><span>&laquo;</span></li>
                        <% } %>

                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <% if (i == currentPage) { %>
                    <li class="active"><span><%= i %></span></li>
                            <% } else { %>
                    <li><a href="carTypeList?page=<%= i %>&search=<%= searchParam %>&sort=<%= sortParam %>"><%= i %></a></li>
                        <% } %>
                        <% } %>

                    <% if (currentPage < totalPages) { %>
                    <li><a href="carTypeList?page=<%= currentPage + 1 %>&search=<%= searchParam %>&sort=<%= sortParam %>">&raquo;</a></li>
                        <% } else { %>
                    <li class="disabled"><span>&raquo;</span></li>
                        <% } %>
                </ul>
            </div>
        </div>
    </body>
</html>