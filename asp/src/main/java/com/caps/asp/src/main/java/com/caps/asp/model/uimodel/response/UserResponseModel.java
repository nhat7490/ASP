package com.caps.asp.model.uimodel.response;

import com.caps.asp.model.TbUser;
import com.caps.asp.model.TbUserRate;

import java.sql.Date;
import java.util.List;

public class UserResponseModel {
    private Integer userId;
    private String fullname;
    private String imageProfile;
    private Date dob;
    private String phone;
    private int gender;
    private List<TbUserRate> userRateList;

    public UserResponseModel() {
    }
    public UserResponseModel(TbUser user){
        this.userId = user.getUserId();
        this.fullname = user.getFullname();
        this.imageProfile = user.getImageProfile();
        this.dob = user.getDob();
        this.phone = user.getPhone();
        this.gender = user.getGender();
    }

    public UserResponseModel(Integer userId, String fullname, String imageProfile, Date dob, String phone, int gender, List<TbUserRate> userRateList) {
        this.userId = userId;
        this.fullname = fullname;
        this.imageProfile = imageProfile;
        this.dob = dob;
        this.phone = phone;
        this.gender = gender;
        this.userRateList = userRateList;
    }

    public List<TbUserRate> getUserRateList() {
        return userRateList;
    }

    public void setUserRateList(List<TbUserRate> userRateList) {
        this.userRateList = userRateList;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getImageProfile() {
        return imageProfile;
    }

    public void setImageProfile(String imageProfile) {
        this.imageProfile = imageProfile;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }
}
