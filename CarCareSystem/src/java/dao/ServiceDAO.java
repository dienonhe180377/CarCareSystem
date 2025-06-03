package dao;

import entity.Service;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class ServiceDAO extends DBConnection {

    // Lấy toàn bộ service (không truyền SQL)
    public Vector<Service> getAllService() {
        Vector<Service> listService = new Vector<>();
        String sql = "SELECT id, name, partId, description, price FROM Service";
        try (PreparedStatement ptm = connection.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {
            while (rs.next()) {
                Service se = new Service(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("partId"),
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

    // Tìm kiếm theo name (an toàn, tránh SQL injection)
    public Vector<Service> searchServiceByName(String name) {
        Vector<Service> listService = new Vector<>();
        String sql = "SELECT id, name, partId, description, price FROM Service WHERE name LIKE ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, "%" + name + "%");
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Service se = new Service(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("partId"),
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
        String sql = "INSERT INTO [dbo].[Service]\n"
                + "           ([name]\n"
                + "           ,[partId]\n"
                + "           ,[description]\n"
                + "           ,[price])\n"
                + "       VALUES(?,?,?,?)\n";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, se.getName());
            ptm.setInt(2, se.getPartId());
            ptm.setString(3, se.getDescription());
            ptm.setDouble(4, se.getPrice());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(); // Đã sửa
        }
    }

    public Service searchService(int id) {
        String sql = "SELECT * FROM Service WHERE id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                Service se = new Service(id,
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getDouble(5));
                return se;
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // Đã sửa
        }
        return null;
    }

    public void updateService(Service se) {
        String sql = "UPDATE [dbo].[Service]\n"
                + "   SET [name] = ?\n"
                + "      ,[partId] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[price] = ?\n"
                + " WHERE id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, se.getName());
            ptm.setInt(2, se.getPartId());
            ptm.setString(3, se.getDescription());
            ptm.setDouble(4, se.getPrice());
            ptm.setInt(5, se.getId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace(); // Đã sửa
        }
    }

   public void deleteService(int id) {
    System.out.println("Đang xóa Service id = " + id); // Thêm log này
    String sql = "DELETE FROM [dbo].[Service] WHERE id=?";
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        ptm.setInt(1, id);
        int affected = ptm.executeUpdate();
        System.out.println("Số dòng bị xóa: " + affected); // Thêm log này
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
   }
}