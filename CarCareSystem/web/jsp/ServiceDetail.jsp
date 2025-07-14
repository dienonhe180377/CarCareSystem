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
    <style>
        body { font-family: Arial, sans-serif; background: #f5f6fa; }
        .form-container {
            background: #fff;
            width: 700px;
            margin: 40px auto;
            border-radius: 8px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.07);
            padding: 32px 40px;
        }
        .form-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
            color: #003366;
        }
        .tieu-de {
            margin-top: 18px;
            margin-bottom: 12px;
            color: #15518d;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 16px;
        }
        th, td {
            border: 1px solid #dde5eb;
            padding: 8px 12px;
        }
        th {
            background: #e6f0fb;
            color: #003366;
            font-weight: 600;
            text-align: center;
        }
        .form-label {
            background: #f0f6fb;
            width: 180px;
            font-weight: 500;
        }
        .form-value {
            background: #fff;
        }
        .no-parts {
            text-align: center;
            color: #999;
        }
        .form-actions {
            margin-top: 24px;
            text-align: right;
        }
        .btn-back, .btn-order {
            background: #2471a3;
            color: #fff;
            padding: 8px 18px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.2s;
            border: none;
            cursor: pointer;
        }
        .btn-back:hover, .btn-order:hover {
            background: #15518d;
        }
        .btn-order {
            background: #e74c3c;
            margin-right: 16px;
        }
        .btn-order:hover {
            background: #b62a13;
        }
        .service-img {
            max-width: 180px;
            max-height: 120px;
            border-radius: 6px;
            border: 1px solid #ececec;
            margin: 3px 0 3px 0;
        }
        .part-img {
            max-width: 100px;
            max-height: 70px;
            border-radius: 4px;
            border: 1px solid #ececec;
        }
        .img-note {
            color: #999; font-size: 12px; font-style: italic;
        }
        @media (max-width: 900px) {
            .form-container { width: 96vw; padding: 12px 2vw; }
        }
        @media (max-width: 600px) {
            .form-title { font-size: 20px; }
            .tieu-de { font-size: 17px; }
            table, th, td { font-size: 13px; }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="form-title">Chi tiết dịch vụ</div>
        <h2 class="tieu-de">Thông tin dịch vụ</h2>
        <table>
            <tr>
                <td class="form-label">Tên dịch vụ</td>
                <td class="form-value"><%= se != null ? se.getName() : "" %></td>
            </tr>
            <tr>
                <td class="form-label">Mô tả</td>
                <td class="form-value"><%= se != null ? se.getDescription() : "" %></td>
            </tr>
            <tr>
                <td class="form-label">Ảnh dịch vụ</td>
                <td class="form-value">
                    <% if (se != null && se.getImg() != null && !se.getImg().isEmpty()) { %>
                        <img src="<%= request.getContextPath() + "/uploads/" + se.getImg() %>" alt="Ảnh dịch vụ" class="service-img">
                    <% } else { %>
                        <span class="img-note">Chưa có ảnh</span>
                    <% } %>
                </td>
            </tr>
            <tr>
                <td class="form-label">Giá gốc dịch vụ</td>
                <td class="form-value"><%= se != null ? String.format("%,.0f", se.getPrice()) : "" %> VND</td>
            </tr>
            <tr>
                <td class="form-label">Tổng giá phụ tùng</td>
                <td class="form-value"><%= String.format("%,.0f", totalPartPrice) %> VND</td>
            </tr>
            <tr>
                <td class="form-label"><b>Giá dịch vụ (gồm phụ tùng)</b></td>
                <td class="form-value"><b style="color:#e74c3c;"><%= String.format("%,.0f", totalPrice) %> VND</b></td>
            </tr>
        </table>
        <h2 class="tieu-de" style="margin-top:32px;">Phụ tùng liên quan</h2>
        <table class="table-parts">
            <tr>
                <th>STT</th>
                <th>Tên phụ tùng</th>
                <th>Ảnh</th>
                <th>Giá</th>
            </tr>
            <%
                if (parts != null && !parts.isEmpty()) {
                    int stt = 1;
                    for (Part part : parts) {
            %>
            <tr>
                <td style="text-align:center;"><%= stt++ %></td>
                <td><%= part.getName() %></td>
                <td>
                    <%
                        String partImgPath = part.getImage();
                        if (partImgPath != null && !partImgPath.trim().isEmpty()) {
                            String finalPartImgUrl = request.getContextPath() + "/image/" + partImgPath;
                    %>
                        <img src="<%= finalPartImgUrl %>" class="part-img" alt="Ảnh phụ tùng"/>
                    <%
                        } else {
                    %>
                        <span class="img-note">Chưa có ảnh</span>
                    <%
                        }
                    %>
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
        <div class="form-actions">
            <form action="OrderServlet" method="post" style="display:inline;">
                <input type="hidden" name="serviceId" value="<%= se != null ? se.getId() : "" %>"/>
                <button type="submit" class="btn-order">Đặt dịch vụ</button>
            </form>
            <a href="ServiceServlet_JSP?service=listService" class="btn-back">Quay lại danh sách</a>
        </div>
    </div>
</body>
</html>