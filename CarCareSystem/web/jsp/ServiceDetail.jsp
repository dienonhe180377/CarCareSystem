<%-- 
    Document   : ServiceDetail
    Created on : Jun 7, 2025, 9:32:13 AM
    Author     : ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Service"%>
<%
    Service se = (Service) request.getAttribute("service");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <style>
        body {
            background: linear-gradient(120deg, #e0eafc, #cfdef3 100%);
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .form-container {
            background: #fff;
            max-width: 450px;
            margin: 50px auto;
            padding: 36px 40px 28px 40px;
            border-radius: 20px;
            box-shadow: 0 6px 32px rgba(0,0,0,0.12);
            position: relative;
            animation: floatIn 0.9s cubic-bezier(.55,.06,.68,.19);
        }
        @keyframes floatIn {
            from { transform: translateY(60px) scale(0.95); opacity: 0; }
            to { transform: translateY(0) scale(1); opacity: 1; }
        }
        .form-title {
            text-align: center;
            font-size: 2rem;
            font-weight: 600;
            color: #276678;
            letter-spacing: 1px;
            margin-bottom: 22px;
        }
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 12px;
        }
        td, th {
            padding: 0;
        }
        .form-label {
            font-size: 1.06rem;
            color: #1e3c72;
            font-weight: 500;
            padding-bottom: 4px;
            width: 36%;
            vertical-align: top;
        }
        .form-value {
            font-size: 1.05rem;
            color: #2563eb;
            background: #f7fbff;
            border-radius: 8px;
            padding: 8px 12px;
            font-weight: 600;
        }
        .form-actions {
            text-align: right;
            padding-top: 12px;
        }
        .btn {
            padding: 9px 30px;
            border-radius: 8px;
            border: none;
            font-size: 1.06rem;
            font-weight: 500;
            margin-left: 12px;
            margin-top: 5px;
            cursor: pointer;
            transition: box-shadow 0.16s, background 0.16s, color 0.16s;
            box-shadow: 0 2px 6px rgba(56,149,211,0.09);
            text-decoration: none;
            display: inline-block;
        }
        .btn-back {
            background: linear-gradient(90deg, #3895d3, #47b5ff);
            color: #fff;
        }
        .btn-back:hover {
            background: linear-gradient(90deg,#47b5ff,#3895d3);
            color: #fff;
            box-shadow: 0 4px 16px rgba(56,149,211,0.16);
        }
        .tieu-de{
            text-align: center;
            margin-bottom: 20px;
            color: #2563eb;
            font-size: 1.35rem;
            font-weight: 700;
            letter-spacing: 1px;
        }
        @media (max-width: 600px) {
            .form-container {
                padding: 22px 10px;
            }
            .form-title {
                font-size: 1.3rem;
            }
            .btn {
                padding: 8px 16px;
            }
            .tieu-de {
                font-size: 1.12rem;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <div class="form-title">${pageTitle}</div>
        <h2 class="tieu-de">Chi tiết dịch vụ</h2>
        <table>
            <tr>
                <td class="form-label">ID</td>
                <td class="form-value"><%= se.getId() %></td>
            </tr>
            <tr>
                <td class="form-label">Tên dịch vụ</td>
                <td class="form-value"><%= se.getName() %></td>
            </tr>
            <tr>
                <td class="form-label">Mô tả</td>
                <td class="form-value"><%= se.getDescription() %></td>
            </tr>
            <tr>
                <td class="form-label">Giá dịch vụ</td>
                <td class="form-value"><%= String.format("%,.0f", se.getPrice()) %> VND</td>
            </tr>
            <tr>
                <td colspan="2" class="form-actions">
                    <a href="ServiceServlet_JSP?service=listService" class="btn btn-back">Quay lại danh sách</a>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>