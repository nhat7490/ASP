package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbRatePK implements Serializable {
    private int tbUserUserId;
    private int tbRoomRoomId;

    @Column(name = "tb_user_user_id", nullable = false)
    @Id
    public int getTbUserUserId() {
        return tbUserUserId;
    }

    public void setTbUserUserId(int tbUserUserId) {
        this.tbUserUserId = tbUserUserId;
    }

    @Column(name = "tb_room_room_id", nullable = false)
    @Id
    public int getTbRoomRoomId() {
        return tbRoomRoomId;
    }

    public void setTbRoomRoomId(int tbRoomRoomId) {
        this.tbRoomRoomId = tbRoomRoomId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRatePK tbRatePK = (TbRatePK) o;
        return tbUserUserId == tbRatePK.tbUserUserId &&
                tbRoomRoomId == tbRatePK.tbRoomRoomId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(tbUserUserId, tbRoomRoomId);
    }
}
