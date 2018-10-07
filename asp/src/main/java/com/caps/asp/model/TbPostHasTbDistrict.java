package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_post_has_tb_district", schema = "asp", catalog = "")
@IdClass(TbPostHasTbDistrictPK.class)
public class TbPostHasTbDistrict {
    private int postId;
    private int districtId;

    @Id
    @Column(name = "post_id", nullable = false)
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    @Id
    @Column(name = "district_id", nullable = false)
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
        TbPostHasTbDistrict that = (TbPostHasTbDistrict) o;
        return postId == that.postId &&
                districtId == that.districtId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(postId, districtId);
    }
}
