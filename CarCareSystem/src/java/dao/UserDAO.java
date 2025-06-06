/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.User;
import java.sql.*;
/**
 *
 * @author TRAN ANH HAI
 */
public class UserDAO extends DBConnection {
    
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
        String sql = "INSERT INTO [User](username, password, email, phone, address, role) VALUES (?, ?, ?, ?, ?, customer)";
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
    
    public User findByUsername(String username) {
        String sql = "SELECT * FROM [User] WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                String user = rs.getString("username");
                String pass = rs.getString("password");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                java.util.Date createdDate = rs.getDate("createDate");
                String userRole = rs.getString("role");

                return new User(id, user, pass, email, phone, address, createdDate, userRole);
            }
        } catch (Exception e) {
            System.out.println("Error in findByUsername: " + e.getMessage());
        }
        return null;
    }

    public User authenticate(String username, String password) {
        User user = findByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    public boolean authorize(User user, String requiredRole) {
        if (user == null || requiredRole == null) {
            return false;
        }
        return user.getUserRole().equalsIgnoreCase(requiredRole);
    }
    
}
