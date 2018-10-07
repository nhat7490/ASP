package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbRoomHasUtilityPK implements Serializable {
    private int roomId;
    private int utilityId;

    @Column(name = "room_id", nullable = false)
    @Id
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    @Column(name = "utility_id", nullable = false)
    @Id
    public int getUtilityId() {
        return utilityId;
    }

    public void setUtilityId(int utilityId) {
        this.utilityId = utilityId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRoomHasUtilityPK that = (TbRoomHasUtilityPK) o;
        return roomId == that.roomId &&
                utilityId == that.utilityId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomId, utilityId);
    }
}
