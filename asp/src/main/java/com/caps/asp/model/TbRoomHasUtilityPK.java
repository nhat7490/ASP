package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbRoomHasUtilityPK implements Serializable {
    private Integer roomId;
    private Integer utilityId;

    @Column(name = "room_id", nullable = false)
    @Id
    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    @Column(name = "utility_id", nullable = false)
    @Id
    public Integer getUtilityId() {
        return utilityId;
    }

    public void setUtilityId(Integer utilityId) {
        this.utilityId = utilityId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRoomHasUtilityPK that = (TbRoomHasUtilityPK) o;
        return Objects.equals(roomId, that.roomId) &&
                Objects.equals(utilityId, that.utilityId);
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomId, utilityId);
    }
}
