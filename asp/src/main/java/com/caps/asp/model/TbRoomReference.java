package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_room_reference", schema = "asp", catalog = "")
@IdClass(TbRoomReferencePK.class)
public class TbRoomReference {
    private int roomId;
    private int userId;

    @Id
    @Column(name = "room_id")
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    @Id
    @Column(name = "user_id")
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
        TbRoomReference that = (TbRoomReference) o;
        return roomId == that.roomId &&
                userId == that.userId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomId, userId);
    }
}
