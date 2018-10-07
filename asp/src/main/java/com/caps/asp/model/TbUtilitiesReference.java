package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_utilities_reference", schema = "roomate", catalog = "")
@IdClass(TbUtilitiesReferencePK.class)
public class TbUtilitiesReference {
    private Integer utilityId;
    private Integer userId;

    @Id
    @Column(name = "utility_id")
    public Integer getUtilityId() {
        return utilityId;
    }

    public void setUtilityId(Integer utilityId) {
        this.utilityId = utilityId;
    }

    @Id
    @Column(name = "user_id")
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
        TbUtilitiesReference that = (TbUtilitiesReference) o;
        return Objects.equals(utilityId, that.utilityId) &&
                Objects.equals(userId, that.userId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(utilityId, userId);
    }
}
