<%-- 
    Document   : settingList
    Created on : Jun 27, 2025, 2:04:10 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Website Settings</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 900px;
                margin: 40px auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.05);
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            .top-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                gap: 10px;
            }

            .add-setting {
                padding: 8px 16px;
                background-color: lightblue;
                color: #fff;
                border-radius: 6px;
                text-decoration: none;
                font-weight: bold;
                transition: background-color 0.3s ease;
                height: 40px;
                display: flex;
                align-items: center;
            }

            .add-setting:hover {
                background-color: deepskyblue;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                padding: 12px;
                border: 1px solid #ccc;
                text-align: left;
            }

            th {
                background-color: #f1f1f1;
            }

            .action-btn {
                padding: 6px 12px;
                font-size: 14px;
                border: none;
                border-radius: 6px;
                background-color: lightblue;
                color: black;
                cursor: pointer;
                margin-right: 5px;
            }

            .action-btn:hover {
                background-color: deepskyblue;
                color: white;
            }

            .alert {
                margin: 0;
                padding: 8px 16px;
                background-color: #d1e7dd;
                color: #0f5132;
                border: 1px solid #badbcc;
                border-radius: 6px;
                font-size: 14px;
                flex-grow: 1;
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
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="container">
            <h2><i class="fa fa-cogs"></i> Cài đặt Website</h2>
            <div class="top-bar">
                <%
                    String success = (String) session.getAttribute("success");
                    if (success != null) {
                %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= success %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <%
                        session.removeAttribute("success");
                    }
                %>
            </div>

            <table>
                <thead>
                    <tr>
                        <th style="width: 30%;">Tên Setting</th>
                        <th style="width: 50%;">Giá trị</th>
                        <th style="width: 20%;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${settings}">
                        <tr>
                            <td>${s.name}</td>
                            <td>${s.value}</td>
                            <td>
                                <a href="settingDetail?id=${s.id}" class="action-btn btn-warning btn-sm"><i class="fa fa-edit"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <%
                int currentPage = request.getAttribute("currentPage") != null ? (Integer) request.getAttribute("currentPage") : 1;
                int totalPages = request.getAttribute("totalPages") != null ? (Integer) request.getAttribute("totalPages") : 1;
            %>
            <div class="pagination-container">
                <ul class="pagination">
                    <% if (currentPage > 1) { %>
                    <li><a href="settingList?page=<%= currentPage - 1 %>">&laquo;</a></li>
                        <% } else { %>
                    <li class="disabled"><span>&laquo;</span></li>
                        <% } %>

                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <% if (i == currentPage) { %>
                    <li class="active"><span><%= i %></span></li>
                            <% } else { %>
                    <li><a href="settingList?page=<%= i %>"><%= i %></a></li>
                        <% } %>
                        <% } %>

                    <% if (currentPage < totalPages) { %>
                    <li><a href="settingList?page=<%= currentPage + 1 %>">&raquo;</a></li>
                        <% } else { %>
                    <li class="disabled"><span>&raquo;</span></li>
                        <% } %>
                </ul>
            </div>
        </div>
    </body>
</html>