<%-- 
    Document   : marketing
    Created on : Aug 2, 2025, 9:46:03 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Marketing - Chat</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .container {
                display: flex;
                height: 100vh;
            }
            .sidebar {
                width: 30%;
                background: #f0f0f0;
                padding: 10px;
                overflow-y: auto;
            }
            .chat-area {
                width: 70%;
                padding: 20px;
                display: flex;
                flex-direction: column;
            }
            .messages {
                flex: 1;
                overflow-y: auto;
                padding: 10px;
                background: #f9f9f9;
            }
            .message {
                margin: 8px 0;
                padding: 10px;
                border-radius: 8px;
                max-width: 70%;
            }
            .sent {
                background: #007bff;
                color: white;
                align-self: flex-end;
            }
            .received {
                background: #e0e0e0;
                color: black;
                align-self: flex-start;
            }
            .input-area {
                display: flex;
                padding: 10px;
                border-top: 1px solid #ccc;
            }
            .input-area input {
                flex: 1;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .input-area button {
                padding: 10px 15px;
                background: #28a745;
                color: white;
                border: none;
                margin-left: 5px;
                cursor: pointer;
            }
            .customer-item {
                padding: 10px;
                margin: 5px 0;
                background: #ddd;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <%@include file="/header_emp.jsp" %>
        <div class="container">
            <!-- Danh sách customer -->
            <div class="sidebar">
                <h3>Customers</h3>
                <c:forEach items="${customerIds}" var="customerId">
                    <div class="customer-item" onclick="loadChat(${customerId})">
                        Customer ID: ${customerId}
                    </div>
                </c:forEach>
            </div>

            <!-- Khung chat -->
            <div class="chat-area">
                <div class="messages" id="messages">
                    <p>Select a customer to view messages.</p>
                </div>

                <!-- Form gửi tin nhắn (ẩn ban đầu, hiện khi có customer) -->
                <div class="input-area" id="replyForm" style="display: none;">
                    <form id="replyFormElement" onsubmit="sendReply(event)">
                        <input type="hidden" id="customerId" name="customerId" />
                        <input type="text" name="content" placeholder="Type a reply..." required style="flex: 1;" />
                        <button type="submit">Send</button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            let currentCustomerId = null;

            function loadChat(customerId) {
                currentCustomerId = customerId;
                fetch('api/messages?customerId=' + customerId)
                        .then(res => res.text())
                        .then(html => {
                            document.getElementById('messages').innerHTML = html;
                            document.getElementById('replyForm').style.display = 'flex';
                            document.getElementById('customerId').value = customerId;
                        });
            }

            function sendReply(event) {
                event.preventDefault();
                const form = event.target;
                const content = form.content.value;
                const customerId = form.customerId.value;

                // Dùng URLSearchParams để gửi đúng định dạng
                const params = new URLSearchParams();
                params.append("customerId", customerId);
                params.append("content", content);

                fetch('api/reply', {
                    method: 'POST',
                    body: params, // ← đúng định dạng application/x-www-form-urlencoded
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    }
                })
                        .then(response => {
                            if (response.ok) {
                                form.content.value = '';
                                loadChat(currentCustomerId); // Tải lại tin nhắn
                            } else {
                                alert("Lỗi: " + response.status);
                            }
                        })
                        .catch(err => {
                            console.error("Lỗi gửi tin:", err);
                            alert("Gửi thất bại. Xem console.");
                        });
            }
        </script>
    </body>
</html>
