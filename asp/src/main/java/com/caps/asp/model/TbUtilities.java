package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_utilities", schema = "asp", catalog = "")
public class TbUtilities {
    private int utilityId;
    private String name;

    @Id
    @Column(name = "utility_id", nullable = false)
    public int getUtilityId() {
        return utilityId;
    }

    public void setUtilityId(int utilityId) {
        this.utilityId = utilityId;
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
        TbUtilities that = (TbUtilities) o;
        return utilityId == that.utilityId &&
                Objects.equals(name, that.name);
    }

    @Override
    public int hashCode() {

        return Objects.hash(utilityId, name);
    }
}
