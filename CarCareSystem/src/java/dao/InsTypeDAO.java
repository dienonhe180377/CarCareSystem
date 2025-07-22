package dao;

import entity.InsuranceType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class InsTypeDAO extends DBConnection {

    public Vector<InsuranceType> getAllInsuranceTypes() {
        Vector<InsuranceType> list = new Vector<>();
        String sql = "SELECT * FROM InsuranceType";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                InsuranceType type = new InsuranceType(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price")
                );
                list.add(type);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public void addInsuranceType(InsuranceType type) {
        String sql = "INSERT INTO InsuranceType (name, description, price) VALUES (?, ?, ?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, type.getName());
            ptm.setString(2, type.getDescription());
            ptm.setDouble(3, type.getPrice());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateInsuranceType(InsuranceType type) {
        String sql = "UPDATE InsuranceType SET name=?, description=?, price=? WHERE id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, type.getName());
            ptm.setString(2, type.getDescription());
            ptm.setDouble(3, type.getPrice());
            ptm.setInt(4, type.getId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteInsuranceType(int id) {
        String sql = "DELETE FROM InsuranceType WHERE id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public InsuranceType getInsuranceTypeById(int id) {
        String sql = "SELECT * FROM InsuranceType WHERE id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return new InsuranceType(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public Vector<InsuranceType> searchInsuranceTypeByName(String keyword) {
        Vector<InsuranceType> list = new Vector<>();
        String sql = "SELECT * FROM InsuranceType WHERE LOWER(name) LIKE ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, "%" + keyword.toLowerCase() + "%");
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                InsuranceType type = new InsuranceType(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price")
                );
                list.add(type);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
    public int getTotalInsuranceTypeCount() {
    String sql = "SELECT COUNT(*) FROM InsuranceType";
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        ResultSet rs = ptm.executeQuery();
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return 0;
}
    public Vector<InsuranceType> getInsuranceTypeByPage(int page, int pageSize) {
    Vector<InsuranceType> list = new Vector<>();
    String sql = "SELECT * FROM InsuranceType ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        ptm.setInt(1, (page - 1) * pageSize);
        ptm.setInt(2, pageSize);
        ResultSet rs = ptm.executeQuery();
        while (rs.next()) {
            InsuranceType type = new InsuranceType(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getDouble("price")
            );
            list.add(type);
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return list;
}
}