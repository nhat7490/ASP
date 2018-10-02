package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_image", schema = "asp", catalog = "")
@IdClass(TbImagePK.class)
public class TbImage {
    private int imageId;
    private String linkUrl;
    private int roomId;

    @Id
    @Column(name = "image_id", nullable = false)
    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    @Basic
    @Column(name = "link_url", nullable = true, length = 255)
    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
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
        TbImage tbImage = (TbImage) o;
        return imageId == tbImage.imageId &&
                roomId == tbImage.roomId &&
                Objects.equals(linkUrl, tbImage.linkUrl);
    }

    @Override
    public int hashCode() {

        return Objects.hash(imageId, linkUrl, roomId);
    }
}
