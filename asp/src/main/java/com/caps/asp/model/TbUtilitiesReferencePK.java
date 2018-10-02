package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbUtilitiesReferencePK implements Serializable {
    private int utilityId;
    private int userId;

    @Column(name = "utility_id", nullable = false)
    @Id
    public int getUtilityId() {
        return utilityId;
    }

    public void setUtilityId(int utilityId) {
        this.utilityId = utilityId;
    }

    @Column(name = "user_id", nullable = false)
    @Id
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbUtilitiesReferencePK that = (TbUtilitiesReferencePK) o;
        return utilityId == that.utilityId &&
                userId == that.userId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(utilityId, userId);
    }
}
