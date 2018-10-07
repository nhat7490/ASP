package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbRoomHasUserPK implements Serializable {
    private Integer roomHasUserId;
    private Integer userId;
    private Integer roomId;

    @Column(name = "room_has_user_id")
    @Id
    public Integer getRoomHasUserId() {
        return roomHasUserId;
    }

    public void setRoomHasUserId(Integer roomHasUserId) {
        this.roomHasUserId = roomHasUserId;
    }

    @Column(name = "user_id")
    @Id
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Column(name = "room_id")
    @Id
    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRoomHasUserPK that = (TbRoomHasUserPK) o;
        return Objects.equals(roomHasUserId, that.roomHasUserId) &&
                Objects.equals(userId, that.userId) &&
                Objects.equals(roomId, that.roomId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(roomHasUserId, userId, roomId);
    }
}
