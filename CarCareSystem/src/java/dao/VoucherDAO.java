/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import entity.Voucher;
import entity.UserVoucher;
import entity.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author NTN
 */
public class VoucherDAO extends DBConnection {
    
    public List<Voucher> getAllVouchers() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM Voucher ORDER BY createdDate DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt("id"));
                voucher.setName(rs.getString("name"));
                voucher.setDescription(rs.getString("description"));
                voucher.setDiscount(rs.getFloat("discount"));
                voucher.setDiscountType(rs.getString("discountType"));
                voucher.setMaxDiscountAmount(rs.getFloat("maxDiscountAmount"));
                voucher.setMinOrderAmount(rs.getFloat("minOrderAmount"));
                voucher.setStartDate(rs.getDate("startDate"));
                voucher.setEndDate(rs.getDate("endDate"));
                voucher.setServiceId(rs.getInt("serviceId"));
                voucher.setCampaignId(rs.getInt("campaignId"));
                voucher.setStatus(rs.getBoolean("status"));
                voucher.setCreatedDate(rs.getTimestamp("createdDate"));
                voucher.setVoucherCode(rs.getString("voucherCode"));
                vouchers.add(voucher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vouchers;
    }
    
    public Voucher getVoucherById(int id) {
        String sql = "SELECT * FROM Voucher WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt("id"));
                voucher.setName(rs.getString("name"));
                voucher.setDescription(rs.getString("description"));
                voucher.setDiscount(rs.getFloat("discount"));
                voucher.setDiscountType(rs.getString("discountType"));
                voucher.setMaxDiscountAmount(rs.getFloat("maxDiscountAmount"));
                voucher.setMinOrderAmount(rs.getFloat("minOrderAmount"));
                voucher.setStartDate(rs.getDate("startDate"));
                voucher.setEndDate(rs.getDate("endDate"));
                voucher.setServiceId(rs.getInt("serviceId"));
                voucher.setCampaignId(rs.getInt("campaignId"));
                voucher.setStatus(rs.getBoolean("status"));
                voucher.setCreatedDate(rs.getTimestamp("createdDate"));
                voucher.setVoucherCode(rs.getString("voucherCode"));
                return voucher;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addVoucher(Voucher voucher) {
        String sql = "INSERT INTO Voucher (name, description, discount, discountType, maxDiscountAmount, " +
                    "minOrderAmount, startDate, endDate, serviceId, campaignId, status, voucherCode) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, voucher.getName());
            ps.setString(2, voucher.getDescription());
            ps.setFloat(3, voucher.getDiscount());
            ps.setString(4, voucher.getDiscountType());
            ps.setFloat(5, voucher.getMaxDiscountAmount());
            ps.setFloat(6, voucher.getMinOrderAmount());
            ps.setDate(7, new java.sql.Date(voucher.getStartDate().getTime()));
            ps.setDate(8, new java.sql.Date(voucher.getEndDate().getTime()));
            ps.setObject(9, voucher.getServiceId() == 0 ? null : voucher.getServiceId());
            ps.setObject(10, voucher.getCampaignId() == 0 ? null : voucher.getCampaignId());
            ps.setBoolean(11, voucher.isStatus());
            ps.setString(12, voucher.getVoucherCode());
            
            int result = ps.executeUpdate();
            if (result > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    voucher.setId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteVoucher(int voucherId) {
        try {
            connection.setAutoCommit(false);
            
            // Xóa UserVoucher trước
            String deleteUserVoucherSql = "DELETE FROM UserVoucher WHERE voucherId = ?";
            try (PreparedStatement ps = connection.prepareStatement(deleteUserVoucherSql)) {
                ps.setInt(1, voucherId);
                ps.executeUpdate();
            }
            
            // Xóa Voucher
            String deleteVoucherSql = "DELETE FROM Voucher WHERE id = ?";
            try (PreparedStatement ps = connection.prepareStatement(deleteVoucherSql)) {
                ps.setInt(1, voucherId);
                int result = ps.executeUpdate();
                
                connection.commit();
                return result > 0;
            }
        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
    
    public boolean isVoucherCodeExists(String voucherCode) {
        String sql = "SELECT id FROM Voucher WHERE voucherCode = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, voucherCode);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public void addUserVoucher(int userId, int voucherId, String voucherCode) {
        String sql = "INSERT INTO UserVoucher (userId, voucherId, voucherCode, isUsed) VALUES (?, ?, ?, 0)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, voucherId);
            ps.setString(3, voucherCode);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, username, email, Role FROM [User]";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setUserRole(rs.getString("Role"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    public List<User> getUsersByRole(String role) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, username, email, Role FROM [User] WHERE Role = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setUserRole(rs.getString("Role"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    public List<String> getVoucherOwners(int voucherId) {
        List<String> owners = new ArrayList<>();
        String sql = "SELECT u.username, u.Role FROM UserVoucher uv " +
                    "JOIN [User] u ON uv.userId = u.id WHERE uv.voucherId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                owners.add(rs.getString("username") + " (" + rs.getString("Role") + ")");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return owners;
    }
    
    public List<UserVoucher> getUserVouchersByUserId(int userId) {
        List<UserVoucher> userVouchers = new ArrayList<>();
        String sql = "SELECT uv.*, v.name as voucherName, v.description, v.discount, v.discountType, " +
                    "v.maxDiscountAmount, v.minOrderAmount, v.startDate, v.endDate " +
                    "FROM UserVoucher uv JOIN Voucher v ON uv.voucherId = v.id " +
                    "WHERE uv.userId = ? AND v.status = 1 ORDER BY v.endDate";
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
                uv.setVoucher(voucher);
                
                userVouchers.add(uv);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userVouchers;
    }
}