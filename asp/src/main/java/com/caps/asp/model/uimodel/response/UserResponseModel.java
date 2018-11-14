package com.caps.asp.model.uimodel.response;

import com.caps.asp.model.TbUser;

import java.sql.Date;

public class UserResponseModel {
    private Integer userId;
    private String fullname;
    private String imageProfile;
    private Date dob;
    private String phone;
    private int gender;

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
    public UserResponseModel(Integer userId, String fullname, String imageProfile, Date dob, String phone, int gender) {
        this.userId = userId;
        this.fullname = fullname;
        this.imageProfile = imageProfile;
        this.dob = dob;
        this.phone = phone;
        this.gender = gender;
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