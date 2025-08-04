<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Feedback Nhân viên</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            color: #333;
            line-height: 1.6;
            padding: 20px;
            min-height: 100vh;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        header {
            text-align: center;
            padding: 30px 0;
            margin-bottom: 30px;
        }
        
        h1 {
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 10px;
            position: relative;
            display: inline-block;
        }
        
        h1::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 70px;
            height: 4px;
            background: #3498db;
            border-radius: 2px;
        }
        
        .subtitle {
            color: #7f8c8d;
            font-size: 1.1rem;
            max-width: 600px;
            margin: 0 auto;
        }
        
        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }
        
        .search-box {
            display: flex;
            align-items: center;
            flex: 1;
            max-width: 400px;
        }
        
        .search-box input {
            width: 100%;
            padding: 10px 15px;
            border: 2px solid #e0e6ed;
            border-radius: 30px 0 0 30px;
            font-size: 1rem;
            outline: none;
            transition: border-color 0.3s;
        }
        
        .search-box input:focus {
            border-color: #3498db;
        }
        
        .search-box button {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 0 30px 30px 0;
            cursor: pointer;
            font-size: 1rem;
            transition: background 0.3s;
        }
        
        .search-box button:hover {
            background: #2980b9;
        }
        
        .filter {
            display: flex;
            gap: 15px;
        }
        
        .filter select {
            padding: 10px 15px;
            border: 2px solid #e0e6ed;
            border-radius: 30px;
            font-size: 1rem;
            outline: none;
            background: white;
            cursor: pointer;
        }
        
        .feedback-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }
        
        .feedback-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .feedback-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }
        
        .feedback-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            border-bottom: 1px solid #eee;
        }
        
        .date {
            font-size: 0.9rem;
            color: #7f8c8d;
            font-weight: 500;
        }
        
        .rating {
            display: flex;
        }
        
        .rating .star {
            color: #ddd;
            font-size: 1.2rem;
        }
        
        .rating .star.filled {
            color: #f39c12;
        }
        
        .feedback-content {
            padding: 20px;
        }
        
        .comment {
            color: #34495e;
            font-size: 1.05rem;
            line-height: 1.7;
        }
        
        .employee-info {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            background: #f8f9fa;
            border-top: 1px solid #eee;
        }
        
        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #3498db;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.1rem;
            margin-right: 12px;
        }
        
        .employee-name {
            font-weight: 600;
            color: #2c3e50;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 40px;
            gap: 8px;
        }
        
        .pagination a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border: none;
            border-radius: 8px;
            background: white;
            color: #3498db;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.08);
            text-decoration: none;
        }
        
        .pagination a:hover {
            background: #3498db;
            color: white;
        }
        
        .pagination a.active {
            background: #3498db;
            color: white;
        }
        
        .stats {
            display: flex;
            justify-content: space-around;
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-value {
            font-size: 2.2rem;
            font-weight: 700;
            color: #3498db;
        }
        
        .stat-label {
            color: #7f8c8d;
            font-size: 0.95rem;
        }
        
        .pagination-info {
            text-align: center;
            margin-top: 20px;
            color: #7f8c8d;
            font-size: 1.1rem;
        }
        
        @media (max-width: 768px) {
            .controls {
                flex-direction: column;
                gap: 15px;
            }
            
            .search-box {
                max-width: 100%;
            }
            
            .filter {
                width: 100%;
                justify-content: center;
            }
            
            .feedback-list {
                grid-template-columns: 1fr;
            }
            
            .stats {
                flex-direction: column;
                gap: 20px;
            }
        }
        
        /* Pagination pages */
        #page1 { display: grid; }
        #page2 { display: none; }
        #page3 { display: none; }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Danh sách Feedback Nhân viên</h1>
            <p class="subtitle">Xem và quản lý tất cả các phản hồi từ nhân viên của bạn tại một nơi</p>
        </header>
        
        <div class="stats">
            <div class="stat-item">
                <div class="stat-value">27</div>
                <div class="stat-label">Tổng số Feedback</div>
            </div>
            <div class="stat-item">
                <div class="stat-value">4.3</div>
                <div class="stat-label">Điểm đánh giá trung bình</div>
            </div>
        </div>
        
        <div class="controls">
            <div class="search-box">
                <input type="text" placeholder="Tìm kiếm feedback...">
                <button><i class="fas fa-search"></i></button>
            </div>
            <div class="filter">
                <select>
                    <option value="all">Tất cả đánh giá</option>
                    <option value="5">5 sao</option>
                    <option value="4">4 sao</option>
                    <option value="3">3 sao</option>
                    <option value="2">2 sao</option>
                    <option value="1">1 sao</option>
                </select>
                <select>
                    <option value="newest">Mới nhất</option>
                    <option value="oldest">Cũ nhất</option>
                </select>
            </div>
        </div>
        
        <!-- Page 1 -->
        <div class="feedback-list" id="page1">
            <!-- Feedback item 1 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">15/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Môi trường làm việc rất tốt, đồng nghiệp thân thiện và hỗ trợ nhiệt tình. Tuy nhiên, thiết bị làm việc cần được nâng cấp để hiệu quả hơn.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">NL</div>
                    <div class="employee-name">Nguyễn Văn Long</div>
                </div>
            </div>
            
            <!-- Feedback item 2 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">14/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Công ty có chính sách đãi ngộ nhân viên rất tốt, lương thưởng hợp lý. Quản lý luôn lắng nghe và hỗ trợ nhân viên khi cần thiết.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">TH</div>
                    <div class="employee-name">Trần Thị Hương</div>
                </div>
            </div>
            
            <!-- Feedback item 3 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">13/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Công việc ổn định nhưng cơ hội thăng tiến chưa rõ ràng. Mong công ty có lộ trình phát triển rõ ràng hơn cho nhân viên.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">PM</div>
                    <div class="employee-name">Phạm Văn Minh</div>
                </div>
            </div>
            
            <!-- Feedback item 4 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">12/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Áp lực công việc khá cao, thường xuyên phải làm thêm giờ nhưng không được tính lương. Mong công ty xem xét lại chính sách làm thêm giờ.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">LQ</div>
                    <div class="employee-name">Lê Thị Quỳnh</div>
                </div>
            </div>
            
            <!-- Feedback item 5 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">11/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Đào tạo nội bộ rất tốt, giúp nâng cao kỹ năng chuyên môn. Không gian làm việc thoải mái, có khu vực nghỉ ngơi riêng.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">VT</div>
                    <div class="employee-name">Vũ Đức Thành</div>
                </div>
            </div>
            
            <!-- Feedback item 6 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">10/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Làm việc tại công ty là một trải nghiệm tuyệt vời. Tôi học hỏi được nhiều điều mới mỗi ngày. Cảm ơn ban lãnh đạo đã tạo môi trường làm việc chuyên nghiệp!</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">NT</div>
                    <div class="employee-name">Ngô Thị Tuyết</div>
                </div>
            </div>
            
            <!-- Feedback item 7 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">09/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Chế độ phúc lợi tốt, đặc biệt là bảo hiểm sức khỏe. Tuy nhiên, cần cải thiện thêm về hệ thống phần mềm quản lý công việc.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">HS</div>
                    <div class="employee-name">Hoàng Văn Sơn</div>
                </div>
            </div>
            
            <!-- Feedback item 8 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">08/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Môi trường làm việc năng động, sáng tạo. Đồng nghiệp thân thiện, hỗ trợ lẫn nhau. Đây thực sự là nơi lý tưởng để phát triển sự nghiệp.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">DM</div>
                    <div class="employee-name">Đặng Thị Mai</div>
                </div>
            </div>
            
            <!-- Feedback item 9 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">07/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Công việc tương đối ổn nhưng phòng làm việc hơi chật. Mong công ty cải thiện không gian làm việc trong thời gian tới.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">NQ</div>
                    <div class="employee-name">Nguyễn Đình Quân</div>
                </div>
            </div>
        </div>
        
        <!-- Page 2 -->
        <div class="feedback-list" id="page2">
            <!-- Feedback item 10 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">06/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Lương thưởng cạnh tranh, đúng hạn. Quản lý luôn tạo điều kiện để nhân viên học hỏi và phát triển kỹ năng mới.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">PL</div>
                    <div class="employee-name">Phan Thị Lan</div>
                </div>
            </div>
            
            <!-- Feedback item 11 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">05/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Quy trình làm việc còn rườm rà, cần đơn giản hóa để tiết kiệm thời gian. Đề xuất cải tiến quy trình nội bộ.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">LT</div>
                    <div class="employee-name">Lý Văn Tú</div>
                </div>
            </div>
            
            <!-- Feedback item 12 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">04/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Tôi rất hài lòng với công việc hiện tại. Công ty có nhiều hoạt động team building thú vị giúp gắn kết mọi người.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">TH</div>
                    <div class="employee-name">Trương Thị Hoa</div>
                </div>
            </div>
            
            <!-- Feedback item 13 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">03/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Chính sách nghỉ phép linh hoạt, phù hợp với nhu cầu cá nhân. Tuy nhiên, cần cải thiện hệ thống máy tính để đáp ứng nhu cầu công việc.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">VK</div>
                    <div class="employee-name">Võ Minh Khôi</div>
                </div>
            </div>
            
            <!-- Feedback item 14 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">02/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Công việc đúng chuyên môn nhưng đôi khi cảm thấy nhàm chán. Mong công ty tạo thêm cơ hội học hỏi và thử thách mới.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">NM</div>
                    <div class="employee-name">Nguyễn Thị Mỹ</div>
                </div>
            </div>
            
            <!-- Feedback item 15 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">01/08/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Công ty thiếu minh bạch trong đánh giá hiệu suất làm việc. Mong ban lãnh đạo cải thiện quy trình đánh giá nhân viên.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">PT</div>
                    <div class="employee-name">Phạm Thanh Tùng</div>
                </div>
            </div>
            
            <!-- Feedback item 16 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">31/07/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Cơ sở vật chất tốt, phòng họp hiện đại. Tuy nhiên, khu vực để xe cho nhân viên còn hạn chế, mong công ty mở rộng thêm.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">LH</div>
                    <div class="employee-name">Lê Văn Hải</div>
                </div>
            </div>
            
            <!-- Feedback item 17 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">30/07/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Tôi rất tự hào khi được làm việc tại công ty. Văn hóa doanh nghiệp tích cực, đồng nghiệp chuyên nghiệp và nhiệt tình giúp đỡ.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">NT</div>
                    <div class="employee-name">Nguyễn Thành Trung</div>
                </div>
            </div>
            
            <!-- Feedback item 18 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">29/07/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Công ty nên tổ chức thêm các khóa đào tạo kỹ năng mềm cho nhân viên. Điều này sẽ giúp nâng cao hiệu quả làm việc nhóm.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">HT</div>
                    <div class="employee-name">Hoàng Thị Thu</div>
                </div>
            </div>
        </div>
        
        <!-- Page 3 -->
        <div class="feedback-list" id="page3">
            <!-- Feedback item 19 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">28/07/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Mức lương cạnh tranh với thị trường. Tuy nhiên, mong công ty có chính sách tăng lương định kỳ rõ ràng hơn cho nhân viên.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">QT</div>
                    <div class="employee-name">Quách Văn Tuấn</div>
                </div>
            </div>
            
            <!-- Feedback item 20 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">27/07/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Ban lãnh đạo luôn lắng nghe ý kiến nhân viên và có hành động cải thiện kịp thời. Điều này khiến tôi cảm thấy được tôn trọng và đánh giá cao.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">NH</div>
                    <div class="employee-name">Nguyễn Thị Hằng</div>
                </div>
            </div>
            
            <!-- Feedback item 21 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">26/07/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Chế độ phúc lợi chưa thực sự hấp dẫn so với các công ty cùng ngành. Mong công ty cải thiện thêm các chế độ như du lịch hàng năm, khám sức khỏe định kỳ.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">PT</div>
                    <div class="employee-name">Phùng Văn Thắng</div>
                </div>
            </div>
            
            <!-- Feedback item 22 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">25/07/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Công ty có nhiều cơ hội thăng tiến cho nhân viên nếu bạn thực sự nỗ lực. Tôi đã được thăng chức sau 2 năm làm việc tại đây.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">LV</div>
                    <div class="employee-name">Lưu Thị Vân</div>
                </div>
            </div>
            
            <!-- Feedback item 23 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">24/07/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Môi trường làm việc khá tốt nhưng đôi khi giao tiếp giữa các phòng ban chưa hiệu quả, gây chậm trễ công việc.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">TT</div>
                    <div class="employee-name">Trần Văn Tài</div>
                </div>
            </div>
            
            <!-- Feedback item 24 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">23/07/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Công ty đầu tư rất tốt cho việc đào tạo nhân viên. Tôi đã được tham gia nhiều khóa học chuyên môn bổ ích mà không mất phí.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">NK</div>
                    <div class="employee-name">Nguyễn Khánh Linh</div>
                </div>
            </div>
            
            <!-- Feedback item 25 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">22/07/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Áp lực công việc đôi lúc quá lớn, nhất là vào mùa cao điểm. Mong công ty cân nhắc bổ sung nhân sự cho các phòng ban hoạt động căng thẳng.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">HH</div>
                    <div class="employee-name">Hồ Minh Hải</div>
                </div>
            </div>
            
            <!-- Feedback item 26 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">21/07/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Công ty có khu vực giải trí, cà phê rất tốt giúp nhân viên thư giãn giữa giờ. Điều này góp phần tăng năng suất làm việc đáng kể.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">DV</div>
                    <div class="employee-name">Đỗ Văn Dũng</div>
                </div>
            </div>
            
            <!-- Feedback item 27 -->
            <div class="feedback-card">
                <div class="feedback-header">
                    <div class="date">20/07/2023</div>
                    <div class="rating">
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star filled"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                        <span class="star"><i class="fas fa-star"></i></span>
                    </div>
                </div>
                <div class="feedback-content">
                    <p class="comment">Mong công ty tổ chức thêm các buổi gặp gỡ, giao lưu giữa lãnh đạo và nhân viên để tăng sự kết nối và thấu hiểu lẫn nhau.</p>
                </div>
                <div class="employee-info">
                    <div class="avatar">NT</div>
                    <div class="employee-name">Nguyễn Thị Ngọc</div>
                </div>
            </div>
        </div>
        
       
    </div>

    
</body>
</html>