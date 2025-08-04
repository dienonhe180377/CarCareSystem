/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import entity.Notification;
import entity.Order;
import entity.RepairerRating;
import entity.User;
import entity.Work;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class EmployeeFeedbackDAO extends DBConnection {

    private UserDAO userDAO = new UserDAO();
    private OrderDAO orderDAO = new OrderDAO();

    //Set Feedback to Rated
    public int setFeedback(int id, int rating, String comment, boolean status) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        // SQL UPDATE statement to modify rating, comment, and status
        String sql = "UPDATE RepairerRating SET rating = ?, comment = ?, [status] = ? WHERE id = ?";

        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);

            // Set parameters for the prepared statement
            pre.setInt(1, rating);             // Set rating
            pre.setString(2, comment);          // Set comment
            pre.setBoolean(3, status);          // Set status
            pre.setInt(4, id);                  // Specify which record to update

            int successCheck = pre.executeUpdate();
            return successCheck;  // Returns the number of rows affected
        } catch (Exception e) {
            throw e;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    //Get All Feedback By Customer Id
    public ArrayList<RepairerRating> getAllFeedbackByCustomerId(int customerId) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "select * from RepairerRating where customer_id = " + customerId;
        ArrayList<RepairerRating> feedbacks = new ArrayList<>();
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                User customer = userDAO.getUserById(rs.getInt("customer_id"));
                User repairer = userDAO.getUserById(rs.getInt("repairer_id"));
                Order order = orderDAO.getOrderById(rs.getInt("order_id"));
                int rating = rs.getInt("rating");
                String comment = rs.getString("comment");
                boolean status = rs.getBoolean("status");
                Date createDate = rs.getDate("createDate");
                feedbacks.add(new RepairerRating(id, customer, repairer, order, rating, comment, status, createDate));
            }
            return feedbacks;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Get All Feedback By Repairer Id
    public ArrayList<RepairerRating> getAllFeedbackByRepairerId(int customerId) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "select * from RepairerRating where repairer_id = " + customerId + " and rating != 0";
        ArrayList<RepairerRating> feedbacks = new ArrayList<>();
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                User customer = userDAO.getUserById(rs.getInt("customer_id"));
                User repairer = userDAO.getUserById(rs.getInt("repairer_id"));
                Order order = orderDAO.getOrderById(rs.getInt("order_id"));
                int rating = rs.getInt("rating");
                String comment = rs.getString("comment");
                boolean status = rs.getBoolean("status");
                Date createDate = rs.getDate("createDate");
                feedbacks.add(new RepairerRating(id, customer, repairer, order, rating, comment, status, createDate));
            }
            return feedbacks;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    //Add Feedback
    public int addRepairerFeedback(int customerId, int repairerId, int orderId, int rating, String comment, boolean status) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;

        // SQL INSERT phù hợp với cấu trúc bảng
        String sql = "INSERT INTO RepairerRating (customer_id, repairer_id, order_id, rating, comment, [status]) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);

            // Thiết lập các tham số
            pre.setInt(1, customerId);
            pre.setInt(2, repairerId);
            pre.setInt(3, orderId);
            pre.setInt(4, rating);

            // Xử lý comment có thể null
            if (comment != null) {
                pre.setNString(5, comment);  // Sử dụng setNString cho nvarchar
            } else {
                pre.setNull(5, java.sql.Types.NVARCHAR);
            }

            // Chuyển boolean sang bit (1/0)
            pre.setBoolean(6, status);

            int successCheck = pre.executeUpdate();
            return successCheck;
        } catch (Exception e) {
            throw e;
        } finally {
            closeConnection(conn);
            closePreparedStatement(pre);
        }
    }

    //Get Repairer id By Order Id
    public int getRepairerIdByOrderId(int id) throws Exception {
        Connection conn = null;
        PreparedStatement pre = null;
        ResultSet rs = null;
        String sql = "select * from Work where order_id = " + id;
        int repairerId = 0;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                repairerId = rs.getInt("repairer_id");
            }
            return repairerId;
        } catch (Exception e) {
            throw e;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }

    public static void main(String[] args) throws Exception {
        EmployeeFeedbackDAO dAO = new EmployeeFeedbackDAO();
        System.out.println(dAO.getAllFeedbackByCustomerId(4));
    }
}
