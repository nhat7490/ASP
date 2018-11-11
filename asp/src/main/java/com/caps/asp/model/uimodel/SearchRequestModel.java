package com.caps.asp.model.uimodel;

import java.util.List;

public class SearchRequestModel {
    private List<Integer> utilities;
    private List<Integer> districts;
    int maxPrice;
    int minPrice;
    int gender;

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

    public int getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(int maxPrice) {
        this.maxPrice = maxPrice;
    }

    public int getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(int minPrice) {
        this.minPrice = minPrice;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }
}
