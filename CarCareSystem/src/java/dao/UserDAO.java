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
        String sql = "INSERT INTO [User](username, password, email, phone, address, role) VALUES (?, ?, ?, ?, ?, 6)";
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
        return user.getUserRoleStr().equalsIgnoreCase(requiredRole);
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getDate("createDate"),
                        rs.getString("role")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return users;
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
                        rs.getString("role")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean addUser(User user) {
        String sql = "INSERT INTO [User] (username, password, email, phone, "
                + "address, createDate, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setDate(6, new Date(user.getCreatedDate().getTime()));
            ps.setString(7, user.getUserRoleStr());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println(e);
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
            ps.setString(5, user.getUserRoleStr());
            ps.setInt(6, user.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void deleteUser(int id){
        String sql = "DELETE FROM [User] WHERE id = ?";
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch(SQLException e){
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        List<User> allUsers = userDAO.getAllUsers();

        if (allUsers != null && !allUsers.isEmpty()) {
            System.out.println("List of all users:");
            for (User user : allUsers) {
                System.out.println("--------------------");
                System.out.println("ID: " + user.getId());
                System.out.println("Username: " + user.getUsername());
                System.out.println("Password: " + user.getPassword()); // Be cautious when printing passwords
                System.out.println("Email: " + user.getEmail());
                System.out.println("Phone: " + user.getPhone());
                System.out.println("Address: " + user.getAddress());
                System.out.println("Create Date: " + user.getCreatedDate());
                System.out.println("Role: " + user.getUserRoleStr());
            }
            System.out.println("--------------------");
            System.out.println("Total users: " + allUsers.size());
        } else {
            System.out.println("No users found in the database.");
        }
    }
}
