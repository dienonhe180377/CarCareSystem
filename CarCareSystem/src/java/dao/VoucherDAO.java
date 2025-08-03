/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Voucher;
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

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt("id"));
                voucher.setName(rs.getString("name"));
                voucher.setDescription(rs.getString("description"));
                voucher.setDiscount(rs.getFloat("discount"));
                voucher.setDiscountType(rs.getString("discountType"));
                voucher.setMaxDiscountAmount(rs.getFloat("maxDiscountAmount"));
                voucher.setMinOrderAmount(rs.getFloat("minOrderAmount"));
                voucher.setStartDate(rs.getTimestamp("startDate")); // ✅ Sửa thành getTimestamp
                voucher.setEndDate(rs.getTimestamp("endDate"));     // ✅ Sửa thành getTimestamp
                voucher.setServiceId(rs.getInt("serviceId"));
                voucher.setCampaignId(rs.getInt("campaignId"));
                voucher.setCreatedDate(rs.getTimestamp("createdDate"));
                voucher.setVoucherCode(rs.getString("voucherCode"));
                voucher.setTotalVoucherCount(rs.getInt("totalVoucherCount")); // ✅ Thêm field bị thiếu
                voucher.setStatus(rs.getString("status"));
                vouchers.add(voucher);
            }

        } catch (SQLException e) {
            System.err.println("Error in getAllVouchers: " + e.getMessage());
            e.printStackTrace();
        }

        return vouchers;
    }

    public Voucher getVoucherById(int id) {
        String sql = "SELECT * FROM Voucher WHERE id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);  // ✅ Set parameter TRƯỚC

            try (ResultSet rs = ps.executeQuery()) {  // ✅ Execute SAU
                if (rs.next()) {
                    Voucher voucher = new Voucher();
                    voucher.setId(rs.getInt("id"));
                    voucher.setName(rs.getString("name"));
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
                    voucher.setVoucherCode(rs.getString("voucherCode"));
                    voucher.setTotalVoucherCount(rs.getInt("totalVoucherCount"));
                    voucher.setStatus(rs.getString("status"));

                    return voucher;
                }
            }

        } catch (SQLException e) {
            System.err.println("Error in getVoucherById: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    public boolean addVoucher(Voucher voucher) {
        String sql = "INSERT INTO Voucher (name, description, discount, discountType, maxDiscountAmount, "
                + "minOrderAmount, startDate, endDate, serviceId, campaignId, voucherCode, totalVoucherCount, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, voucher.getName());
            ps.setString(2, voucher.getDescription());
            ps.setFloat(3, voucher.getDiscount());
            ps.setString(4, voucher.getDiscountType());
            ps.setFloat(5, voucher.getMaxDiscountAmount());
            ps.setFloat(6, voucher.getMinOrderAmount());
            ps.setTimestamp(7, voucher.getStartDate());
            ps.setTimestamp(8, voucher.getEndDate());
            ps.setObject(9, voucher.getServiceId() == 0 ? null : voucher.getServiceId());
            ps.setObject(10, voucher.getCampaignId() == 0 ? null : voucher.getCampaignId());
            ps.setString(11, voucher.getVoucherCode());
            ps.setInt(12, voucher.getTotalVoucherCount());
            ps.setString(13, voucher.getStatus());

            int result = ps.executeUpdate();
            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        voucher.setId(rs.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException e) {
            System.err.println("Error in addVoucher: " + e.getMessage());
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

    public List<Voucher> getVoucherByCampaignId(int campaignId) {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM Voucher WHERE campaignId = ? ORDER BY createdDate DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, campaignId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Voucher voucher = new Voucher();
                    voucher.setId(rs.getInt("id"));
                    voucher.setName(rs.getString("name"));
                    voucher.setDescription(rs.getString("description"));
                    voucher.setVoucherCode(rs.getString("voucherCode"));
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
                    voucher.setStatus(rs.getString("status"));

                    vouchers.add(voucher);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error in getVoucherByCampaignId: " + e.getMessage());
            e.printStackTrace();
        }

        return vouchers;
    }

    public String getServiceNameById(Integer serviceId) {
        if (serviceId == null) {
            return null; // Áp dụng cho tất cả dịch vụ
        }

        String sql = "SELECT name FROM Service WHERE id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, serviceId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting service name by ID " + serviceId + ": " + e.getMessage());
            e.printStackTrace();
        }

        return "Tất cả dịch vụ";
    }

    public String getCampaignNameById(Integer campaignId) {
        if (campaignId == null) {
            return null; // Áp dụng cho tất cả dịch vụ
        }

        String sql = "SELECT name FROM Campaign WHERE id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, campaignId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }

        } catch (SQLException e) {
            System.err.println("Error getting service name by ID " + campaignId + ": " + e.getMessage());
            e.printStackTrace();
        }

        return "Không thuộc campaign nào";
    }

//    public boolean updateVoucher(Voucher voucher) {
//        String sql = "UPDATE Voucher SET name=?, description=?, discount=?, discountType=?, "
//                + "maxDiscountAmount=?, minOrderAmount=?, startDate=?, endDate=?, "
//                + "serviceId=?, campaignId=?, voucherCode=?, totalVoucherCount=?, status=? "
//                + "WHERE id=?";
//
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, voucher.getName());
//            ps.setString(2, voucher.getDescription());
//            ps.setFloat(3, voucher.getDiscount());
//            ps.setString(4, voucher.getDiscountType());
//            ps.setFloat(5, voucher.getMaxDiscountAmount());
//            ps.setFloat(6, voucher.getMinOrderAmount());
//            ps.setTimestamp(7, voucher.getStartDate());
//            ps.setTimestamp(8, voucher.getEndDate());
//            ps.setObject(9, voucher.getServiceId() == 0 ? null : voucher.getServiceId());
//            ps.setObject(10, voucher.getCampaignId() == 0 ? null : voucher.getCampaignId());
//            ps.setString(11, voucher.getVoucherCode());
//            ps.setInt(12, voucher.getTotalVoucherCount());
//            ps.setString(13, voucher.getStatus());
//            ps.setInt(14, voucher.getId());
//
//            return ps.executeUpdate() > 0;
//
//        } catch (SQLException e) {
//            System.err.println("Error in updateVoucher: " + e.getMessage());
//            e.printStackTrace();
//        }
//
//        return false;
//    }
    public List<Voucher> getAvailableVouchers() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM [Voucher] WHERE status = 'ACTIVE' AND startDate <= CURRENT_TIMESTAMP AND endDate >= CURRENT_TIMESTAMP";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Voucher voucher = new Voucher();
                voucher.setId(rs.getInt("id"));
                voucher.setName(rs.getString("name"));
                voucher.setDescription(rs.getString("description"));
                voucher.setVoucherCode(rs.getString("voucherCode"));
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
                voucher.setStatus(rs.getString("status"));

                vouchers.add(voucher);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vouchers;
    }

    public Voucher getVoucherByCode(String code) {
        String sql = "SELECT * FROM [Voucher] WHERE voucher_code = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, code);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Voucher voucher = new Voucher();
                    voucher.setId(rs.getInt("id"));
                    voucher.setName(rs.getString("name"));
                    voucher.setDescription(rs.getString("description"));
                    voucher.setVoucherCode(rs.getString("voucherCode"));
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
                    voucher.setStatus(rs.getString("status"));

                    return voucher;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
}
