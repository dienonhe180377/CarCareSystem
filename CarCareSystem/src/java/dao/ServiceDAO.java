package dao;

import entity.Service;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class ServiceDAO extends DBConnection {

    public Vector<Service> getAllService() {
        Vector<Service> listService = new Vector<>();
        String sql = "SELECT id, name, description, price FROM Service";
        try (PreparedStatement ptm = connection.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
            while (rs.next()) {
                Service se = new Service(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price")
                );
                listService.add(se);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listService;
    }

    public Vector<Service> searchServiceByName(String name) {
        Vector<Service> listService = new Vector<>();
        String sql = "SELECT id, name, description, price FROM Service WHERE name LIKE ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, "%" + name + "%");
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Service se = new Service(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price")
                );
                listService.add(se);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listService;
    }

    public void insertService(Service se) {
        String sql = "INSERT INTO [dbo].[Service] ([name],[description],[price]) VALUES (?,?,?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, se.getName());
            ptm.setString(2, se.getDescription());
            ptm.setDouble(3, se.getPrice());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public Service searchService(int id) {
        String sql = "SELECT id, name, description, price FROM Service WHERE id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                Service se = new Service(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price")
                );
                return se;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public void updateService(Service se) {
        String sql = "UPDATE [dbo].[Service] SET [name] = ?, [description] = ?, [price] = ? WHERE id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, se.getName());
            ptm.setString(2, se.getDescription());
            ptm.setDouble(3, se.getPrice());
            ptm.setInt(4, se.getId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteService(int id) {
        System.out.println("Đang xóa Service id = " + id);
        String sql = "DELETE FROM [dbo].[Service] WHERE id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            int affected = ptm.executeUpdate();
            System.out.println("Số dòng bị xóa: " + affected);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}