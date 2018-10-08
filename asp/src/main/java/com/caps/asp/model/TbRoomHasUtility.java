package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_room_has_utility", schema = "asp", catalog = "")
public class TbRoomHasUtility {
    private Integer id;
    private Integer roomId;
    private Integer utilityId;
    private String brand;
    private String description;
    private Integer quality;

    @Id
    @Column(name = "id", nullable = false)
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Basic
    @Column(name = "room_id", nullable = false)
    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    @Basic
    @Column(name = "utility_id", nullable = false)
    public Integer getUtilityId() {
        return utilityId;
    }

    public void setUtilityId(Integer utilityId) {
        this.utilityId = utilityId;
    }

    @Basic
    @Column(name = "brand", nullable = true, length = 45)
    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    @Basic
    @Column(name = "description", nullable = true, length = 45)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Basic
    @Column(name = "quality", nullable = true)
    public Integer getQuality() {
        return quality;
    }

    public void setQuality(Integer quality) {
        this.quality = quality;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRoomHasUtility that = (TbRoomHasUtility) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(roomId, that.roomId) &&
                Objects.equals(utilityId, that.utilityId) &&
                Objects.equals(brand, that.brand) &&
                Objects.equals(description, that.description) &&
                Objects.equals(quality, that.quality);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, roomId, utilityId, brand, description, quality);
    }
}
