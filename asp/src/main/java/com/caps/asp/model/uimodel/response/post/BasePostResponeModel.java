package com.caps.asp.model.uimodel.response.post;

import com.caps.asp.model.uimodel.response.UserResponeModel;

import java.sql.Date;

public class BasePostResponeModel {
    private Integer postId;
    private String phoneContact;
    private Date date;
    private UserResponeModel userResponeModel;
    private boolean isFavourite;
    private double minPrice;
    private Integer favouriteId;

    public BasePostResponeModel(Integer postId, String phoneContact, Date date, UserResponeModel userResponeModel, boolean isFavourite, double minPrice, Integer favouriteId) {
        this.postId = postId;
        this.phoneContact = phoneContact;
        this.date = date;
        this.userResponeModel = userResponeModel;
        this.isFavourite = isFavourite;
        this.minPrice = minPrice;
        this.favouriteId = favouriteId;
    }

    public BasePostResponeModel() {
    }

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public String getPhoneContact() {
        return phoneContact;
    }

    public void setPhoneContact(String phoneContact) {
        this.phoneContact = phoneContact;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public UserResponeModel getUserResponeModel() {
        return userResponeModel;
    }

    public void setUserResponeModel(UserResponeModel userResponeModel) {
        this.userResponeModel = userResponeModel;
    }

    public boolean isFavourite() {
        return isFavourite;
    }

    public void setFavourite(boolean favourite) {
        isFavourite = favourite;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }

    public Integer getFavouriteId() {
        return favouriteId;
    }

    public void setFavouriteId(Integer favouriteId) {
        this.favouriteId = favouriteId;
    }
}
