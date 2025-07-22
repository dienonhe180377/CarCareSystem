package dao;

import entity.Service;
import entity.Part;
import entity.Order;
import entity.CarType;
import entity.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

public class ServiceDAO extends DBConnection {

    // ----------- ORDER DETAIL FUNCTIONALITY -----------
    /**
     * Lấy chi tiết đơn hàng (OrderDetail) bao gồm cả User, CarType, Service,
     * Part
     */
    public Order getOrderDetail(int orderId) throws SQLException {
        Order order = null;
        String sql = "SELECT o.id, o.name, o.email, o.phone, o.address, o.createDate, o.appointmentDate, o.price, "
                + "o.paymentStatus, o.orderStatus, o.paymentMethod, "
                + "ct.id AS car_type_id, ct.name AS car_type_name, "
                + "u.id AS user_id, u.username, u.email AS user_email, u.role AS user_role "
                + "FROM [Order] o "
                + "LEFT JOIN CarType ct ON o.carTypeId = ct.id "
                + "LEFT JOIN [User] u ON o.userId = u.id "
                + "WHERE o.id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setName(rs.getString("name"));
                    order.setEmail(rs.getString("email"));
                    order.setPhone(rs.getString("phone"));
                    order.setAddress(rs.getString("address"));
                    order.setCreatedDate(rs.getTimestamp("createDate"));
                    order.setAppointmentDate(rs.getTimestamp("appointmentDate"));
                    order.setPrice(rs.getDouble("price"));
                    order.setPaymentStatus(rs.getString("paymentStatus"));
                    order.setOrderStatus(rs.getString("orderStatus"));
                    order.setPaymentMethod(rs.getString("paymentMethod"));

                    // Set CarType
                    CarType carType = new CarType();
                    carType.setId(rs.getInt("car_type_id"));
                    carType.setName(rs.getString("car_type_name"));
                    order.setCarType(carType);

                    // Set User
                    User user = new User();
                    user.setId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("user_email"));
                    user.setUserRole(rs.getString("user_role"));
                    order.setUser(user);

                    // Set Services & Parts
                    ArrayList<Service> services = getServicesForOrder(orderId);
                    ArrayList<Part> parts = getPartsForOrder(orderId);
                    order.setServices(services);
                    order.setParts(parts);

