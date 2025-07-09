/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Voucher;
import entity.Campaign;
import entity.Service;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

/**
 *
 * @author Admin
 */
public class VoucherDAO extends DBConnection {

    private CampaignDAO campaignDAO = new CampaignDAO();
    private ServiceDAO serviceDAO = new ServiceDAO();

    public void addVoucher(Voucher voucher) {
        String sql = "INSERT INTO [dbo].[Voucher] ([name], [campaignId], [serviceId], [startDate], [endDate], [description], [discount], [status]) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, voucher.getName());
            ptm.setInt(2, voucher.getCampaign().getId());
            ptm.setInt(3, voucher.getService().getId());
            ptm.setDate(4, (Date) voucher.getStartDate());
            ptm.setDate(5, (Date) voucher.getEndDate());
            ptm.setString(6, voucher.getDescription());
            ptm.setInt(7, voucher.getDiscount());
            ptm.setBoolean(8, voucher.isStatus());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public List<Voucher> getAllVouchers() {
        List<Voucher> list = new ArrayList<>();
        String sql = "SELECT v.[id], v.[name], v.[campaignId], v.[serviceId], v.[startDate], v.[endDate], v.[description], v.[discount], v.[status] FROM [dbo].[Voucher] v";

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                // Get campaign and service objects
                Campaign campaign = getCampaignById(rs.getInt("campaignId"));
                Service service = getServiceById(rs.getInt("serviceId"));
                
                Voucher voucher = new Voucher(
                        rs.getInt("id"),
                        rs.getString("name"),
                        campaign,
                        service,
                        rs.getDate("startDate"),
                        rs.getDate("endDate"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        rs.getBoolean("status"));
                list.add(voucher);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public void updateVoucher(Voucher voucher) {
        String sql = "UPDATE [dbo].[Voucher] SET [name] = ?, [campaignId] = ?, [serviceId] = ?, [startDate] = ?, [endDate] = ?, [description] = ?, [discount] = ?, [status] = ? WHERE [id] = ?";

        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, voucher.getName());
            ptm.setInt(2, voucher.getCampaign().getId());
            ptm.setInt(3, voucher.getService().getId());
            ptm.setDate(4, (Date) voucher.getStartDate());
            ptm.setDate(5, (Date) voucher.getEndDate());
            ptm.setString(6, voucher.getDescription());
            ptm.setInt(7, voucher.getDiscount());
            ptm.setBoolean(8, voucher.isStatus());
            ptm.setInt(9, voucher.getId());

            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteVoucher(int id) {
        String sql = "DELETE FROM [dbo].[Voucher] WHERE [id] = ?";

        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    private Campaign getCampaignById(int id) {
        List<Campaign> campaigns = campaignDAO.getAllCampaigns();
        return campaigns.stream()
                .filter(c -> c.getId() == id)
                .findFirst()
                .orElse(null);
    }

    private Service getServiceById(int id) {
        Vector<Service> services = serviceDAO.getAllService();
        return services.stream()
                .filter(s -> s.getId() == id)
                .findFirst()
                .orElse(null);
    }

    public static void main(String[] args) {
        System.out.println("getAllVouchers");
        VoucherDAO instance = new VoucherDAO();
        List<Voucher> result = instance.getAllVouchers();
        System.out.println(result);
    }
}
