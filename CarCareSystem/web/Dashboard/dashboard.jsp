<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Dashboard</title>
    <link rel="stylesheet" href="../Insurance/Insurance.css">
    <style>
        .dashboard-container { max-width: 900px; margin: 30px auto; }
        .dashboard-title { font-size: 2rem; margin-bottom: 24px; text-align: center; }
        .dashboard-stats { display: flex; flex-wrap: wrap; gap: 24px; justify-content: center; }
        .dashboard-card {
            background: #f7fafd;
            border-radius: 8px;
            box-shadow: 0 2px 8px #e0eafc;
            padding: 24px 32px;
            min-width: 220px;
            text-align: center;
        }
        .dashboard-card .stat-label { font-size: 1.1rem; color: #555; margin-bottom: 8px; }
        .dashboard-card .stat-value { font-size: 2rem; font-weight: bold; color: #3895d3; }
    </style>
</head>
<body>
    <jsp:include page="/header_emp.jsp" />
    <div class="dashboard-container">
        <form method="get" action="dashboard" style="text-align: center; margin-bottom: 20px;">
    <label for="range">Chọn khoảng thời gian:</label>
    <select name="range" id="range" onchange="this.form.submit()">
        <option value="1" ${param.range == '1' ? 'selected' : ''}>1 ngày qua</option>
        <option value="7" ${param.range == '7' ? 'selected' : ''}>7 ngày qua</option>
        <option value="30" ${param.range == '30' ? 'selected' : ''}>30 ngày qua</option>
        <option value="all" ${param.range == 'all' || param.range == null ? 'selected' : ''}>Toàn bộ</option>
    </select>
</form>

        <div class="dashboard-title">Tổng quan hệ thống</div>
        <div class="dashboard-stats">
            <div class="dashboard-card">
                <div class="stat-label">Tổng khách hàng</div>
                <div class="stat-value">${totalCustomers}</div>
            </div>
            <div class="dashboard-card">
                <div class="stat-label">Tổng đơn hàng</div>
                <div class="stat-value">${totalOrders}</div>
            </div>
            <div class="dashboard-card">
                <div class="stat-label">Doanh thu đơn hàng</div>
                <div class="stat-value">
                    <fmt:formatNumber value="${totalOrderRevenue}" type="currency" currencySymbol="₫"/>
                </div>
            </div>
            <div class="dashboard-card">
                <div class="stat-label">Tổng bảo hiểm đã bán</div>
                <div class="stat-value">${totalInsurance}</div>
            </div>
            <div class="dashboard-card">
                <div class="stat-label">Doanh thu bảo hiểm</div>
                <div class="stat-value">
                    <fmt:formatNumber value="${totalInsuranceRevenue}" type="currency" currencySymbol="₫"/>
                </div>
            </div>
        </div>
    </div>
</body>
</html>