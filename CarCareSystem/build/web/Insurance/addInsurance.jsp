<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thêm bảo hiểm</title>
    <style>
        body {
            background: linear-gradient(120deg, #e0eafc, #cfdef3 100%);
            min-height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .form-container {
            background: #fff;
            max-width: 480px;
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
        td {
            padding: 0;
        }
        .form-label {
            font-size: 1.06rem;
            color: #1e3c72;
            font-weight: 500;
            padding-bottom: 4px;
            width: 32%;
            vertical-align: top;
        }
        .form-input, .form-select {
            width: 99%;
            padding: 9px 12px;
            border: 1.5px solid #dbe2ef;
            border-radius: 8px;
            font-size: 1.04rem;
            color: #333;
            background: #f7fbff;
            transition: border-color 0.2s;
            outline: none;
            box-sizing: border-box;
        }
        .form-input:focus, .form-select:focus {
            border-color: #3895d3;
            background: #ecf6fc;
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
        }
        .btn-submit {
            background: linear-gradient(90deg, #3895d3, #47b5ff);
            color: #fff;
        }
        .btn-submit:hover {
            background: linear-gradient(90deg,#47b5ff,#3895d3);
            box-shadow: 0 4px 16px rgba(56,149,211,0.16);
        }
        .btn-reset {
            background: #e84545;
            color: #fff;
        }
        .btn-reset:hover {
            background: #b02a37;
            color: #fff;
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
        }
    </style>
</head>
<body>
    <div style="text-align:left; margin: 18px 0 0 32px;">
        <a href="index.html" style="color:#3895d3; font-weight:500; text-decoration:none;">
            &larr; Trang chủ
        </a>
    </div>
    <div class="form-container">
        <div class="form-title">Add Insurance</div>
        <form action="insurance" method="POST" autocomplete="off">
            <table>
                <tr>
                    <td class="form-label">UserId</td>
                    <td>
                        <select class="form-select" name="userId" required>
                            <c:forEach var="u" items="${user}">
                                <option value="${u.id}">${u.username}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="form-label">CarTypeId</td>
                    <td>
                        <select class="form-select" name="carTypeId" required>
                            <c:forEach var="c" items="${carType}">
                                <option value="${c.id}">${c.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="form-label">Start Date</td>
                    <td><input class="form-input" type="date" name="startDate" required></td>
                </tr>
                <tr>
                    <td class="form-label">End Date</td>
                    <td><input class="form-input" type="date" name="endDate" required></td>
                </tr>
                <tr>
                    <td class="form-label">Price</td>
                    <td><input class="form-input" type="text" name="price" required></td>
                </tr>
                <tr>
                    <td class="form-label">Description</td>
                    <td><input class="form-input" type="text" name="discription"></td>
                </tr>
                <tr>
                    <td colspan="2" class="form-actions">
                        <input class="btn btn-submit" type="submit" name="submit" value="add">
                        <input class="btn btn-reset" type="reset" value="reset">
                        <input type="hidden" name="service" value="addInsurance">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>