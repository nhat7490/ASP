package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbPostPK implements Serializable {
    private int postId;
    private int typeId;
    private int userId;
    private int roomId;

    @Column(name = "post_id", nullable = false)
    @Id
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    @Column(name = "type_id", nullable = false)
    @Id
    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
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
        TbPostPK tbPostPK = (TbPostPK) o;
        return postId == tbPostPK.postId &&
                typeId == tbPostPK.typeId &&
                userId == tbPostPK.userId &&
                roomId == tbPostPK.roomId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(postId, typeId, userId, roomId);
    }
}
