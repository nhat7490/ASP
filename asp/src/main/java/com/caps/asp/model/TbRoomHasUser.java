package com.caps.asp.model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "tb_room_has_user", schema = "asp", catalog = "")
@IdClass(TbRoomHasUserPK.class)
public class TbRoomHasUser {
    private Integer roomHasUserId;
    private Timestamp dateIn;
    private Timestamp dateOut;
    private Byte status;
    private Integer userId;
    private Integer roomId;

    @Id
    @Column(name = "room_has_user_id", nullable = false)
    public Integer getRoomHasUserId() {
        return roomHasUserId;
    }

    public void setRoomHasUserId(Integer roomHasUserId) {
        this.roomHasUserId = roomHasUserId;
    }

    @Basic
    @Column(name = "date_in", nullable = true)
    public Timestamp getDateIn() {
        return dateIn;
    }

    public void setDateIn(Timestamp dateIn) {
        this.dateIn = dateIn;
    }

    @Basic
    @Column(name = "date_out", nullable = true)
    public Timestamp getDateOut() {
        return dateOut;
    }

    public void setDateOut(Timestamp dateOut) {
        this.dateOut = dateOut;
    }

    @Basic
    @Column(name = "status", nullable = true)
    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    @Id
    @Column(name = "user_id", nullable = false)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Id
    @Column(name = "room_id", nullable = false)
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
        TbRoomHasUser that = (TbRoomHasUser) o;
        return Objects.equals(roomHasUserId, that.roomHasUserId) &&
                Objects.equals(dateIn, that.dateIn) &&
                Objects.equals(dateOut, that.dateOut) &&
                Objects.equals(status, that.status) &&
                Objects.equals(userId, that.userId) &&
                Objects.equals(roomId, that.roomId);
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomHasUserId, dateIn, dateOut, status, userId, roomId);
    }
}
