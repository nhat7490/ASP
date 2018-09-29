package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbImagePK implements Serializable {
    private int imageId;
    private int roomId;

    @Column(name = "image_id")
    @Id
    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    @Column(name = "room_id")
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
        TbImagePK tbImagePK = (TbImagePK) o;
        return imageId == tbImagePK.imageId &&
                roomId == tbImagePK.roomId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(imageId, roomId);
    }
}
