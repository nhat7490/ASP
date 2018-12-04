package com.caps.asp.model.uimodel.response.common;

import com.caps.asp.model.TbUser;
import com.caps.asp.model.TbUserRate;
import com.caps.asp.model.uimodel.common.UserSuggestSettingModel;
import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Date;
import java.util.List;

public class UserResponseModel {
    private Integer userId;
    private String fullname;
    private String imageProfile;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dob;
    private String phone;
    private int gender;
    private int roleId;
    private String email;
    private String username;
    private Double avgBehaviourRate;
    private Double avgLifeStyleRate;
    private Double avgPaymentRate;
    private List<TbUserRate> userRateList;
    private UserSuggestSettingModel userSuggestSettingModel;

    public UserResponseModel() {
    }
    public UserResponseModel(TbUser user){
        this.userId = user.getUserId();
        this.fullname = user.getFullname();
        this.imageProfile = user.getImageProfile();
        this.dob = user.getDob();
        this.phone = user.getPhone();
        this.gender = user.getGender();
        this.email = user.getEmail();
        this.roleId = user.getRoleId();
        this.username = user.getUsername();
    }

    public Double getAvgBehaviourRate() {
        return avgBehaviourRate;
    }

    public void setAvgBehaviourRate(Double avgBehaviourRate) {
        this.avgBehaviourRate = avgBehaviourRate;
    }

    public Double getAvgLifeStyleRate() {
        return avgLifeStyleRate;
    }

    public void setAvgLifeStyleRate(Double avgLifeStyleRate) {
        this.avgLifeStyleRate = avgLifeStyleRate;
    }

    public Double getAvgPaymentRate() {
        return avgPaymentRate;
    }

    public void setAvgPaymentRate(Double avgPaymentRate) {
        this.avgPaymentRate = avgPaymentRate;
    }

    public UserResponseModel(Integer userId, String fullname, String imageProfile, Date dob, String phone, int gender, int roleId, String email, String username, Double avgBehaviourRate, Double avgLifeStyleRate, Double avgPaymentRate, List<TbUserRate> userRateList, UserSuggestSettingModel userSuggestSettingModel) {
        this.userId = userId;
        this.fullname = fullname;
        this.imageProfile = imageProfile;
        this.dob = dob;
        this.phone = phone;
        this.gender = gender;
        this.roleId = roleId;
        this.email = email;
        this.username = username;
        this.avgBehaviourRate = avgBehaviourRate;
        this.avgLifeStyleRate = avgLifeStyleRate;
        this.avgPaymentRate = avgPaymentRate;
        this.userRateList = userRateList;
        this.userSuggestSettingModel = userSuggestSettingModel;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public UserSuggestSettingModel getUserSuggestSettingModel() {
        return userSuggestSettingModel;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setUserSuggestSettingModel(UserSuggestSettingModel userSuggestSettingModel) {
        this.userSuggestSettingModel = userSuggestSettingModel;
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
