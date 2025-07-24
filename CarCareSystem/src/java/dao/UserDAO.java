/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author TRAN ANH HAI
 */
public class UserDAO extends DBConnection {

    public User getUserById(int id) {
        String sql = "SELECT * FROM [User] WHERE id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int userId = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                java.util.Date createdDate = rs.getDate("createDate");
                String userRole = rs.getString("role");
                return new User(userId, username, password, email, phone, address, createdDate, userRole);
            }
        } catch (SQLException e) {
            System.out.println("Error in getUserById: " + e.getMessage());
        }
        return null;
    }

    public void updateUser(User user) {
        String sql = "UPDATE [User] SET username = ?, email = ?, phone = ?, address = ? WHERE id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, user.getUsername());
            st.setString(2, user.getEmail());
            st.setString(3, user.getPhone());
            st.setString(4, user.getAddress());
            st.setInt(5, user.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in updateUser: " + e.getMessage());
        }
    }

    public User authenticationUserLogin(String username, String password) {
        String sql = "SELECT *\n"
                + "FROM [User]\n"
                + "WHERE username = ? AND [password] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setUserRole(rs.getString("role"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public User checkUserExist(String username) {
        String sql = "SELECT *\n"
                + "FROM [User]\n"
                + "WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setUserRole(rs.getString("role"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void registerUser(String username, String password, String email, String phone, String address) {
        String sql = "INSERT INTO [User](username, password, email, phone, address, role) VALUES (?, ?, ?, ?, ?, 'customer')";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            st.setString(3, email);
            st.setString(4, phone);
            st.setString(5, address);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT *\n"
                + "FROM [User]\n"
                + "WHERE email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                u.setUserRole(rs.getString("role"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void updatePassword(String email, String password) {
        String sql = "UPDATE [User]\n"
                + "SET password = ?\n"
                + "WHERE Email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, password);
            st.setString(2, email);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<User> getAllUser() {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                java.util.Date createDate = rs.getDate("createDate");
                String role = rs.getString("role");

                userList.add(new User(id, username, password, email, phone, address, createDate, role));
            }
        } catch (Exception e) {
            System.out.println("Error in getAllUser: " + e.getMessage());
        }
        return userList;
    }

    public boolean isUsernameExists(String username, int excludeUserId) {
        String sql = "SELECT id FROM [User] WHERE username = ? AND id <> ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setInt(2, excludeUserId);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error in isUsernameExists: " + e.getMessage());
        }
        return false;
    }

    public boolean isEmailExists(String email, int excludeUserId) {
        String sql = "SELECT id FROM [User] WHERE email = ? AND id <> ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            st.setInt(2, excludeUserId);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error in isEmailExists: " + e.getMessage());
        }
        return false;
    }

    public boolean isPhoneExists(String phone, int excludeUserId) {
        String sql = "SELECT id FROM [User] WHERE phone = ? AND id <> ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, phone);
            st.setInt(2, excludeUserId);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error in isPhoneExists: " + e.getMessage());
        }
        return false;
    }

    public boolean isEmailTaken(String email) {
        String sql = "SELECT 1 FROM [User] WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isPhoneTaken(String phone) {
        String sql = "SELECT 1 FROM [User] WHERE phone = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<User> searchUsersByName(String keyword) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM [User] WHERE username LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + (keyword != null ? keyword : "") + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getDate("createDate"),
                        rs.getString("role")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public boolean addUser(User user) {
        String sql = "INSERT INTO [User] (username, password, email, phone,"
                + " address, createDate, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setDate(6, new java.sql.Date(user.getCreatedDate().getTime()));
            ps.setString(7, user.getUserRole());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("Error in addUser: " + e.getMessage());
        }
        return false;
    }

    public void deleteUser(int id) {
        String sql = "DELETE FROM [User] WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in deleteUser: " + e.getMessage());
        }
    }
}
