package com.caps.asp.model.uimodel;

import java.util.List;

public class SearchRequestModel {
    private List<String> utilities;
    private List<String> districts;

    public List<String> getUtilities() {
        return utilities;
    }

    public void setUtilities(List<String> utilities) {
        this.utilities = utilities;
    }

    public List<String> getDistricts() {
        return districts;
    }

    public void setDistricts(List<String> districts) {
        this.districts = districts;
    }
}
