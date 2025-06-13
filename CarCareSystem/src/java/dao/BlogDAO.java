/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Blog;
import java.sql.Date;
import java.sql.PreparedStatement;

/**
 *
 * @author NTN
 */
public class BlogDAO extends DBConnection {

    public void addBlog(Blog blog) {
        String sql = "INSERT INTO [dbo].[Blog] "
                + "([title], [campaignId], [content], [createDate], [updatedDate], [status]) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, blog.getTitle());
            ptm.setInt(2, blog.getId());
            ptm.setString(3, blog.getContent());
            ptm.setDate(4, (Date) blog.getCreateDate());
            ptm.setDate(5, (Date) blog.getUpdatedDate());
            ptm.setBoolean(6, blog.isStatus());
            ptm.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateBlog(Blog blog) {
        String sql = "UPDATE [dbo].[Blog] "
                + "SET [title] = ?, "
                + "[campaignId] = ?, "
                + "[content] = ?, "
                + "[createDate] = ?, "
                + "[updatedDate] = ?, "
                + "[status] = ? "
                + "WHERE [id] = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, blog.getTitle());
            ptm.setInt(2, blog.getId());
            ptm.setString(3, blog.getContent());
            ptm.setDate(4, (Date) blog.getCreateDate());
            ptm.setDate(5, (Date) blog.getUpdatedDate());
            ptm.setBoolean(6, blog.isStatus());
            ptm.setInt(7, blog.getId());
            ptm.executeUpdate();
        } catch (Exception e) {
        }
    }
    
   
}
