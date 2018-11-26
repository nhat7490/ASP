package com.caps.asp.model.uimodel.response.common;

import java.sql.Date;

public class RoomRateResponseModel {
    private Double security;
    private Double location;
    private Double utility;
    private UserResponseModel userResponseModel;
    private String comment;
    private Date date;

    public RoomRateResponseModel() {
    }

    public RoomRateResponseModel(Double security, Double location, Double utility, UserResponseModel userResponseModel, String comment, Date date) {
        this.security = security;
        this.location = location;
        this.utility = utility;
        this.userResponseModel = userResponseModel;
        this.comment = comment;
        this.date = date;
    }

    public Double getSecurity() {
        return security;
    }

    public void setSecurity(Double security) {
        this.security = security;
    }

    public Double getLocation() {
        return location;
    }

    public void setLocation(Double location) {
        this.location = location;
    }

    public Double getUtility() {
        return utility;
    }

    public void setUtility(Double utility) {
        this.utility = utility;
    }

    public UserResponseModel getUserResponseModel() {
        return userResponseModel;
    }

    public void setUserResponseModel(UserResponseModel userResponseModel) {
        this.userResponseModel = userResponseModel;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}