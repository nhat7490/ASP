package com.caps.asp.model.uimodel.request;

import java.util.List;

public class SearchRequestModel {
    private List<Integer> utilities;
    private List<Integer> districts;
    private List<Double> price;
    private Integer gender;
    private Integer typeId;
    private String orderBy;
    private Integer userId;

    public SearchRequestModel() {
    }

    public SearchRequestModel(List<Integer> utilities, List<Integer> districts, List<Double> price, Integer gender, Integer typeId, String orderBy, Integer userId) {
        this.utilities = utilities;
        this.districts = districts;
        this.price = price;
        this.gender = gender;
        this.typeId = typeId;
        this.orderBy = orderBy;
        this.userId = userId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public List<Integer> getUtilities() {
        return utilities;
    }

    public void setUtilities(List<Integer> utilities) {
        this.utilities = utilities;
    }

    public List<Integer> getDistricts() {
        return districts;
    }

    public void setDistricts(List<Integer> districts) {
        this.districts = districts;
    }

    public List<Double> getPrice() {
        return price;
    }

    public void setPrice(List<Double> price) {
        this.price = price;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }
}
