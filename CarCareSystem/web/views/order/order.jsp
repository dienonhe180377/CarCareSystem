
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="entity.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đặt lịch sửa xe</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f5f6fa;
                margin: 0;
                padding: 0;
            }

            .form-container {
                max-width: 700px;
                margin: 100px auto 40px auto;
                background: #fff;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
                color: #2f3640;
            }

            label {
                display: block;
                margin-bottom: 6px;
                font-weight: bold;
                color: #333;
            }

            input[type="text"],
            input[type="email"],
            input[type="date"],
            textarea {
                width: 100%;
                padding: 10px 12px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 8px;
                transition: border-color 0.3s;
            }

            textarea {
                height: 100px;
                resize: vertical;
            }

            input:focus,
            textarea:focus {
                border-color: #40739e;
                outline: none;
            }

            .submit-btn {
                display: block;
                width: 100%;
                padding: 12px;
                background-color: #40739e;
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .submit-btn:hover {
                background-color: #273c75;
            }

            .message {
                text-align: center;
                color: green;
                font-weight: bold;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <%@include file="/header.jsp" %>
        <div class="form-container">
            <h2>Đặt lịch sửa xe</h2>
            <form action="order" method="post">
                <label>Họ và tên:</label>
                <input type="text" name="fullName" required
                       value="<%= currentUser != null ? currentUser.getUsername() : "" %>"
                       <%= currentUser != null ? "readonly" : "" %>>

                <label>Email:</label>
                <input type="email" name="email" required
                       value="<%= currentUser != null ? currentUser.getEmail() : "" %>"
                       <%= currentUser != null ? "readonly" : "" %>>

                <label>Số điện thoại:</label>
                <input type="text" name="phone" required
                       value="<%= currentUser != null ? currentUser.getPhone() : "" %>"
                       <%= currentUser != null ? "readonly" : "" %>>

                <label>Địa chỉ:</label>
                <input type="text" name="address" required
                       value="<%= currentUser != null ? currentUser.getAddress() : "" %>"
                       <%= currentUser != null ? "readonly" : "" %>>

                <label>Loại Xe:</label>
                <input type="text" name="carType" required placeholder="Nhập loại xe (VD: Toyota Camry, Honda CR-V...)">

                <label>Mô tả vấn đề:</label>
                <textarea name="description" required placeholder="Mô tả chi tiết vấn đề của xe..."></textarea>

                <label>Ngày hẹn:</label>
                <input type="date" name="appointmentDate" required 
                       min="<fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/>">

                <input type="submit" class="submit-btn" value="Đặt lịch">
            </form>

            <c:if test="${not empty message}">
                <div class="alert alert-danger">
                    ${message}
                </div>
            </c:if>
        </div>
    </body>
</html>
