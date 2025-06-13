/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Campaign;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NTN
 */
public class CampaignDAO extends DBConnection {

    public void addCampaign(Campaign campaign) {
        String sql = "INSERT INTO [dbo].[Campaign] "
                + "([name], [status], [description], [startDate], [endDate]) "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, campaign.getName());
            ptm.setBoolean(2, campaign.isStatus());
            ptm.setString(3, campaign.getDescription());
            ptm.setDate(4, (Date) campaign.getStartDate());
            ptm.setDate(5, (Date) campaign.getEndDate());
            ptm.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void updateCampaign(Campaign campaign) {
        String sql = "UPDATE [dbo].[Campaign] SET "
                + "[name] = ?, "
                + "[status] = ?, "
                + "[description] = ?, "
                + "[startDate] = ?, "
                + "[endDate] = ? "
                + "WHERE [id] = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, campaign.getName());
            ptm.setBoolean(2, campaign.isStatus());
            ptm.setString(3, campaign.getDescription());
            ptm.setDate(4, (Date) campaign.getStartDate());
            ptm.setDate(5, (Date) campaign.getEndDate());
            ptm.setInt(6, campaign.getId());
            ptm.executeUpdate();
        } catch (Exception ex) {
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
                Campaign campaign = new Campaign();
                campaign.setId(rs.getInt("id"));
                campaign.setName(rs.getString("name"));
                campaign.setStatus(rs.getBoolean("status"));
                campaign.setDescription(rs.getString("description"));
                campaign.setStartDate(rs.getDate("startDate"));
                campaign.setEndDate(rs.getDate("endDate"));
                list.add(campaign);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public void deleteCampaign(int id) {
        String sql = "DELETE FROM [dbo].[Campaign] WHERE [id] = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}
