package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbRatePK implements Serializable {
    private Integer tbUserUserId;
    private Integer tbRoomRoomId;

    @Column(name = "tb_user_user_id")
    @Id
    public Integer getTbUserUserId() {
        return tbUserUserId;
    }

    public void setTbUserUserId(Integer tbUserUserId) {
        this.tbUserUserId = tbUserUserId;
    }

    @Column(name = "tb_room_room_id")
    @Id
    public Integer getTbRoomRoomId() {
        return tbRoomRoomId;
    }

    public void setTbRoomRoomId(Integer tbRoomRoomId) {
        this.tbRoomRoomId = tbRoomRoomId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRatePK tbRatePK = (TbRatePK) o;
        return Objects.equals(tbUserUserId, tbRatePK.tbUserUserId) &&
                Objects.equals(tbRoomRoomId, tbRatePK.tbRoomRoomId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(tbUserUserId, tbRoomRoomId);
    }
}
