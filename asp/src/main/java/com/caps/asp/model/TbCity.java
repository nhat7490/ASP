package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_city", schema = "asp", catalog = "")
public class TbCity {
    private int cityId;
    private String name;

    @Id
    @Column(name = "city_id", nullable = false)
    public int getCityId() {
        return cityId;
    }

    public void setCityId(int cityId) {
        this.cityId = cityId;
    }

    @Basic
    @Column(name = "name", nullable = true, length = 45)
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
        return cityId == tbCity.cityId &&
                Objects.equals(name, tbCity.name);
    }

    @Override
    public int hashCode() {

        return Objects.hash(cityId, name);
    }
}