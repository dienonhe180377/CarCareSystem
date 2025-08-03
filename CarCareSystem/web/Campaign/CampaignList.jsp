<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách Campaign</title>
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
                max-width: 1200px;
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
                padding: 30px;
                text-align: center;
                color: white;
                text-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .header h1 {
                font-size: 2.5rem;
                font-weight: 600;
                margin-bottom: 10px;
            }

            .campaigns-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                gap: 30px;
                padding: 30px;
            }

            .campaign-card {
                background: white;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(173, 216, 230, 0.15);
                overflow: hidden;
                transition: all 0.3s ease;
                border: 2px solid transparent;
                position: relative;
            }

            .campaign-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 40px rgba(173, 216, 230, 0.25);
                border-color: var(--accent-blue);
            }

            /* 🔥 THUMBNAIL STYLE - THEO ĐÚNG LOGIC CAMPAIGN.JSP */
            .campaign-thumbnail {
                width: 100%;
                height: 200px;
                overflow: hidden;
                position: relative;
                background: var(--light-blue);
            }

            .campaign-thumbnail img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s ease;
            }

            .campaign-card:hover .campaign-thumbnail img {
                transform: scale(1.05);
            }

            .campaign-content {
                padding: 25px;
            }

            .campaign-title {
                font-size: 1.4rem;
                font-weight: 600;
                color: var(--dark-blue);
                margin-bottom: 10px;
                line-height: 1.3;
            }

            .campaign-description {
                color: #666;
                margin-bottom: 20px;
                line-height: 1.6;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .campaign-meta {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                font-size: 0.9rem;
                color: #888;
            }

            .campaign-dates {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            .status-badge {
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                text-transform: uppercase;
            }

            .status-active {
                background: #d4edda;
                color: #155724;
            }

            .status-inactive {
                background: #f8d7da;
                color: #721c24;
            }

            .view-detail-btn {
                width: 100%;
                padding: 12px;
                background: linear-gradient(135deg, var(--primary-blue) 0%, var(--secondary-blue) 100%);
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
                text-align: center;
            }

            .view-detail-btn:hover {
                background: linear-gradient(135deg, var(--secondary-blue) 0%, var(--dark-blue) 100%);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(173, 216, 230, 0.4);
            }

            .empty-state {
                text-align: center;
                padding: 60px 30px;
                color: #888;
            }

            .empty-state i {
                font-size: 4rem;
                color: var(--accent-blue);
                margin-bottom: 20px;
            }

            .back-btn {
                position: fixed;
                top: 30px;
                left: 30px;
                background: white;
                color: var(--dark-blue);
                padding: 12px 20px;
                border-radius: 25px;
                text-decoration: none;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                font-weight: 600;
                z-index: 1000;
            }

            .back-btn:hover {
                background: var(--accent-blue);
                color: white;
                transform: translateY(-2px);
            }
        </style>
    </head>
    <body>
<jsp:include page="/header.jsp"></jsp:include>
        <div class="container">
            <div class="header">
                <h1><i class="fas fa-bullhorn"></i> Danh sách Campaign</h1>
                <p>Khám phá các chiến dịch khuyến mãi hấp dẫn</p>
            </div>

            <div class="campaigns-grid">
                <c:forEach var="campaign" items="${campaigns}">
                    <div class="campaign-card">
                        <!-- 🔥 THUMBNAIL - THEO LOGIC CAMPAIGN.JSP -->
                        <div class="campaign-thumbnail">
                            <c:choose>
                                <c:when test="${not empty campaign.thumbnail}">
                                    <img src="${pageContext.request.contextPath}/${campaign.thumbnail}" 
                                         alt="${campaign.name}"
                                         onerror="this.src='${pageContext.request.contextPath}/image/campaign-default.png'">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/image/campaign-default.png" 
                                         alt="Campaign Default">
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="campaign-content">
                            <h3 class="campaign-title">${campaign.name}</h3>
                            <p class="campaign-description">
                                <c:choose>
                                    <c:when test="${empty campaign.description}">
                                        <em>Chưa có mô tả</em>
                                    </c:when>
                                    <c:otherwise>
                                        ${campaign.description}
                                    </c:otherwise>
                                </c:choose>
                            </p>

                            <div class="campaign-meta">
                                <div class="campaign-dates">
                                    <div><i class="fas fa-calendar-alt"></i> 
                                        <fmt:formatDate value="${campaign.startDate}" pattern="dd/MM/yyyy"/>
                                    </div>
                                    <div><i class="fas fa-calendar-times"></i> 
                                        <fmt:formatDate value="${campaign.endDate}" pattern="dd/MM/yyyy"/>
                                    </div>
                                    <div>
                                        <jsp:useBean id="now" class="java.util.Date" />
                                        <c:set var="currentTime" value="${now.time}" />
                                        <c:set var="endTime" value="${campaign.endDate.time}" />
                                        <c:set var="timeDiff" value="${endTime - currentTime}" />
                                        <c:set var="daysLeft" value="${timeDiff / (1000 * 60 * 60 * 24)}" />

                                        <br>
                                        <strong style="color: #28a745;">
                                            <i class="fas fa-clock"></i> Còn lại: 
                                            <c:choose>
                                                <c:when test="${daysLeft >= 1}">
                                                    <fmt:formatNumber value="${daysLeft}" maxFractionDigits="0"/> ngày
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="hoursLeft" value="${timeDiff / (1000 * 60 * 60)}" />
                                                    <fmt:formatNumber value="${hoursLeft}" maxFractionDigits="0"/> giờ
                                                </c:otherwise>
                                            </c:choose>
                                        </strong>
                                    </div>
                                </div>
                            </div>

                            <a href="${pageContext.request.contextPath}/campaignlist?id=${campaign.id}" 
                               class="view-detail-btn">
                                <i class="fas fa-eye"></i> Xem chi tiết
                            </a>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty campaigns}">
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <h3>Chưa có campaign nào</h3>
                        <p>Hiện tại chưa có chiến dịch nào được tạo.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </body>
</html>
