package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbUtilitiesReferencePK implements Serializable {
    private Integer utilityId;
    private Integer userId;

    @Column(name = "utility_id")
    @Id
    public Integer getUtilityId() {
        return utilityId;
    }

    public void setUtilityId(Integer utilityId) {
        this.utilityId = utilityId;
    }

    @Column(name = "user_id")
    @Id
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbUtilitiesReferencePK that = (TbUtilitiesReferencePK) o;
        return Objects.equals(utilityId, that.utilityId) &&
                Objects.equals(userId, that.userId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(utilityId, userId);
    }
}
