<%-- 
    Document   : contact
    Created on : Jul 23, 2025, 3:50:01 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liên hệ - Car Care Centre</title>
    <style>
        body {
            background-color: #f3f8fa;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .contact-container {
            max-width: 740px;
            margin: 120px auto 40px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.08);
            padding: 36px 40px 32px;
        }
        .contact-container h2 {
            text-align: center;
            color: #006699;
            margin-bottom: 24px;
        }
        .contact-details {
            color: #222;
            font-size: 17px;
            line-height: 1.55;
        }
        .contact-details div {
            margin: 12px 0;
        }
        @media (max-width: 800px) {
            .contact-container {
                max-width: 97vw;
                margin: 90px 1vw 32px;
                padding: 18px 4vw;
            }
            .contact-details { font-size: 15px; }
        }
    </style>
</head>
<body>
    <%@include file="/header.jsp" %>
    <div class="contact-container">
        <h2>Liên hệ với Car Care Centre</h2>
        <div class="contact-details">
            <div><strong>Địa chỉ:</strong> 198 Đường Giải Phóng, Đống Đa, TP Hà Nội</div>
            <div><strong>Email:</strong> <a href="mailto:support@carcarecentre.com"><%= settingMap.get("contact_email") %></a></div>
            <div><strong>Điện thoại:</strong> <%= settingMap.get("hotline") %></div>
            <div><strong>Facebook:</strong> <a href="https://facebook.com/carcarecentre" target="_blank" rel="noopener">CarCareCentre</a></div>
            <div><strong>Giờ làm việc:</strong> <%= settingMap.get("working_hours") %></div>
        </div>
    </div>
    <%@include file="/footer.jsp" %>
</body>
</html>
