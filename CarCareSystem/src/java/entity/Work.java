/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author TRAN ANH HAI
 */
public class Work {
    private int id;
    private int orderId;
    private int repairerId;
    private String image;
    private Date receivedDate;
    private Date returnDate;

    public Work(int id, int orderId, int repairerId, String image, Date receivedDate, Date returnDate) {
        this.id = id;
        this.orderId = orderId;
        this.repairerId = repairerId;
        this.image = image;
        this.receivedDate = receivedDate;
        this.returnDate = returnDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getRepairerId() {
        return repairerId;
    }

    public void setRepairerId(int repairerId) {
        this.repairerId = repairerId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getReceivedDate() {
        return receivedDate;
    }

    public void setReceivedDate(Date receivedDate) {
        this.receivedDate = receivedDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }
    
    
}
