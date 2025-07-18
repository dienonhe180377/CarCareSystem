
package entity;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Notification {
    private int id;
    private String message;
    private boolean status;
    private Date createDate;
    private User reciever;
    private String type;

    public Notification(int id, String message, boolean status, Date createDate, User reciever, String type) {
        this.id = id;
        this.message = message;
        this.status = status;
        this.createDate = createDate;
        this.reciever = reciever;
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public User getReciever() {
        return reciever;
    }

    public void setReciever(User reciever) {
        this.reciever = reciever;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    

    @Override
    public String toString() {
        return "Notification{" + "id=" + id + ", message=" + message + ", status=" + status + ", createDate=" + createDate + ", reciever=" + reciever + '}' + "\n";
    }
    
    
}
