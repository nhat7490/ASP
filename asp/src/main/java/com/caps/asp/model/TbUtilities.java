package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_utilities", schema = "roomate", catalog = "")
public class TbUtilities {
    private Integer utilityId;
    private String name;

    @Id
    @Column(name = "utility_id")
    public Integer getUtilityId() {
        return utilityId;
    }

    public void setUtilityId(Integer utilityId) {
        this.utilityId = utilityId;
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
        TbUtilities that = (TbUtilities) o;
        return Objects.equals(utilityId, that.utilityId) &&
                Objects.equals(name, that.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(utilityId, name);
    }
}
