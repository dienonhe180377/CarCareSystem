package entity;

import java.sql.Timestamp;

public class Feedback {
    private int id;
    private int userId;
    private int serviceId;
    private String description;
    private int rating;
    private Timestamp createDate;
    private String username;
    private String serviceName;

    public Feedback() {
    }

    public Feedback(int id, int userId, int serviceId, String description, int rating, Timestamp createDate, String username) {
        this.id = id;
        this.userId = userId;
        this.serviceId = serviceId;
        this.description = description;
        this.rating = rating;
        this.createDate = createDate;
        this.username = username;
    }

    public Feedback(int userId, int serviceId, String description, int rating, Timestamp createDate, String username) {
        this.userId = userId;
        this.serviceId = serviceId;
        this.description = description;
        this.rating = rating;
        this.createDate = createDate;
        this.username = username;
    }

    public Feedback(int id, int userId, int serviceId, String description, int rating, Timestamp createDate, String username, String serviceName) {
        this.id = id;
        this.userId = userId;
        this.serviceId = serviceId;
        this.description = description;
        this.rating = rating;
        this.createDate = createDate;
        this.username = username;
        this.serviceName = serviceName;
    }

    public Feedback(int userId, int serviceId, String description, int rating, Timestamp createDate, String username, String serviceName) {
        this.userId = userId;
        this.serviceId = serviceId;
        this.description = description;
        this.rating = rating;
        this.createDate = createDate;
        this.username = username;
        this.serviceName = serviceName;
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

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
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
    public String getServiceName() {
    return serviceName;
}

public void setServiceName(String serviceName) {
    this.serviceName = serviceName;
}
}
