package dao;

import entity.Service;
import entity.Part;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.util.ArrayList;

public class HomeDAO extends DBConnection {
    // Lấy top 3 dịch vụ nổi bật (bán chạy nhất)
    public Vector<Service> getTop3BestServices() {
        Vector<Service> listService = new Vector<>();
        String sql = "SELECT s.id, s.name, s.description, s.price, s.img, COUNT(os.serviceId) AS soldCount "
                + "FROM Service s "
                + "JOIN OrderService os ON s.id = os.serviceId "
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
                // LẤY VÀ GÁN PHỤ TÙNG CHO TỪNG DỊCH VỤ
                se.setParts(new ArrayList<>(getPartsByServiceId(se.getId())));
                listService.add(se);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listService;
    }
    
    // Lấy danh sách phụ tùng của 1 dịch vụ (dùng bảng PartsService!)
    public Vector<Part> getPartsByServiceId(int serviceId) {
        Vector<Part> parts = new Vector<>();
        String sql = "SELECT p.id, p.name, p.image, p.price " +
                     "FROM Parts p " +
                     "JOIN PartsService ps ON p.id = ps.partId " +
                     "WHERE ps.serviceId = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, serviceId);
            try (ResultSet rs = ptm.executeQuery()) {
                while (rs.next()) {
                    Part part = new Part(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("image"),
                            rs.getDouble("price")
                    );
                    parts.add(part);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return parts;
    }

    // Lấy top 5 phụ tùng nổi bật
    public Vector<Part> getTop5FeaturedParts() {
        Vector<Part> partList = new Vector<>();
        String sql = "SELECT TOP 5 id, name, image, price FROM Parts ORDER BY id DESC";
        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery()) {
            while (rs.next()) {
                Part part = new Part(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getDouble("price")
                );
                partList.add(part);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return partList;
    }
}