package com.caps.asp.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "tb_room", schema = "roomate", catalog = "")
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
    private Date date;
    private Integer tbStatusStatusId;
    private Double longtitude;
    private Double lattitude;

    @Id
    @Column(name = "room_id")
    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
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
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Id
    @Column(name = "city_id")
    public Integer getCityId() {
        return cityId;
    }

    public void setCityId(Integer cityId) {
        this.cityId = cityId;
    }

    @Id
    @Column(name = "district_id")
    public Integer getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Integer districtId) {
        this.districtId = districtId;
    }

    @Basic
    @Column(name = "date")
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Id
    @Column(name = "tb_status_status_id")
    public Integer getTbStatusStatusId() {
        return tbStatusStatusId;
    }

    public void setTbStatusStatusId(Integer tbStatusStatusId) {
        this.tbStatusStatusId = tbStatusStatusId;
    }

    @Basic
    @Column(name = "longtitude")
    public Double getLongtitude() {
        return longtitude;
    }

    public void setLongtitude(Double longtitude) {
        this.longtitude = longtitude;
    }

    @Basic
    @Column(name = "lattitude")
    public Double getLattitude() {
        return lattitude;
    }

    public void setLattitude(Double lattitude) {
        this.lattitude = lattitude;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRoom tbRoom = (TbRoom) o;
        return Objects.equals(roomId, tbRoom.roomId) &&
                Objects.equals(name, tbRoom.name) &&
                Objects.equals(price, tbRoom.price) &&
                Objects.equals(area, tbRoom.area) &&
                Objects.equals(address, tbRoom.address) &&
                Objects.equals(maxGuest, tbRoom.maxGuest) &&
                Objects.equals(currentNumber, tbRoom.currentNumber) &&
                Objects.equals(description, tbRoom.description) &&
                Objects.equals(userId, tbRoom.userId) &&
                Objects.equals(cityId, tbRoom.cityId) &&
                Objects.equals(districtId, tbRoom.districtId) &&
                Objects.equals(date, tbRoom.date) &&
                Objects.equals(tbStatusStatusId, tbRoom.tbStatusStatusId) &&
                Objects.equals(longtitude, tbRoom.longtitude) &&
                Objects.equals(lattitude, tbRoom.lattitude);
    }

    @Override
    public int hashCode() {
        return Objects.hash(roomId, name, price, area, address, maxGuest, currentNumber, description, userId, cityId, districtId, date, tbStatusStatusId, longtitude, lattitude);
    }
}
