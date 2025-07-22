package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

public class DashboardDAO extends DBConnection {

    // Tổng số khách hàng (role = 'customer')
    public int getTotalCustomerCount() {
        String sql = "SELECT COUNT(*) FROM [User] WHERE role = 'customer'";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    // Tổng số đơn hàng
    public int getTotalOrderCount() {
        String sql = "SELECT COUNT(*) FROM [Order]";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    // Tổng doanh thu đơn hàng
    public double getTotalOrderRevenue() {
        String sql = "SELECT SUM(price) FROM [Order]";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    // Tổng số bảo hiểm đã bán
    public int getTotalInsuranceCount() {
        String sql = "SELECT COUNT(*) FROM Insurance";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    // Tổng doanh thu bảo hiểm
    public double getTotalInsuranceRevenue() {
        String sql = "SELECT SUM(t.price) FROM Insurance i JOIN InsuranceType t ON i.insuranceTypeId = t.id";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }
    public double getOrderRevenueBetween(String fromDate, String toDate) {
    String sql = "SELECT SUM(price) FROM [Order] WHERE createDate >= ? AND createDate < ?";
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        ptm.setString(1, fromDate);
        ptm.setString(2, toDate);
        ResultSet rs = ptm.executeQuery();
        if (rs.next()) return rs.getDouble(1);
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return 0;
}
    public double getInsuranceRevenueBetween(String fromDate, String toDate) {
    String sql = "SELECT SUM(t.price) FROM Insurance i " +
                 "JOIN InsuranceType t ON i.insuranceTypeId = t.id " +
                 "WHERE i.startDate >= ? AND i.startDate < ?";
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        ptm.setString(1, fromDate);
        ptm.setString(2, toDate);
        ResultSet rs = ptm.executeQuery();
        if (rs.next()) return rs.getDouble(1);
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return 0;
}
public int getTotalOrderCount(LocalDate fromDate) {
    String sql = "SELECT COUNT(*) FROM [Order]";
    if (fromDate != null) {
        sql += " WHERE createDate >= ?";
    }
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        if (fromDate != null) {
            stmt.setDate(1, java.sql.Date.valueOf(fromDate));
        }
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) return rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

public double getTotalOrderRevenue(LocalDate fromDate) {
    String sql = "SELECT SUM(price) FROM [Order]";
    if (fromDate != null) {
        sql += " WHERE createDate >= ?";
    }
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        if (fromDate != null) {
            stmt.setDate(1, java.sql.Date.valueOf(fromDate));
        }
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) return rs.getDouble(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

public int getTotalInsuranceCount(LocalDate fromDate) {
    String sql = "SELECT COUNT(*) FROM [Insurance]";
    if (fromDate != null) {
        sql += " WHERE startDate >= ?";
    }
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        if (fromDate != null) {
            stmt.setDate(1, java.sql.Date.valueOf(fromDate));
        }
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) return rs.getInt(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

public double getTotalInsuranceRevenue(LocalDate fromDate) {
    String sql = "SELECT SUM(price) FROM [Insurance] JOIN InsuranceType ON Insurance.insuranceTypeId = InsuranceType.id";
    if (fromDate != null) {
        sql += " WHERE startDate >= ?";
    }
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        if (fromDate != null) {
            stmt.setDate(1, java.sql.Date.valueOf(fromDate));
        }
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) return rs.getDouble(1);
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

}