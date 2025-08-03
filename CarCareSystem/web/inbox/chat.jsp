<%-- 
    Document   : chat
    Created on : Aug 2, 2025, 9:45:23 PM
    Author     : GIGABYTE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chat with Marketing</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            .container {
                display: flex;
                height: 100vh;
            }
            .sidebar {
                width: 30%;
                background: #f0f0f0;
                padding: 10px;
            }
            .chat-area {
                width: 70%;
                display: flex;
                flex-direction: column;
            }
            .messages {
                flex: 1;
                overflow-y: auto;
                padding: 10px;
            }
            .message {
                margin: 5px 0;
                padding: 8px;
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
                background: #007bff;
                color: white;
                border: none;
                margin-left: 5px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <%@include file="/header.jsp" %>
        <div class="container">
            <!-- Sidebar -->
            <div class="sidebar">
                <h3>Your Chat</h3>
                <p>With Marketing Team</p>
            </div>

            <!-- Chat Area -->
            <div class="chat-area">
                <div class="messages" id="messages">
                    <c:forEach items="${messages}" var="msg">
                        <div class="message ${msg.senderId == user.id ? 'sent' : 'received'}">
                            ${msg.content}
                        </div>
                    </c:forEach>
                </div>
                <div class="input-area">
                    <form action="chat" method="post">
                        <input type="text" name="content" placeholder="Type a message..." required />
                        <button type="submit">Send</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
