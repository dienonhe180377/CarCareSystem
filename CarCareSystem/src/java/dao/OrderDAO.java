/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.CarType;
import entity.Order;
import entity.Part;
import entity.Service;
import java.sql.*;
import java.util.ArrayList;


/**
 *
 * @author TRAN ANH HAI
 */
public class OrderDAO extends DBConnection {

    public int createOrder(String fullName, String email, String phone, String address, int carTypeId,
                           Date appointmentDate, double price, String paymentStatus, String orderStatus, String paymentMethod) throws SQLException {
        String sql = "INSERT INTO [Order] (name, email, phone, address, carTypeId, appointmentDate, price, paymentStatus, orderStatus, paymentMethod) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setInt(5, carTypeId);
            ps.setDate(6, appointmentDate);
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
        String sql = "UPDATE [Order] SET paymentStatus = ? WHERE id = ?";
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
    
    public Order getOrderById(int orderId) throws SQLException {
        String sql = "SELECT "
                + "o.id, o.name, o.email, o.phone, o.address, "
                + "o.appointmentDate, o.price, o.paymentStatus, o.orderStatus, o.paymentMethod, "
                + "ct.id AS car_type_id, ct.name AS car_type_name "
                + "FROM [Order] o "
                + "LEFT JOIN CarType ct ON o.carTypeId = ct.id "
                + "WHERE o.id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setName(rs.getString("name"));
                order.setEmail(rs.getString("email"));
                order.setPhone(rs.getString("phone"));
                order.setAddress(rs.getString("address"));
                order.setAppointmentDate(rs.getDate("appointmentDate"));
                order.setPrice(rs.getDouble("price"));
                order.setPaymentStatus(rs.getString("paymentStatus"));
                order.setOrderStatus(rs.getString("orderStatus"));
                order.setPaymentMethod(rs.getString("paymentMethod"));

                CarType carType = new CarType();
                carType.setId(rs.getInt("car_type_id"));  
                carType.setName(rs.getString("car_type_name"));
                order.setCarType(carType);

                order.setServices(getServicesForOrder(orderId));
                order.setParts(getPartsForOrder(orderId));

                return order;
            } else {
                throw new SQLException("Không tìm thấy đơn hàng với ID: " + orderId);
            }
        } catch (Exception e) {
            throw new SQLException("Lỗi khi lấy thông tin đơn hàng: " + e.getMessage(), e);
        }
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
    
