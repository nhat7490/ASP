package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbImagePK implements Serializable {
    private Integer imageId;
    private Integer roomId;

    @Column(name = "image_id")
    @Id
    public Integer getImageId() {
        return imageId;
    }

    public void setImageId(Integer imageId) {
        this.imageId = imageId;
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
        TbImagePK tbImagePK = (TbImagePK) o;
        return Objects.equals(imageId, tbImagePK.imageId) &&
                Objects.equals(roomId, tbImagePK.roomId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(imageId, roomId);
    }
}
