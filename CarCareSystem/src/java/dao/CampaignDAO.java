/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Campaign;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NTN
 */
public class CampaignDAO extends DBConnection {

    public void addCampaign(Campaign campaign) {
        String sql = "INSERT INTO [dbo].[Campaign] ([name], [status], [description], [startDate], [endDate], [img], [thumbnail]) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, campaign.getName());
            ptm.setBoolean(2, campaign.isStatus());
            ptm.setString(3, campaign.getDescription());
            ptm.setDate(4, (Date) campaign.getStartDate());
            ptm.setDate(5, (Date) campaign.getEndDate());
            ptm.setString(6, campaign.getImg());
            ptm.setString(7, campaign.getThumbnail());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public List<Campaign> getAllCampaigns() {
        List<Campaign> list = new ArrayList<>();
        String sql = "SELECT [id], [name], [status], [description], [startDate], [endDate], [img], [thumbnail], [createdDate] FROM [dbo].[Campaign]";

        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery()) {

            while (rs.next()) {
                Campaign campaign = new Campaign(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getBoolean("status"),
                        rs.getString("description"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate"),
                        rs.getString("img"),
                        rs.getString("thumbnail"),
                        rs.getTimestamp("createdDate"));
                list.add(campaign);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public void updateCampaign(Campaign campaign) {
        String sql = "UPDATE [dbo].[Campaign] SET [name] = ?, [status] = ?, [description] = ?, [startDate] = ?, [endDate] = ?, [img] = ?, [thumbnail] = ? WHERE [id] = ?";

        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, campaign.getName());
            ptm.setBoolean(2, campaign.isStatus());
            ptm.setString(3, campaign.getDescription());
            ptm.setDate(4, (Date) campaign.getStartDate());
            ptm.setDate(5, (Date) campaign.getEndDate());
            ptm.setString(6, campaign.getImg());        // Thêm img
            ptm.setString(7, campaign.getThumbnail());  // Thêm thumbnail
            ptm.setInt(8, campaign.getId());            // WHERE condition (index tăng lên 8)

            ptm.executeUpdate();
            System.out.println("Campaign updated successfully with ID: " + campaign.getId());

        } catch (SQLException ex) {
            System.err.println("Error updating campaign: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public void deleteCampaign(int id) {
        String sql = "DELETE FROM [dbo].[Campaign] WHERE [id] = ?";

        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public Campaign getCampaignById(int id) {
        Campaign campaign = null;
        String sql = "SELECT [id], [name], [status], [description], [startDate], [endDate], [img], [thumbnail], [createdDate] FROM [dbo].[Campaign] WHERE [id] = ?";

        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, id);
            ResultSet rs = ptm.executeQuery();

            if (rs.next()) {
                campaign = new Campaign(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getBoolean("status"),
                        rs.getString("description"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate"),
                        rs.getString("img"), // Thêm img
                        rs.getString("thumbnail"), // Thêm thumbnail
                        rs.getTimestamp("createdDate") // Thêm createdDate
                );
            }
        } catch (SQLException ex) {
            System.err.println("Error getting campaign by ID: " + ex.getMessage());
            ex.printStackTrace();
        }

        return campaign;
    }

    public static void main(String[] args) {
        System.out.println("getAllCampaigns");
        CampaignDAO instance = new CampaignDAO();
        List<Campaign> result = instance.getAllCampaigns();
        System.out.println(result);
        // TODO review the generated test code and remove the default call to fail.
    }
}
