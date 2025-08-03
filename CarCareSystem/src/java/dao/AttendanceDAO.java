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


    public Vector<User> getAllUsersForAttendance() {
        Vector<User> list = new Vector<>();
        String sql = "SELECT id, username, role FROM [dbo].[User] WHERE role IN ('repairer','marketing','warehouse manager')";
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

}
