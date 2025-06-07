<%-- 
    Document   : InsertService
    Created on : Jun 1, 2025, 9:04:03 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
            .form-input {
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
            .form-input:focus {
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
            .tieu-de{
                text-align: center;
                
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
        <div class="form-container">
            <div class="form-title">${pageTitle}</div>
            <form action="ServiceServlet_JSP" method="POST" autocomplete="off">
                <table>
                     <h2 class="tieu-de">Thêm dịch vụ</h2>
                    <%-- Đã bỏ trường ID --%>
                    <tr>
                        <td class="form-label">Tên dịch vụ</td>
                        <td><input class="form-input" type="text" name="name" required autocomplete="off"></td>
                    </tr>
                  
                    <tr>
                        <td class="form-label">Mô tả</td>
                        <td><input class="form-input" type="text" name="description" autocomplete="off"></td>
                    </tr>
                    <tr>
                        <td class="form-label">Giá dịch vụ</td>
                        <td><input class="form-input" type="text" name="price" required autocomplete="off"></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="form-actions">
                            <input class="btn btn-submit" type="submit" name="submit" value="Thêm dịch vụ">
                            <input class="btn btn-reset" type="reset" value="Làm lại">
                            <input type="hidden" name="service" value="addService">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>