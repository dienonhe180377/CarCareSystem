package dao;

import entity.CarType;
import entity.Insurance;
import entity.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.sql.Date;

/**
 * DAO cho các thao tác liên quan đến bảng Insurance, User, CarType.
 */
public class InsuranceDAO extends DBConnection {

    /**
     * Lấy danh sách bảo hiểm theo câu SQL truyền vào.
     */
    public Vector<Insurance> getAllInsurance(String sql) {
        Vector<Insurance> listInsurance = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Insurance i = new Insurance(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getInt("carTypeId"),
                        rs.getInt("insuranceTypeId"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate")
                );
                listInsurance.add(i);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listInsurance;
    }

    /**
     * Thêm mới một bảo hiểm vào database.
     */
    public void addInsurance(Insurance i) {
        String sql = "INSERT INTO [dbo].[Insurance] ([userId],[carTypeId],[insuranceTypeId],[startDate],[endDate]) VALUES (?,?,?,?,?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, i.getUserId());
            ptm.setInt(2, i.getCarTypeId());
            ptm.setInt(3, i.getInsuranceTypeId());
            ptm.setDate(4, i.getStartDate());
            ptm.setDate(5, i.getEndDate());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    /**
     * Cập nhật thông tin bảo hiểm theo id.
     */
    public void updateInsurance(Insurance i) {
        String sql = "UPDATE [dbo].[Insurance] SET [userId]=?, [carTypeId]=?, [insuranceTypeId]=?, [startDate]=?, [endDate]=? WHERE id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, i.getUserId());
            ptm.setInt(2, i.getCarTypeId());
            ptm.setInt(3, i.getInsuranceTypeId());
            ptm.setDate(4, i.getStartDate());
            ptm.setDate(5, i.getEndDate());
            ptm.setInt(6, i.getId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    /**
     * Xóa bảo hiểm theo id.
     */
    public void deleteInsurance(int id) {
        String sql = "DELETE FROM [dbo].[Insurance] WHERE id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /**
     * Lấy toàn bộ user (chỉ lấy id và username).
     */
    public Vector<User> getAllUsers() {
        Vector<User> list = new Vector<>();
        String sql = "SELECT id, username FROM [dbo].[User]";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt("id"), rs.getString("username"));
                list.add(u);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy toàn bộ loại xe (chỉ lấy id và name).
     */
    public Vector<CarType> getAllCarTypes() {
        Vector<CarType> list = new Vector<>();
        String sql = "SELECT id, name FROM [dbo].[CarType]";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                CarType c = new CarType(rs.getInt("id"), rs.getString("name"));
                list.add(c);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    /**
     * Tìm bảo hiểm theo id.
     */
    public Insurance searchInsurance(int id) {
        String sql = "SELECT * FROM [dbo].[Insurance] WHERE id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                Insurance i = new Insurance(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getInt("carTypeId"),
                        rs.getInt("insuranceTypeId"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate")
                );
                return i;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy danh sách bảo hiểm theo userId.
     */
    public Vector<Insurance> getInsuranceByUserId(int userId) {
        Vector<Insurance> list = new Vector<>();
        String sql = "SELECT * FROM [dbo].[Insurance] WHERE userId = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, userId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Insurance i = new Insurance(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getInt("carTypeId"),
                        rs.getInt("insuranceTypeId"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate")
                );
                list.add(i);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    /**
     * Đếm tổng số bảo hiểm.
     */
    public int getTotalInsuranceCount() {
        String sql = "SELECT COUNT(*) FROM [dbo].[Insurance]";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy danh sách bảo hiểm theo phân trang.
     */
    public Vector<Insurance> getInsuranceByPage(int page, int pageSize) {
        Vector<Insurance> list = new Vector<>();
        String sql = "SELECT * FROM [dbo].[Insurance] ORDER BY id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, (page - 1) * pageSize);
            ptm.setInt(2, pageSize);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Insurance i = new Insurance(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getInt("carTypeId"),
                        rs.getInt("insuranceTypeId"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate")
                );
                list.add(i);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    /**
     * tìm kiếm theo tên khách hoặc loại xe
     */
    public Vector<Insurance> searchInsuranceByUserOrCarType(String keyword) {
    Vector<Insurance> list = new Vector<>();
    String sql = "SELECT i.* FROM [dbo].[Insurance] i " +
                 "JOIN [dbo].[User] u ON i.userId = u.id " +
                 "JOIN [dbo].[CarType] c ON i.carTypeId = c.id " +
                 "WHERE u.username LIKE ? OR c.name LIKE ?";
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        String likeKeyword = "%" + keyword + "%";
        ptm.setString(1, likeKeyword);
        ptm.setString(2, likeKeyword);
        ResultSet rs = ptm.executeQuery();
        while (rs.next()) {
            Insurance i = new Insurance(
                rs.getInt("id"),
                rs.getInt("userId"),
                rs.getInt("carTypeId"),
                rs.getInt("insuranceTypeId"),
                rs.getDate("startDate"),
                rs.getDate("endDate")
            );
            list.add(i);
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return list;
}
//    lấy role của user
    public Vector<User> getUsersByRole(String role) {
    Vector<User> list = new Vector<>();
    String sql = "SELECT id, username, role FROM [dbo].[User] WHERE LOWER(role) = ?";
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        ptm.setString(1, role.toLowerCase());
        ResultSet rs = ptm.executeQuery();
        while (rs.next()) {
            User u = new User(
                rs.getInt("id"),
                rs.getString("username"),
                rs.getString("role")
            );
            list.add(u);
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return list;
}
}
