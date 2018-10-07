package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_image", schema = "roomate", catalog = "")
@IdClass(TbImagePK.class)
public class TbImage {
    private Integer imageId;
    private String linkUrl;
    private Integer roomId;

    @Id
    @Column(name = "image_id")
    public Integer getImageId() {
        return imageId;
    }

    public void setImageId(Integer imageId) {
        this.imageId = imageId;
    }

    @Basic
    @Column(name = "link_url")
    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
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
        TbImage tbImage = (TbImage) o;
        return Objects.equals(imageId, tbImage.imageId) &&
                Objects.equals(linkUrl, tbImage.linkUrl) &&
                Objects.equals(roomId, tbImage.roomId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(imageId, linkUrl, roomId);
    }
}
