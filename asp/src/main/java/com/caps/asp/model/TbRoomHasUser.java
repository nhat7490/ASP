package com.caps.asp.model;

import javax.persistence.*;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "tb_room_has_user", schema = "roomate", catalog = "")
@IdClass(TbRoomHasUserPK.class)
public class TbRoomHasUser {
    private Integer roomHasUserId;
    private Date dateIn;
    private Date dateOut;
    private Byte status;
    private Integer userId;
    private Integer roomId;

    @Id
    @Column(name = "room_has_user_id")
    public Integer getRoomHasUserId() {
        return roomHasUserId;
    }

    public void setRoomHasUserId(Integer roomHasUserId) {
        this.roomHasUserId = roomHasUserId;
    }

    @Basic
    @Column(name = "date_in")
    public Date getDateIn() {
        return dateIn;
    }

    public void setDateIn(Date dateIn) {
        this.dateIn = dateIn;
    }

    @Basic
    @Column(name = "date_out")
    public Date getDateOut() {
        return dateOut;
    }

    public void setDateOut(Date dateOut) {
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
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Id
    @Column(name = "room_id")
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
