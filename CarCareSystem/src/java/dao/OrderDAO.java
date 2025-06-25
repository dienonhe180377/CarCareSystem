/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author TRAN ANH HAI
 */
public class OrderDAO extends DBConnection {

    public int insertOrder(int userId, int carTypeId, Timestamp createdDate, Timestamp appointmentDate) throws SQLException {
        String sql = "INSERT INTO [Order](userId, carTypeId, createdDate, appointmentDate, price) OUTPUT INSERTED.id VALUES (?, ?, ?, ?, 0)";
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

    // TRUY VẤN DỮ LIỆU CHI TIẾT ĐƠN HÀNG THEO YÊU CẦU (KHÔNG TẠO DTO)
    public List<Map<String, Object>> getOrderDetails() throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql
                = "SELECT "
                + "    o.id AS orderId, "
                + "    u.username, "
                + "    ct.name AS carType, "
                + "    FORMAT(o.appointmentDate, 'yyyy-MM-dd HH:mm') AS appointmentDate, "
                + "    s.name AS serviceName, "
                + "    FORMAT(s.price, 'N0') + N' VNĐ' AS servicePrice, "
                + "    ISNULL(p.name, N'Không có phụ tùng') AS partName, "
                + "    CASE "
                + "        WHEN p.price IS NOT NULL THEN FORMAT(p.price, 'N0') + N' VNĐ' "
                + "        ELSE N'-' "
                + "    END AS partPrice "
                + "FROM [Order] o "
                + "JOIN [User] u ON o.userId = u.id "
                + "JOIN CarType ct ON o.carTypeId = ct.id "
                + "JOIN OrderService os ON o.id = os.orderId "
                + "JOIN Service s ON os.serviceId = s.id "
                + "LEFT JOIN PartsService ps ON s.id = ps.serviceId "
                + "LEFT JOIN Parts p ON ps.partId = p.id "
                + "ORDER BY o.id, s.id;";

        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("orderId", rs.getInt("orderId"));
            row.put("username", rs.getString("username"));
            row.put("carType", rs.getString("carType"));
            row.put("appointmentDate", rs.getString("appointmentDate"));
            row.put("serviceName", rs.getString("serviceName"));
            row.put("servicePrice", rs.getString("servicePrice"));
            row.put("partName", rs.getString("partName"));
            row.put("partPrice", rs.getString("partPrice"));
            list.add(row);
        }
        rs.close();
        st.close();
        return list;
    }
    public List<Map<String, Object>> getOrderDetailsByUsername(String username) throws SQLException {
    List<Map<String, Object>> list = new ArrayList<>();
    String sql = 
            "SELECT "
            + "    o.id AS orderId, "
            + "    u.username, "
            + "    ct.name AS carType, "
            + "    FORMAT(o.appointmentDate, 'yyyy-MM-dd HH:mm') AS appointmentDate, "
            + "    s.name AS serviceName, "
            + "    FORMAT(s.price, 'N0') + N' VNĐ' AS servicePrice, "
            + "    ISNULL(p.name, N'Không có phụ tùng') AS partName, "
            + "    CASE "
            + "        WHEN p.price IS NOT NULL THEN FORMAT(p.price, 'N0') + N' VNĐ' "
            + "        ELSE N'-' "
            + "    END AS partPrice "
            + "FROM [Order] o "
            + "JOIN [User] u ON o.userId = u.id "
            + "JOIN CarType ct ON o.carTypeId = ct.id "
            + "JOIN OrderService os ON o.id = os.orderId "
            + "JOIN Service s ON os.serviceId = s.id "
            + "LEFT JOIN PartsService ps ON s.id = ps.serviceId "
            + "LEFT JOIN Parts p ON ps.partId = p.id "
            + "WHERE u.username = ? "
            + "ORDER BY o.id, s.id;";

    PreparedStatement ps = connection.prepareStatement(sql);
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();
    while (rs.next()) {
        Map<String, Object> row = new HashMap<>();
        row.put("orderId", rs.getInt("orderId"));
        row.put("username", rs.getString("username"));
        row.put("carType", rs.getString("carType"));
        row.put("appointmentDate", rs.getString("appointmentDate"));
        row.put("serviceName", rs.getString("serviceName"));
        row.put("servicePrice", rs.getString("servicePrice"));
        row.put("partName", rs.getString("partName"));
        row.put("partPrice", rs.getString("partPrice"));
        list.add(row);
    }
    rs.close();
    ps.close();
    return list;
}
}
