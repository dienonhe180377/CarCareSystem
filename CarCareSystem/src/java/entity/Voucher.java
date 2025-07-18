/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author NTN
 */
public class Voucher {

    private int id;
    private String name;
    private String description;
    private float discount;
    private String discountType; // PERCENTAGE hoặc FIXED_AMOUNT
    private float maxDiscountAmount;
    private float minOrderAmount;
    private Date startDate;
    private Date endDate;
    private int serviceId;
    private int campaignId;
    private boolean status;
    private Date createdDate;
    private String voucherCode;

    public Voucher() {
    }

    public Voucher(int id, String name, String description, float discount, String discountType,
            float maxDiscountAmount, float minOrderAmount, Date startDate, Date endDate,
            int serviceId, int campaignId, boolean status, Date createdDate, String voucherCode) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.discount = discount;
        this.discountType = discountType;
        this.maxDiscountAmount = maxDiscountAmount;
        this.minOrderAmount = minOrderAmount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.serviceId = serviceId;
        this.campaignId = campaignId;
        this.status = status;
        this.createdDate = createdDate;
        this.voucherCode = voucherCode;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getDiscount() {
        return discount;
    }

    public void setDiscount(float discount) {
        this.discount = discount;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public float getMaxDiscountAmount() {
        return maxDiscountAmount;
    }

    public void setMaxDiscountAmount(float maxDiscountAmount) {
        this.maxDiscountAmount = maxDiscountAmount;
    }

    public float getMinOrderAmount() {
        return minOrderAmount;
    }

    public void setMinOrderAmount(float minOrderAmount) {
        this.minOrderAmount = minOrderAmount;
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

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public int getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(int campaignId) {
        this.campaignId = campaignId;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }
}
