package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_status", schema = "roomate", catalog = "")
public class TbStatus {
    private Integer statusId;
    private String name;

    @Id
    @Column(name = "status_id")
    public Integer getStatusId() {
        return statusId;
    }

    public void setStatusId(Integer statusId) {
        this.statusId = statusId;
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
        TbStatus tbStatus = (TbStatus) o;
        return Objects.equals(statusId, tbStatus.statusId) &&
                Objects.equals(name, tbStatus.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(statusId, name);
    }
}
