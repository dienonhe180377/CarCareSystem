
package dao;

import entity.Category;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
/**
 *
 * @author Admin
 */
public class CategoryDAO extends DBConnection{
    
    //Get All Category
    public ArrayList<Category> getAllCategory() throws Exception{
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM Category";
        ArrayList<Category> categoryList = new ArrayList<>();
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                String description = rs.getString("description");
                Category newCategory = new Category(id, name, description, status);
                categoryList.add(newCategory);
            }
            return categoryList;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Add New Category
    public void addCategory(String name,String description , boolean status) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        String sql = "INSERT INTO Category (name, description, status) VALUES (?,?,?)";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, name);
            pre.setString(2, description);
            pre.setBoolean(3, status);
            pre.executeUpdate();
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Get All Category By Text
    public ArrayList<Category> getAllCategoryByText(String text) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Category> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM Category where name COLLATE Latin1_General_CI_AI like '%" + text + "%'";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                boolean status = rs.getBoolean("status");
                categoryList.add(new Category(id, name, description, status));
            }
            return categoryList;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Delete a category
    public int deleteCategory(int id) throws Exception{
        Connection conn = null;
        PreparedStatement pre = null;
        
        String sql = "delete from Category where id = ?";
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
    
    //Update a category
    public int editCategory(int id, String name, String description , boolean status) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "update Category\n"
                + "set status = ? , name = ? , description = ?\n"
                + "where id = ?";
        
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setBoolean(1, status);
            pre.setString(2, name);
            pre.setString(3, description);
            pre.setInt(4, id);
            int success = pre.executeUpdate();
            return success;
        } catch (Exception e) {
            throw e;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }
    
    public static void main(String[] args) throws Exception {
        CategoryDAO dao = new CategoryDAO();
        System.out.println(dao.getAllCategoryByText("eng"));
    }
}
