package com.caps.asp.model.uimodel.request.post;

import java.sql.Date;

public class BasePostRequestModel {
    private Integer userId;
    //default min price in room post
    private double price;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
