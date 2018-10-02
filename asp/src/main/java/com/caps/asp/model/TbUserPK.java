package com.caps.asp.model;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;
import java.util.Objects;

public class TbUserPK implements Serializable {
    private int userId;
    private int roleId;

    @Column(name = "user_id", nullable = false)
    @Id
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Column(name = "role_id", nullable = false)
    @Id
    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbUserPK tbUserPK = (TbUserPK) o;
        return userId == tbUserPK.userId &&
                roleId == tbUserPK.roleId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(userId, roleId);
    }
}
