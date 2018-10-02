package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbRoomHasUserPK implements Serializable {
    private int roomHasUserId;
    private int userId;
    private int roomId;

    @Column(name = "room_has_user_id", nullable = false)
    @Id
    public int getRoomHasUserId() {
        return roomHasUserId;
    }

    public void setRoomHasUserId(int roomHasUserId) {
        this.roomHasUserId = roomHasUserId;
    }

    @Column(name = "user_id", nullable = false)
    @Id
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Column(name = "room_id", nullable = false)
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
        TbRoomHasUserPK that = (TbRoomHasUserPK) o;
        return roomHasUserId == that.roomHasUserId &&
                userId == that.userId &&
                roomId == that.roomId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomHasUserId, userId, roomId);
    }
}
