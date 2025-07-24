
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*, entity.CarType, entity.Service, entity.Part" %>
<%@ page import="dao.CarTypeDAO, dao.ServiceDAO, dao.PartDAO" %>
<%@ page import="entity.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    CarTypeDAO carDAO = new CarTypeDAO();
    ServiceDAO serviceDAO = new ServiceDAO();
    PartDAO partDAO = new PartDAO();

    List<CarType> carTypes = carDAO.getAllCarTypes();
    List<Service> services = serviceDAO.getAllService();
    List<Part> parts = partDAO.getAllPart();
%>
<% 
Map<Integer, Double> serviceTotalPrices = new HashMap<>();
for (Service s : services) {
    double totalPrice = s.getPrice();
    if (s.getParts() != null) {
        for (Part p : s.getParts()) {
            totalPrice += p.getPrice();
        }
    }
    serviceTotalPrices.put(s.getId(), totalPrice);
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đặt lịch sửa xe</title>
        <style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #f5f6fa;
        margin: 0;
        padding: 0;
    }

    .form-container {
        max-width: 700px;
        margin: 100px auto 40px auto;
        background: #fff;
        padding: 30px 40px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    }

    h2 {
        text-align: center;
        margin-bottom: 30px;
        color: #2f3640;
    }

    label {
        display: block;
        margin-bottom: 6px;
        font-weight: bold;
        color: #333;
    }

    input[type="text"],
    input[type="email"],
    input[type="datetime-local"],
    select {
        width: 100%;
        padding: 10px 12px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 8px;
        transition: border-color 0.3s;
    }

    input:focus,
    select:focus {
        border-color: #40739e;
        outline: none;
    }

    .checkbox-group,
    .radio-group {
        margin-bottom: 20px;
    }

    .checkbox-group label,
    .radio-group label {
        font-weight: normal;
        display: block;
        margin-bottom: 5px;
        color: #555;
    }

    .submit-btn {
        display: block;
        width: 100%;
        padding: 12px;
        background-color: #40739e;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .submit-btn:hover {
        background-color: #273c75;
    }

    .message {
        text-align: center;
        color: green;
        font-weight: bold;
        margin-top: 20px;
    }
    .form-check-input:checked + .form-check-label {
        font-weight: bold;
        color: #2980b9;
    }

</style>
    </head>
    <body>
        <%@include file="/header.jsp" %>
        <div class="form-container">
            <h2>Đặt lịch sửa xe</h2>
            <form action="order" method="post">
                <label>Họ và tên:</label>
                <input type="text" name="fullName" required
                    value="<%= currentUser != null ? currentUser.getUsername() : "" %>"
                    <%= currentUser != null ? "readonly" : "" %>>

                <label>Email:</label>
                <input type="email" name="email" required
                    value="<%= currentUser != null ? currentUser.getEmail() : "" %>"
                    <%= currentUser != null ? "readonly" : "" %>>

                <label>Số điện thoại:</label>
                <input type="text" name="phone" required
                    value="<%= currentUser != null ? currentUser.getPhone() : "" %>"
                    <%= currentUser != null ? "readonly" : "" %>>

                <label>Địa chỉ:</label>
                <input type="text" name="address" required
                    value="<%= currentUser != null ? currentUser.getAddress() : "" %>"
                    <%= currentUser != null ? "readonly" : "" %>>

                <label>Loại Xe:</label>
                <% if (carTypes != null && !carTypes.isEmpty()) { %>
                    <select name="carTypeId" required>
                        <% for(CarType c : carTypes) { %>
                            <option value="<%= c.getId() %>"><%= c.getName() %></option>
                        <% } %>
                    </select>
                <% } else { %>
                    <p>Không có loại xe nào trong hệ thống.</p>
                <% } %>

                <label>Ngày hẹn:</label>
                <input type="date" name="appointmentDate" required 
                       min="<fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/>">

                <div class="checkbox-group">
                    <label>Dịch vụ muốn đặt:</label>
                    <div class="scrollable-container" style="max-height: 200px; overflow-y: auto; border: 1px solid #ddd; padding: 10px;">
                        <% if (services != null) { 
                            for (Service s : services) { 
                            double totalPrice = serviceTotalPrices.get(s.getId());
                        %>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="serviceIds" value="<%= s.getId() %>" id="service_<%= s.getId() %>" data-price="<%= totalPrice %>">
                            <label class="form-check-label" for="service_<%= s.getId() %>">
                                <%= s.getName() %> - <%= String.format("%,.0f", totalPrice) %> VNĐ
                            </label>
                        </div>
                        <% } 
                        } %>
                    </div>
                </div>

                <div class="checkbox-group">
                    <label>Thêm phụ tùng (nếu cần):</label>
                    <div class="scrollable-container" style="max-height: 200px; overflow-y: auto; border: 1px solid #ddd; padding: 10px;">
                    <% 
                        Set<Integer> servicePartIds = new HashSet<>();
                        for (Service s : services) {
                            if (s.getParts() != null) {
                                for (Part p : s.getParts()) {
                                    servicePartIds.add(p.getId());
                                }
                            }
                        }
        
                        if (parts != null) { 
                            for (Part p : parts) { 
                                if (!servicePartIds.contains(p.getId())) { 
                    %>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="partIds" value="<%= p.getId() %>" id="part_<%= p.getId() %>" data-price="<%= p.getPrice() %>">
                                    <label class="form-check-label" for="part_<%= p.getId() %>">
                                        <%= p.getName() %> - <%= String.format("%,.0f", p.getPrice()) %> VNĐ
                                    </label>
                                </div>
                                <% } 
                            } 
                        } %>
                    </div>
                </div>

                <p style="text-align:center; font-weight: bold; font-size: 1.2em; margin-top: 20px;">
                    TỔNG CỘNG: <span id="totalPrice" style="color: #e74c3c;">0</span> VNĐ
                </p>
                
                <div class="radio-group">
                    <label>Hình thức thanh toán:</label>
                    <label><input type="radio" name="paymentMethod" value="Thanh toán bằng tiền mặt"> Tiền mặt</label>
                    <label><input type="radio" name="paymentMethod" value="Chuyển khoản ngân hàng"> Chuyển khoản</label>
                </div>

                <input type="submit" class="submit-btn" value="Đặt lịch">
            </form>

            <% if (request.getAttribute("message") != null) { %>
                <p class="message"><%= request.getAttribute("message") %></p>
            <% } %>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Lấy tất cả các checkbox
                const checkboxes = document.querySelectorAll('input[type="checkbox"]');
    
                // Hàm tính tổng tiền
                function calculateTotal() {
                    let total = 0;
        
                    // Duyệt qua tất cả checkbox
                    checkboxes.forEach(checkbox => {
                        if (checkbox.checked) {
                            // Lấy giá từ thuộc tính data-price và cộng vào tổng
                            total += parseInt(checkbox.getAttribute('data-price'));
                        }
                    });
        
                    // Hiển thị tổng (định dạng số)
                    document.getElementById('totalPrice').textContent = total.toLocaleString('vi-VN');
                }
    
                // Gắn sự kiện change cho tất cả checkbox
                checkboxes.forEach(checkbox => {
                    checkbox.addEventListener('change', calculateTotal);
                });
    
                // Tính tổng ban đầu (nếu có checkbox được chọn sẵn)
                calculateTotal();
            });
        </script>
    </body>
</html>
