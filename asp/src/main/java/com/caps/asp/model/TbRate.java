package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_rate", schema = "roomate", catalog = "")
@IdClass(TbRatePK.class)
public class TbRate {
    private Integer tbUserUserId;
    private Integer tbRoomRoomId;
    private Double securityRating;
    private Double locationRating;
    private Double utilityRating;

    @Id
    @Column(name = "tb_user_user_id")
    public Integer getTbUserUserId() {
        return tbUserUserId;
    }

    public void setTbUserUserId(Integer tbUserUserId) {
        this.tbUserUserId = tbUserUserId;
    }

    @Id
    @Column(name = "tb_room_room_id")
    public Integer getTbRoomRoomId() {
        return tbRoomRoomId;
    }

    public void setTbRoomRoomId(Integer tbRoomRoomId) {
        this.tbRoomRoomId = tbRoomRoomId;
    }

    @Basic
    @Column(name = "security_rating")
    public Double getSecurityRating() {
        return securityRating;
    }

    public void setSecurityRating(Double securityRating) {
        this.securityRating = securityRating;
    }

    @Basic
    @Column(name = "location_rating")
    public Double getLocationRating() {
        return locationRating;
    }

    public void setLocationRating(Double locationRating) {
        this.locationRating = locationRating;
    }

    @Basic
    @Column(name = "utility_rating")
    public Double getUtilityRating() {
        return utilityRating;
    }

    public void setUtilityRating(Double utilityRating) {
        this.utilityRating = utilityRating;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRate tbRate = (TbRate) o;
        return Objects.equals(tbUserUserId, tbRate.tbUserUserId) &&
                Objects.equals(tbRoomRoomId, tbRate.tbRoomRoomId) &&
                Objects.equals(securityRating, tbRate.securityRating) &&
                Objects.equals(locationRating, tbRate.locationRating) &&
                Objects.equals(utilityRating, tbRate.utilityRating);
    }

    @Override
    public int hashCode() {
        return Objects.hash(tbUserUserId, tbRoomRoomId, securityRating, locationRating, utilityRating);
    }
}
