package com.caps.asp.model.uimodel.request.post;

public class BasePostRequestModel {
    private Integer userId;
    //default min minPrice in room post
    private double minPrice;
    private String phoneContact;


    public BasePostRequestModel() {
    }

    public BasePostRequestModel(Integer userId, double minPrice, String phoneContact) {
        this.userId = userId;
        this.minPrice = minPrice;
        this.phoneContact = phoneContact;
    }

    public String getPhoneContact() {
        return phoneContact;
    }

    public void setPhoneContact(String phoneContact) {
        this.phoneContact = phoneContact;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }
}
