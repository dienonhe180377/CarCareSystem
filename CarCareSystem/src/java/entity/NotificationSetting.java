/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Admin
 */
public class NotificationSetting {
    private int id;
    private User reciever;
    private boolean notificationTime;
    private boolean notificationStatus;
    private boolean profile;
    private boolean orderChange;
    private boolean attendance;
    private boolean email;
    private boolean service;
    private boolean insurance;
    private boolean category;
    private boolean supplier;
    private boolean parts;
    private boolean settingChange;
    private boolean carType;
    private boolean campaign;
    private boolean blog;
    private boolean voucher;

    public NotificationSetting(int id, User reciever, boolean notificationTime, boolean notificationStatus, boolean profile, boolean orderChange, boolean attendance, boolean email, boolean service, boolean insurance, boolean category, boolean supplier, boolean parts, boolean settingChange, boolean carType, boolean campaign, boolean blog, boolean voucher) {
        this.id = id;
        this.reciever = reciever;
        this.notificationTime = notificationTime;
        this.notificationStatus = notificationStatus;
        this.profile = profile;
        this.orderChange = orderChange;
        this.attendance = attendance;
        this.email = email;
        this.service = service;
        this.insurance = insurance;
        this.category = category;
        this.supplier = supplier;
        this.parts = parts;
        this.settingChange = settingChange;
        this.carType = carType;
        this.campaign = campaign;
        this.blog = blog;
        this.voucher = voucher;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getReciever() {
        return reciever;
    }

    public void setReciever(User reciever) {
        this.reciever = reciever;
    }

    public boolean isNotificationTime() {
        return notificationTime;
    }

    public void setNotificationTime(boolean notificationTime) {
        this.notificationTime = notificationTime;
    }

    public boolean isNotificationStatus() {
        return notificationStatus;
    }

    public void setNotificationStatus(boolean notificationStatus) {
        this.notificationStatus = notificationStatus;
    }

    public boolean isProfile() {
        return profile;
    }

    public void setProfile(boolean profile) {
        this.profile = profile;
    }

    public boolean isOrderChange() {
        return orderChange;
    }

    public void setOrderChange(boolean orderChange) {
        this.orderChange = orderChange;
    }

    public boolean isAttendance() {
        return attendance;
    }

    public void setAttendance(boolean attendance) {
        this.attendance = attendance;
    }

    public boolean isEmail() {
        return email;
    }

    public void setEmail(boolean email) {
        this.email = email;
    }

    public boolean isService() {
        return service;
    }

    public void setService(boolean service) {
        this.service = service;
    }

    public boolean isInsurance() {
        return insurance;
    }

    public void setInsurance(boolean insurance) {
        this.insurance = insurance;
    }

    public boolean isCategory() {
        return category;
    }

    public void setCategory(boolean category) {
        this.category = category;
    }

    public boolean isSupplier() {
        return supplier;
    }

    public void setSupplier(boolean supplier) {
        this.supplier = supplier;
    }

    public boolean isParts() {
        return parts;
    }

    public void setParts(boolean parts) {
        this.parts = parts;
    }

    public boolean isSettingChange() {
        return settingChange;
    }

    public void setSettingChange(boolean settingChange) {
        this.settingChange = settingChange;
    }

    public boolean isCarType() {
        return carType;
    }

    public void setCarType(boolean carType) {
        this.carType = carType;
    }

    public boolean isCampaign() {
        return campaign;
    }

    public void setCampaign(boolean campaign) {
        this.campaign = campaign;
    }

    public boolean isBlog() {
        return blog;
    }

    public void setBlog(boolean blog) {
        this.blog = blog;
    }

    public boolean isVoucher() {
        return voucher;
    }

    public void setVoucher(boolean voucher) {
        this.voucher = voucher;
    }
    
    

    @Override
    public String toString() {
        return "NotificationSetting{" + "id=" + id + ", reciever=" + reciever + ", notificationTime=" + notificationTime + ", notificationStatus=" + notificationStatus + ", profile=" + profile + ", orderChange=" + orderChange + ", attendance=" + attendance + ", email=" + email + ", service=" + service + ", insurance=" + insurance + ", category=" + category + ", supplier=" + supplier + ", parts=" + parts + ", settingChange=" + settingChange + ", carType=" + carType + ", campaign=" + campaign + ", blog=" + blog + ", voucher=" + voucher + '}';
    }

    
    
}
