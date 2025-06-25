<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Service, entity.Part, entity.User, java.util.ArrayList" %>
<%
    Service se = (Service) request.getAttribute("service");
    ArrayList<Part> parts = (se != null && se.getParts() != null) ? se.getParts() : new ArrayList<>();
    double totalPartPrice = 0;
    for (Part part : parts) {
        totalPartPrice += part.getPrice();
    }
    double totalPrice = (se != null ? se.getPrice() : 0) + totalPartPrice;

    User currentUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết dịch vụ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            background: #f1f6fc;
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 960px;
            margin: 36px auto 24px auto;
            padding: 0 12px;
        }
        .card {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.07);
            padding: 34px 28px 24px 28px;
            margin-bottom: 32px;
        }
        .header-title {
            font-size: 2rem;
            font-weight: 700;
            color: #1161b5;
            text-align: center;
            letter-spacing: 1px;
            margin-bottom: 30px;
        }
        .service-info-table, .parts-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 18px;
        }
        .service-info-table td {
            padding: 11px 10px;
            border-bottom: 1px solid #f0f2f7;
        }
        .service-info-table .label {
            color: #346899;
            font-weight: 500;
            width: 140px;
            background: #f7fbff;
        }
        .service-info-table .value {
            color: #123;
            background: #fcfdff;
        }
        .service-img {
            max-width: 170px;
            max-height: 110px;
            border-radius: 8px;
            border: 1px solid #e6e6e6;
        }
        .parts-section {
            margin-bottom: 30px;
        }
        .parts-title {
            font-size: 20px;
            color: #1161b5;
            font-weight: 600;
            margin-bottom: 12px;
        }
        .parts-table th, .parts-table td {
            padding: 8px 8px;
            border: 1px solid #e0e9f5;
            font-size: 15px;
        }
        .parts-table th {
            background: #eaf3fb;
            color: #276fbe;
            font-weight: 600;
        }
        .part-img {
            max-width: 55px;
            max-height: 35px;
            border-radius: 6px;
            border: 1px solid #ececec;
        }
        .img-note {
            color: #999; font-size: 12px; font-style: italic;
        }
        .no-parts {
            color: #aaa; text-align: center;
        }
        .price-main, .price-parts, .price-total {
            font-weight: bold;
        }
        .price-total {
            color: #d35400;
            font-size: 1.1em;
        }
        .feedback-link {
            display: inline-block;
            margin: 22px 0 0 0;
            background: #f7fbff;
            color: #1161b5;
            padding: 10px 22px;
            border-radius: 7px;
            text-decoration: none;
            font-size: 1.1rem;
            font-weight: 600;
            border: 1px solid #b3cef6;
            transition: background 0.2s, color 0.2s;
        }
        .feedback-link:hover {
            background: #1161b5;
            color: #fff;
        }
        .back-btn {
            background: #1161b5;
            color: #fff;
            padding: 8px 22px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            transition: background 0.2s;
            margin-top: 16px;
            display: inline-block;
        }
        .back-btn:hover {
            background: #093f77;
        }
        @media (max-width: 700px) {
            .container, .card { padding: 12px 5px; }
            .header-title { font-size: 1.3rem; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="header-title">Chi tiết dịch vụ</div>
            <table class="service-info-table">
                <tr>
                    <td class="label">ID</td>
                    <td class="value"><%= se != null ? se.getId() : "" %></td>
                </tr>
                <tr>
                    <td class="label">Tên dịch vụ</td>
                    <td class="value"><%= se != null ? se.getName() : "" %></td>
                </tr>
                <tr>
                    <td class="label">Mô tả</td>
                    <td class="value"><%= se != null ? se.getDescription() : "" %></td>
                </tr>
                <tr>
                    <td class="label">Ảnh dịch vụ</td>
                    <td class="value">
                        <% if (se != null && se.getImg() != null && !se.getImg().isEmpty()) { %>
                            <img src="<%= request.getContextPath() + "/" + se.getImg() %>" alt="Ảnh dịch vụ" class="service-img">
                        <% } else { %>
                            <span class="img-note">Chưa có ảnh</span>
                        <% } %>
                    </td>
                </tr>
                <tr>
                    <td class="label">Giá gốc dịch vụ</td>
                    <td class="value price-main"><%= se != null ? String.format("%,.0f", se.getPrice()) : "" %> VND</td>
                </tr>
                <tr>
                    <td class="label">Tổng giá phụ tùng</td>
                    <td class="value price-parts"><%= String.format("%,.0f", totalPartPrice) %> VND</td>
                </tr>
                <tr>
                    <td class="label"><b>Giá cuối (gồm phụ tùng)</b></td>
                    <td class="value price-total"><b><%= String.format("%,.0f", totalPrice) %> VND</b></td>
                </tr>
            </table>

            <!-- PHỤ TÙNG -->
            <div class="parts-section">
                <div class="parts-title">Phụ tùng liên quan</div>
                <table class="parts-table">
                    <tr>
                        <th>ID</th>
                        <th>Tên phụ tùng</th>
                        <th>Ảnh</th>
                        <th>Giá</th>
                    </tr>
                    <%
                        if (parts != null && !parts.isEmpty()) {
                            for (Part part : parts) {
                    %>
                    <tr>
                        <td><%= part.getId() %></td>
                        <td><%= part.getName() %></td>
                        <td>
                            <% if (part.getImage() != null && !part.getImage().isEmpty()) { %>
                                <img src="<%= request.getContextPath() + "/" + part.getImage() %>" class="part-img" alt="Ảnh phụ tùng"/>
                            <% } else { %>
                                <span class="img-note">Chưa có ảnh</span>
                            <% } %>
                        </td>
                        <td><%= String.format("%,.0f", part.getPrice()) %> VND</td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" class="no-parts">Không có phụ tùng liên quan</td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>

            <!-- Liên kết xem feedback -->
            <% if (se != null) { %>
                <a href="FeedbackServlet?serviceId=<%= se.getId() %>" class="feedback-link">Xem đánh giá & phản hồi</a>
            <% } %>

            <a href="home" class="back-btn">← Quay lại trang chủ</a>
        </div>
    </div>
</body>
</html>