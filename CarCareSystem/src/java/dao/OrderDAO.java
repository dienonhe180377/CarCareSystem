/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.List;
/**
 *
 * @author TRAN ANH HAI
 */
public class OrderDAO extends DBConnection{
    
    public int insertOrder(int userId, int carTypeId,Timestamp createdDate, Timestamp appointmentDate) throws SQLException {
        String sql = "INSERT INTO [Order](userId, carTypeId, createdDate, appointmentDate, price) OUTPUT INSERTED.id VALUES (?, ?, ?, ?,0)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, carTypeId);
            st.setTimestamp(3, createdDate);
            st.setTimestamp(4, appointmentDate);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // return generated orderId
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -1;
    }

    public void insertOrderServices(int orderId, List<Integer> serviceIds) throws SQLException {
        String sql = "INSERT INTO OrderService(orderId, serviceId) VALUES (?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            for (int sid : serviceIds) {
                st.setInt(1, orderId);
                st.setInt(2, sid);
                st.addBatch();
            }
            st.executeBatch();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateOrderPrice(int orderId, double totalPrice) throws SQLException {
        String sql = "UPDATE [Order] SET price = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setDouble(1, totalPrice);
            st.setInt(2, orderId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
}
