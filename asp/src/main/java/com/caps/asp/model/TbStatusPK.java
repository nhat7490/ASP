package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbStatusPK implements Serializable {
    private int statusId;
    private int roomId;

    @Column(name = "status_id")
    @Id
    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    @Column(name = "room_id")
    @Id
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbStatusPK that = (TbStatusPK) o;
        return statusId == that.statusId &&
                roomId == that.roomId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(statusId, roomId);
    }
}
