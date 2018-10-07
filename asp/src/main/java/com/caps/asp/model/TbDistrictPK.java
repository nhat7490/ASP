package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbDistrictPK implements Serializable {
    private Integer districtId;
    private Integer cityId;

    @Column(name = "district_id")
    @Id
    public Integer getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Integer districtId) {
        this.districtId = districtId;
    }

    @Column(name = "city_id")
    @Id
    public Integer getCityId() {
        return cityId;
    }

    public void setCityId(Integer cityId) {
        this.cityId = cityId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbDistrictPK that = (TbDistrictPK) o;
        return Objects.equals(districtId, that.districtId) &&
                Objects.equals(cityId, that.cityId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(districtId, cityId);
    }
}
