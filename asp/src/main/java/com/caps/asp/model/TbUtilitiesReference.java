package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_utilities_reference", schema = "asp", catalog = "")
@IdClass(TbUtilitiesReferencePK.class)
public class TbUtilitiesReference {
    private int utilityId;
    private int userId;

    @Id
    @Column(name = "utility_id", nullable = false)
    public int getUtilityId() {
        return utilityId;
    }

    public void setUtilityId(int utilityId) {
        this.utilityId = utilityId;
    }

    @Id
    @Column(name = "user_id", nullable = false)
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
        TbUtilitiesReference that = (TbUtilitiesReference) o;
        return utilityId == that.utilityId &&
                userId == that.userId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(utilityId, userId);
    }
}
