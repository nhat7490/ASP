package com.caps.asp.model.uimodel.response.post;

import com.caps.asp.model.TbRoomHasUtility;
import com.caps.asp.model.uimodel.response.UserResponeModel;

import java.sql.Date;
import java.util.List;

//show room post detail
public class RoomPostResponseModel extends BasePostResponeModel {
    private String name;
    private Integer area;
    private String address;
    private List<TbRoomHasUtility> utilities;
    private List<String> imageUrls;
    private Integer numberPartner;
    private Integer genderPartner;

    public RoomPostResponseModel() {
    }

    public RoomPostResponseModel(Integer postId, String phoneContact, Date date, UserResponeModel userResponeModel, boolean isFavourite, double minPrice, String name, Integer area, String address, List<TbRoomHasUtility> utilities, List<String> imageUrls, Integer numberPartner, Integer genderPartner) {
        super(postId, phoneContact, date, userResponeModel, isFavourite, minPrice);
        this.name = name;
        this.area = area;
        this.address = address;
        this.utilities = utilities;
        this.imageUrls = imageUrls;
        this.numberPartner = numberPartner;
        this.genderPartner = genderPartner;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public List<TbRoomHasUtility> getUtilities() {
        return utilities;
    }

    public void setUtilities(List<TbRoomHasUtility> utilities) {
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
