<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đơn hàng chưa đánh giá</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --success-color: #4cc9f0;
                --light-color: #f8f9fa;
                --dark-color: #212529;
                --gray-color: #6c757d;
                --border-color: #dee2e6;
                --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            }

            body {
                background-color: #f5f7fb;
                color: var(--dark-color);
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
            }

            /* Header */
            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 1px solid var(--border-color);
            }

            .logo {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .logo i {
                font-size: 28px;
                color: var(--primary-color);
            }

            .logo h1 {
                font-size: 24px;
                font-weight: 700;
                color: var(--primary-color);
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .user-info .avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: var(--success-color);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: bold;
            }

            .user-info .name {
                font-weight: 600;
            }

            /* Filter Section */
            .filters {
                background: white;
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 30px;
                box-shadow: var(--card-shadow);
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
            }

            .filter-group {
                flex: 1;
                min-width: 200px;
            }

            .filter-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: var(--gray-color);
            }

            .filter-group select,
            .filter-group input {
                width: 100%;
                padding: 10px 15px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-size: 15px;
                background: white;
            }

            .filter-group input {
                background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%236c757d"><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/></svg>');
                background-repeat: no-repeat;
                background-position: right 15px center;
                background-size: 18px;
            }

            /* Stats */
            .stats {
                display: flex;
                gap: 20px;
                margin-bottom: 30px;
                flex-wrap: wrap;
            }

            .stat-card {
                flex: 1;
                min-width: 200px;
                background: white;
                border-radius: 12px;
                padding: 20px;
                box-shadow: var(--card-shadow);
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .stat-icon {
                width: 50px;
                height: 50px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
            }

            .stat-icon.blue {
                background: rgba(67, 97, 238, 0.15);
                color: var(--primary-color);
            }

            .stat-icon.green {
                background: rgba(76, 201, 240, 0.15);
                color: var(--success-color);
            }

            .stat-info h3 {
                font-size: 24px;
                font-weight: 700;
                margin-bottom: 5px;
            }

            .stat-info p {
                color: var(--gray-color);
                font-size: 14px;
            }

            /* Orders List */
            .orders-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .orders-header h2 {
                font-size: 20px;
                font-weight: 600;
            }

            .order-list {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .order-card {
                background: white;
                border-radius: 12px;
                padding: 20px;
                box-shadow: var(--card-shadow);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .order-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
            }

            .order-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
                padding-bottom: 15px;
                border-bottom: 1px solid var(--border-color);
            }

            .order-id {
                font-weight: 600;
                color: var(--primary-color);
            }

            .order-date {
                color: var(--gray-color);
                font-size: 14px;
            }

            .order-status {
                background: #fff9db;
                color: #e67700;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 500;
            }

            .order-products {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }

            .product-item {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 10px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                flex: 1;
                min-width: 250px;
            }

            .product-image {
                width: 60px;
                height: 60px;
                border-radius: 8px;
                background: #f1f3f9;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
                color: var(--primary-color);
            }

            .product-info h4 {
                font-weight: 600;
                margin-bottom: 5px;
            }

            .product-info p {
                color: var(--gray-color);
                font-size: 14px;
            }

            .order-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 15px;
                padding-top: 15px;
                border-top: 1px solid var(--border-color);
            }

            .order-total {
                font-weight: 700;
                font-size: 18px;
                color: var(--dark-color);
            }

            .order-actions {
                display: flex;
                gap: 10px;
            }

            .btn {
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                border: none;
                font-size: 15px;
            }

            .btn-primary {
                background: var(--primary-color);
                color: white;
            }

            .btn-primary:hover {
                background: var(--secondary-color);
            }

            .btn-outline {
                background: transparent;
                border: 1px solid var(--border-color);
                color: var(--gray-color);
            }

            .btn-outline:hover {
                background: #f8f9fa;
            }

            .empty-state {
                text-align: center;
                padding: 40px;
                background: white;
                border-radius: 12px;
                box-shadow: var(--card-shadow);
            }

            .empty-state i {
                font-size: 64px;
                color: #adb5bd;
                margin-bottom: 20px;
            }

            .empty-state h3 {
                font-size: 24px;
                margin-bottom: 10px;
                color: var(--gray-color);
            }

            .empty-state p {
                color: var(--gray-color);
                margin-bottom: 20px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .filters {
                    flex-direction: column;
                }

                .order-header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .order-footer {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 15px;
                }

                .order-actions {
                    width: 100%;
                }

                .order-actions .btn {
                    flex: 1;
                    text-align: center;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- Header -->
            <header>
                <div class="logo">
                    <i class="fas fa-shopping-bag"></i>
                    <h1>ShopMall</h1>
                </div>
                <div class="user-info">
                    <div class="avatar">TN</div>
                    <div class="name">Trần Nguyễn</div>
                </div>
            </header>

            <!-- Stats -->
            <div class="stats">
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="stat-info">
                        <h3>12</h3>
                        <p>Tổng đơn hàng</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon green">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-info">
                        <h3>5</h3>
                        <p>Đơn chưa đánh giá</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-info">
                        <h3>30+ ngày</h3>
                        <p>Đơn hàng cũ nhất</p>
                    </div>
                </div>
            </div>

            <!-- Filters -->
            <div class="filters">
                <div class="filter-group">
                    <label for="date-filter">Thời gian</label>
                    <select id="date-filter">
                        <option>Tất cả thời gian</option>
                        <option>7 ngày qua</option>
                        <option>30 ngày qua</option>
                        <option>3 tháng qua</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="status-filter">Trạng thái</label>
                    <select id="status-filter">
                        <option>Tất cả trạng thái</option>
                        <option selected>Chưa đánh giá</option>
                        <option>Đã đánh giá</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="search">Tìm kiếm đơn hàng</label>
                    <input type="text" id="search" placeholder="Nhập mã đơn hàng...">
                </div>
            </div>

            <!-- Orders List -->
            <div class="orders-container">
                <div class="orders-header">
                    <h2><i class="fas fa-list"></i> Danh sách đơn hàng chưa đánh giá</h2>
                </div>

                <div class="order-list" id="order-list">
                    <!-- Orders will be inserted here by JavaScript -->
                </div>
            </div>
        </div>

        <script>
            // Sample order data
            const orders = [
                {
                    id: "DH-20230815-001",
                    date: "15/08/2023",
                    products: [
                        {
                            name: "Điện thoại Samsung Galaxy S23",
                            category: "Điện thoại",
                            quantity: 1,
                            price: "21.990.000 ₫"
                        },
                        {
                            name: "Ốp lưng chống sốc",
                            category: "Phụ kiện",
                            quantity: 2,
                            price: "350.000 ₫"
                        }
                    ],
                    total: "22.690.000 ₫",
                    status: "Chưa đánh giá"
                },
                {
                    id: "DH-20230810-045",
                    date: "10/08/2023",
                    products: [
                        {
                            name: "Máy tính xách tay Dell XPS 15",
                            category: "Laptop",
                            quantity: 1,
                            price: "34.500.000 ₫"
                        }
                    ],
                    total: "34.500.000 ₫",
                    status: "Chưa đánh giá"
                },
                {
                    id: "DH-20230728-102",
                    date: "28/07/2023",
                    products: [
                        {
                            name: "Tai nghe Bluetooth Sony WH-1000XM5",
                            category: "Phụ kiện",
                            quantity: 1,
                            price: "7.990.000 ₫"
                        },
                        {
                            name: "Adapter chuyển đổi USB-C",
                            category: "Phụ kiện",
                            quantity: 1,
                            price: "450.000 ₫"
                        }
                    ],
                    total: "8.440.000 ₫",
                    status: "Chưa đánh giá"
                },
                {
                    id: "DH-20230720-078",
                    date: "20/07/2023",
                    products: [
                        {
                            name: "Máy ảnh Canon EOS R6 Mark II",
                            category: "Máy ảnh",
                            quantity: 1,
                            price: "48.990.000 ₫"
                        },
                        {
                            name: "Thẻ nhớ 128GB",
                            category: "Phụ kiện",
                            quantity: 1,
                            price: "1.250.000 ₫"
                        }
                    ],
                    total: "50.240.000 ₫",
                    status: "Chưa đánh giá"
                },
                {
                    id: "DH-20230715-033",
                    date: "15/07/2023",
                    products: [
                        {
                            name: "Loa Bluetooth Marshall Emberton",
                            category: "Âm thanh",
                            quantity: 2,
                            price: "3.490.000 ₫"
                        }
                    ],
                    total: "6.980.000 ₫",
                    status: "Chưa đánh giá"
                }
            ];

            // Function to render orders
            function renderOrders() {
                const orderList = document.getElementById('order-list');
                orderList.innerHTML = '';

                if (orders.length === 0) {
                    orderList.innerHTML = `
                        <div class="empty-state">
                            <i class="fas fa-smile"></i>
                            <h3>Không có đơn hàng nào cần đánh giá</h3>
                            <p>Bạn đã đánh giá tất cả các đơn hàng của mình.</p>
                            <button class="btn btn-outline">Quay lại cửa hàng</button>
                        </div>
                    `;
                    return;
                }

                orders.forEach(order => {
                    const orderElement = document.createElement('div');
                    orderElement.className = 'order-card';

                    // Product items HTML
                    let productsHTML = '';
                    order.products.forEach(product => {
                        productsHTML += `
                        <div class="product-item">
                            <div class="product-image">
                                <i class="fas fa-box"></i>
                            </div>
                            <div class="product-info">
                                <h4>${product.name}</h4>
                                <p>${product.category} • Số lượng: ${product.quantity} • ${product.price}</p>
                            </div>
                        </div>
                        `;
                    });

                    orderElement.innerHTML = `
                        <div class="order-header">
                            <div>
                                <div class="order-id">${order.id}</div>
                                <div class="order-date">Ngày đặt hàng: ${order.date}</div>
                            </div>
                            <div class="order-status">${order.status}</div>
                        </div>
                        <div class="order-products">
            ${productsHTML}
                        </div>
                        <div class="order-footer">
                            <div class="order-total">Tổng tiền: ${order.total}</div>
                            <div class="order-actions">
                                <button class="btn btn-outline">Xem chi tiết</button>
                                <button class="btn btn-primary">Đánh giá ngay</button>
                            </div>
                        </div>
                    `;

                    orderList.appendChild(orderElement);
                });
            }

            // Filter and search functionality
            function filterOrders() {
                const searchTerm = document.getElementById('search').value.toLowerCase();
                const statusFilter = document.getElementById('status-filter').value;
                const dateFilter = document.getElementById('date-filter').value;

                // In a real application, you would fetch from server or filter locally
                // For this example, we'll just re-render all orders
                renderOrders();

                // Add event listeners to newly created buttons
                document.querySelectorAll('.btn-primary').forEach(button => {
                    button.addEventListener('click', function () {
                        const orderId = this.closest('.order-card').querySelector('.order-id').textContent;
                        alert(`Bắt đầu đánh giá cho đơn hàng: ${orderId}`);
                        // In a real application, this would navigate to the rating page
                    });
                });
            }

            // Initialize the page
            document.addEventListener('DOMContentLoaded', () => {
                renderOrders();

                // Add event listeners to buttons
                document.querySelectorAll('.btn-primary').forEach(button => {
                    button.addEventListener('click', function () {
                        const orderId = this.closest('.order-card').querySelector('.order-id').textContent;
                        alert(`Bắt đầu đánh giá cho đơn hàng: ${orderId}`);
                    });
                });

                // Add event listeners to filters
                document.getElementById('search').addEventListener('input', filterOrders);
                document.getElementById('status-filter').addEventListener('change', filterOrders);
                document.getElementById('date-filter').addEventListener('change', filterOrders);
            });
        </script>
    </body>
</html>