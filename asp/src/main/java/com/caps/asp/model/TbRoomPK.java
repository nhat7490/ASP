package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbRoomPK implements Serializable {
    private Integer roomId;
    private Integer userId;
    private Integer cityId;
    private Integer districtId;
    private Integer tbStatusStatusId;

    @Column(name = "room_id", nullable = false)
    @Id
    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    @Column(name = "user_id", nullable = false)
    @Id
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Column(name = "city_id", nullable = false)
    @Id
    public Integer getCityId() {
        return cityId;
    }

    public void setCityId(Integer cityId) {
        this.cityId = cityId;
    }

    @Column(name = "district_id", nullable = false)
    @Id
    public Integer getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Integer districtId) {
        this.districtId = districtId;
    }

    @Column(name = "tb_status_status_id", nullable = false)
    @Id
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
        TbRoomPK tbRoomPK = (TbRoomPK) o;
        return Objects.equals(roomId, tbRoomPK.roomId) &&
                Objects.equals(userId, tbRoomPK.userId) &&
                Objects.equals(cityId, tbRoomPK.cityId) &&
                Objects.equals(districtId, tbRoomPK.districtId) &&
                Objects.equals(tbStatusStatusId, tbRoomPK.tbStatusStatusId);
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomId, userId, cityId, districtId, tbStatusStatusId);
    }
}
