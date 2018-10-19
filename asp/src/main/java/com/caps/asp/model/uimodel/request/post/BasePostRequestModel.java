package com.caps.asp.model.uimodel.request.post;

public class BasePostRequestModel {
    private Integer userId;
    //default min minPrice in room post
    private double minPrice;

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
