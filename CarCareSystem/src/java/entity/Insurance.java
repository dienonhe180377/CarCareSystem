
package entity;

import java.util.Date;


public class Insurance {
    private int id;
    private User user;
    private CarType carType;
    private Date startDate;
    private Date endDate;
    private double price;
    private String description;

    public Insurance(int id, User user, CarType carType, Date startDate, Date endDate, double price, String description) {
        this.id = id;
        this.user = user;
        this.carType = carType;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public CarType getCarType() {
        return carType;
    }

    public void setCarType(CarType carType) {
        this.carType = carType;
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
