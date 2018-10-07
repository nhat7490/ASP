package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbPostHasTbDistrictPK implements Serializable {
    private int postId;
    private int districtId;

    @Column(name = "post_id", nullable = false)
    @Id
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    @Column(name = "district_id", nullable = false)
    @Id
    public int getDistrictId() {
        return districtId;
    }

    public void setDistrictId(int districtId) {
        this.districtId = districtId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbPostHasTbDistrictPK that = (TbPostHasTbDistrictPK) o;
        return postId == that.postId &&
                districtId == that.districtId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(postId, districtId);
    }
}
