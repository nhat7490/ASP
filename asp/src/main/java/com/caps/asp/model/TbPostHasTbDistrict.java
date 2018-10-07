package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_post_has_tb_district", schema = "roomate", catalog = "")
@IdClass(TbPostHasTbDistrictPK.class)
public class TbPostHasTbDistrict {
    private Integer postId;
    private Integer districtId;

    @Id
    @Column(name = "post_id")
    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    @Id
    @Column(name = "district_id")
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
        TbPostHasTbDistrict that = (TbPostHasTbDistrict) o;
        return Objects.equals(postId, that.postId) &&
                Objects.equals(districtId, that.districtId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(postId, districtId);
    }
}
