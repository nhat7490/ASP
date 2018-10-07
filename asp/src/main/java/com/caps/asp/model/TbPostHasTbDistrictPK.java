package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbPostHasTbDistrictPK implements Serializable {
    private Integer postId;
    private Integer districtId;

    @Column(name = "post_id")
    @Id
    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    @Column(name = "district_id")
    @Id
    public Integer getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Integer districtId) {
        this.districtId = districtId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbPostHasTbDistrictPK that = (TbPostHasTbDistrictPK) o;
        return Objects.equals(postId, that.postId) &&
                Objects.equals(districtId, that.districtId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(postId, districtId);
    }
}
