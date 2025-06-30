/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class Order {
    private int id;
    private User user;
    private CarType carType;
    private ArrayList<Service> services;
    private ArrayList<Part> parts;
    private Date createdDate;
    private Date appointmentDate;
    private double price;
    private String name;
    private String email;
    private String phone;
    private String address;
    private String paymentStatus;
    private String orderStatus;

    public Order(int id, User user, CarType carType, ArrayList<Service> services, ArrayList<Part> parts, Date createdDate, Date appointmentDate, double price, String name, String email, String phone, String address, String paymentStatus, String orderStatus) {
        this.id = id;
        this.user = user;
        this.carType = carType;
        this.services = services;
        this.parts = parts;
        this.createdDate = createdDate;
        this.appointmentDate = appointmentDate;
        this.price = price;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.paymentStatus = paymentStatus;
        this.orderStatus = orderStatus;
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

    public ArrayList<Service> getServices() {
        return services;
    }

    public void setServices(ArrayList<Service> services) {
        this.services = services;
    }

    public ArrayList<Part> getParts() {
        return parts;
    }

    public void setParts(ArrayList<Part> parts) {
        this.parts = parts;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(Date appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
    
}
