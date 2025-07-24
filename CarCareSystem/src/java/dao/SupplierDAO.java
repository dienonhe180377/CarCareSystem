/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Supplier;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class SupplierDAO extends DBConnection {

    //Get All Supplier
    public ArrayList<Supplier> getAllSupplier() throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM Supplier";
        ArrayList<Supplier> supplierList = new ArrayList<>();
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String logo = rs.getString("logo");
                String description = rs.getString("description");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                supplierList.add(new Supplier(id, name, logo, description, email, phone, address));
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

    //Get All Supplier By Text
    public ArrayList<Supplier> getAllSupplierByText(String text) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Supplier> supplierList = new ArrayList<>();
        String sql = "SELECT * FROM Supplier where name COLLATE Latin1_General_CI_AI like '%" + text + "%'";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String logo = rs.getString("logo");
                String description = rs.getString("description");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                supplierList.add(new Supplier(id, name, logo, description, email, phone, address));
            }
            return supplierList;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Delete A Supplier
    public int deleteSupplier(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "delete from Supplier where id = ?";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            return 0;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    //Add Supplier
    public int addSupplier(String name, String logo, String description, String email, String phone, String address) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "INSERT INTO Supplier ([name], logo, [description], email, phone, [address]) VALUES\n"
                + "(?,?, ?,?,?,?)";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, name);
            pre.setString(2, logo);
            pre.setString(3, description);
            pre.setString(4, email);
            pre.setString(5, phone);
            pre.setString(6, address);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            return 0;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    //Get Supplier By ID
    public Supplier getSupplierById(int id) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "SELECT * FROM Supplier where id = " + id;
        Supplier supplier = null;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                String logo = rs.getString("logo");
                String description = rs.getString("description");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                supplier = new Supplier(id, name, logo, description, email, phone, address);
            }
            return supplier;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Edit Supplier
    public int editSupplier(int id, String name, String logo, String description, String email, String phone, String address) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "UPDATE dbo.Supplier\n"
                + "SET \n"
                + "    [name]        = ?,     \n"
                + "    logo          = ?,     \n"
                + "    [description] = ?, \n"
                + "    email         = ?,  \n"
                + "    phone         = ?,            \n"
                + "    [address]     = ? \n"
                + "WHERE \n"
                + "    id = ?;";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, name);
            pre.setString(2, logo);
            pre.setString(3, description);
            pre.setString(4, email);
            pre.setString(5, phone);
            pre.setString(6, address);
            pre.setInt(7, id);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            return 0;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    public static void main(String[] args) throws Exception {
        SupplierDAO dao = new SupplierDAO();
        System.out.println(dao.getSupplierById(1));
    }

}
