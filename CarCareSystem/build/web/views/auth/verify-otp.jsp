<%-- 
    Document   : verify-otp
    Created on : Jun 3, 2025, 7:57:16 PM
    Author     : TRAN ANH HAI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="verifyOTP" method="post">
            <h2>Xác minh OTP</h2>
            <input type="text" name="otp" placeholder="Nhập mã OTP" required />
            <button type="submit">Xác minh</button>
        </form>
        <% if (request.getAttribute("error") != null) { %>
            <p style="color:red"><%= request.getAttribute("error") %></p>
        <% } %>
        <% if (request.getAttribute("message") != null) { %>
            <p style="color:green"><%= request.getAttribute("message") %></p>
        <% } %>
    </body>
</html>
