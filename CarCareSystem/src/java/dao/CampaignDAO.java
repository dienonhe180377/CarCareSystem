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
        String sql = "INSERT INTO [dbo].[Campaign] ([name], [status], [description], [startDate], [endDate]) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, campaign.getName());
            ptm.setBoolean(2, campaign.isStatus());
            ptm.setString(3, campaign.getDescription());
            ptm.setDate(4, (Date) campaign.getStartDate());
            ptm.setDate(5, (Date) campaign.getEndDate());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public List<Campaign> getAllCampaigns() {
        List<Campaign> list = new ArrayList<>();
        String sql = "SELECT [id], [name], [status], [description], [startDate], [endDate] FROM [dbo].[Campaign]";

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Campaign campaign = new Campaign(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getBoolean("status"),
                        rs.getString("description"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate"));
                list.add(campaign);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public void updateCampaign(Campaign campaign) {
        String sql = "UPDATE [dbo].[Campaign] SET [name] = ?, [status] = ?, [description] = ?, [startDate] = ?, [endDate] = ? WHERE [id] = ?";

        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, campaign.getName());
            ptm.setBoolean(2, campaign.isStatus());
            ptm.setString(3, campaign.getDescription());
            ptm.setDate(4, (Date) campaign.getStartDate());
            ptm.setDate(5, (Date) campaign.getEndDate());
            ptm.setInt(6, campaign.getId()); // điều kiện WHERE theo id

            ptm.executeUpdate();
        } catch (SQLException ex) {
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
    String sql = "SELECT [id], [name], [status], [description], [startDate], [endDate] FROM [dbo].[Campaign] WHERE [id] = ?";
    
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
                rs.getDate("endDate")
            );
        }
    } catch (SQLException ex) {
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
