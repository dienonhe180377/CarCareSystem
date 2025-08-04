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
        <title>Danh sách Thợ Sửa Chữa</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                padding: 20px;
            }

            .container {
                max-width: 1000px;
                margin: 0 auto;
            }

            header {
                text-align: center;
                padding: 30px 0;
            }

            header h1 {
                color: #2c3e50;
                font-size: 2.8rem;
                margin-bottom: 10px;
                text-shadow: 1px 1px 3px rgba(0,0,0,0.1);
            }

            header p {
                color: #7f8c8d;
                font-size: 1.2rem;
                max-width: 600px;
                margin: 0 auto;
            }

            .filter-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin: 25px auto;
                width: 90%;
                gap: 20px;
            }

            .search-box {
                background: white;
                border-radius: 50px;
                padding: 12px 20px;
                display: flex;
                align-items: center;
                flex: 1;
                box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            }

            .search-box input {
                flex: 1;
                border: none;
                outline: none;
                font-size: 1rem;
                padding: 8px;
            }

            .filter-box {
                position: relative;
                width: 250px;
            }

            .filter-select {
                background: white;
                border: none;
                border-radius: 50px;
                padding: 12px 20px;
                font-size: 1rem;
                width: 100%;
                box-shadow: 0 4px 12px rgba(0,0,0,0.08);
                appearance: none;
                cursor: pointer;
                padding-right: 50px;
            }

            .filter-box::after {
                content: "\f078";
                font-family: "Font Awesome 5 Free";
                font-weight: 900;
                position: absolute;
                top: 50%;
                right: 20px;
                transform: translateY(-50%);
                color: #3498db;
                pointer-events: none;
            }

            .stats {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin: 20px 0 40px;
            }

            .stat-card {
                background: white;
                border-radius: 15px;
                padding: 20px;
                text-align: center;
                min-width: 150px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            }

            .stat-card h3 {
                color: #3498db;
                font-size: 2.2rem;
                margin-bottom: 5px;
            }

            .stat-card p {
                color: #7f8c8d;
                font-size: 0.9rem;
            }

            .repairer-list {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            }

            .list-header {
                display: grid;
                grid-template-columns: 3fr 1.5fr 1.5fr;
                background: #3498db;
                color: white;
                padding: 18px 30px;
                font-weight: 600;
                font-size: 1.1rem;
            }

            .repairer-item {
                display: grid;
                grid-template-columns: 3fr 1.5fr 1.5fr;
                padding: 20px 30px;
                border-bottom: 1px solid #eee;
                transition: all 0.3s ease;
            }

            .repairer-item:hover {
                background-color: #f9f9f9;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            }

            .repairer-info {
                display: flex;
                align-items: center;
            }

            .avatar {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                background: #3498db;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.5rem;
                font-weight: bold;
                margin-right: 20px;
            }

            .name {
                font-weight: 600;
                font-size: 1.2rem;
                color: #2c3e50;
            }

            .specialty {
                color: #7f8c8d;
                font-size: 0.9rem;
                margin-top: 5px;
            }

            .rating {
                display: flex;
                align-items: center;
                font-size: 1.1rem;
                color: #f39c12;
            }

            .rating-value {
                font-weight: 600;
                margin-left: 10px;
                color: #2c3e50;
            }

            .feedbacks-btn {
                background: #2ecc71;
                color: white;
                border: none;
                border-radius: 8px;
                padding: 10px 20px;
                cursor: pointer;
                font-weight: 600;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                transition: all 0.3s ease;
                width: 140px;
            }

            .feedbacks-btn:hover {
                background: #27ae60;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(46, 204, 113, 0.3);
            }

            .pagination {
                display: flex;
                justify-content: center;
                gap: 10px;
                padding: 30px 0;
            }

            .pagination button {
                background: white;
                border: 1px solid #ddd;
                border-radius: 8px;
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.2s ease;
            }

            .pagination button.active {
                background: #3498db;
                color: white;
                border-color: #3498db;
            }

            .pagination button:hover:not(.active) {
                background: #f5f5f5;
            }

            .pagination button:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }

            .items-per-page {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-top: 10px;
                color: #7f8c8d;
                font-size: 0.9rem;
            }

            .items-per-page select {
                padding: 5px 10px;
                border-radius: 5px;
                border: 1px solid #ddd;
                background: white;
            }

            @media (max-width: 768px) {
                .filter-bar {
                    flex-direction: column;
                }

                .search-box, .filter-box {
                    width: 100%;
                }

                .filter-box::after {
                    right: 15px;
                }

                .list-header, .repairer-item {
                    grid-template-columns: 1fr;
                    padding: 15px;
                }

                .repairer-info {
                    margin-bottom: 15px;
                }

                .rating, .actions {
                    margin: 10px 0;
                }

                .stats {
                    flex-direction: column;
                    align-items: center;
                }

                .stat-card {
                    width: 100%;
                    max-width: 300px;
                }

                .feedbacks-btn {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>

        <jsp:include page="header_emp.jsp"></jsp:include>
            <div class="container">


                <div class="filter-bar">
                    <div class="search-box">
                        <input type="text" id="search-input" placeholder="Tìm kiếm thợ sửa chữa...">
                        <button class="search-btn"><i class="fas fa-search"></i></button>
                    </div>

                    <div class="filter-box">
                        <select class="filter-select" id="filter-select">
                            <option value="default">Sắp xếp theo: Mặc định</option>
                            <option value="rating">Theo đánh giá (cao nhất)</option>
                        </select>
                    </div>
                </div>


                <div class="repairer-list">
                    <div class="list-header">
                        <div>Thợ sửa chữa</div>
                        <div>Đánh giá</div>
                        <div>Hành động</div>
                    </div>

                <c:forEach var="repairer" items="${repairerList}">
                    <div class="repairer-item" data-rating="4.7" data-feedback="320">
                        <div class="repairer-info">
                            <div class="avatar">NV</div>
                            <div>
                                <div class="name">${repairer.username}</div>
                            </div>
                        </div>
                        <div class="rating">
                            <div class="rating-value">${repairer.rating} </div>
                        </div>
                        <div class="actions">
                            <a href="">
                                <button class="feedbacks-btn">
                                    <i class="fas fa-comments"></i> Feedbacks
                                </button>
                            </a>
                        </div>
                    </div>
                </c:forEach>

            </div>

            <div class="pagination" id="pagination">
                <!-- Pagination sẽ được tạo bằng JavaScript -->
            </div>

            <div class="items-per-page">
                <span>Hiển thị:</span>
                <select id="items-per-page">
                    <option value="5">5 mục/trang</option>
                    <option value="10">10 mục/trang</option>
                    <option value="15">15 mục/trang</option>
                    <option value="20">20 mục/trang</option>
                </select>
            </div>
        </div>

        <script>
            // Biến toàn cục
            let currentPage = 1;
            let itemsPerPage = 5;
            let repairerItems = [];
            let filteredItems = [];

            // Khởi tạo khi trang được tải
            document.addEventListener('DOMContentLoaded', function () {
                // Lấy tất cả các item thợ sửa chữa
                repairerItems = Array.from(document.querySelectorAll('.repairer-item'));
                filteredItems = [...repairerItems];

                // Cập nhật thống kê
                document.getElementById('total-repairers').textContent = repairerItems.length;

                // Áp dụng phân trang
                setupPagination();

                // Thêm sự kiện cho dropdown số item trên trang
                document.getElementById('items-per-page').addEventListener('change', function (e) {
                    itemsPerPage = parseInt(e.target.value);
                    currentPage = 1; // Reset về trang đầu tiên
                    setupPagination();
                });

                // Thêm sự kiện cho ô tìm kiếm
                document.querySelector('.search-btn').addEventListener('click', function () {
                    const searchTerm = document.getElementById('search-input').value.toLowerCase();
                    filterItems(searchTerm);
                });

                // Thêm sự kiện khi nhấn Enter trong ô tìm kiếm
                document.getElementById('search-input').addEventListener('keyup', function (e) {
                    if (e.key === 'Enter') {
                        const searchTerm = this.value.toLowerCase();
                        filterItems(searchTerm);
                    }
                });

                // Thêm sự kiện cho dropdown sắp xếp
                document.getElementById('filter-select').addEventListener('change', function () {
                    sortRepairers(this.value);
                });

                // Thêm sự kiện cho nút feedbacks (sử dụng event delegation)
                document.querySelector('.repairer-list').addEventListener('click', function (e) {
                    if (e.target.closest('.feedbacks-btn')) {
                        const button = e.target.closest('.feedbacks-btn');
                        const repairerName = button.closest('.repairer-item').querySelector('.name').textContent;
                        alert(`Xem Feedbacks của thợ sửa chữa: ${repairerName}`);
                    }
                });
            });

            // Hàm thiết lập phân trang
            function setupPagination() {
                const totalPages = Math.ceil(filteredItems.length / itemsPerPage);
                const paginationContainer = document.getElementById('pagination');

                // Xóa phân trang cũ
                paginationContainer.innerHTML = '';

                // Tạo nút Previous
                const prevButton = document.createElement('button');
                prevButton.innerHTML = '<i class="fas fa-chevron-left"></i>';
                prevButton.classList.add('pagination-prev');
                prevButton.disabled = currentPage === 1;
                prevButton.addEventListener('click', function () {
                    if (currentPage > 1) {
                        currentPage--;
                        setupPagination();
                        showCurrentPage();
                    }
                });
                paginationContainer.appendChild(prevButton);

                // Tạo các nút trang
                const startPage = Math.max(1, currentPage - 2);
                const endPage = Math.min(totalPages, startPage + 4);

                for (let i = startPage; i <= endPage; i++) {
                    const pageButton = document.createElement('button');
                    pageButton.textContent = i;
                    pageButton.classList.add('page-number');
                    if (i === currentPage) {
                        pageButton.classList.add('active');
                    }
                    pageButton.addEventListener('click', function () {
                        currentPage = i;
                        setupPagination();
                        showCurrentPage();
                    });
                    paginationContainer.appendChild(pageButton);
                }

                // Tạo nút Next
                const nextButton = document.createElement('button');
                nextButton.innerHTML = '<i class="fas fa-chevron-right"></i>';
                nextButton.classList.add('pagination-next');
                nextButton.disabled = currentPage === totalPages;
                nextButton.addEventListener('click', function () {
                    if (currentPage < totalPages) {
                        currentPage++;
                        setupPagination();
                        showCurrentPage();
                    }
                });
                paginationContainer.appendChild(nextButton);

                // Hiển thị trang hiện tại
                showCurrentPage();
            }

            // Hàm hiển thị trang hiện tại
            function showCurrentPage() {
                // Ẩn tất cả các item
                repairerItems.forEach(item => {
                    item.style.display = 'none';
                });

                // Tính chỉ mục bắt đầu và kết thúc
                const startIndex = (currentPage - 1) * itemsPerPage;
                const endIndex = Math.min(startIndex + itemsPerPage, filteredItems.length);

                // Hiển thị các item trong trang hiện tại
                for (let i = startIndex; i < endIndex; i++) {
                    if (filteredItems[i]) {
                        filteredItems[i].style.display = 'grid';
                    }
                }
            }

            // Hàm sắp xếp danh sách thợ sửa chữa
            function sortRepairers(sortBy) {
                switch (sortBy) {
                    case 'rating':
                        filteredItems.sort((a, b) => {
                            return parseFloat(b.getAttribute('data-rating')) - parseFloat(a.getAttribute('data-rating'));
                        });
                        break;
                    case 'name':
                        filteredItems.sort((a, b) => {
                            const nameA = a.querySelector('.name').textContent.toLowerCase();
                            const nameB = b.querySelector('.name').textContent.toLowerCase();
                            return nameA.localeCompare(nameB);
                        });
                        break;
                    case 'feedback':
                        filteredItems.sort((a, b) => {
                            return parseInt(b.getAttribute('data-feedback')) - parseInt(a.getAttribute('data-feedback'));
                        });
                        break;
                    default:
                        // Trả về thứ tự ban đầu
                        filteredItems = [...repairerItems];
                }

                currentPage = 1;
                setupPagination();
            }

            // Hàm lọc item theo từ khóa tìm kiếm
            function filterItems(searchTerm) {
                if (!searchTerm) {
                    filteredItems = [...repairerItems];
                } else {
                    filteredItems = repairerItems.filter(item => {
                        const name = item.querySelector('.name').textContent.toLowerCase();
                        const specialty = item.querySelector('.specialty').textContent.toLowerCase();
                        return name.includes(searchTerm) || specialty.includes(searchTerm);
                    });
                }

                currentPage = 1;
                setupPagination();
            }
        </script>
    </body>
</html>