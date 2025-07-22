/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import entity.CarType;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author GIGABYTE
 */
public class CarTypeDAO extends DBConnection {

    public List<CarType> getAllCarTypes() {
        List<CarType> carTypes = new ArrayList<>();
        String sql = "SELECT * FROM CarType";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CarType carType = new CarType();
                carType.setId(rs.getInt("id"));
                carType.setName(rs.getString("name"));
                carType.setStatus(rs.getBoolean("status"));
                carTypes.add(carType);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return carTypes;
    }
    
    public CarType getCarTypeById(int id) {
        String sql = "SELECT * FROM CarType WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                CarType carType = new CarType();
                carType.setId(rs.getInt("id"));
                carType.setName(rs.getString("name"));
                carType.setDescription(rs.getString("description"));
                carType.setStatus(rs.getBoolean("status"));
                carType.setCreatedAt(rs.getTimestamp("created_at"));
                carType.setUpdatedAt(rs.getTimestamp("updated_at"));
                return carType;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean addCarType(CarType carType) {
        String sql = "INSERT INTO CarType (name, description, status, created_at) VALUES (?, ?, ?, GETDATE())";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, carType.getName());
            ps.setString(2, carType.getDescription());
            ps.setBoolean(3, carType.isStatus());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public void update(CarType carType) {
        String sql = "UPDATE CarType SET name = ?, description = ?, status = ?, updated_at = GETDATE() WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, carType.getName());
            ps.setString(2, carType.getDescription());
            ps.setBoolean(3, carType.isStatus());
            ps.setInt(4, carType.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM CarType WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean isNameExists(String name) {
        String sql = "SELECT COUNT(*) FROM CarType WHERE LOWER(name) = LOWER(?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, name.trim());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean isNameExistsForOtherId(String name, int id) {
        String sql = "SELECT COUNT(*) FROM CarType WHERE LOWER(name) = LOWER(?) AND id <> ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, name.trim());
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<CarType> searchAndSortCarTypes(String keyword, String sortBy) {
        List<CarType> list = new ArrayList<>();
        String sql = "SELECT * FROM CarType WHERE name LIKE ?";
        
        if (sortBy != null) {
        switch (sortBy) {
            case "nameAsc":
                sql += " ORDER BY name ASC";
                break;
            case "nameDesc":
                sql += " ORDER BY name DESC";
                break;
            case "createdAtAsc":
                sql += " ORDER BY created_at ASC";
                break;
            case "createdAtDesc":
                sql += " ORDER BY created_at DESC";
                break;
            case "updatedAtDesc":
                sql += " ORDER BY updated_at DESC";
                break;
            }
        }
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + (keyword != null ? keyword : "") + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CarType carType = new CarType();
                carType.setId(rs.getInt("id"));
                carType.setName(rs.getString("name"));
                carType.setDescription(rs.getString("description"));
                carType.setStatus(rs.getBoolean("status"));
                carType.setCreatedAt(rs.getTimestamp("created_at"));
                carType.setUpdatedAt(rs.getTimestamp("updated_at"));
                list.add(carType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}