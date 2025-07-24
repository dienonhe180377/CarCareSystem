/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Notification;
import entity.NotificationSetting;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class NotificationDAO extends DBConnection {

    private UserDAO userDAO = new UserDAO();

    //Get All Notification By Id
    public ArrayList<Notification> getAllNotificationById(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM Notification where recieverId = " + id;
        ArrayList<Notification> notifications = new ArrayList<>();
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int notificationId = rs.getInt("id");
                String message = rs.getString("message");
                boolean status = rs.getBoolean("status");
                Date createDate = rs.getDate("createDate");
                User reciever = userDAO.getUserById(rs.getInt("recieverId"));
                String type = rs.getString("notification_type");
                notifications.add(new Notification(notificationId, message, status, createDate, reciever, type));
            }
            Collections.reverse(notifications);
            return notifications;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Get Notification Setting By Id
    public NotificationSetting getNotificationSettingById(int userId) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM [NotificationSetting] where recieverId = " + userId;
        NotificationSetting setting = null;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                User reciever = userDAO.getUserById(rs.getInt("recieverId"));
                boolean notificationTime = rs.getBoolean("notification_time");
                boolean notificationStatus = rs.getBoolean("notification_status");
                boolean profile = rs.getBoolean("profile");
                boolean orderChange = rs.getBoolean("order_change");
                boolean attendance = rs.getBoolean("attendance");
                boolean email = rs.getBoolean("email");
                boolean service = rs.getBoolean("service");
                boolean insurance = rs.getBoolean("insurance");
                boolean category = rs.getBoolean("category");
                boolean supplier = rs.getBoolean("supplier");
                boolean parts = rs.getBoolean("parts");
                boolean settingChange = rs.getBoolean("setting_change");
                boolean carType = rs.getBoolean("car_type");
                boolean campaign = rs.getBoolean("campaign");
                boolean blog = rs.getBoolean("blog");
                boolean voucher = rs.getBoolean("voucher");
                setting = new NotificationSetting(id, reciever, notificationTime, notificationStatus, profile, orderChange, attendance, email, service, insurance, category, supplier, parts, settingChange, carType, campaign, blog, voucher);
            }
            return setting;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Get Notification By Id
    public Notification getNotificationById(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM [Notification] where id = " + id;
        Notification notification = null;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int notificationId = rs.getInt("id");
                String message = rs.getString("message");
                boolean status = rs.getBoolean("status");
                Date createDate = rs.getDate("createDate");
                User reciever = userDAO.getUserById(rs.getInt("recieverId"));
                String type = rs.getString("notification_type");
                notification = new Notification(notificationId, message, status, createDate, reciever, type);
            }
            return notification;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Set Status to Readed
    public int setNotificationStatus(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "UPDATE [Notification]\n"
                + "SET \n"
                + "    status = 1\n"
                + "WHERE \n"
                + "    id = ?";
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

    //Delete All Notifications
    public int deleteNotification(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "delete from Notification where recieverId = ?";
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

    //Add Notification
    public int addNotification(int userId, String message, String type) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "INSERT INTO [Notification] ([message], status, recieverId, notification_type)\n"
                + "VALUES \n"
                + "(?, ?, ?, ?)";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            pre.setString(1, message);
            pre.setBoolean(2, false);
            pre.setInt(3, userId);
            pre.setString(4, type);
            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            throw e;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    // Edit user notification setting 
    public int editNotificationSetting(
            int recieverId,
            String notification_time,
            String notification_status,
            String profile,
            String order_change,
            String attendance,
            String email,
            String service,
            String insurance,
            String category,
            String supplier,
            String parts,
            String setting_change,
            String car_type,
            String campaign,
            String blog,
            String voucher
    ) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "UPDATE [NotificationSetting]\n"
                + "SET \n"
                + "    [notification_time] = ?,\n"
                + "    [notification_status] = ?,\n"
                + "    [profile] = ?,\n"
                + "    [order_change] = ?,\n"
                + "    attendance = ?,\n"
                + "    email = ?,\n"
                + "    [service] = ?,\n"
                + "    insurance = ?,\n"
                + "    category = ?,\n"
                + "    supplier = ?,\n"
                + "    parts = ?,\n"
                + "    [setting_change] = ?,\n"
                + "    car_type = ?,\n"
                + "    campaign = ?,\n"
                + "    blog = ?,\n"
                + "    voucher = ?\n"
                + "WHERE \n"
                + "    recieverId = ?;";

        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);

            // Convert String parameters to boolean ("yes" -> true, others -> false)
            pre.setBoolean(1, "yes".equalsIgnoreCase(notification_time));
            pre.setBoolean(2, "yes".equalsIgnoreCase(notification_status));
            pre.setBoolean(3, "yes".equalsIgnoreCase(profile));
            pre.setBoolean(4, "yes".equalsIgnoreCase(order_change));
            pre.setBoolean(5, "yes".equalsIgnoreCase(attendance));
            pre.setBoolean(6, "yes".equalsIgnoreCase(email));
            pre.setBoolean(7, "yes".equalsIgnoreCase(service));
            pre.setBoolean(8, "yes".equalsIgnoreCase(insurance));
            pre.setBoolean(9, "yes".equalsIgnoreCase(category));
            pre.setBoolean(10, "yes".equalsIgnoreCase(supplier));
            pre.setBoolean(11, "yes".equalsIgnoreCase(parts));
            pre.setBoolean(12, "yes".equalsIgnoreCase(setting_change));
            pre.setBoolean(13, "yes".equalsIgnoreCase(car_type));
            pre.setBoolean(14, "yes".equalsIgnoreCase(campaign));
            pre.setBoolean(15, "yes".equalsIgnoreCase(blog));
            pre.setBoolean(16, "yes".equalsIgnoreCase(voucher));
            pre.setInt(17, recieverId);

            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            throw e;
        } finally {
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public int addNotificationSetting(
            int receiverId,
            boolean notificationTime,
            boolean notificationStatus,
            boolean profile,
            boolean orderChange,
            boolean attendance,
            boolean email,
            boolean service,
            boolean insurance,
            boolean category,
            boolean supplier,
            boolean parts,
            boolean settingChange,
            boolean carType,
            boolean campaign,
            boolean blog,
            boolean voucher
    ) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        String sql = "INSERT INTO [NotificationSetting] (\n"
                + "    recieverId,\n"
                + "    notification_time,\n"
                + "    notification_status,\n"
                + "    profile,\n"
                + "    order_change,\n"
                + "    attendance,\n"
                + "    email,\n"
                + "    service,\n"
                + "    insurance,\n"
                + "    category,\n"
                + "    supplier,\n"
                + "    parts,\n"
                + "    setting_change,\n"
                + "    car_type,\n"
                + "    campaign,\n"
                + "    blog,\n"
                + "    voucher\n"
                + ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);

            // Thiết lập tham số
            pre.setInt(1, receiverId);
            pre.setBoolean(2, notificationTime);
            pre.setBoolean(3, notificationStatus);
            pre.setBoolean(4, profile);
            pre.setBoolean(5, orderChange);
            pre.setBoolean(6, attendance);
            pre.setBoolean(7, email);
            pre.setBoolean(8, service);
            pre.setBoolean(9, insurance);
            pre.setBoolean(10, category);
            pre.setBoolean(11, supplier);
            pre.setBoolean(12, parts);
            pre.setBoolean(13, settingChange);
            pre.setBoolean(14, carType);
            pre.setBoolean(15, campaign);
            pre.setBoolean(16, blog);
            pre.setBoolean(17, voucher);

            return pre.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public static void main(String[] args) throws Exception {
        NotificationDAO dAO = new NotificationDAO();
        System.out.println(dAO.getNotificationSettingById(1));
    }
}
