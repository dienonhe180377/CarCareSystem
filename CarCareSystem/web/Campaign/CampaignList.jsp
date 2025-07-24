<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách Campaign</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-blue: #add8e6;
                --secondary-blue: #87ceeb;
                --light-blue: #e6f3ff;
                --dark-blue: #4682b4;
                --accent-blue: #b0e0e6;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #f0f8ff 0%, #e6f3ff 100%);
                min-height: 100vh;
                padding: 20px;
            }

            .main-header {
                background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
                color: #333;
                padding: 40px 0;
                margin-bottom: 40px;
                box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
                border-radius: 0 0 20px 20px;
            }

            .main-header h1 {
                font-weight: bold;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
                text-align: center;
                font-size: 2.5rem;
                margin: 0;
            }

            .container {
                max-width: 1000px;
                margin: auto;
                background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
                border: 2px solid var(--accent-blue);
            }

            .table-header {
                color: var(--dark-blue);
                font-weight: bold;
                margin-bottom: 20px;
                font-size: 1.8rem;
                position: relative;
                padding-bottom: 10px;
            }

            .table-header::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 50px;
                height: 3px;
                background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
                border-radius: 2px;
            }

            .table-container {
                overflow-x: auto;
                margin-top: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                font-size: 0.9rem;
            }

            th {
                background: linear-gradient(135deg, var(--dark-blue), var(--secondary-blue));
                color: white;
                padding: 15px 12px;
                text-align: left;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            th:first-child {
                border-top-left-radius: 10px;
            }

            th:last-child {
                border-top-right-radius: 10px;
            }

            td {
                padding: 12px;
                border-bottom: 1px solid var(--accent-blue);
                vertical-align: middle;
            }

            tr:hover {
                background: var(--light-blue);
                transition: all 0.3s ease;
            }

            tr:nth-child(even) {
                background-color: rgba(173, 216, 230, 0.1);
            }

            tr:nth-child(even):hover {
                background: var(--light-blue);
            }

            .status-active {
                background: linear-gradient(135deg, #28a745, #20c997);
                color: white;
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                display: inline-block;
            }

            .status-inactive {
                background: linear-gradient(135deg, #dc3545, #c82333);
                color: white;
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                display: inline-block;
            }

            .no-data {
                text-align: center;
                color: var(--dark-blue);
                font-style: italic;
                padding: 40px 0;
                font-size: 1.1rem;
            }

            .campaign-name {
                font-weight: bold;
                color: var(--dark-blue);
            }

            .fa-list, .fa-check, .fa-times, .fa-inbox {
                color: var(--secondary-blue);
                margin-right: 8px;
            }

            .description-cell {
                max-width: 200px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                }

                .main-header h1 {
                    font-size: 2rem;
                }

                table {
                    font-size: 0.8rem;
                }

                th, td {
                    padding: 8px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="/header_emp.jsp"></jsp:include>
        <div class="main-header">
            <h1><i class="fas fa-list"></i> Danh sách Campaign</h1>
        </div>

        <div class="container">
            <c:choose>
                <c:when test="${empty campaigns}">
                    <div class="no-data">
                        <i class="fas fa-inbox fa-2x mb-3"></i>
                        <br>
                        Chưa có campaign nào được tạo.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Tên Campaign</th>
                                    <th>Mô tả</th>
                                    <th>Ngày bắt đầu</th>
                                    <th>Ngày kết thúc</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="c" items="${campaigns}">
                                    <tr>
                                        <td>
                                            <a href="campaignlist?id=${c.id}" class="blog-title-link">
                                                <i class="campaign-name">${c.name}</i>
                                            </a>
                                        </td>
                                        <td>
                                            <div class="description-cell" title="${c.description}">
                                                ${c.description}
                                            </div>
                                        </td>
                                        <td><fmt:formatDate value="${c.startDate}" pattern="dd/MM/yyyy"/></td>
                                        <td><fmt:formatDate value="${c.endDate}" pattern="dd/MM/yyyy"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
