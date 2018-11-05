package com.caps.asp.model.uimodel.response.common;

import com.caps.asp.model.TbRoomHasUtility;

import java.sql.Date;
import java.util.List;

public class RoomResponseModel {
    private int roomId;
    private String name;
    private Double price;
    private Integer area;
    private String address;
    private Integer maxGuest;
    private Integer currentMember;
    private int userId;
    private int cityId;
    private int districtId;
    private Date date;
    private int statusId;
    private List<TbRoomHasUtility> utilities;
    private List<String> imageUrls;
    private List<MemberResponseModel> members;
    private String description;
    private String  phoneNumber;

    public RoomResponseModel() {
    }

    public RoomResponseModel(int roomId, String name, Double price, Integer area, String address, Integer maxGuest, Integer currentMember, int userId, int cityId, int districtId, Date date, int statusId, List<TbRoomHasUtility> utilities, List<String> imageUrls, List<MemberResponseModel> members, String description, String phoneNumber) {
        this.roomId = roomId;
        this.name = name;
        this.price = price;
        this.area = area;
        this.address = address;
        this.maxGuest = maxGuest;
        this.currentMember = currentMember;
        this.userId = userId;
        this.cityId = cityId;
        this.districtId = districtId;
        this.date = date;
        this.statusId = statusId;
        this.utilities = utilities;
        this.imageUrls = imageUrls;
        this.members = members;
        this.description = description;
        this.phoneNumber = phoneNumber;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
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

    public Integer getMaxGuest() {
        return maxGuest;
    }

    public void setMaxGuest(Integer maxGuest) {
        this.maxGuest = maxGuest;
    }

    public Integer getCurrentMember() {
        return currentMember;
    }

    public void setCurrentMember(Integer currentMember) {
        this.currentMember = currentMember;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCityId() {
        return cityId;
    }

    public void setCityId(int cityId) {
        this.cityId = cityId;
    }

    public int getDistrictId() {
        return districtId;
    }

    public void setDistrictId(int districtId) {
        this.districtId = districtId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
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

    public List<MemberResponseModel> getMembers() {
        return members;
    }

    public void setMembers(List<MemberResponseModel> members) {
        this.members = members;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}