    public ArrayList<Order> getOrdersByEmail(String email) throws SQLException {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT o.id, o.name, o.email, o.phone, o.address, o.createDate, "
                    + "o.appointmentDate, o.price, o.paymentStatus, o.orderStatus, o.paymentMethod, "
                    + "ct.id AS car_type_id, ct.name AS car_type_name "
                    + "FROM [Order] o "
                    + "LEFT JOIN CarType ct ON o.carTypeId = ct.id "
                    + "WHERE o.email = ? "
                    + "ORDER BY o.id DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
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

                CarType carType = new CarType();
                carType.setId(rs.getInt("car_type_id"));
                carType.setName(rs.getString("car_type_name"));
                order.setCarType(carType);

                orders.add(order);
            }
        }
        return orders;
    }
    
    public ArrayList<Order> getAllOrders() throws SQLException {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT o.id, o.name, o.email, o.phone, o.address, o.createDate, "
                    + "o.appointmentDate, o.price, o.paymentStatus, o.orderStatus, o.paymentMethod, "
                    + "ct.id AS car_type_id, ct.name AS car_type_name "
                    + "FROM [Order] o "
                    + "LEFT JOIN CarType ct ON o.carTypeId = ct.id "
                    + "ORDER BY o.createDate DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
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

                CarType carType = new CarType();
                carType.setId(rs.getInt("car_type_id"));
                carType.setName(rs.getString("car_type_name"));
                order.setCarType(carType);

                orders.add(order);
            } 
        }
        return orders;
    }

    
    public ArrayList<Order> getOrdersByStatus(String status) throws SQLException {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT o.id, o.name, o.email, o.phone, o.address, o.createDate, "
                    + "o.appointmentDate, o.price, o.paymentStatus, o.orderStatus, o.paymentMethod, "
                    + "ct.id AS car_type_id, ct.name AS car_type_name "
                    + "FROM [Order] o "
                    + "LEFT JOIN CarType ct ON o.carTypeId = ct.id "
                    + "WHERE o.orderStatus = ? "
                    + "ORDER BY o.createDate DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
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

                CarType carType = new CarType();
                carType.setId(rs.getInt("car_type_id"));
                carType.setName(rs.getString("car_type_name"));
                order.setCarType(carType);

                int orderId = order.getId();
                order.setServices(getServicesForOrder(orderId));
                order.setParts(getPartsForOrder(orderId));
                
                orders.add(order);
            }
        }
        return orders;
    }

    public ArrayList<Order> getOrdersByPaymentStatus(String paymentStatus) throws SQLException {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT o.id, o.name, o.email, o.phone, o.address, o.createDate, "
                    + "o.appointmentDate, o.price, o.paymentStatus, o.orderStatus, o.paymentMethod, "
                    + "ct.id AS car_type_id, ct.name AS car_type_name "
                    + "FROM [Order] o "
                    + "LEFT JOIN CarType ct ON o.carTypeId = ct.id "
                    + "WHERE o.paymentStatus = ? "
                    + "ORDER BY o.createDate DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, paymentStatus);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
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

                CarType carType = new CarType();
                carType.setId(rs.getInt("car_type_id"));
                carType.setName(rs.getString("car_type_name"));
                order.setCarType(carType);

                orders.add(order);
            }
        }
        return orders;
    }
    
    public ArrayList<Order> getCompletedOrders() {
        ArrayList<Order> completedOrders = new ArrayList<>();
        String sql = "SELECT o.id, o.name, o.email, o.phone, o.address, o.createDate, "
               + "o.appointmentDate, o.price, o.paymentStatus, o.orderStatus, o.paymentMethod, "
               + "ct.id AS car_type_id, ct.name AS car_type_name "
               + "FROM [Order] o "
               + "LEFT JOIN CarType ct ON o.carTypeId = ct.id "
               + "WHERE o.paymentStatus = ? AND o.orderStatus = ? "
               + "ORDER BY o.createDate DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, "Đã thanh toán");
            stmt.setString(2, "Đã trả xe");
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
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

                CarType carType = new CarType();
                carType.setId(rs.getInt("car_type_id"));
                carType.setName(rs.getString("car_type_name"));
                order.setCarType(carType);

                completedOrders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return completedOrders;
    }

    public ArrayList<Order> searchOrders(String query) throws SQLException {
        ArrayList<Order> orders = new ArrayList<>();
        String sql = "SELECT o.id, o.name, o.email, o.phone, o.address, o.createDate, "
                    + "o.appointmentDate, o.price, o.paymentStatus, o.orderStatus, o.paymentMethod, "
                    + "ct.id AS car_type_id, ct.name AS car_type_name "
                    + "FROM [Order] o "
                    + "LEFT JOIN CarType ct ON o.carTypeId = ct.id "
                    + "WHERE o.name LIKE ? OR o.email LIKE ? OR o.phone LIKE ? OR o.id = ? "
                    + "ORDER BY o.createDate DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchParam = "%" + query + "%";
            stmt.setString(1, searchParam);
            stmt.setString(2, searchParam);
            stmt.setString(3, searchParam);
        
            try {
                int idQuery = Integer.parseInt(query);
                stmt.setInt(4, idQuery);
            } catch (NumberFormatException e) {
                stmt.setInt(4, -1); 
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
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

                CarType carType = new CarType();
                carType.setId(rs.getInt("car_type_id"));
                carType.setName(rs.getString("car_type_name"));
                order.setCarType(carType);

                orders.add(order);
            }
        }
        return orders;
    }
    
    public String getPaymentStatus(int orderId) {
    String sql = "SELECT paymentStatus FROM Order WHERE id = ?";
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, orderId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getString("paymentStatus");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

    public boolean updateOrderStatus(int orderId, String newStatus) {
        String sql = "UPDATE [Order] SET orderStatus = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);
    
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean checkAndUpdateMissedAppointments() {
        String sql = "UPDATE [Order] SET orderStatus = ? " +
                "WHERE orderStatus = 'Chưa xác nhận' " +  
                "AND CONVERT(DATE, appointmentDate) < CONVERT(DATE, GETDATE())";  
    
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setNString(1, "Lỡ hẹn");
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean rescheduleOrder(int orderId, Date newAppointmentDate) {
            String sql = "UPDATE [Order] SET appointmentDate = ?, orderStatus = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDate(1, newAppointmentDate);
            ps.setNString(2, "Chưa xác nhận");
            ps.setInt(3, orderId);
    
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean removeAllServicesFromOrder(int orderId) {
        String sql = "DELETE FROM OrderService WHERE orderId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean removeAllPartsFromOrder(int orderId) {
        String sql = "DELETE FROM OrderParts WHERE orderId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateOrderPrice(int orderId, double newPrice) {
        String sql = "UPDATE [Order] SET price = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDouble(1, newPrice);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean removeServiceFromOrder(int orderId, int serviceId) {
    String sql = "DELETE FROM OrderService WHERE orderId = ? AND serviceId = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, orderId);
        ps.setInt(2, serviceId);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
    }
    
    public boolean removePartFromOrder(int orderId, int partId) {
    String sql = "DELETE FROM OrderParts WHERE orderId = ? AND partId = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, orderId);
        ps.setInt(2, partId);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
    }
    
    public static void main(String[] args) throws Exception {
        OrderDAO dao = new OrderDAO();
        System.out.println(dao.getOrdersByEmail("tuanlinh3898@gmail.com"));
    }
}
