/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Timestamp;

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
    private Timestamp startDate;
    private Timestamp endDate;
    private int serviceId;
    private int campaignId;
    private Timestamp createdDate;
    private String voucherCode;
    private int totalVoucherCount;
    private String status;

    public Voucher() {
    }

//    public Voucher(String name, String description, float discount, String discountType,
//            float maxDiscountAmount, float minOrderAmount, Timestamp startDate,
//            Timestamp endDate, int serviceId, int campaignId, Timestamp createdDate, 
//            String voucherCode, int totalVoucherCount, String status) {
//        // Gán tất cả trừ id
//    }

    public Voucher(int id, String name, String description, float discount, String discountType, float maxDiscountAmount, float minOrderAmount, Timestamp startDate, Timestamp endDate, int serviceId, int campaignId, Timestamp createdDate, String voucherCode, int totalVoucherCount, String status) {
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
        this.createdDate = createdDate;
        this.voucherCode = voucherCode;
        this.totalVoucherCount = totalVoucherCount;
        this.status = status;
    }

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

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
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

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public int getTotalVoucherCount() {
        return totalVoucherCount;
    }

    public void setTotalVoucherCount(int totalVoucherCount) {
        this.totalVoucherCount = totalVoucherCount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
