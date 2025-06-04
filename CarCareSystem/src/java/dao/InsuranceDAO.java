/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.CarType;
import entity.Insurance;
import entity.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import java.sql.Date;
import java.text.SimpleDateFormat;

/**
 *
 * @author ADMIN
 */
public class InsuranceDAO extends DBConnection {

    public Vector<Insurance> getAllInsurance(String sql) {
        Vector<Insurance> listInsurance = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Insurance i = new Insurance(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getDate(4),
                        rs.getDate(5),
                        rs.getDouble(6),
                        rs.getString(7));
                listInsurance.add(i);

            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listInsurance;
    }

    public void addInsurance(Insurance i) {
        String sql = "INSERT INTO [dbo].[Insurance]\n"
                + "           ([userId]\n"
                + "           ,[carTypeId]\n"
                + "           ,[startDate]\n"
                + "           ,[endDate]\n"
                + "           ,[price]\n"
                + "           ,[description])\n"
                + "     VALUES(?,?,?,?,?,?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, i.getUserId());
            ptm.setInt(2, i.getCarTypeId());
            ptm.setDate(3, i.getStartDate());
            ptm.setDate(4, i.getEndDate());
            ptm.setDouble(5, i.getPrice());
            ptm.setString(6, i.getDescription());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateInsurance(Insurance i) {
        String sql = "UPDATE [dbo].[Insurance]\n"
                + "   SET [userId] = ?\n"
                + "      ,[carTypeId] = ?\n"
                + "      ,[startDate] = ?\n"
                + "      ,[endDate] = ?\n"
                + "      ,[price] = ?\n"
                + "      ,[description] = ?\n"
                + " WHERE id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, i.getUserId());
            ptm.setInt(2, i.getCarTypeId());
            ptm.setDate(3, i.getStartDate());
            ptm.setDate(4, i.getEndDate());
            ptm.setDouble(5, i.getPrice());
            ptm.setString(6, i.getDescription());
            ptm.setInt(7, i.getId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteInsurance(int id) {
        String sql = "DELETE FROM [dbo].[Insurance]\n"
                + "      WHERE id=?";
        PreparedStatement ptm;
        try {
            ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ptm.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public Vector<User> getAllUsers() {
    Vector<User> list = new Vector<>();
    String sql = "SELECT id, username FROM [dbo].[User]";
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        ResultSet rs = ptm.executeQuery();
        while (rs.next()) {
            User u = new User(rs.getInt("id"), rs.getString("username"));
            list.add(u);
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return list;
}

    public Vector<CarType> getAllCarTypes() {
        Vector<CarType> list = new Vector<>();
        String sql = "SELECT id, name FROM [dbo].[CarType]";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                CarType c = new CarType(rs.getInt("id"), rs.getString("name"));
                list.add(c);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Insurance searchInsurance(int id) {
        String sql = "SELECT * FROM [dbo].[Insurance]\n"
                + "      WHERE id=?";

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, id);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                Insurance i = new Insurance(rs.getInt(1),
                        rs.getInt(2), rs.getInt(3),
                        rs.getDate(4), rs.getDate(5),
                        rs.getDouble(6), rs.getString(7));
                return i;
            }

        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return null;
    }
    
    public Vector<Insurance> getInsuranceByUserId(int userId) {
    Vector<Insurance> list = new Vector<>();
    String sql = "SELECT * FROM [dbo].[Insurance] WHERE userId = ?";
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        ptm.setInt(1, userId);
        ResultSet rs = ptm.executeQuery();
        while (rs.next()) {
            Insurance i = new Insurance(
                rs.getInt(1),
                rs.getInt(2),
                rs.getInt(3),
                rs.getDate(4),
                rs.getDate(5),
                rs.getDouble(6),
                rs.getString(7)
            );
            list.add(i);
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return list;
}

    public static void main(String[] args) {
        InsuranceDAO iDAO = new InsuranceDAO();
        //Insurance i = new Insurance(1, 1, new Date(20, 5, 29), new Date(25, 5, 30), 1234, "test");
        //iDAO.deleteInsurance(5);
        Insurance iSearch = iDAO.searchInsurance(6);
        if (iSearch != null) {
            iDAO.updateInsurance(new Insurance(
                    iSearch.getId(),
                    1,
                    1,
                    Date.valueOf("2025-06-29"),
                    Date.valueOf("2025-06-30"),
                    678,
                    "test"
            ));
            System.out.println("update ok");
        }

    }
}
