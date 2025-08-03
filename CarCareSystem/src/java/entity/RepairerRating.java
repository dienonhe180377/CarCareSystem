/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class RepairerRating {
    private int id;
    private User customerId;
    private User repairerId;
    private Order order;
    private int rating;
    private String comment;
    private Date createDate;

    public RepairerRating(int id, User customerId, User repairerId, Order order, int rating, String comment, Date createDate) {
        this.id = id;
        this.customerId = customerId;
        this.repairerId = repairerId;
        this.order = order;
        this.rating = rating;
        this.comment = comment;
        this.createDate = createDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getCustomerId() {
        return customerId;
    }

    public void setCustomerId(User customerId) {
        this.customerId = customerId;
    }

    public User getRepairerId() {
        return repairerId;
    }

    public void setRepairerId(User repairerId) {
        this.repairerId = repairerId;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
    
}
