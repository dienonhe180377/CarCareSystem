/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Message;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author GIGABYTE
 */
public class MessageDAO extends DBConnection{

    private static final int MARKETING_ID = 6;
    
    // Lấy danh sách tin nhắn giữa sender và receiver
    public List<Message> getMessages(int senderId, int receiverId) throws Exception {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM [Message] WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) ORDER BY timestamp";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, senderId);
            ps.setInt(2, receiverId);
            ps.setInt(3, receiverId);
            ps.setInt(4, senderId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Message msg = new Message();
                msg.setMessageId(rs.getInt("message_id"));
                msg.setSenderId(rs.getInt("sender_id"));
                msg.setReceiverId(rs.getInt("receiver_id"));
                msg.setContent(rs.getString("content"));
                msg.setTimestamp(rs.getTimestamp("timestamp"));
                messages.add(msg);
            }
        }
        return messages;
    }

    // Lấy danh sách các customer đã từng nhắn tin (cho marketing)
    public List<Integer> getCustomerIdsWithMessages() throws Exception {
        List<Integer> customerIds = new ArrayList<>();
        String sql = "SELECT DISTINCT sender_id FROM [Message] WHERE sender_id != ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, MARKETING_ID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                customerIds.add(rs.getInt("sender_id"));
            }
        }
        return customerIds;
    }

    // Gửi tin nhắn mới
    public void sendMessage(int senderId, int receiverId, String content) throws Exception {
        String sql = "INSERT INTO [Message] (sender_id, receiver_id, content, timestamp) VALUES (?, ?, ?, GETDATE())";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, senderId);
            ps.setInt(2, receiverId);
            ps.setString(3, content);
            ps.executeUpdate();
        }
    }
}
