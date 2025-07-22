    package dao;

    import entity.Feedback;
    import java.sql.*;
    import java.util.Vector;

    public class FeedbackDAO extends DBConnection {

        public void addFeedback(int userId, int serviceId, String description, int rating) {
        String sql = "INSERT INTO Feedback (userId, serviceId, description, rating, createDate) VALUES (?, ?, ?, ?, GETDATE())";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, serviceId);
            ps.setString(3, description);
            ps.setInt(4, rating);
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
                int userId = rs.getInt("userId");
                String username = getUsernameByUserId(userId);
                int serviceId = rs.getInt("serviceId");
    String serviceName = getServiceNameByServiceId(serviceId);
    Feedback fb = new Feedback(
        rs.getInt("id"),
        userId,
        serviceId,
        rs.getString("description"),
        rs.getInt("rating"),
        rs.getTimestamp("createDate"),
        username,
        serviceName
    );
                list.add(fb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }


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

        public void updateFeedback(int id, String description, int rating) {
        String sql = "UPDATE Feedback SET description = ?, rating = ? WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, description);
            ps.setInt(2, rating);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

        public Feedback getFeedbackById(int id) {
        String sql = "SELECT * FROM Feedback WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("userId");
                String username = getUsernameByUserId(userId);
                return new Feedback(
                    rs.getInt("id"),
                    userId,
                    rs.getInt("serviceId"),
                    rs.getString("description"),
                    rs.getInt("rating"),
                    rs.getTimestamp("createDate"),
                    username
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }
    public Vector<Feedback> getFeedbackByServiceId(int serviceId) {
        Vector<Feedback> list = new Vector<>();
        String sql = "SELECT * FROM Feedback WHERE serviceId = ? ORDER BY createDate DESC";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt("userId");
                String username = getUsernameByUserId(userId);
                Feedback fb = new Feedback(
                    rs.getInt("id"),
                    userId,
                    serviceId,
                    rs.getString("description"),
                    rs.getInt("rating"),
                    rs.getTimestamp("createDate"),
                    username
                );
                list.add(fb);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    public String getServiceNameByServiceId(int serviceId) {
        String sql = "SELECT name FROM Service WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, serviceId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return "Unknown Service";
    }
    }