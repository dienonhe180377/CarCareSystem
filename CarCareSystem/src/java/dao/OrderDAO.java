/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;

/**
 *
 * @author TRAN ANH HAI
 */
public class OrderDAO extends DBConnection {

    public int createOrder(String fullName, String email, String phone, String address, int carTypeId,
                           Timestamp appointmentDate, double price, String paymentStatus, String orderStatus) throws SQLException {
        String sql = "INSERT INTO [Order] (fullName, email, phone, address, carTypeId, appointmentDate, price, paymentStatus, orderStatus) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setInt(5, carTypeId);
            ps.setTimestamp(6, appointmentDate);
            ps.setDouble(7, price);
            ps.setString(8, paymentStatus);
            ps.setString(9, orderStatus);

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        }
        throw new SQLException("Không thể tạo đơn hàng.");
    }
     
    public void addServiceToOrder(int orderId, int serviceId) throws SQLException {
        String sql = "INSERT INTO OrderService (orderId, serviceId) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, serviceId);
            ps.executeUpdate();
        }
    }
    
    public void addPartToOrder(int orderId, int partId) throws SQLException {
        String sql = "INSERT INTO OrderParts (orderId, partId) VALUES (?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, partId);
            ps.executeUpdate();
        }
    }
}
