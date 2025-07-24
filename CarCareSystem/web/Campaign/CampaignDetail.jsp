<%-- 
    Document   : CampaignDetail
    Created on : Jul 24, 2025, 12:59:25 PM
    Author     : NTN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Campaign</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-blue: #add8e6;
            --secondary-blue: #87ceeb;
            --light-blue: #e6f3ff;
            --dark-blue: #4682b4;
            --accent-blue: #b0e0e6;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f0f8ff 0%, #e6f3ff 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(173, 216, 230, 0.2);
            overflow: hidden;
            backdrop-filter: blur(10px);
            border: 2px solid var(--accent-blue);
        }

        .header {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
            color: #333;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
            font-weight: bold;
        }

        .breadcrumb {
            background: var(--light-blue);
            padding: 15px 30px;
            border-bottom: 1px solid var(--accent-blue);
        }

        .breadcrumb a {
            color: var(--dark-blue);
            text-decoration: none;
            font-weight: 500;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .breadcrumb .separator {
            margin: 0 10px;
            color: var(--dark-blue);
        }

        .content {
            padding: 30px;
        }

        .campaign-info {
            background: linear-gradient(135deg, #FFFFFF 0%, var(--light-blue) 100%);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 8px 25px rgba(173, 216, 230, 0.2);
            border: 2px solid var(--accent-blue);
        }

        .campaign-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .campaign-title {
            color: var(--dark-blue);
            font-size: 2rem;
            font-weight: bold;
            margin: 0;
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-active {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }

        .status-inactive {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .info-item {
            background: rgba(255, 255, 255, 0.7);
            padding: 20px;
            border-radius: 10px;
            border: 1px solid var(--accent-blue);
        }

        .info-label {
            font-weight: 600;
            color: var(--dark-blue);
            margin-bottom: 8px;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 1.1rem;
            color: #333;
            font-weight: 500;
        }

        .description-section {
            background: rgba(255, 255, 255, 0.7);
            padding: 20px;
            border-radius: 10px;
            border: 1px solid var(--accent-blue);
        }

        .description-title {
            font-weight: 600;
            color: var(--dark-blue);
            margin-bottom: 15px;
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .description-content {
            line-height: 1.6;
            color: #555;
            font-size: 1rem;
        }

        .actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            box-shadow: 0 4px 15px rgba(173, 216, 230, 0.3);
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: #333;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, var(--secondary-blue), var(--dark-blue));
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(173, 216, 230, 0.4);
            color: white;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #c82333, #a71e2a);
            transform: translateY(-2px);
        }

        .not-found {
            text-align: center;
            padding: 60px 20px;
            color: var(--dark-blue);
        }

        .not-found i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: var(--secondary-blue);
        }

        .not-found h2 {
            font-size: 1.8rem;
            margin-bottom: 15px;
        }

        .not-found p {
            font-size: 1.1rem;
            margin-bottom: 30px;
            color: #666;
        }

        .fa-calendar, .fa-info-circle, .fa-edit, .fa-trash, .fa-arrow-left, .fa-exclamation-triangle {
            margin-right: 8px;
        }

        @media (max-width: 768px) {
            .campaign-header {
                flex-direction: column;
                text-align: center;
            }

            .campaign-title {
                font-size: 1.5rem;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .actions {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 300px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-info-circle"></i> Chi tiết Campaign</h1>
        </div>

        <div class="breadcrumb">
            <a href="campaignlist"><i class="fas fa-list"></i> Danh sách Campaign</a>
            <span class="separator">></span>
            <span>Chi tiết Campaign</span>
        </div>

        <div class="content">
            <c:choose>
                <c:when test="${empty campaign}">
                    <div class="not-found">
                        <i class="fas fa-exclamation-triangle"></i>
                        <h2>Không tìm thấy Campaign</h2>
                        <p>Campaign bạn đang tìm kiếm không tồn tại hoặc đã bị xóa.</p>
                        <a href="campaignlist" class="btn btn-primary">
                            <i class="fas fa-arrow-left"></i> Quay lại danh sách
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="campaign-info">
                        <div class="campaign-header">
                            <h2 class="campaign-title">${campaign.name}</h2>
<!--                            <span class="status-badge {campaign.status ? 'status-active' : 'status-inactive'}">
                                <i class="fas {campaign.status ? 'fa-check' : 'fa-times'}"></i>
                                {campaign.status ? 'Đang hoạt động' : 'Tạm dừng'}
                            </span>-->
                        </div>

                        <div class="info-grid">
<!--                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-hashtag"></i> ID Campaign
                                </div>
                                <div class="info-value">#campaign.id</div>
                            </div>-->

                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-calendar-alt"></i> Ngày bắt đầu
                                </div>
                                <div class="info-value">
                                    <fmt:formatDate value="${campaign.startDate}" pattern="dd/MM/yyyy"/>
                                </div>
                            </div>

                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-calendar-times"></i> Ngày kết thúc
                                </div>
                                <div class="info-value">
                                    <fmt:formatDate value="${campaign.endDate}" pattern="dd/MM/yyyy"/>
                                </div>
                            </div>

                            <div class="info-item">
                                <div class="info-label">
                                    <i class="fas fa-clock"></i> Thời gian còn lại
                                </div>
                                <div class="info-value">
                                    <c:set var="currentDate" value="<%= new java.util.Date() %>" />
                                    <c:choose>
                                        <c:when test="${campaign.endDate.time > currentDate.time}">
                                            <c:set var="daysLeft" value="${(campaign.endDate.time - currentDate.time) / (1000 * 60 * 60 * 24)}" />
                                            <fmt:formatNumber value="${daysLeft}" pattern="#" var="daysLeftFormatted" />
                                            ${daysLeftFormatted} ngày
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #dc3545;">Đã kết thúc</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <c:if test="${not empty campaign.description}">
                            <div class="description-section">
                                <div class="description-title">
                                    <i class="fas fa-align-left"></i> Mô tả Campaign
                                </div>
                                <div class="description-content">
                                    ${campaign.description}
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <div class="actions">
<!--                        <a href="campaign?editId={campaign.id}" class="btn btn-primary">
                            <i class="fas fa-edit"></i> Chỉnh sửa
                        </a>
                        
                        <form method="post" action="campaign" style="display:inline">
                            <input type="hidden" name="id" value="{campaign.id}"/>
                            <input type="hidden" name="service" value="delete"/>
                            <button type="submit" class="btn btn-danger" 
                                    onclick="return confirm('Bạn có chắc chắn muốn xóa campaign {campaign.name}?')">
                                <i class="fas fa-trash"></i> Xóa Campaign
                            </button>
                        </form>-->
                        
                        <a href="campaignlist" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        // Auto calculate days left with more precision
        document.addEventListener('DOMContentLoaded', function() {
            const timeElements = document.querySelectorAll('.info-value');
            // Additional JavaScript functionality can be added here
        });
    </script>
</body>
</html>
