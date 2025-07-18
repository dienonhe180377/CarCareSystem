/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.UserVoucher;
import entity.Voucher;
import entity.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NTN
 */
public class UserVoucherDAO extends DBConnection {

    /**
     * Lấy tất cả UserVoucher
     */
    public List<UserVoucher> getAllUserVouchers() {
        List<UserVoucher> userVouchers = new ArrayList<>();
        String sql = "SELECT uv.*, v.name as voucherName, v.description, v.discount, v.discountType, "
                + "v.maxDiscountAmount, v.minOrderAmount, v.startDate, v.endDate, v.status as voucherStatus "
                + "FROM UserVoucher uv "
                + "JOIN Voucher v ON uv.voucherId = v.id "
                + "ORDER BY uv.id DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserVoucher uv = new UserVoucher();
                uv.setId(rs.getInt("id"));
                uv.setUserId(rs.getInt("userId"));
                uv.setVoucherId(rs.getInt("voucherId"));
                uv.setVoucherCode(rs.getString("voucherCode"));
                uv.setIsUsed(rs.getBoolean("isUsed"));
                uv.setUsedDate(rs.getTimestamp("usedDate"));
                uv.setOrderId(rs.getInt("orderId"));

                // Set voucher info
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt("voucherId"));
                voucher.setName(rs.getString("voucherName"));
                voucher.setDescription(rs.getString("description"));
                voucher.setDiscount(rs.getFloat("discount"));
                voucher.setDiscountType(rs.getString("discountType"));
                voucher.setMaxDiscountAmount(rs.getFloat("maxDiscountAmount"));
                voucher.setMinOrderAmount(rs.getFloat("minOrderAmount"));
                voucher.setStartDate(rs.getDate("startDate"));
                voucher.setEndDate(rs.getDate("endDate"));
                voucher.setStatus(rs.getBoolean("voucherStatus"));
                uv.setVoucher(voucher);

                userVouchers.add(uv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userVouchers;
    }

    /**
     * Lấy UserVoucher theo userId
     */
    public List<UserVoucher> getUserVouchersByUserId(int userId) {
        List<UserVoucher> userVouchers = new ArrayList<>();
        String sql = "SELECT uv.*, v.name as voucherName, v.description, v.discount, v.discountType, "
                + "v.maxDiscountAmount, v.minOrderAmount, v.startDate, v.endDate, v.status as voucherStatus "
                + "FROM UserVoucher uv "
                + "JOIN Voucher v ON uv.voucherId = v.id "
                + "WHERE uv.userId = ? AND v.status = 1 "
                + "ORDER BY v.endDate ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserVoucher uv = new UserVoucher();
                uv.setId(rs.getInt("id"));
                uv.setUserId(rs.getInt("userId"));
                uv.setVoucherId(rs.getInt("voucherId"));
                uv.setVoucherCode(rs.getString("voucherCode"));
                uv.setIsUsed(rs.getBoolean("isUsed"));
                uv.setUsedDate(rs.getTimestamp("usedDate"));
                uv.setOrderId(rs.getInt("orderId"));

                // Set voucher info
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt("voucherId"));
                voucher.setName(rs.getString("voucherName"));
                voucher.setDescription(rs.getString("description"));
                voucher.setDiscount(rs.getFloat("discount"));
                voucher.setDiscountType(rs.getString("discountType"));
                voucher.setMaxDiscountAmount(rs.getFloat("maxDiscountAmount"));
                voucher.setMinOrderAmount(rs.getFloat("minOrderAmount"));
                voucher.setStartDate(rs.getDate("startDate"));
                voucher.setEndDate(rs.getDate("endDate"));
                voucher.setStatus(rs.getBoolean("voucherStatus"));
                uv.setVoucher(voucher);

                userVouchers.add(uv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userVouchers;
    }

