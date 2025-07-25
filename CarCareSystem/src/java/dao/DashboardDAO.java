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