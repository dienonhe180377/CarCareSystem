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

    // Lấy UserVoucher theo userId
    public List<UserVoucher> getUserVouchersByUserId(int userId) {
        List<UserVoucher> userVouchers = new ArrayList<>();
        String sql = "SELECT uv.*, v.name as voucherName, v.description, v.discount, v.discountType, "
                + "v.maxDiscountAmount, v.minOrderAmount, v.startDate, v.endDate, v.status as voucherStatus, "
                + "v.serviceId, v.campaignId, v.createdDate, v.totalVoucherCount "
                + "FROM UserVoucher uv "
                + "JOIN Voucher v ON uv.voucherId = v.id "
                + "WHERE uv.userId = ? AND v.status = 'ACTIVE' " 
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

                // 🔥 SỬA: Set voucher info với đầy đủ fields
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt("voucherId"));
                voucher.setName(rs.getString("voucherName"));
                voucher.setDescription(rs.getString("description"));
                voucher.setDiscount(rs.getFloat("discount"));
                voucher.setDiscountType(rs.getString("discountType"));
                voucher.setMaxDiscountAmount(rs.getFloat("maxDiscountAmount"));
                voucher.setMinOrderAmount(rs.getFloat("minOrderAmount"));
                voucher.setStartDate(rs.getTimestamp("startDate"));
                voucher.setEndDate(rs.getTimestamp("endDate"));
                voucher.setServiceId(rs.getInt("serviceId"));
                voucher.setCampaignId(rs.getInt("campaignId"));
                voucher.setCreatedDate(rs.getTimestamp("createdDate"));
                voucher.setTotalVoucherCount(rs.getInt("totalVoucherCount"));
                voucher.setStatus(rs.getString("voucherStatus")); 

                uv.setVoucher(voucher);
                userVouchers.add(uv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userVouchers;
    }

    //Thêm UserVoucher với các tham số cơ bản
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

    // Lấy danh sách user theo role
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

    // Lấy tất cả user
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

    // Lấy thông tin owners của voucher (username và role)
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

    // Check user đã lấy voucher này chưa
    public boolean hasUserClaimedVoucher(int userId, int voucherId) {
        String sql = "SELECT 1 FROM UserVoucher WHERE userId = ? AND voucherId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, voucherId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Có record = đã claim
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Check user đã dùng voucher chưa
    public boolean hasUserUsedVoucher(int userId, int voucherId) {
        String sql = "SELECT 1 FROM UserVoucher WHERE userId = ? AND voucherId = ? AND isUsed = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, voucherId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Có record với isUsed = 1 = đã dùng
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