                    // ----------- TÍNH LẠI TỔNG TIỀN -----------
                    double total = 0;
                    if (services != null) {
                        for (Service sv : services) {
                            double serviceTotal = sv.getPrice();
                            if (sv.getParts() != null) {
                                for (Part p : sv.getParts()) {
                                    serviceTotal += p.getPrice();
                                }
                            }
                            total += serviceTotal;
                        }
                    }
                    if (parts != null) {
                        for (Part pt : parts) {
                            total += pt.getPrice();
                        }
                    }
                    order.setPrice(total);
                }
            }
        }
        return order;
    }

    /**
     * Lấy danh sách Service của một Order
     */
    private ArrayList<Service> getServicesForOrder(int orderId) throws SQLException {
        ArrayList<Service> services = new ArrayList<>();
        String sql = "SELECT s.id, s.name, s.description, s.price, s.img "
                + "FROM OrderService os "
                + "JOIN Service s ON os.serviceId = s.id "
                + "WHERE os.orderId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Service service = new Service(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("description"),
                            rs.getDouble("price"),
                            rs.getString("img")
                    );
                    service.setParts(new ArrayList<>(getPartsByServiceId(service.getId())));
                    services.add(service);
                }
            }
        }
        return services;
    }

    /**
     * Lấy danh sách Part của một Order
     */
    private ArrayList<Part> getPartsForOrder(int orderId) throws SQLException {
        ArrayList<Part> parts = new ArrayList<>();
        String sql = "SELECT p.id, p.name, p.image, p.price "
                + "FROM OrderParts op "
                + "JOIN Parts p ON op.partId = p.id "
                + "WHERE op.orderId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Part part = new Part(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getDouble("price")
                    );
                    parts.add(part);
                }
            }
        }
        return parts;
    }
    // Lấy tất cả Service, mỗi Service đều set đầy đủ parts
    public Vector<Service> getAllService() {
        Vector<Service> listService = new Vector<>();
        String sql = "SELECT id, name, description, price, img FROM Service";
        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery()) {
            while (rs.next()) {
                Service se = new Service(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("img")
                );
                // Set danh sách part cho service
                se.setParts(new ArrayList<>(getPartsByServiceId(se.getId())));
                listService.add(se);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listService;
    }

    // Tìm kiếm Service theo tên, mỗi Service đều set đầy đủ parts
    public Vector<Service> searchServiceByName(String name) {
        Vector<Service> listService = new Vector<>();
        String sql = "SELECT id, name, description, price, img FROM Service WHERE name LIKE ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, "%" + name + "%");
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Service se = new Service(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("img")
                );
                se.setParts(new ArrayList<>(getPartsByServiceId(se.getId())));
                listService.add(se);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listService;
    }

    public int insertServiceAndReturnId(Service se) {
        String sql = "INSERT INTO [dbo].[Service] ([name],[description],[price],[img]) OUTPUT INSERTED.id VALUES (?,?,?,?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, se.getName());
            ptm.setString(2, se.getDescription());
            ptm.setDouble(3, se.getPrice());
            ptm.setString(4, se.getImg());
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    public void insertPartsForService(int serviceId, List<Integer> partIds) {
        String sql = "INSERT INTO PartsService (serviceId, partId) VALUES (?, ?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            for (Integer pid : partIds) {
                ptm.setInt(1, serviceId);
                ptm.setInt(2, pid);
                ptm.addBatch();
            }
            ptm.executeBatch();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updatePartsForService(int serviceId, List<Integer> partIds) {
        String deleteSql = "DELETE FROM PartsService WHERE serviceId = ?";
        try (PreparedStatement ptm = connection.prepareStatement(deleteSql)) {
            ptm.setInt(1, serviceId);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        insertPartsForService(serviceId, partIds);
    }

    public List<Integer> getPartIdsByServiceId(int serviceId) {
        List<Integer> ids = new ArrayList<>();
        String sql = "SELECT partId FROM PartsService WHERE serviceId = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, serviceId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) ids.add(rs.getInt("partId"));
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return ids;
    }

    public void insertService(Service se) {
        String sql = "INSERT INTO [dbo].[Service] ([name],[description],[price],[img]) VALUES (?,?,?,?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, se.getName());
            ptm.setString(2, se.getDescription());
            ptm.setDouble(3, se.getPrice());
            ptm.setString(4, se.getImg());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // LẤY Service THEO ID (chỉ lấy thông tin service, chưa có parts)
    public Service searchService(int id) {
        String sql = "SELECT id, name, description, price, img FROM Service WHERE id=?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, id);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                Service se = new Service(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("img")
                );
                return se;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public void updateService(Service se) {
        String sql = "UPDATE [dbo].[Service] SET [name] = ?, [description] = ?, [price] = ?, [img] = ? WHERE id=?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, se.getName());
            ptm.setString(2, se.getDescription());
            ptm.setDouble(3, se.getPrice());
            ptm.setString(4, se.getImg());
            ptm.setInt(5, se.getId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteService(int id) {
        // 1. Xóa các UserVoucher liên quan đến Voucher của service này
        String sqlUserVoucher = "DELETE uv FROM UserVoucher uv " +
                                "JOIN Voucher v ON uv.voucherId = v.id " +
                                "WHERE v.serviceId = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sqlUserVoucher)) {
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        // 2. Xóa các voucher liên quan đến service này
        String sqlVoucher = "DELETE FROM Voucher WHERE serviceId=?";
        try (PreparedStatement ptm = connection.prepareStatement(sqlVoucher)) {
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        // 3. Xóa các liên kết phụ tùng (PartsService)
        String sqlPartsService = "DELETE FROM PartsService WHERE serviceId=?";
        try (PreparedStatement ptm = connection.prepareStatement(sqlPartsService)) {
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        // 4. Xóa các liên kết với OrderService
        String sqlOrderService = "DELETE FROM OrderService WHERE serviceId=?";
        try (PreparedStatement ptm = connection.prepareStatement(sqlOrderService)) {
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        // 5. Xóa service khỏi bảng Service
        String sql = "DELETE FROM [dbo].[Service] WHERE id=?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    // Lấy danh sách Part liên quan đến 1 Service
    public Vector<Part> getPartsByServiceId(int serviceId) {
        Vector<Part> parts = new Vector<>();
        String sql = "SELECT p.id, p.name, p.image, p.price "
                + "FROM Parts p "
                + "JOIN PartsService ps ON p.id = ps.partId "
                + "WHERE ps.serviceId = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, serviceId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Part part = new Part(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getDouble("price")
                );
                parts.add(part);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return parts;
    }

    // Lấy chi tiết Service và danh sách Part liên quan
    public Service getServiceDetail(int id) {
        Service se = searchService(id);
        if (se != null) {
            se.setParts(new ArrayList<>(getPartsByServiceId(id)));
        }
        return se;
    }
    
    // Đếm tổng số dịch vụ (có hỗ trợ tìm kiếm)
    public int countAllServices(String searchName) {
        String sql = "SELECT COUNT(*) FROM Service";
        boolean hasSearch = searchName != null && !searchName.trim().isEmpty();
        if (hasSearch) {
            sql += " WHERE name LIKE ?";
        }
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            if (hasSearch) {
                ptm.setString(1, "%" + searchName + "%");
            }
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    // Lấy danh sách dịch vụ phân trang (có hỗ trợ tìm kiếm), mỗi service đều set đầy đủ parts
    public Vector<Service> getServicesPaging(int page, int pageSize, String searchName) {
        Vector<Service> listService = new Vector<>();
        int offset = (page - 1) * pageSize;
        boolean hasSearch = searchName != null && !searchName.trim().isEmpty();
        String sql = "SELECT id, name, description, price, img FROM Service";
        if (hasSearch) {
            sql += " WHERE name LIKE ?";
        }        
        // Đảm bảo thứ tự tăng dần của ID
        sql += " ORDER BY id ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            int paramIdx = 1;
            if (hasSearch) {
                ptm.setString(paramIdx++, "%" + searchName + "%");
            }
            ptm.setInt(paramIdx++, offset);
            ptm.setInt(paramIdx, pageSize);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Service se = new Service(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("img")
                );
                // Set parts cho từng service để có thể dùng getTotalPriceWithParts()
                se.setParts(new ArrayList<>(getPartsByServiceId(se.getId())));
                listService.add(se);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listService;
    }
    
    // Lay price theo id
        public double getPriceById(int serviceId) throws SQLException {
            String sql = "SELECT price FROM Service WHERE id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("price");
            }
            return 0;
        }
        
     public Vector<Part> getAllParts() {
        Vector<Part> parts = new Vector<>();
        String sql = "SELECT id, name, image, price FROM Parts";
        try (PreparedStatement ptm = connection.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
            while (rs.next()) {
                Part part = new Part(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getDouble("price")
                );
                parts.add(part);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return parts;
    }
}
