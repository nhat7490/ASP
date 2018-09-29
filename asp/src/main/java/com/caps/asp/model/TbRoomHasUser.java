package com.caps.asp.model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "tb_room_has_user", schema = "asp", catalog = "")
@IdClass(TbRoomHasUserPK.class)
public class TbRoomHasUser {
    private int roomHasUserId;
    private Timestamp dateIn;
    private Timestamp dateOut;
    private Byte status;
    private int userId;
    private int roomId;

    @Id
    @Column(name = "room_has_user_id")
    public int getRoomHasUserId() {
        return roomHasUserId;
    }

    public void setRoomHasUserId(int roomHasUserId) {
        this.roomHasUserId = roomHasUserId;
    }

    @Basic
    @Column(name = "date_in")
    public Timestamp getDateIn() {
        return dateIn;
    }

    public void setDateIn(Timestamp dateIn) {
        this.dateIn = dateIn;
    }

    @Basic
    @Column(name = "date_out")
    public Timestamp getDateOut() {
        return dateOut;
    }

    public void setDateOut(Timestamp dateOut) {
        this.dateOut = dateOut;
    }

    @Basic
    @Column(name = "status")
    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    @Id
    @Column(name = "user_id")
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Id
    @Column(name = "room_id")
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
        TbRoomHasUser that = (TbRoomHasUser) o;
        return roomHasUserId == that.roomHasUserId &&
                userId == that.userId &&
                roomId == that.roomId &&
                Objects.equals(dateIn, that.dateIn) &&
                Objects.equals(dateOut, that.dateOut) &&
                Objects.equals(status, that.status);
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomHasUserId, dateIn, dateOut, status, userId, roomId);
    }
}
