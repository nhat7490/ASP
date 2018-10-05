package com.caps.asp.model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "tb_room", schema = "asp", catalog = "")
@IdClass(TbRoomPK.class)
public class TbRoom {
    private Integer roomId;
    private String name;
    private Double price;
    private Integer area;
    private String address;
    private Integer maxGuest;
    private Integer currentNumber;
    private String description;
    private Integer userId;
    private Integer cityId;
    private Integer districtId;
    private Timestamp date;
    private Integer tbStatusStatusId;

    @Id
    @Column(name = "room_id", nullable = false)
    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    @Basic
    @Column(name = "name", nullable = true, length = 45)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "price", nullable = true, precision = 0)
    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    @Basic
    @Column(name = "area", nullable = true)
    public Integer getArea() {
        return area;
    }

    public void setArea(Integer area) {
        this.area = area;
    }

    @Basic
    @Column(name = "address", nullable = false, length = 255)
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Basic
    @Column(name = "max_guest", nullable = true)
    public Integer getMaxGuest() {
        return maxGuest;
    }

    public void setMaxGuest(Integer maxGuest) {
        this.maxGuest = maxGuest;
    }

    @Basic
    @Column(name = "current_number", nullable = true)
    public Integer getCurrentNumber() {
        return currentNumber;
    }

    public void setCurrentNumber(Integer currentNumber) {
        this.currentNumber = currentNumber;
    }

    @Basic
    @Column(name = "description", nullable = true, length = 255)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Id
    @Column(name = "user_id", nullable = false)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Id
    @Column(name = "city_id", nullable = false)
    public Integer getCityId() {
        return cityId;
    }

    public void setCityId(Integer cityId) {
        this.cityId = cityId;
    }

    @Id
    @Column(name = "district_id", nullable = false)
    public Integer getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Integer districtId) {
        this.districtId = districtId;
    }

    @Basic
    @Column(name = "date", nullable = true)
    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    @Id
    @Column(name = "tb_status_status_id", nullable = false)
    public Integer getTbStatusStatusId() {
        return tbStatusStatusId;
    }

    public void setTbStatusStatusId(Integer tbStatusStatusId) {
        this.tbStatusStatusId = tbStatusStatusId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRoom room = (TbRoom) o;
        return Objects.equals(roomId, room.roomId) &&
                Objects.equals(name, room.name) &&
                Objects.equals(price, room.price) &&
                Objects.equals(area, room.area) &&
                Objects.equals(address, room.address) &&
                Objects.equals(maxGuest, room.maxGuest) &&
                Objects.equals(currentNumber, room.currentNumber) &&
                Objects.equals(description, room.description) &&
                Objects.equals(userId, room.userId) &&
                Objects.equals(cityId, room.cityId) &&
                Objects.equals(districtId, room.districtId) &&
                Objects.equals(date, room.date) &&
                Objects.equals(tbStatusStatusId, room.tbStatusStatusId);
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomId, name, price, area, address, maxGuest, currentNumber, description, userId, cityId, districtId, date, tbStatusStatusId);
    }
}
