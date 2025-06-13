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
    
    public User getUserById(int id) {
        String sql = "SELECT * FROM [User] WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("email"),    
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getDate("createDate"),
                    rs.getString("role"));
            }
        } catch (Exception e) {
            System.out.println("Error in getUserById: " + e.getMessage());
        }
        return null;
    }
    
    public boolean addUser(User user){
        String sql = "INSERT INTO [User] (username, password, email, phone,"
                + " address, createDate, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try(PreparedStatement ps = connection.prepareStatement(sql)){
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
    
    public void updateUser(User user) {
        String sql = "UPDATE [User] SET username=?, email=?, phone=?, address=?, role=? WHERE id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getUserRole());
            ps.setInt(6, user.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in updateUser: " + e.getMessage());
        }
    }
    
    public void deleteUser(int id){
        String sql = "DELETE FROM [User] WHERE id = ?";
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch(SQLException e){
            System.out.println("Error in deleteUser: " + e.getMessage());
        }
    }
}
