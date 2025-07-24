<%-- 
    Document   : settingDetail
    Created on : Jun 27, 2025, 2:26:17 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Setting</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>
        <style>
            body {
                background-color: #f0f8ff;
                padding: 20px;
            }
            
            .form-container {
                max-width: 600px;
                margin: auto;
                background-color: #ffffff;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                margin-top: 50px;
            }
            
            .form-title {
                font-size: 24px;
                color: #2b6cb0;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="container">
            <div class="form-container">
                <div class="form-title">Edit Setting: ${setting.name}</div>

                <form method="post" action="updateSetting">
                    <input type="hidden" name="id" value="${setting.id}"/>

                    <div class="mb-3">
                        <label for="value" class="form-label">Value:</label>
                        <input type="text" id="value" name="value" class="form-control" value="${setting.value}" required>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="settingList" class="btn btn-secondary">Back</a>
                        <button type="submit" class="btn btn-success">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>