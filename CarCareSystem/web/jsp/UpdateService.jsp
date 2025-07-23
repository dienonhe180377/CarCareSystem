<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${pageTitle}</title>
        <style>
            body {
                background: #f4f7fb;
                font-family: Arial, sans-serif;
            }
            .form-container {
                background: #fff;
                max-width: 900px;
                margin: 48px auto;
                border-radius: 18px;
                padding: 48px 56px 30px 56px;
                box-shadow: 0 8px 32px 0 rgba(31,38,135,0.12);
            }
            .form-title {
                font-size: 2.5rem;
                color: #2563eb;
                font-weight: 700;
                text-align: center;
                margin-bottom: 28px;
            }
            .tieu-de {
                font-size: 1.65rem;
                color: #166bb3;
                font-weight: 600;
                text-align: center;
                margin-bottom: 28px;
            }
            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0 20px;
                font-size: 1.22rem;
            }
            .form-label {
                width: 170px;
                color: #333;
                font-weight: 500;
                vertical-align: top;
                font-size: 1.15rem;
                padding-top: 10px;
            }
            .form-input[type="text"], .form-input[type="number"] {
                width: 100%;
                padding: 13px 18px;
                border-radius: 10px;
                border: 1.6px solid #b7c7d7;
                font-size: 1.18rem;
            }
            .form-input[type="file"] {
                font-size: 1.12rem;
            }
            .form-actions {
                text-align: right;
                padding-top: 10px;
            }
            .btn {
                padding: 12px 32px;
                border-radius: 8px;
                border: none;
                font-size: 1.15rem;
                font-weight: 700;
            }
            .btn-submit {
                background: #2563eb;
                color: #fff;
            }
            .btn-submit:hover {
                background: #1746a2;
            }
            .btn-reset {
                background: #888;
                color: #fff;
                margin-left: 14px;
            }
            .btn-back {
                background: #2471a3;
                color: #fff;
                padding: 12px 32px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 700;
                margin-left: 14px;
                transition: background 0.2s;
                display: inline-block;
                font-size: 1.15rem;
            }
            .btn-back:hover {
                background: #15518d;
            }
            .alert {
                text-align: center;
                margin-bottom: 18px;
                font-size: 1.12rem;
            }
            .alert-error {
                color: #e74c3c;
            }
            .alert-success {
                color: #27ae60;
            }
            /* Custom dropdown multi-select */
            .multiselect-wrapper {
                position: relative;
                width: 100%;
            }
            .multiselect-selected {
                border: 1.6px solid #b7c7d7;
                border-radius: 10px;
                min-height: 44px;
                background: #fff;
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                gap: 6px;
                padding: 10px 16px;
                cursor: pointer;
                font-size: 1.18rem;
                position: relative;
            }
            .multiselect-selected:after {
                content: '';
                border: solid #2563eb;
                border-width: 0 3px 3px 0;
                display: inline-block;
                padding: 7px;
                transform: rotate(45deg);
                position: absolute;
                right: 24px;
                top: 17px;
                pointer-events: none;
            }
            .multiselect-dropdown {
                display: none;
                position: absolute;
                top: 108%;
                left: 0;
                width: 100%;
                background: #fff;
                border: 1.6px solid #b7c7d7;
                border-radius: 10px;
                box-shadow: 0 4px 18px rgba(0,0,0,0.09);
                z-index: 10;
                max-height: 280px;
                overflow-y: auto;
            }
            .multiselect-dropdown.open {
                display: block;
            }
            .multiselect-option {
                padding: 12px 24px 12px 12px;
                cursor: pointer;
                display: flex;
                align-items: center;
                border-radius: 6px;
                font-size: 1.13rem;
            }
            .multiselect-option:hover {
                background: #e7f1fd;
            }
            .multiselect-option input {
                margin-right: 10px;
            }
            .multiselect-badge {
                background: #e0f0ff;
                color: #166bb3;
                border-radius: 13px;
                padding: 4px 14px;
                font-size: 1.08em;
                margin-right: 5px;
                margin-bottom: 3px;
                display: inline-block;
            }
            /* Ảnh dịch vụ hiển thị lớn hơn */
            .service-img-preview {
                margin-top: 12px;
                width: 180px;
                border-radius: 7px;
                border: 1.3px solid #e0e0e0;
            }
            @media (max-width: 900px) {
                .form-container {
                    padding: 12px 2vw;
                    max-width: 98vw;
                }
                table {
                    font-size: 1.05rem;
                }
                .form-title { font-size: 1.3rem; }
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="form-container">
            <div class="form-title">${pageTitle}</div>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <h2 class="tieu-de">Cập nhật dịch vụ</h2>
            <c:choose>
                <c:when test="${role == 'admin' || role == 'manager' || role == 'marketing'}">
                    <form action="ServiceServlet_JSP" method="POST" enctype="multipart/form-data" autocomplete="off">
                        <input type="hidden" name="id" value="${service.id}">
                        <table>
                            <tr>
                                <td class="form-label">Tên dịch vụ</td>
                                <td>
                                    <input class="form-input" type="text" name="name" required minlength="3" maxlength="29"
                                           pattern="^[\p{L} ]+$"
                                           title="Chỉ nhập chữ cái, không số, không ký tự đặc biệt"
                                           value="${service != null ? service.name : ''}" autocomplete="off">
                                </td>
                            </tr>
                            <tr>
                                <td class="form-label">Mô tả</td>
                                <td>
                                    <input class="form-input" type="text" name="description" required minlength="3" maxlength="29"
                                           pattern="^[\p{L} ]+$"
                                           title="Chỉ nhập chữ cái, không số, không ký tự đặc biệt"
                                           value="${service != null ? service.description : ''}" autocomplete="off">
                                </td>
                            </tr>
                            <tr>
                                <td class="form-label">Giá dịch vụ</td>
                                <td>
                                    <input class="form-input" type="number" name="price" required 
                                           min="1" max="999999999" step="1"
                                           value="${service.price}" autocomplete="off">
                                </td>
                            </tr>
                            <tr>
                                <td class="form-label">Ảnh dịch vụ</td>
                                <td>
                                    <input class="form-input" type="file" name="img" accept="image/*">
                                    <c:if test="${not empty service.img}">
                                        <div>
                                            <img src="${pageContext.request.contextPath}/img/${service.img}" class="service-img-preview" alt="Ảnh dịch vụ hiện tại">
                                            <div style="font-size:13px;color:#888;margin-top:5px;">Ảnh hiện tại</div>
                                        </div>
                                    </c:if>
                                    <input type="hidden" name="imgOld" value="${service.img}" />
                                </td>
                            </tr>
                            <tr>
                                <td class="form-label" style="vertical-align:top;">Phụ tùng liên quan</td>
                                <td>
                                    <div class="multiselect-wrapper" id="multiPartSelect">
                                        <div class="multiselect-selected" onclick="toggleDropdown()">
                                            <span id="selectedPartsPlaceholder" style="color:#bbb;">Chọn phụ tùng liên quan</span>
                                        </div>
                                        <div class="multiselect-dropdown" id="dropdownList">
                                            <c:forEach var="part" items="${allParts}">
                                                <div class="multiselect-option">
                                                    <input type="checkbox" name="partIds" value="${part.id}" id="part_${part.id}"
                                                           <c:if test="${selectedPartIds != null && selectedPartIds.contains(part.id)}">checked</c:if>
                                                               onchange="updateSelectedParts()">
                                                           <label for="part_${part.id}" style="margin-bottom:0">${part.name}</label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="form-actions">
                                    <input class="btn btn-submit" type="submit" name="submit" value="Cập nhật dịch vụ">
                                    <input class="btn btn-reset" type="reset" value="Làm lại">
                                    <a href="ServiceServlet_JSP?service=listService" class="btn btn-back">Quay lại danh sách</a>
                                    <input type="hidden" name="service" value="updateService">
                                </td>
                            </tr>
                        </table>
                    </form>
                </c:when>
                <c:otherwise>
                    <div style="color:red;text-align:center;margin-top:16px">
                        Bạn không có quyền truy cập chức năng này.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <script>
            // Mở/đóng dropdown khi bấm vào khung
            function toggleDropdown() {
                var dropdown = document.getElementById("dropdownList");
                dropdown.classList.toggle("open");
            }
            // Đóng dropdown khi bấm ra ngoài
            document.addEventListener('click', function (event) {
                var wrapper = document.getElementById("multiPartSelect");
                if (!wrapper.contains(event.target)) {
                    document.getElementById("dropdownList").classList.remove("open");
                }
            });
            // Hiển thị các phụ tùng đã chọn lên khung
            function updateSelectedParts() {
                var checked = document.querySelectorAll('.multiselect-dropdown input[type="checkbox"]:checked');
                var container = document.querySelector('.multiselect-selected');
                var placeholder = document.getElementById('selectedPartsPlaceholder');
                // Xóa phần tử cũ (nếu có)
                container.innerHTML = '';
                if (checked.length === 0) {
                    placeholder.style.display = '';
                    container.appendChild(placeholder);
                } else {
                    checked.forEach(function (item) {
                        var badge = document.createElement("span");
                        badge.className = "multiselect-badge";
                        badge.textContent = item.nextElementSibling.textContent;
                        container.appendChild(badge);
                    });
                }
            }
            // Khởi tạo placeholder và checked
            window.onload = function () {
                updateSelectedParts();
            };
        </script>
    </body>
</html> 