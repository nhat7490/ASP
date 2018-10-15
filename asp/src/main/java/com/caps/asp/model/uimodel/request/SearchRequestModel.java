package com.caps.asp.model.uimodel.request;

import java.util.List;

public class SearchRequestModel {
    private List<Integer> utilities;
    private List<Integer> districts;
    private List<Double> price;
    private List<Integer> gender;
    private Integer typeId;

    public SearchRequestModel() {
    }

    public SearchRequestModel(List<Integer> utilities, List<Integer> districts, List<Double> price, List<Integer> gender, Integer typeId) {
        this.utilities = utilities;
        this.districts = districts;
        this.price = price;
        this.gender = gender;
        this.typeId = typeId;
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

    public List<Integer> getGender() {
        return gender;
    }

    public void setGender(List<Integer> gender) {
        this.gender = gender;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }
}
