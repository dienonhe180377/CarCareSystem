/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Category;
import entity.Part;
import entity.Service;
import entity.Size;
import entity.Supplier;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Admin
 */
public class PartDAO extends DBConnection {

    private CategoryDAO categoryDAO = new CategoryDAO();
    private SupplierDAO supplierDAO = new SupplierDAO();
    

    //Get All Part
    public ArrayList<Part> getAllPart() throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "select * from Parts";
        ArrayList<Part> partList = new ArrayList<>();
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                ArrayList<Service> services = getAllServiceByPartId(id);
                int categoryId = rs.getInt("categoryId");
                Category category = categoryDAO.getCategoryById(categoryId);
                ArrayList<Supplier> suppliers = getAllSupplierByPartId(id);
                ArrayList<Size> sizeList = getAllSizeByPartId(id);
                double price = rs.getDouble("price");
                partList.add(new Part(id, name, image, services, category, suppliers, sizeList, price));
            }
            return partList;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Get All Service By Part Id
    public ArrayList<Service> getAllServiceByPartId(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT sv.id AS serviceId ,sv.name AS ServiceName, sv.description as serviceDes , sv.price as servicePrice\n"
                + "FROM PartsService ps\n"
                + "INNER JOIN Service sv\n"
                + "ON ps.serviceId = sv.id\n"
                + "INNER JOIN Parts pr\n"
                + "ON ps.partId = pr.id\n"
                + "where partId = " + id;
        ArrayList<Service> serviceList = new ArrayList<>();
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int serviceId = rs.getInt("serviceId");
                String name = rs.getString("ServiceName");
                String description = rs.getString("serviceDes");
                double price = rs.getDouble("servicePrice");
                serviceList.add(new Service(serviceId, name, description, price));
            }
            return serviceList;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Get All Supplier By Part Id
    public ArrayList<Supplier> getAllSupplierByPartId(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT sp.*\n"
                + "FROM PartsSupplier ps\n"
                + "INNER JOIN Supplier sp\n"
                + "ON ps.supplierId = sp.id\n"
                + "INNER JOIN Parts pr\n"
                + "ON ps.partId = pr.id\n"
                + "where partId = " + id;
        ArrayList<Supplier> supplierList = new ArrayList<>();
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int supId = rs.getInt("id");
                String name = rs.getString("name");
                String logo = rs.getString("logo");
                String description = rs.getString("description");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                supplierList.add(new Supplier(supId, name, logo, description, email, phone, address));
            }
            return supplierList;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Get All Size By Part Id
    public ArrayList<Size> getAllSizeByPartId(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "select * from Size where partId = " + id;
        ArrayList<Size> sizeList = new ArrayList<>();
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int sizeId = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                int quantity = rs.getInt("quantity");
                sizeList.add(new Size(sizeId, name, status, quantity));
            }
            return sizeList;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Get All Part By Text
    public ArrayList<Part> getAllPartByText(String text) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "select * from Parts where name COLLATE Latin1_General_CI_AI like '%" + text + "%'";
        ArrayList<Part> partList = new ArrayList<>();
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                ArrayList<Service> services = getAllServiceByPartId(id);
                int categoryId = rs.getInt("categoryId");
                Category category = categoryDAO.getCategoryById(categoryId);
                ArrayList<Supplier> suppliers = getAllSupplierByPartId(id);
                ArrayList<Size> sizeList = getAllSizeByPartId(id);
                double price = rs.getDouble("price");
                partList.add(new Part(id, name, image, services, category, suppliers, sizeList, price));
            }
            return partList;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Add Part
    public int addPart(String name, String image, int categoryId, double price) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "INSERT INTO Parts (name, image, categoryId, price) VALUES\n"
                + "  (?, ? , ?, ?)";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, name);
            pre.setString(2, image);
            pre.setInt(3, categoryId);
            pre.setDouble(4, price);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            return 0;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    //Add PartSupplier
    public int addPartSupplier(int partId, String[] suppliers) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        String sql = "";

        if (suppliers.length == 1) {
            sql = "INSERT INTO PartsSupplier (partId, supplierId) VALUES\n"
                    + "  ( " + partId + " ,  " + suppliers[0] + ")";
        } else if (suppliers.length == 2) {
            sql = "INSERT INTO PartsSupplier (partId, supplierId) VALUES\n"
                    + "  ( " + partId + " ,  " + suppliers[0] + "),\n"
                    + "  ( " + partId + " ,  " + suppliers[1] + ")\n";
        } else if (suppliers.length == 3) {
            sql = "INSERT INTO PartsSupplier (partId, supplierId) VALUES\n"
                    + "  ( " + partId + " ,  " + suppliers[0] + "),\n"
                    + "  ( " + partId + " ,  " + suppliers[1] + "),\n"
                    + "  ( " + partId + " ,  " + suppliers[2] + ")\n";
        } else if (suppliers.length == 4) {
            sql = "INSERT INTO PartsSupplier (partId, supplierId) VALUES\n"
                    + "  ( " + partId + " ,  " + suppliers[0] + "),\n"
                    + "  ( " + partId + " ,  " + suppliers[1] + "),\n"
                    + "  ( " + partId + " ,  " + suppliers[2] + "),\n"
                    + "  ( " + partId + " ,  " + suppliers[3] + ")\n";
        } else {
            sql = "INSERT INTO PartsSupplier (partId, supplierId) VALUES\n"
                    + "  ( " + partId + " ,  " + suppliers[0] + "),\n"
                    + "  ( " + partId + " ,  " + suppliers[1] + "),\n"
                    + "  ( " + partId + " ,  " + suppliers[2] + "),\n"
                    + "  ( " + partId + " ,  " + suppliers[3] + "),\n"
                    + "  ( " + partId + " ,  " + suppliers[4] + ")\n";
        }
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            return 0;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    //Add PartSize
    public int addPartSize(String name, int partId, boolean status, int quantity) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        String sql = "INSERT INTO Size (name, partId, quantity, status) VALUES\n"
                + " (?,  ?,   ?,  ?)";

        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, name);
            pre.setInt(2, partId);
            pre.setInt(3, quantity);
            pre.setBoolean(4, status);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            return 0;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    //Get Part By Id
    public Part getPartById(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "select * from Parts where id = " + id;
        Part part = null;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                String name = rs.getString("name");
                String image = rs.getString("image");
                ArrayList<Service> services = getAllServiceByPartId(id);
                int categoryId = rs.getInt("categoryId");
                Category category = categoryDAO.getCategoryById(categoryId);
                ArrayList<Supplier> suppliers = getAllSupplierByPartId(id);
                ArrayList<Size> sizeList = getAllSizeByPartId(id);
                double price = rs.getDouble("price");
                part = new Part(id, name, image, services, category, suppliers, sizeList, price);
            }
            return part;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Edit Part
    public int editPart(int id, String name, String image, int categoryId, double price) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = " UPDATE Parts\n"
                + "SET \n"
                + "    name       = ?,   \n"
                + "    image      = ?,    \n"
                + "    categoryId = ?, \n"
                + "    price      = ?       \n"
                + "WHERE\n"
                + "    id         = ?;";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, name);
            pre.setString(2, image);
            pre.setInt(3, categoryId);
            pre.setDouble(4, price);
            pre.setInt(5, id);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            return 0;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    //Delete A PartSupplier
    public int deletePartSupplier(int partId, int supplierId) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "delete from PartsSupplier where partId = ? and supplierId = ?";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, partId);
            pre.setInt(2, supplierId);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            throw e;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }
    
    //Delete A PartSupplier By PartId
    public int deletePartSupplierByPartId(int partId) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "delete from PartsSupplier where partId = ?";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, partId);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            throw e;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    //Get All Part Supplier
    public int getAllPartSupplier(int partId, int supplierId) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "select * from PartsSupplier where partId = ? and supplierId = ?";
        int check = 0;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, partId);
            pre.setInt(2, supplierId);
            rs = pre.executeQuery();
            while (rs.next()) {
                check++;
            }
            return check;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Add Single PartSupplier
    public int addSinglePartSupplier(int partId, int supplierId) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        String sql = "INSERT INTO PartsSupplier (partId, supplierId) VALUES\n"
                + "  ( ?,  ?)";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, partId);
            pre.setInt(2, supplierId);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            return 0;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    //Delete A Size
    public int deleteSizeById(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "delete from Size where id = ?";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            throw e;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }
    
    //Delete A Size By Part Id
    public int deleteSizeByPartId(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "delete from Size where partId = ?";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            throw e;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    //Get All Size By Id
    public int getAllSizeById(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "select * from Size where id = " + id;
        int check = 0;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                check++;
            }
            return check;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Edit Size
    public int editSize(int id , String name , boolean status, int quantity) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = " UPDATE dbo.Size\n"
                + "    SET \n"
                + "        name     = ?,\n"
                + "        status   = ?,\n"
                + "        quantity = ?\n"
                + "    WHERE id = ?;";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, name);
            pre.setBoolean(2, status);
            pre.setInt(3, quantity);
            pre.setInt(4, id);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            return 0;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }
    
    //Delete A Part By Id
    public int deletePartById(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "delete from Parts where id = ?";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            throw e;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    public static void main(String[] args) throws Exception {
        PartDAO parts = new PartDAO();
        String[] sizeNames = {"S", "X", "L"};
        String[] quantity = {"300", "600", "900"};
        String[] sizeStatus = {"1", "1", "0"};
        for (int i = 0; i < sizeNames.length; i++) {
            boolean status = true;
            int sizeQuantity = Integer.parseInt(quantity[i]);
            if (sizeStatus[i].equals("0")) {
                status = false;
            }
            parts.addPartSize(sizeNames[i], 3, status, sizeQuantity);
        }
    }
        // Lấy danh sách phụ tùng đơn giản (chỉ id, name, image, price)
    public ArrayList<Part> getAllParts() throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT id, name, image, price FROM Parts";
        ArrayList<Part> partList = new ArrayList<>();
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String image = rs.getString("image");
                double price = rs.getDouble("price");
                // Các trường khác để null
                partList.add(new Part(id, name, image, null, null, null, null, price));
            }
            return partList;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    // Lay price theo id
    public double getPriceById(int partId) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT price FROM Parts WHERE id = ?";
        try{
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, partId);
            
            rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getDouble("price");
            }
        return 0;
        } catch(Exception e){
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
}
