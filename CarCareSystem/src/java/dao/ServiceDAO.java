package dao;

import entity.Service;
import entity.Part;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;

public class ServiceDAO extends DBConnection {

    public Vector<Service> getAllService() {
        Vector<Service> listService = new Vector<>();
        String sql = "SELECT id, name, description, price, img FROM Service";
        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery()) {
            while (rs.next()) {
                Service se = new Service(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("img")
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
        String sql = "SELECT id, name, description, price, img FROM Service WHERE name LIKE ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, "%" + name + "%");
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Service se = new Service(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("img")
                );
                listService.add(se);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listService;
    }

    public void insertService(Service se) {
        String sql = "INSERT INTO [dbo].[Service] ([name],[description],[price],[img]) VALUES (?,?,?,?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, se.getName());
            ptm.setString(2, se.getDescription());
            ptm.setDouble(3, se.getPrice());
            ptm.setString(4, se.getImg());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public Service searchService(int id) {
        String sql = "SELECT id, name, description, price, img FROM Service WHERE id=?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, id);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                Service se = new Service(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("img")
                );
                return se;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public void updateService(Service se) {
        String sql = "UPDATE [dbo].[Service] SET [name] = ?, [description] = ?, [price] = ?, [img] = ? WHERE id=?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, se.getName());
            ptm.setString(2, se.getDescription());
            ptm.setDouble(3, se.getPrice());
            ptm.setString(4, se.getImg());
            ptm.setInt(5, se.getId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteService(int id) {
        String sql = "DELETE FROM [dbo].[Service] WHERE id=?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public Vector<Service> getTop3BestSeller() {
        Vector<Service> listService = new Vector<>();
        String sql = "SELECT s.id, s.name, s.description, s.price, s.img, COUNT(o.id) AS soldCount "
                + "FROM Service s "
                + "JOIN [Order] o ON s.id = o.serviceId "
                + "GROUP BY s.id, s.name, s.description, s.price, s.img "
                + "ORDER BY soldCount DESC "
                + "OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY";
        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery()) {
            while (rs.next()) {
                Service se = new Service(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("img")
                );
                // Nếu bạn muốn hiển thị số lượt bán, hãy thêm thuộc tính soldCount vào Service entity
                // se.setSoldCount(rs.getInt("soldCount"));
                listService.add(se);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listService;
    }

    public Vector<Part> getPartsByServiceId(int serviceId) {
        Vector<Part> parts = new Vector<>();
        String sql = "SELECT p.id, p.name, p.price "
                + "FROM Parts p "
                + "JOIN PartsService ps ON p.id = ps.partId "
                + "WHERE ps.serviceId = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, serviceId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Part part = new Part(
                        rs.getInt("id"),
                        rs.getString("name"),
                        null,
                        null,
                        null,
                        rs.getDouble("price")
                );
                parts.add(part);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return parts;
    }

    public Service getServiceDetail(int id) {
        Service se = searchService(id);
        if (se != null) {
            Vector<Part> parts = getPartsByServiceId(id);
            se.setParts(new ArrayList<>(parts));
        }
        return se;
    }
}
