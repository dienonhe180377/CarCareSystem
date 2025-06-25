package entity;

import java.sql.Timestamp;

public class Feedback {
    private int id;
    private int userId;
    private int serviceId;
    private String description;
    private Integer rating;
    private Timestamp createDate;
    private String username; // Chỉ dùng trong Java để hiển thị

    // Constructor cũ (giữ lại cho tương thích code cũ)
    public Feedback(int id, int userId, String description, Timestamp createDate) {
        this.id = id;
        this.userId = userId;
        this.description = description;
        this.createDate = createDate;
    }

    // Constructor mới (đầy đủ các trường, dùng cho code mới)
    public Feedback(int id, int userId, int serviceId, String description, Integer rating, Timestamp createDate, String username) {
        this.id = id;
        this.userId = userId;
        this.serviceId = serviceId;
        this.description = description;
        this.rating = rating;
        this.createDate = createDate;
        this.username = username;
    }

    public Feedback() {}

    // Getter và Setter
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
    public int getServiceId() {
        return serviceId;
    }
    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public Integer getRating() {
        return rating;
    }
    public void setRating(Integer rating) {
        this.rating = rating;
    }
    public Timestamp getCreateDate() {
        return createDate;
    }
    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
}