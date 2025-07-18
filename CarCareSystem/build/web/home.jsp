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
        <title>Trang chủ</title>
        <style>
            .carousel-item img { width: 100%; height: 1000px; object-fit: cover; }
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

            .quick-booking-voucher-row {
                display: flex;
                flex-wrap: wrap;
                gap: 2rem;
                justify-content: center;
                align-items: stretch;
            }
            .quick-booking-col, .voucher-col {
                flex: 1 1 320px;
                min-width: 320px;
                max-width: 540px;
                background: #fff;
                border-radius: 1rem;
                box-shadow: 0 0 10px #e2e2e2;
                padding: 2rem 1.5rem;
                margin-bottom: 2rem;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }
            .voucher-col {
                display: flex;
                align-items: center;
                justify-content: center;
                background: linear-gradient(110deg, #fffbe6 80%, #ffe5e5 100%);
                border: 2px dashed #e67e22;
                box-shadow: 0 0 10px #fffbe6;
            }
            @media (max-width: 991.98px) {
                .quick-booking-voucher-row {
                    flex-direction: column;
                    gap: 0;
                }
                .carousel-item img { height: 200px; }
            }

            /* Back to Top Button styling */
            #backToTopBtn {
                display: none;
                position: fixed;
                bottom: 40px;
                right: 40px;
                z-index: 99;
                border: none;
                outline: none;
                background-color: #e67e22;
                color: white;
                cursor: pointer;
                padding: 14px 18px;
                border-radius: 50%;
                box-shadow: 0 6px 24px #bdbdbd;
                font-size: 24px;
                transition: background 0.3s, transform 0.2s;
            }
            #backToTopBtn:hover {
                background-color: #ff9900;
                transform: scale(1.1);
            }
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

        <!-- DỊCH VỤ NỔI BẬT (Best Services) -->
        <div class="container my-5">
            <h2 class="fw-bold mb-4 text-center">DỊCH VỤ NỔI BẬT</h2>
            <% if (request.getAttribute("errorService") != null) { %>
                <div class="alert alert-danger text-center"><%= request.getAttribute("errorService") %></div>
            <% } %>
            <% if (request.getAttribute("messageService") != null) { %>
                <div class="alert alert-success text-center"><%= request.getAttribute("messageService") %></div>
            <% } %>
            <form action="BuyController" method="post">
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
                    %>
                    <div class="col-12 text-center my-3">
                        <button type="submit" class="btn btn-warning px-5">Mua các dịch vụ đã chọn</button>
                    </div>
                    <%
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

        <!-- PHỤ TÙNG NỔI BẬT (Featured Parts) -->
        <div class="container my-5">
            <h2 class="fw-bold mb-4 text-center">PHỤ TÙNG NỔI BẬT</h2>
            <div class="row justify-content-center">
                <%
                    Vector<Part> top5Parts = (Vector<Part>) request.getAttribute("top5Parts");
                    if (top5Parts != null && !top5Parts.isEmpty()) {
                        for (Part p : top5Parts) {
                %>
                <div class="col-md-3 mb-4 d-flex">
                    <div class="card flex-fill">
                        <img src="<%=p.getImage()%>" class="card-img-top" alt="<%=p.getName()%>">
                        <div class="card-body">
                            <div class="card-title"><%=p.getName()%></div>
                            <div class="card-text text-warning">Giá: <%=String.format("%,.0f", p.getPrice())%> VNĐ</div>
                            <a href="PartServlet?part=previewPart&id=<%=p.getId()%>" class="btn btn-sm btn-outline-primary mt-2">Xem chi tiết</a>
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

        <!-- ĐẶT LỊCH NHANH VÀ VOUCHER -->
        <div class="container my-5">
            <div class="quick-booking-voucher-row">
                <!-- ĐẶT LỊCH NHANH -->
                <div class="quick-booking-col">
                    <h2 class="fw-bold mb-4 text-center">ĐẶT LỊCH NHANH</h2>
                    <form action="BookingController" method="post" class="row g-3">
                        <div class="col-12">
                            <input type="text" class="form-control" name="name" placeholder="Họ tên của bạn" required>
                        </div>
                        <div class="col-12">
                            <input type="tel" class="form-control" name="phone" placeholder="Số điện thoại" required>
                        </div>
                        <div class="col-12">
                            <select class="form-select" name="serviceId" required>
                                <option value="" selected disabled>Chọn dịch vụ</option>
                                <%
                                    if (top3Services != null) {
                                        for (Service s : top3Services) {
                                %>
                                <option value="<%=s.getId()%>"><%=s.getName()%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-12">
                            <input type="date" class="form-control" name="date" required>
                        </div>
                        <div class="col-12 text-center mt-2">
                            <button type="submit" class="btn btn-success px-5">Đặt lịch</button>
                        </div>
                    </form>
                </div>
                <!-- VOUCHER -->
                <div class="voucher-col">
                    <div class="alert alert-warning text-center py-4 fs-5 fw-bold mb-0 w-100" role="alert" style="border:none;background:transparent;">
                        🎁 Nhập mã <span class="text-danger">SALE2025</span> để nhận ngay <span class="text-success">giảm giá 10%</span> cho mọi dịch vụ tháng này!
                    </div>
                </div>
            </div>
        </div>

        <!-- GIỚI THIỆU -->
        <div class="container my-5">
            <h2 class="fw-bold mb-4 text-center">VỀ CHÚNG TÔI</h2>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <p class="fs-5 text-center">CarCareSystem chuyên cung cấp các dịch vụ bảo dưỡng, sửa chữa và phụ tùng ô tô chính hãng với đội ngũ kỹ thuật viên giàu kinh nghiệm, máy móc hiện đại, cam kết mang đến sự hài lòng tuyệt đối cho khách hàng.</p>
                </div>
            </div>
        </div>

        <!-- ĐÁNH GIÁ KHÁCH HÀNG -->
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

        <!-- Back to Top Button -->
        <button onclick="topFunction()" id="backToTopBtn" title="Lên đầu trang">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-arrow-up" viewBox="0 0 16 16">
                <path fill-rule="evenodd" d="M8 12a.5.5 0 0 0 .5-.5V3.707l3.147 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 3.707V11.5A.5.5 0 0 0 8 12z"/>
            </svg>
        </button>
        <script>
            // Show/hide the button when scrolling
            var backToTopBtn = document.getElementById("backToTopBtn");
            window.onscroll = function() {scrollFunction();};

            function scrollFunction() {
                if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
                    backToTopBtn.style.display = "block";
                } else {
                    backToTopBtn.style.display = "none";
                }
            }

            // When the user clicks on the button, scroll to the top of the document
            function topFunction() {
                window.scrollTo({top: 0, behavior: 'smooth'});
            }
        </script>
    </body>
</html>