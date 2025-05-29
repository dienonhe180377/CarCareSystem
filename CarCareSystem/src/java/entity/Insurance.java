
package entity;

import java.util.Date;


public class Insurance {
    private int id;
    private int userId;
    private int carTypeId;
    private Date startDate;
    private Date endDate;
    private double price;
    private String description;

    public Insurance(int id, int userId, int carTypeId, Date startDate, Date endDate, double price, String description) {
        this.id = id;
        this.userId = userId;
        this.carTypeId = carTypeId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.price = price;
        this.description = description;
    }

    public Insurance(int userId, int carTypeId, Date startDate, Date endDate, double price, String description) {
        this.userId = userId;
        this.carTypeId = carTypeId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.price = price;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCarTypeId() {
        return carTypeId;
    }

    public void setCarTypeId(int carTypeId) {
        this.carTypeId = carTypeId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    
}
