
<%-- 
    Document   : home
    Created on : May 30, 2025, 2:15:56 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .carousel-item img {
                width: 100%;
                height: 800px;
                object-fit: cover;
            }
        </style>
    </head>

    <body>
        <%@include file="header.jsp" %>
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="img/1.jpg" class="d-block w-100" alt="Slide 1">
                </div>
                <div class="carousel-item">
                    <img src="img/2.jpg" class="d-block w-100" alt="Slide 2">
                </div>
                <div class="carousel-item">
                    <img src="img/3.jpg" class="d-block w-100" alt="Slide 3">
                </div>
                <div class="carousel-item">
                    <img src="img/4.jpg" class="d-block w-100" alt="Slide 4">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        <!-- DỊCH VỤ NỔI BẬT -->
        <div class="container my-5">
            <h2 class="fw-bold mb-4 text-center">DỊCH VỤ NỔI BẬT</h2>
    <div class="row text-center justify-content-center align-items-end">
        <!-- Service 1 -->
        <div class="col-md-4 mb-4">
            <div class="mb-2" style="font-size:2.5rem; font-weight:bold; color:#3ce03c;">1</div>
            <div class="position-relative mb-3">
                <img src="img/5.jpg" alt="Rửa xe" class="img-fluid w-100 rounded-3" style="height:250px; object-fit:cover;">
                <div class="position-absolute top-50 start-50 translate-middle text-white fw-bold"
                     style="font-size:1.8rem; text-shadow:1px 1px 3px rgba(0,0,0,0.8);">
                    RỬA XE
                </div>
            </div>
            <div>
                <a href="ServiceServlet_JSP" class="btn btn-outline-success rounded-pill px-4 fw-bold" style="font-size:1.2rem;">XEM THÊM DỊCH VỤ</a>
            </div>
        </div>
        <!-- Service 2 -->
        <div class="col-md-4 mb-4">
            <div class="mb-2" style="font-size:2.5rem; font-weight:bold; color:#ff2e44;">2</div>
            <div class="position-relative mb-3">
                <img src="img/7.jpg" alt="Đánh bóng/Hiệu chỉnh sơn" class="img-fluid w-100 rounded-3" style="height:250px; object-fit:cover;">
                <div class="position-absolute top-50 start-50 translate-middle text-white fw-bold text-center"
                     style="font-size:1.5rem; text-shadow:1px 1px 3px rgba(0,0,0,0.8);">
                    ĐÁNH BÓNG /<br>HIỆU CHỈNH SƠN
                </div>
            </div>
            <div>
                <a href="ServiceServlet_JSP" class="btn btn-outline-danger rounded-pill px-4 fw-bold" style="font-size:1.2rem;">XEM THÊM DỊCH VỤ</a>
            </div>
        </div>
        <!-- Service 3 -->
        <div class="col-md-4 mb-4">
            <div class="mb-2" style="font-size:2.5rem; font-weight:bold; color:#a54fff;">3</div>
            <div class="position-relative mb-3">
                <img src="img/6.jpg" alt="Vệ sinh khoang động cơ" class="img-fluid w-100 rounded-3" style="height:250px; object-fit:cover;">
                <div class="position-absolute top-50 start-50 translate-middle text-white fw-bold text-center"
                     style="font-size:1.5rem; text-shadow:1px 1px 3px rgba(0,0,0,0.8);">
                    VỆ SINH<br>KHOANG ĐỘNG CƠ
                </div>
            </div>
            <div>
                <a href="ServiceServlet_JSP" class="btn rounded-pill px-4 fw-bold"
                   style="border:2px solid #a54fff; color:#a54fff; font-size:1.2rem;"
                   onmouseover="this.style.backgroundColor = '#a54fff';this.style.color = '#fff';"
                   onmouseout="this.style.backgroundColor = 'transparent';this.style.color = '#a54fff';">
                    XEM THÊM DỊCH VỤ
                </a>
            </div>
        </div>
    </div>
