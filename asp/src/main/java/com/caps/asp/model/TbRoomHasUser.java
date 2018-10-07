package com.caps.asp.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "tb_room_has_user", schema = "asp", catalog = "")
@IdClass(TbRoomHasUserPK.class)
public class TbRoomHasUser {
    private int roomHasUserId;
    private Date dateIn;
    private Date dateOut;
    private int userId;
    private int roomId;

    @Id
    @Column(name = "room_has_user_id", nullable = false)
    public int getRoomHasUserId() {
        return roomHasUserId;
    }

    public void setRoomHasUserId(int roomHasUserId) {
        this.roomHasUserId = roomHasUserId;
    }

    @Basic
    @Column(name = "date_in", nullable = true)
    public Date getDateIn() {
        return dateIn;
    }

    public void setDateIn(Date dateIn) {
        this.dateIn = dateIn;
    }

    @Basic
    @Column(name = "date_out", nullable = true)
    public Date getDateOut() {
        return dateOut;
    }

    public void setDateOut(Date dateOut) {
        this.dateOut = dateOut;
    }

    @Id
    @Column(name = "user_id", nullable = false)
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Id
    @Column(name = "room_id", nullable = false)
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
                Objects.equals(dateOut, that.dateOut);
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomHasUserId, dateIn, dateOut, userId, roomId);
    }
}