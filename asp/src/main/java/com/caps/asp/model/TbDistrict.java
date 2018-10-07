package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_district", schema = "roomate", catalog = "")
@IdClass(TbDistrictPK.class)
public class TbDistrict {
    private Integer districtId;
    private String name;
    private Integer cityId;

    @Id
    @Column(name = "district_id")
    public Integer getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Integer districtId) {
        this.districtId = districtId;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Id
    @Column(name = "city_id")
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
        TbDistrict that = (TbDistrict) o;
        return Objects.equals(districtId, that.districtId) &&
                Objects.equals(name, that.name) &&
                Objects.equals(cityId, that.cityId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(districtId, name, cityId);
    }
}
