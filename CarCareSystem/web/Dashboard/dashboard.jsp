<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        <!--    <link rel="stylesheet" href="">-->
        <style>
            .dashboard-container {
                max-width: 900px;
                margin: 30px auto;
            }
            .dashboard-title {
                font-size: 2rem;
                margin-bottom: 24px;
                text-align: center;
            }
            .dashboard-stats {
                display: flex;
                flex-wrap: wrap;
                gap: 24px;
                justify-content: center;
            }
            .dashboard-card {
                background: #f7fafd;
                border-radius: 8px;
                box-shadow: 0 2px 8px #e0eafc;
                padding: 24px 32px;
                min-width: 220px;
                text-align: center;
            }
            .dashboard-card .stat-label {
                font-size: 1.1rem;
                color: #555;
                margin-bottom: 8px;
            }
            .dashboard-card .stat-value {
                font-size: 2rem;
                font-weight: bold;
                color: #3895d3;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/header_emp.jsp" />
        <div class="dashboard-container">
            <h2 style="text-align:center; margin-top:40px;">Biểu đồ doanh thu</h2>
            <canvas id="revenueChart" width="800" height="400" style="display:block; margin: 0 auto;"></canvas>

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
                        <fmt:formatNumber value="${totalOrderRevenue}" type="number" pattern="#,##0"/> VND

                    </div>
                </div>
                <div class="dashboard-card">
                    <div class="stat-label">Tổng bảo hiểm đã bán</div>
                    <div class="stat-value">${totalInsurance}</div>
                </div>
                <div class="dashboard-card">
                    <div class="stat-label">Doanh thu bảo hiểm</div>
                    <div class="stat-value">
                        <fmt:formatNumber value="${totalInsuranceRevenue}" type="number" pattern="#,##0"/> VND
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>


        <script>
                    // Dữ liệu từ server
                    const labels = ['Đơn hàng', 'Bảo hiểm'];
                    const data = {
                        labels: labels,
                        datasets: [{
                                label: 'Doanh thu (VNĐ)',
                                data: [${totalOrderRevenue}, ${totalInsuranceRevenue}],
                                backgroundColor: ['rgba(54, 162, 235, 0.6)', 'rgba(255, 206, 86, 0.6)'],
                                borderColor: ['rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'],
                                borderWidth: 1
                            }]
                    };
                    console.log("Order:", ${totalOrderRevenue});
                    console.log("Insurance:", ${totalInsuranceRevenue});
                    // Cấu hình biểu đồ
                    const config = {
                        type: 'bar',
                        data: data,
                        options: {
                            responsive: true,
                            layout: {
                                padding: {
                                    top: 40  //  khoảng trống phía trên để tránh chữ bị dính vào tiêu đề
                                }
                            },
                            plugins: {
                                legend: {display: false},
                                tooltip: {
                                    callbacks: {
                                        label: function (context) {
                                            let value = context.raw;
                                            return value.toLocaleString('vi-VN') + ' VND';
                                        }
                                    }
                                },
                                datalabels: {
                                    anchor: 'end', // vị trí gắn: "end" = đỉnh cột
                                    align: 'end', // căn vị trí: "end" = trên cột
                                    formatter: function (value) {
                                        return value.toLocaleString('vi-VN') + ' VND';
                                    },
                                    color: '#333',
                                    font: {
                                        weight: 'bold',
                                        size: 12
                                    },
                                    offset: -4 // kéo lên phía trên một chút để không chạm vào cột
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    ticks: {
                                        callback: function (value) {
                                            return value.toLocaleString('vi-VN') + ' ₫';
                                        }
                                    }
                                }
                            }
                        },
                        plugins: [ChartDataLabels]
                    };


                    // Render biểu đồ
                    const myChart = new Chart(document.getElementById('revenueChart'), config);
        </script>



    </body>
</html>