package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_city", schema = "roomate", catalog = "")
public class TbCity {
    private Integer cityId;
    private String name;

    @Id
    @Column(name = "city_id")
    public Integer getCityId() {
        return cityId;
    }

    public void setCityId(Integer cityId) {
        this.cityId = cityId;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbCity tbCity = (TbCity) o;
        return Objects.equals(cityId, tbCity.cityId) &&
                Objects.equals(name, tbCity.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cityId, name);
    }
}
