package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbRoomReferencePK implements Serializable {
    private int roomId;
    private int userId;

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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRoomReferencePK that = (TbRoomReferencePK) o;
        return roomId == that.roomId &&
                userId == that.userId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomId, userId);
    }
}
