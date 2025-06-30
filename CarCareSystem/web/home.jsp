<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.Service"%>
<%@page import="entity.Part"%>
<%@page import="java.util.Vector"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ - Garage NVT</title>
        <style>
            .carousel-item img { width: 100%; height: 800px; object-fit: cover; }
            .card, .service-card {
                border-radius: 1rem;
                overflow: hidden;
                box-shadow: 0 0 10px #e2e2e2;
                margin-bottom: 2rem;
                transition: transform 0.2s;
                background: #fff;
            }
            .card:hover, .service-card:hover { transform: translateY(-8px) scale(1.03); box-shadow: 0 6px 24px #bdbdbd; }
            .service-card img, .card-img-top { width: 100%; height: 250px; object-fit: cover; }
            .service-card-body, .card-body { padding: 1rem 1.5rem 1.5rem 1.5rem; }
            .service-card-title, .card-title { font-size: 1.3rem; font-weight: bold; margin-bottom: 0.5rem; }
            .service-card-desc { min-height: 40px; color: #555; font-size: 1rem; }
            .service-card-price, .card-text.text-warning { color: #e67e22; font-size: 1.15rem; font-weight: 600; margin: 0.5rem 0; }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <!-- Carousel banner -->
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active"><img src="img/1.jpg" class="d-block w-100" alt="Slide 1"></div>
                <div class="carousel-item"><img src="img/2.jpg" class="d-block w-100" alt="Slide 2"></div>
                <div class="carousel-item"><img src="img/3.jpg" class="d-block w-100" alt="Slide 3"></div>
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

        <!-- FORM MUA DỊCH VỤ VÀ PHỤ TÙNG NỔI BẬT -->
        <form action="BuyController" method="post">
            <!-- DỊCH VỤ NỔI BẬT -->
            <div class="container my-5">
                <h2 class="fw-bold mb-4 text-center">DỊCH VỤ NỔI BẬT</h2>
                <% if (request.getAttribute("errorService") != null) { %>
                    <div class="alert alert-danger text-center"><%= request.getAttribute("errorService") %></div>
                <% } %>
                <% if (request.getAttribute("messageService") != null) { %>
                    <div class="alert alert-success text-center"><%= request.getAttribute("messageService") %></div>
                <% } %>
                <div class="row justify-content-center">
                    <%
                        Vector<Service> top3Services = (Vector<Service>) request.getAttribute("top3Services");
                        if (top3Services != null && !top3Services.isEmpty()) {
                            for (Service s : top3Services) {
                    %>
                    <div class="col-md-4 mb-4 d-flex">
                        <div class="service-card flex-fill position-relative">
                            <input type="checkbox" name="selectedServiceIds" value="<%=s.getId()%>" style="position:absolute;top:10px;left:10px;width:20px;height:20px;z-index:5;">
                            <img src="<%=s.getImg()%>" alt="<%=s.getName()%>">
                            <div class="service-card-body">
                                <div class="service-card-title"><%=s.getName()%></div>
                                <div class="service-card-desc"><%=s.getDescription()%></div>
                                <div class="service-card-price">Giá: <%=String.format("%,.0f", s.getPrice())%> VNĐ</div>
                                <a href="ServiceServlet_JSP?service=previewService&id=<%=s.getId()%>" class="btn btn-sm btn-outline-primary mt-2">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <div class="col-12 text-center"><p>Không có dịch vụ nổi bật!</p></div>
                    <%
                        }
                    %>
                </div>
            </div>

            <!-- PHỤ TÙNG NỔI BẬT -->
            <div class="container my-5">
                <h2 class="fw-bold mb-4 text-center">TOP 5 PHỤ TÙNG NỔI BẬT</h2>
                <% if (request.getAttribute("errorPart") != null) { %>
                    <div class="alert alert-danger text-center"><%= request.getAttribute("errorPart") %></div>
                <% } %>
                <% if (request.getAttribute("messagePart") != null) { %>
                    <div class="alert alert-success text-center"><%= request.getAttribute("messagePart") %></div>
                <% } %>
                <div class="row g-4 justify-content-center">
                    <%
                        Vector<Part> top5Parts = (Vector<Part>) request.getAttribute("top5Parts");
                        if (top5Parts != null && !top5Parts.isEmpty()) {
                            int count = 0;
                            for (Part p : top5Parts) {
                                if (count++ == 5) break;
                    %>
                    <div class="col-xxl-2 col-lg-2 col-md-4 col-sm-6">
                        <div class="card h-100 text-center position-relative">
                            <input type="checkbox" name="selectedPartIds" value="<%=p.getId()%>" style="position:absolute;top:10px;left:10px;width:20px;height:20px;z-index:5;">
                            <img src="<%=p.getImage()%>" class="card-img-top" alt="<%=p.getName()%>">
                            <div class="card-body">
                                <h5 class="card-title fw-bold"><%=p.getName()%></h5>
                                <p class="card-text text-warning fw-bold">Giá: <%=String.format("%,.0f", p.getPrice())%> VNĐ</p>
                                <a href="PartController?service=view&id=<%=p.getId()%>" class="btn btn-outline-primary">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <div class="col-12 text-center"><p>Không có phụ tùng nổi bật!</p></div>
                    <%
                        }
                    %>
                </div>
            </div>

            <div class="text-center mt-3">
                <button type="submit" class="btn btn-success px-5">Mua dịch vụ & phụ tùng đã chọn</button>
            </div>
        </form>
        
        <!-- PHẦN ĐẶT LỊCH NHANH -->
        <div class="container my-5">
            <h2 class="fw-bold mb-4 text-center">ĐẶT LỊCH NHANH</h2>
            <form action="order" method="post" class="row justify-content-center g-3">
                <div class="col-md-12 text-center">
                    <button type="submit" class="btn btn-success px-5">Đặt lịch</button>
                </div>
            </form>
        </div>

        <!-- PHẦN VOUCHER/KHUYẾN MÃI (Banner mẫu) -->
        <div class="container my-5">
            <div class="alert alert-warning text-center py-4 fs-5 fw-bold" role="alert">
                🎁 Nhập mã <span class="text-danger">SALE2025</span> để nhận ngay <span class="text-success">giảm giá 10%</span> cho mọi dịch vụ tháng này!
            </div>
        </div>

        <!-- THÔNG TIN GIỚI THIỆU (Mẫu) -->
        <div class="container my-5">
            <h2 class="fw-bold mb-4 text-center">VỀ CHÚNG TÔI</h2>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <p class="fs-5 text-center">Garage NVT chuyên cung cấp các dịch vụ bảo dưỡng, sửa chữa và phụ tùng ô tô chính hãng với đội ngũ kỹ thuật viên giàu kinh nghiệm, máy móc hiện đại, cam kết mang đến sự hài lòng tuyệt đối cho khách hàng.</p>
                </div>
            </div>
        </div>

        <!-- ĐÁNH GIÁ KHÁCH HÀNG (Mẫu) -->
        <div class="container my-5">
            <h2 class="fw-bold mb-4 text-center">KHÁCH HÀNG NÓI GÌ VỀ CHÚNG TÔI</h2>
            <div class="row justify-content-center">
                <div class="col-md-4">
                    <div class="card p-3">
                        <div class="card-body">
                            <blockquote class="blockquote mb-0">
                                <p>Dịch vụ nhanh chóng, kỹ thuật viên chuyên nghiệp. Sẽ quay lại lần sau!</p>
                                <footer class="blockquote-footer mt-2">Nguyễn Văn A</footer>
                            </blockquote>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card p-3">
                        <div class="card-body">
                            <blockquote class="blockquote mb-0">
                                <p>Phụ tùng chính hãng, giá hợp lý, tư vấn tận tình.</p>
                                <footer class="blockquote-footer mt-2">Trần Thị B</footer>
                            </blockquote>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card p-3">
                        <div class="card-body">
                            <blockquote class="blockquote mb-0">
                                <p>Không gian sạch sẽ, nhân viên thân thiện. Rất hài lòng!</p>
                                <footer class="blockquote-footer mt-2">Lê Văn C</footer>
                            </blockquote>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>