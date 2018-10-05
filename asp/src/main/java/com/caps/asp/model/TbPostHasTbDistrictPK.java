package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbPostHasTbDistrictPK implements Serializable {
    private Integer tbPostPostId;
    private Integer tbDistrictDistrictId;

    @Column(name = "tb_post_post_id", nullable = false)
    @Id
    public Integer getTbPostPostId() {
        return tbPostPostId;
    }

    public void setTbPostPostId(Integer tbPostPostId) {
        this.tbPostPostId = tbPostPostId;
    }

    @Column(name = "tb_district_district_id", nullable = false)
    @Id
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
        TbPostHasTbDistrictPK that = (TbPostHasTbDistrictPK) o;
        return Objects.equals(tbPostPostId, that.tbPostPostId) &&
                Objects.equals(tbDistrictDistrictId, that.tbDistrictDistrictId);
    }

    @Override
    public int hashCode() {

        return Objects.hash(tbPostPostId, tbDistrictDistrictId);
    }
}
