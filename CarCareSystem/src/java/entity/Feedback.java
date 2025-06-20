/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class Feedback {
    private int id;
    private int userId;
    private String description;
    private Timestamp createDate;

    public Feedback() {
    }

    public Feedback(int id, int userId, String description, Timestamp createDate) {
        this.id = id;
        this.userId = userId;
        this.description = description;
        this.createDate = createDate;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createdDate) {
        this.createDate = createDate;
    }

    


    
}
