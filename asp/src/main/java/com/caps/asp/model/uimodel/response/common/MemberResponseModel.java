package com.caps.asp.model.uimodel.response.common;

public class MemberResponseModel {
    private int userId;
    private int roleId;
    private int username;

    public MemberResponseModel() {
    }

    public MemberResponseModel(int userId, int roleId, int username) {
        this.userId = userId;
        this.roleId = roleId;
        this.username = username;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public int getUsername() {
        return username;
    }

    public void setUsername(int username) {
        this.username = username;
    }
}