</div>
        <!-- SẢN PHẨM NỔI BẬT -->
        <div class="container my-5">
            <h2 class="fw-bold mb-4 text-center">SẢN PHẨM NỔI BẬT</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100 shadow text-center">
                        <img src="img/8.jpg" class="card-img-top" alt="Phụ kiện 1" style="height: 220px; object-fit:cover;">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Camera Hành Trình X9</h5>
                            <p class="card-text">Bảo vệ an toàn cho xe của bạn với chất lượng Full HD, lắp đặt nhanh chóng.</p>
                            <a href="#" class="btn btn-outline-primary">Xem chi tiết</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 shadow text-center">
                        <img src="img/9.jpg" class="card-img-top" alt="Phụ kiện 2" style="height: 220px; object-fit:cover;">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Nước Hoa Ô Tô </h5>
                            <p class="card-text">Mang đến không gian tươi mát, thư giãn cho mọi hành trình của bạn.</p>
                            <a href="#" class="btn btn-outline-primary">Xem chi tiết</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 shadow text-center">
                        <img src="img/10.jpg" class="card-img-top" alt="Phụ kiện 3" style="height: 220px; object-fit:cover;">
                        <div class="card-body">
                            <h5 class="card-title fw-bold">Bọc Ghế Da Cao Cấp</h5>
                            <p class="card-text">Tăng sự sang trọng, thoải mái và bảo vệ ghế xe tối ưu.</p>
                            <a href="#" class="btn btn-outline-primary">Xem chi tiết</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- ĐẶT LỊCH + VOUCHER ƯU ĐÃI -->
<div class="container my-5">
    <div class="row g-4 align-items-stretch">
        <!-- ĐẶT LỊCH DỊCH VỤ -->
        <div class="col-md-6">
            <div class="p-4 border rounded-3 shadow h-100 bg-light">
                <h2 class="fw-bold mb-4 text-center"><i class="bi bi-calendar-check"></i> ĐẶT LỊCH DỊCH VỤ</h2>
                <form class="row g-3">
                    <div class="col-md-6">
                        <input type="text" class="form-control" placeholder="Họ và tên" required>
                    </div>
                    <div class="col-md-6">
                        <input type="tel" class="form-control" placeholder="Số điện thoại" required>
                    </div>
                    <div class="col-md-6">
                        <input type="date" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <input type="text" class="form-control" placeholder="Dịch vụ muốn đặt" required>
                    </div>
                    <div class="col-12 text-center">
                        <button type="submit" class="btn btn-warning px-5 py-2 fw-bold">ĐẶT LỊCH NGAY</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- VOUCHER ƯU ĐÃI -->
        <div class="col-md-6">
            <div class="p-4 h-100 rounded-3 shadow" style="background:linear-gradient(90deg,#fff5c2,#ffe375 70%,#fff5c2); border:2px dashed #eab308;">
                <h2 class="fw-bold mb-3 text-center" style="color:#b8860b;"><i class="bi bi-gift"></i> VOUCHER ƯU ĐÃI HẤP DẪN!</h2>
                <p class="mb-2 fs-5 text-center">Nhập mã <span class="fw-bold text-danger">OTO20</span> khi đặt lịch để được giảm ngay <span class="fw-bold text-success">20%</span> cho mọi dịch vụ!</p>
                <p class="mb-3 text-muted text-center">Áp dụng đến hết 30/06/2025. Đặt lịch ngay để không bỏ lỡ!</p>
                <div class="text-center">
                    <button class="btn btn-outline-warning px-4 fw-bold" style="font-size:1.2rem;"
                        onmouseover="this.style.backgroundColor = '#facc15'; this.style.color = '#000';"
                        onmouseout="this.style.backgroundColor = 'transparent'; this.style.color = '#eab308';">
                   </button>
                </div>
            </div>
        </div>
    </div>
</div>
        <%@include file="footer.jsp" %>
    </body>
</html>