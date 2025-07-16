package dao;

import entity.Blog;
import entity.Campaign;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO {
    private Connection connection;

    public BlogDAO(Connection connection) {
        this.connection = connection;
    }

    public void addBlog(Blog blog) {
        String sql = "INSERT INTO [dbo].[Blog] ([title], [campaignId], [content], [createDate], [updatedDate], [status]) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, blog.getTitle());
            ptm.setInt(2, blog.getCampaign().getId());
            ptm.setString(3, blog.getContent());
            ptm.setDate(4, new Date(blog.getCreateDate().getTime()));
            ptm.setDate(5, new Date(blog.getUpdatedDate().getTime()));
            ptm.setBoolean(6, blog.isStatus());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public List<Blog> getAllBlogs() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT b.*, c.[id] as campaignId, c.[name] as campaignName, c.[status] as campaignStatus, c.[description], c.[startDate], c.[endDate] "
                   + "FROM [dbo].[Blog] b JOIN [dbo].[Campaign] c ON b.campaignId = c.id";
        try (PreparedStatement ptm = connection.prepareStatement(sql);
             ResultSet rs = ptm.executeQuery()) {

            while (rs.next()) {
                Campaign campaign = new Campaign(
                        rs.getInt("campaignId"),
                        rs.getString("campaignName"),
                        rs.getBoolean("campaignStatus"),
                        rs.getString("description"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate")
                );

                Blog blog = new Blog(
                        rs.getInt("id"),
                        rs.getString("title"),
                        campaign,
                        rs.getString("content"),
                        rs.getDate("createDate"),
                        rs.getDate("updatedDate"),
                        rs.getBoolean("status")
                );

                list.add(blog);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Blog getBlogById(int id) {
    String sql = "SELECT b.*, c.[id] as campaignId, c.[name] as campaignName, c.[status] as campaignStatus, c.[description], c.[startDate], c.[endDate] "
               + "FROM [dbo].[Blog] b JOIN [dbo].[Campaign] c ON b.campaignId = c.id "
               + "WHERE b.id = ?";
    
    try (PreparedStatement ptm = connection.prepareStatement(sql)) {
        ptm.setInt(1, id);
        
        try (ResultSet rs = ptm.executeQuery()) {
            if (rs.next()) {
                Campaign campaign = new Campaign(
                        rs.getInt("campaignId"),
                        rs.getString("campaignName"),
                        rs.getBoolean("campaignStatus"),
                        rs.getString("description"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate")
                );

                Blog blog = new Blog(
                        rs.getInt("id"),
                        rs.getString("title"),
                        campaign,
                        rs.getString("content"),
                        rs.getDate("createDate"),
                        rs.getDate("updatedDate"),
                        rs.getBoolean("status")
                );

                return blog;
            }
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    
    return null; // Không tìm thấy blog với ID này
}
    public void updateBlog(Blog blog) {
        String sql = "UPDATE [dbo].[Blog] SET [title] = ?, [campaignId] = ?, [content] = ?, [createDate] = ?, [updatedDate] = ?, [status] = ? WHERE [id] = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, blog.getTitle());
            ptm.setInt(2, blog.getCampaign().getId());
            ptm.setString(3, blog.getContent());
            ptm.setDate(4, new Date(blog.getCreateDate().getTime()));
            ptm.setDate(5, new Date(blog.getUpdatedDate().getTime()));
            ptm.setBoolean(6, blog.isStatus());
            ptm.setInt(7, blog.getId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteBlog(int id) {
        String sql = "DELETE FROM [dbo].[Blog] WHERE [id] = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
