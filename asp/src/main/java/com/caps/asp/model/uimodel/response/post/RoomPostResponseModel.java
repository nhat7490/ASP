package com.caps.asp.model.uimodel.response.post;

import com.caps.asp.model.uimodel.request.UtilityRequestModel;
import com.caps.asp.model.uimodel.response.UserResponeModel;

import java.sql.Date;
import java.util.List;

//show room post detail
public class RoomPostResponseModel extends BasePostResponeModel{
    private Integer area;
    private String address;
    private List<UtilityRequestModel> utilities;
    private List<String> imageUrls;
    private Integer numberPartner;
    private Integer genderPartner;

    public RoomPostResponseModel() {
    }


    public RoomPostResponseModel(Integer postId, String phoneContact, Date date, UserResponeModel userResponeModel, boolean isFavourite, double minPrice) {
        super(postId, phoneContact, date, userResponeModel, isFavourite, minPrice);
    }

    public Integer getArea() {
        return area;
    }

    public void setArea(Integer area) {
        this.area = area;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public List<UtilityRequestModel> getUtilities() {
        return utilities;
    }

    public void setUtilities(List<UtilityRequestModel> utilities) {
        this.utilities = utilities;
    }

    public List<String> getImageUrls() {
        return imageUrls;
    }

    public void setImageUrls(List<String> imageUrls) {
        this.imageUrls = imageUrls;
    }

    public Integer getNumberPartner() {
        return numberPartner;
    }

    public void setNumberPartner(Integer numberPartner) {
        this.numberPartner = numberPartner;
    }

    public Integer getGenderPartner() {
        return genderPartner;
    }

    public void setGenderPartner(Integer genderPartner) {
        this.genderPartner = genderPartner;
    }
}
