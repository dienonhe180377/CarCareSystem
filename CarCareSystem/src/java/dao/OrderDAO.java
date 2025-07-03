/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.CarType;
import entity.Order;
import entity.Part;
import entity.Service;
import entity.User;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author TRAN ANH HAI
 */
public class OrderDAO extends DBConnection {

    public int createOrder(String fullName, String email, String phone, String address, int carTypeId,
                           Timestamp appointmentDate, double price, String paymentStatus, String orderStatus, String paymentMethod) throws SQLException {
        String sql = "INSERT INTO [Order] (name, email, phone, address, carTypeId, appointmentDate, price, paymentStatus, orderStatus, paymentMethod) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            ps.setString(10, paymentMethod);

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
    
    public boolean updatePaymentStatus(int orderId, String paymentStatus) {
        String sql = "UPDATE orders SET payment_status = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, paymentStatus);
            ps.setInt(2, orderId);
        
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public Order getOrderById(int orderId) {
        String orderSql = "SELECT o.*, ct.name AS car_type_name " +
                            "FROM orders o " +
                            "JOIN car_types ct ON o.car_type_id = ct.id " +
                            "WHERE o.id = ?";
    
        String serviceSql = "SELECT s.id, s.name, s.description, s.price, os.quantity " +
                            "FROM order_services os " +
                            "JOIN services s ON os.service_id = s.id " +
                            "WHERE os.order_id = ?";
    
        String partSql = "SELECT p.id, p.name, p.description, p.price, op.quantity " +
                            "FROM order_parts op " +
                            "JOIN parts p ON op.part_id = p.id " +
                            "WHERE op.order_id = ?";

        try (PreparedStatement orderStmt = connection.prepareStatement(orderSql);
             PreparedStatement serviceStmt = connection.prepareStatement(serviceSql);
             PreparedStatement partStmt = connection.prepareStatement(partSql)) {

        
            orderStmt.setInt(1, orderId);
            ResultSet orderRs = orderStmt.executeQuery();
        
            if (orderRs.next()) {
                Order order = new Order();
                order.setId(orderRs.getInt("id"));
            
                int userId = orderRs.getInt("user_id");
                if (userId > 0) {
                    User user = new User();
                    user.setId(userId);
                    order.setUser(user);
                }
            
                CarType carType = new CarType();
                carType.setId(orderRs.getInt("id"));
                carType.setName(orderRs.getString("name"));
                order.setCarType(carType);
            
            
                order.setCreatedDate(orderRs.getTimestamp("created_date"));
                order.setAppointmentDate(orderRs.getTimestamp("appointment_date"));
                order.setPrice(orderRs.getDouble("total_price"));
                order.setName(orderRs.getString("full_name"));
                order.setEmail(orderRs.getString("email"));
                order.setPhone(orderRs.getString("phone"));
                order.setAddress(orderRs.getString("address"));
                order.setPaymentStatus(orderRs.getString("payment_status"));
                order.setOrderStatus(orderRs.getString("order_status"));
                order.setPaymentMethod(orderRs.getString("payment_method"));
            
            
                serviceStmt.setInt(1, orderId);
                ResultSet serviceRs = serviceStmt.executeQuery();
                ArrayList<Service> services = new ArrayList<>();
                while (serviceRs.next()) {
                    Service service = new Service();
                    service.setId(serviceRs.getInt("id"));
                    service.setName(serviceRs.getString("name"));
                    service.setDescription(serviceRs.getString("description"));
                    service.setPrice(serviceRs.getDouble("price"));
                    services.add(service);
                }
                order.setServices(services);
            
            
                partStmt.setInt(1, orderId);
                ResultSet partRs = partStmt.executeQuery();
                ArrayList<Part> parts = new ArrayList<>();
                while (partRs.next()) {
                    Part part = new Part(partRs.getInt("id"),
                                        partRs.getString("name"),
                                       partRs.getDouble("price")
                                    );
                    parts.add(part);
                }
                order.setParts(parts);
            
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
}
