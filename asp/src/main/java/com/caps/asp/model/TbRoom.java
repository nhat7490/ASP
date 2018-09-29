package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_room", schema = "asp", catalog = "")
@IdClass(TbRoomPK.class)
public class TbRoom {
    private int roomId;
    private String name;
    private Double price;
    private Integer area;
    private String address;
    private Integer maxGuest;
    private Integer currentNumber;
    private String description;
    private int userId;
    private int cityId;
    private int districtId;

    @Id
    @Column(name = "room_id")
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "price")
    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    @Basic
    @Column(name = "area")
    public Integer getArea() {
        return area;
    }

    public void setArea(Integer area) {
        this.area = area;
    }

    @Basic
    @Column(name = "address")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Basic
    @Column(name = "max_guest")
    public Integer getMaxGuest() {
        return maxGuest;
    }

    public void setMaxGuest(Integer maxGuest) {
        this.maxGuest = maxGuest;
    }

    @Basic
    @Column(name = "current_number")
    public Integer getCurrentNumber() {
        return currentNumber;
    }

    public void setCurrentNumber(Integer currentNumber) {
        this.currentNumber = currentNumber;
    }

    @Basic
    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Id
    @Column(name = "user_id")
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Id
    @Column(name = "city_id")
    public int getCityId() {
        return cityId;
    }

    public void setCityId(int cityId) {
        this.cityId = cityId;
    }

    @Id
    @Column(name = "district_id")
    public int getDistrictId() {
        return districtId;
    }

    public void setDistrictId(int districtId) {
        this.districtId = districtId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRoom tbRoom = (TbRoom) o;
        return roomId == tbRoom.roomId &&
                userId == tbRoom.userId &&
                cityId == tbRoom.cityId &&
                districtId == tbRoom.districtId &&
                Objects.equals(name, tbRoom.name) &&
                Objects.equals(price, tbRoom.price) &&
                Objects.equals(area, tbRoom.area) &&
                Objects.equals(address, tbRoom.address) &&
                Objects.equals(maxGuest, tbRoom.maxGuest) &&
                Objects.equals(currentNumber, tbRoom.currentNumber) &&
                Objects.equals(description, tbRoom.description);
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomId, name, price, area, address, maxGuest, currentNumber, description, userId, cityId, districtId);
    }
}
