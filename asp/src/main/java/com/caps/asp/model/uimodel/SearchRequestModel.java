package com.caps.asp.model.uimodel;

import java.util.List;

public class SearchRequestModel {
    private List<Integer> utilities;
    private List<Integer> districts;

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
}
