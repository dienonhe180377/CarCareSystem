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
import java.sql.Date;
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
            ps.setDate(7, new Date(voucher.getStartDate().getTime()));
            ps.setDate(8, new Date(voucher.getEndDate().getTime()));
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

}