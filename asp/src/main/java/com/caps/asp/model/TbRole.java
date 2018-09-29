package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_role", schema = "asp", catalog = "")
public class TbRole {
    private int roleId;
    private String rolename;

    @Id
    @Column(name = "role_id")
    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    @Basic
    @Column(name = "rolename")
    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRole tbRole = (TbRole) o;
        return roleId == tbRole.roleId &&
                Objects.equals(rolename, tbRole.rolename);
    }

    @Override
    public int hashCode() {

        return Objects.hash(roleId, rolename);
    }
}