    /**
     * Lấy UserVoucher theo voucherId
     */
    public List<UserVoucher> getUserVouchersByVoucherId(int voucherId) {
        List<UserVoucher> userVouchers = new ArrayList<>();
        String sql = "SELECT uv.* FROM UserVoucher uv WHERE uv.voucherId = ? ORDER BY uv.id DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserVoucher uv = new UserVoucher();
                uv.setId(rs.getInt("id"));
                uv.setUserId(rs.getInt("userId"));
                uv.setVoucherId(rs.getInt("voucherId"));
                uv.setVoucherCode(rs.getString("voucherCode"));
                uv.setIsUsed(rs.getBoolean("isUsed"));
                uv.setUsedDate(rs.getTimestamp("usedDate"));
                uv.setOrderId(rs.getInt("orderId"));

                userVouchers.add(uv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userVouchers;
    }

    /**
     * Thêm UserVoucher mới
     */
    public boolean addUserVoucher(UserVoucher userVoucher) {
        String sql = "INSERT INTO UserVoucher (userId, voucherId, voucherCode, isUsed) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userVoucher.getUserId());
            ps.setInt(2, userVoucher.getVoucherId());
            ps.setString(3, userVoucher.getVoucherCode());
            ps.setBoolean(4, userVoucher.isIsUsed());

            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    userVoucher.setId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Thêm UserVoucher với các tham số cơ bản
     */
    public boolean addUserVoucher(int userId, int voucherId, String voucherCode) {
        String sql = "INSERT INTO UserVoucher (userId, voucherId, voucherCode, isUsed) VALUES (?, ?, ?, 0)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, voucherId);
            ps.setString(3, voucherCode);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Cập nhật UserVoucher
     */
    public boolean updateUserVoucher(UserVoucher userVoucher) {
        String sql = "UPDATE UserVoucher SET userId = ?, voucherId = ?, voucherCode = ?, "
                + "isUsed = ?, usedDate = ?, orderId = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userVoucher.getUserId());
            ps.setInt(2, userVoucher.getVoucherId());
            ps.setString(3, userVoucher.getVoucherCode());
            ps.setBoolean(4, userVoucher.isIsUsed());
            ps.setTimestamp(5, userVoucher.getUsedDate() != null
                    ? new Timestamp(userVoucher.getUsedDate().getTime()) : null);
            ps.setObject(6, userVoucher.getOrderId() == 0 ? null : userVoucher.getOrderId());
            ps.setInt(7, userVoucher.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Đánh dấu voucher đã được sử dụng
     */
    public boolean markVoucherAsUsed(int userVoucherId, int orderId) {
        String sql = "UPDATE UserVoucher SET isUsed = 1, usedDate = GETDATE(), orderId = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userVoucherId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa UserVoucher
     */
    public boolean deleteUserVoucher(int id) {
        String sql = "DELETE FROM UserVoucher WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa tất cả UserVoucher theo voucherId
     */
    public boolean deleteUserVouchersByVoucherId(int voucherId) {
        String sql = "DELETE FROM UserVoucher WHERE voucherId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xóa tất cả UserVoucher theo userId
     */
    public boolean deleteUserVouchersByUserId(int userId) {
        String sql = "DELETE FROM UserVoucher WHERE userId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Lấy UserVoucher theo ID
     */
    public UserVoucher getUserVoucherById(int id) {
        String sql = "SELECT uv.*, v.name as voucherName, v.description, v.discount, v.discountType, "
                + "v.maxDiscountAmount, v.minOrderAmount, v.startDate, v.endDate, v.status as voucherStatus "
                + "FROM UserVoucher uv "
                + "JOIN Voucher v ON uv.voucherId = v.id "
                + "WHERE uv.id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                UserVoucher uv = new UserVoucher();
                uv.setId(rs.getInt("id"));
                uv.setUserId(rs.getInt("userId"));
                uv.setVoucherId(rs.getInt("voucherId"));
                uv.setVoucherCode(rs.getString("voucherCode"));
                uv.setIsUsed(rs.getBoolean("isUsed"));
                uv.setUsedDate(rs.getTimestamp("usedDate"));
                uv.setOrderId(rs.getInt("orderId"));

                // Set voucher info
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt("voucherId"));
                voucher.setName(rs.getString("voucherName"));
                voucher.setDescription(rs.getString("description"));
                voucher.setDiscount(rs.getFloat("discount"));
                voucher.setDiscountType(rs.getString("discountType"));
                voucher.setMaxDiscountAmount(rs.getFloat("maxDiscountAmount"));
                voucher.setMinOrderAmount(rs.getFloat("minOrderAmount"));
                voucher.setStartDate(rs.getDate("startDate"));
                voucher.setEndDate(rs.getDate("endDate"));
                voucher.setStatus(rs.getBoolean("voucherStatus"));
                uv.setVoucher(voucher);

                return uv;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy UserVoucher theo voucherCode và userId
     */
    public UserVoucher getUserVoucherByCodeAndUserId(String voucherCode, int userId) {
        String sql = "SELECT uv.*, v.name as voucherName, v.description, v.discount, v.discountType, "
                + "v.maxDiscountAmount, v.minOrderAmount, v.startDate, v.endDate, v.status as voucherStatus "
                + "FROM UserVoucher uv "
                + "JOIN Voucher v ON uv.voucherId = v.id "
                + "WHERE uv.voucherCode = ? AND uv.userId = ? AND uv.isUsed = 0 AND v.status = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, voucherCode);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                UserVoucher uv = new UserVoucher();
                uv.setId(rs.getInt("id"));
                uv.setUserId(rs.getInt("userId"));
                uv.setVoucherId(rs.getInt("voucherId"));
                uv.setVoucherCode(rs.getString("voucherCode"));
                uv.setIsUsed(rs.getBoolean("isUsed"));
                uv.setUsedDate(rs.getTimestamp("usedDate"));
                uv.setOrderId(rs.getInt("orderId"));

                // Set voucher info
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt("voucherId"));
                voucher.setName(rs.getString("voucherName"));
                voucher.setDescription(rs.getString("description"));
                voucher.setDiscount(rs.getFloat("discount"));
                voucher.setDiscountType(rs.getString("discountType"));
                voucher.setMaxDiscountAmount(rs.getFloat("maxDiscountAmount"));
                voucher.setMinOrderAmount(rs.getFloat("minOrderAmount"));
                voucher.setStartDate(rs.getDate("startDate"));
                voucher.setEndDate(rs.getDate("endDate"));
                voucher.setStatus(rs.getBoolean("voucherStatus"));
                uv.setVoucher(voucher);

                return uv;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Kiểm tra xem user có voucher này không
     */
    public boolean hasUserVoucher(int userId, int voucherId) {
        String sql = "SELECT id FROM UserVoucher WHERE userId = ? AND voucherId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, voucherId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Đếm số lượng voucher chưa sử dụng của user
     */
    public int countUnusedVouchersByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM UserVoucher uv "
                + "JOIN Voucher v ON uv.voucherId = v.id "
                + "WHERE uv.userId = ? AND uv.isUsed = 0 AND v.status = 1 "
                + "AND v.endDate >= GETDATE()";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy danh sách voucher có thể sử dụng của user (chưa dùng, còn hạn)
     */
    public List<UserVoucher> getAvailableVouchersByUserId(int userId) {
        List<UserVoucher> userVouchers = new ArrayList<>();
        String sql = "SELECT uv.*, v.name as voucherName, v.description, v.discount, v.discountType, "
                + "v.maxDiscountAmount, v.minOrderAmount, v.startDate, v.endDate, v.status as voucherStatus "
                + "FROM UserVoucher uv "
                + "JOIN Voucher v ON uv.voucherId = v.id "
                + "WHERE uv.userId = ? AND uv.isUsed = 0 AND v.status = 1 "
                + "AND v.startDate <= GETDATE() AND v.endDate >= GETDATE() "
                + "ORDER BY v.endDate ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserVoucher uv = new UserVoucher();
                uv.setId(rs.getInt("id"));
                uv.setUserId(rs.getInt("userId"));
                uv.setVoucherId(rs.getInt("voucherId"));
                uv.setVoucherCode(rs.getString("voucherCode"));
                uv.setIsUsed(rs.getBoolean("isUsed"));
                uv.setUsedDate(rs.getTimestamp("usedDate"));
                uv.setOrderId(rs.getInt("orderId"));

                // Set voucher info
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt("voucherId"));
                voucher.setName(rs.getString("voucherName"));
                voucher.setDescription(rs.getString("description"));
                voucher.setDiscount(rs.getFloat("discount"));
                voucher.setDiscountType(rs.getString("discountType"));
                voucher.setMaxDiscountAmount(rs.getFloat("maxDiscountAmount"));
                voucher.setMinOrderAmount(rs.getFloat("minOrderAmount"));
                voucher.setStartDate(rs.getDate("startDate"));
                voucher.setEndDate(rs.getDate("endDate"));
                voucher.setStatus(rs.getBoolean("voucherStatus"));
                uv.setVoucher(voucher);

                userVouchers.add(uv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userVouchers;
    }

    /**
     * Lấy danh sách user theo role
     */
    public List<User> getUsersByRole(String role) {
        List<User> users = new ArrayList<>();
        // Sửa từ userRole thành role
        String sql = "SELECT id, username, email, role FROM [User] WHERE role = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setUserRole(rs.getString("role")); // Lấy từ cột 'role'
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    /**
     * Lấy tất cả user
     */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        // Sửa từ userRole thành role để khớp với database
        String sql = "SELECT id, username, email, role FROM [User]";

        System.out.println("=== DEBUG getAllUsers ===");
        System.out.println("SQL: " + sql);

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setUserRole(rs.getString("role")); // Lấy từ cột 'role' nhưng set vào userRole
                users.add(user);

                System.out.println("User found: " + user.getUsername() + " - " + user.getEmail() + " - " + user.getUserRole());
            }
            System.out.println("Total users: " + users.size());
        } catch (SQLException e) {
            System.err.println("Error in getAllUsers: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    /**
     * Lấy thông tin owners của voucher (username và role)
     */
    public List<String> getVoucherOwners(int voucherId) {
        List<String> owners = new ArrayList<>();
        String sql = "SELECT u.username, u.role FROM UserVoucher uv "
                + "JOIN [User] u ON uv.userId = u.id WHERE uv.voucherId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                owners.add(rs.getString("username") + " (" + rs.getString("role") + ")");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return owners;
    }

    /**
     * Lấy user theo ID
     */
    public User getUserById(int userId) {
        String sql = "SELECT id, username, email, role FROM [User] WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setUserRole(rs.getString("role")); // Lấy từ cột 'role'
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
