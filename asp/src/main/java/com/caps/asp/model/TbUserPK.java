package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbUserPK implements Serializable {
    private Integer userId;
    private Integer roleId;

    @Column(name = "user_id", nullable = false)
    @Id
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Column(name = "role_id", nullable = false)
    @Id
    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbUserPK tbUserPK = (TbUserPK) o;
        return Objects.equals(userId, tbUserPK.userId) &&
                Objects.equals(roleId, tbUserPK.roleId);
    }

    @Override
    public int hashCode() {

        return Objects.hash(userId, roleId);
    }
}
