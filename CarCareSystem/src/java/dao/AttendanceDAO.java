package dao;

import entity.Attendance;
import entity.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.Vector;

/**
 *
 * @author ADMIN
 */
public class AttendanceDAO extends DBConnection {

    public Vector<Attendance> getAllAttendance(String sql) {
        Vector<Attendance> list = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Attendance att = new Attendance(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getDate("date"),
                        rs.getBoolean("status")
                );
                list.add(att);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public void addAttendance(Attendance att) {
        String sql = "INSERT INTO [dbo].[Attendance] ([userId], [date], [status]) VALUES (?, ?, ?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, att.getUserId());
            ptm.setDate(2, att.getDate());
            ptm.setBoolean(3, att.isStatus());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateAttendance(Attendance att) {
        String sql = "UPDATE [dbo].[Attendance] SET [userId] = ?, [date] = ?, [status] = ? WHERE id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, att.getUserId());
            ptm.setDate(2, att.getDate());
            ptm.setBoolean(3, att.isStatus());
            ptm.setInt(4, att.getId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteAttendance(int id) {
        String sql = "DELETE FROM [dbo].[Attendance] WHERE id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public Attendance searchAttendance(int id) {
        String sql = "SELECT * FROM [dbo].[Attendance] WHERE id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                Attendance att = new Attendance(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getDate("date"),
                        rs.getBoolean("status")
                );
                return att;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public Vector<User> getAllUsers() {
        Vector<User> list = new Vector<>();
        String sql = "SELECT id, username FROM [dbo].[User] WHERE role = 'customer'";
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

    public Vector<User> getAllUsersForAttendance() {
        Vector<User> list = new Vector<>();
        String sql = "SELECT id, username, role FROM [dbo].[User] WHERE role IN ('admin','manager','repairer','warehouse manager','marketing')";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt("id"), rs.getString("username"), rs.getString("role"));
                list.add(u);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Vector<Attendance> getAttendanceByUserId(int userId) {
        Vector<Attendance> list = new Vector<>();
        String sql = "SELECT * FROM [dbo].[Attendance] WHERE userId = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, userId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Attendance att = new Attendance(
                        rs.getInt("id"),
                        rs.getInt("userId"),
                        rs.getDate("date"),
                        rs.getBoolean("status")
                );
                list.add(att);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
    public Attendance getAttendanceByUserIdAndDate(int userId, Date date) {
    String sql = "SELECT * FROM [dbo].[Attendance] WHERE userId = ? AND date = ?";
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        ptm.setInt(1, userId);
        ptm.setDate(2, date);
        ResultSet rs = ptm.executeQuery();
        if (rs.next()) {
            return new Attendance(
                rs.getInt("id"),
                rs.getInt("userId"),
                rs.getDate("date"),
                rs.getBoolean("status")
            );
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return null;
}
    public Vector<Attendance> getAttendanceByDate(Date date) {
    Vector<Attendance> list = new Vector<>();
    String sql = "SELECT * FROM [dbo].[Attendance] WHERE CAST(date AS DATE) = ?";
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        ptm.setDate(1, date);
        ResultSet rs = ptm.executeQuery();
        while (rs.next()) {
            Attendance att = new Attendance(
                rs.getInt("id"),
                rs.getInt("userId"),
                rs.getDate("date"),
                rs.getBoolean("status")
            );
            list.add(att);
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return list;
}

    public Vector<Attendance> getAttendanceForUser(int userId, String role, Date date) {
    Vector<Attendance> list = new Vector<>();
    String sql = "";
    
    if (role.equals("admin") || role.equals("manager")) {
        // Nếu là admin hoặc manager, lấy tất cả các điểm danh
        sql = "SELECT * FROM [dbo].[Attendance] WHERE date = ?";
    } else {
        // Nếu là người dùng khác, chỉ lấy điểm danh của chính họ
        sql = "SELECT * FROM [dbo].[Attendance] WHERE userId = ? AND date = ?";
    }
    
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        ptm.setDate(1, date); // Lọc theo ngày
        if (!(role.equals("admin") || role.equals("manager"))) {
            ptm.setInt(2, userId); // Nếu không phải admin/manager thì lọc theo userId
        }
        
        ResultSet rs = ptm.executeQuery();
        while (rs.next()) {
            Attendance att = new Attendance(
                    rs.getInt("id"),
                    rs.getInt("userId"),
                    rs.getDate("date"),
                    rs.getBoolean("status")
            );
            list.add(att);
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return list;
}
}
