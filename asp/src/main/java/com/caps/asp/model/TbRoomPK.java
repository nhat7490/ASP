package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbRoomPK implements Serializable {
    private int roomId;
    private int userId;
    private int cityId;
    private int districtId;
    private int statusId;

    @Column(name = "room_id", nullable = false)
    @Id
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    @Column(name = "user_id", nullable = false)
    @Id
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Column(name = "city_id", nullable = false)
    @Id
    public int getCityId() {
        return cityId;
    }

    public void setCityId(int cityId) {
        this.cityId = cityId;
    }

    @Column(name = "district_id", nullable = false)
    @Id
    public int getDistrictId() {
        return districtId;
    }

    public void setDistrictId(int districtId) {
        this.districtId = districtId;
    }

    @Column(name = "status_id", nullable = false)
    @Id
    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRoomPK tbRoomPK = (TbRoomPK) o;
        return roomId == tbRoomPK.roomId &&
                userId == tbRoomPK.userId &&
                cityId == tbRoomPK.cityId &&
                districtId == tbRoomPK.districtId &&
                statusId == tbRoomPK.statusId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomId, userId, cityId, districtId, statusId);
    }
}
