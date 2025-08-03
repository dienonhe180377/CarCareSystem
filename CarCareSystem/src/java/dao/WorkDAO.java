/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Order;
import entity.Part;
import entity.Service;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author TRAN ANH HAI
 */
public class WorkDAO extends DBConnection {

    public int createWork(int orderId, int repairerId, java.sql.Date receivedDate) {
        String sql = "INSERT INTO Work (order_id, repairer_id, received_date) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, orderId);
            ps.setInt(2, repairerId);
            ps.setDate(3, receivedDate);

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public ArrayList<Order> getOrdersAssignedToRepairer(int repairerId) {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT o.* FROM [Order] o "
                   + "JOIN Work w ON o.id = w.order_id "
                   + "WHERE w.repairer_id = ? "
                   + "ORDER BY o.createDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, repairerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = mapOrderFromResultSet(rs);
                order.setServices(getServicesForOrder(order.getId()));
                order.setParts(getPartsForOrder(order.getId()));
                
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public ArrayList<Order> getOrdersByStatusAssignedToRepairer(int repairerId, String status) {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT o.* FROM [Order] o "
                   + "JOIN Work w ON o.id = w.order_id "
                   + "WHERE w.repairer_id = ? AND o.orderStatus = ? "
                   + "ORDER BY o.createDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, repairerId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = mapOrderFromResultSet(rs);
                order.setServices(getServicesForOrder(order.getId()));
                order.setParts(getPartsForOrder(order.getId()));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    public ArrayList<Order> searchOrdersAssignedToRepairer(int repairerId, String searchQuery) {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT o.* FROM [Order] o "
                   + "JOIN Work w ON o.id = w.order_id "
                   + "WHERE w.repairer_id = ? "
                   + "AND (o.name LIKE ? OR o.phone LIKE ? OR o.email LIKE ? OR CAST(o.id AS VARCHAR) LIKE ?) "
                   + "ORDER BY o.createDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String likeQuery = "%" + searchQuery + "%";
            ps.setInt(1, repairerId);
            ps.setString(2, likeQuery);
            ps.setString(3, likeQuery);
            ps.setString(4, likeQuery);
            ps.setString(5, likeQuery);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = mapOrderFromResultSet(rs);
                order.setServices(getServicesForOrder(order.getId()));
                order.setParts(getPartsForOrder(order.getId()));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }
    
    private ArrayList<Service> getServicesForOrder(int orderId) throws SQLException {
        ArrayList<Service> services = new ArrayList<>();
        String sql = "SELECT s.id, s.name, s.description, s.price "
                + "FROM OrderService os "
                + "JOIN Service s ON os.serviceId = s.id "
                + "WHERE os.orderId = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Service service = new Service();
                service.setId(rs.getInt("id"));
                service.setName(rs.getString("name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getDouble("price"));

                service.setParts(getPartsForService(service.getId()));

                services.add(service);
            }
        }
        return services;
    }

    private ArrayList<Part> getPartsForService(int serviceId) throws SQLException {
        ArrayList<Part> parts = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.price "
                + "FROM PartsService ps "
                + "JOIN Parts p ON ps.partId = p.id "
                + "WHERE ps.serviceId = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, serviceId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Part part = new Part(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price")
                );
                parts.add(part);
            }
        }
        return parts;
    }
    
    private ArrayList<Part> getPartsForOrder(int orderId) throws SQLException {
        ArrayList<Part> parts = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.price "
                + "FROM OrderParts op "
                + "JOIN Parts p ON op.partId = p.id "
                + "WHERE op.orderId = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Part part = new Part(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price")
                );
                parts.add(part);
            }
        }
        return parts;
    }

    private Order mapOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setName(rs.getString("name"));
        order.setEmail(rs.getString("email"));
        order.setPhone(rs.getString("phone"));
        order.setAddress(rs.getString("address"));
        order.setCreatedDate(rs.getTimestamp("createDate"));
        order.setAppointmentDate(rs.getDate("appointmentDate"));
        order.setPrice(rs.getDouble("price"));
        order.setPaymentStatus(rs.getString("paymentStatus"));
        order.setOrderStatus(rs.getString("orderStatus"));
        order.setPaymentMethod(rs.getString("paymentMethod"));
        order.setCarType(rs.getString("carType"));
        order.setDescription(rs.getString("description"));
        return order;
    }
}
