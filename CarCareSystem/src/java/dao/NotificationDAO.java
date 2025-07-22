/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Notification;
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
public class NotificationDAO extends DBConnection{
    
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
    
    public static void main(String[] args) throws Exception {
        NotificationDAO dAO = new NotificationDAO();
        System.out.println(dAO.getAllNotificationById(9));
    }
}
