package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbPostPK implements Serializable {
    private Integer postId;
    private Integer typeId;
    private Integer userId;
    private Integer roomId;

    @Column(name = "post_id")
    @Id
    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    @Column(name = "type_id")
    @Id
    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
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
        TbPostPK tbPostPK = (TbPostPK) o;
        return Objects.equals(postId, tbPostPK.postId) &&
                Objects.equals(typeId, tbPostPK.typeId) &&
                Objects.equals(userId, tbPostPK.userId) &&
                Objects.equals(roomId, tbPostPK.roomId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(postId, typeId, userId, roomId);
    }
}
