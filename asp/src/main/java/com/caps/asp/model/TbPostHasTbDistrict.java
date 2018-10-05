package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_post_has_tb_district", schema = "asp", catalog = "")
@IdClass(TbPostHasTbDistrictPK.class)
public class TbPostHasTbDistrict {
    private Integer tbPostPostId;
    private Integer tbDistrictDistrictId;

    @Id
    @Column(name = "tb_post_post_id", nullable = false)
    public Integer getTbPostPostId() {
        return tbPostPostId;
    }

    public void setTbPostPostId(Integer tbPostPostId) {
        this.tbPostPostId = tbPostPostId;
    }

    @Id
    @Column(name = "tb_district_district_id", nullable = false)
    public Integer getTbDistrictDistrictId() {
        return tbDistrictDistrictId;
    }

    public void setTbDistrictDistrictId(Integer tbDistrictDistrictId) {
        this.tbDistrictDistrictId = tbDistrictDistrictId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbPostHasTbDistrict that = (TbPostHasTbDistrict) o;
        return Objects.equals(tbPostPostId, that.tbPostPostId) &&
                Objects.equals(tbDistrictDistrictId, that.tbDistrictDistrictId);
    }

    @Override
    public int hashCode() {

        return Objects.hash(tbPostPostId, tbDistrictDistrictId);
    }
}
