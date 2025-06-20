package dao;

import entity.Feedback;
import java.sql.*;
import java.util.Vector;

public class FeedbackDAO extends DBConnection {

    public void addFeedback(int userId, String description) {
        String sql = "INSERT INTO Feedback (userId, description, createDate) VALUES (?, ?, GETDATE())";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, description);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public Vector<Feedback> getAllFeedback() {
        Vector<Feedback> list = new Vector<>();
        String sql = "SELECT * FROM Feedback ORDER BY createDate DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback fb = new Feedback(
                    rs.getInt("id"),
                    rs.getInt("userId"),
                    rs.getString("description"),
                    rs.getTimestamp("createDate")
                );
                list.add(fb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    // ...existing code...
public String getUsernameByUserId(int userId) {
    String sql = "SELECT username FROM [User] WHERE id = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getString("username");
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return "Unknown";
}
public void deleteFeedback(int id) {
    String sql = "DELETE FROM Feedback WHERE id = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}

public void updateFeedback(int id, String description) {
    String sql = "UPDATE Feedback SET description = ? WHERE id = ?";
    try {
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, description);
        ps.setInt(2, id);
        ps.executeUpdate();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
}
}