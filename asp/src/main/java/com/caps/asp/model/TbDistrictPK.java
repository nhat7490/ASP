package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbDistrictPK implements Serializable {
    private int districtId;
    private int cityId;

    @Column(name = "district_id")
    @Id
    public int getDistrictId() {
        return districtId;
    }

    public void setDistrictId(int districtId) {
        this.districtId = districtId;
    }

    @Column(name = "city_id")
    @Id
    public int getCityId() {
        return cityId;
    }

    public void setCityId(int cityId) {
        this.cityId = cityId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbDistrictPK that = (TbDistrictPK) o;
        return districtId == that.districtId &&
                cityId == that.cityId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(districtId, cityId);
    }
}
