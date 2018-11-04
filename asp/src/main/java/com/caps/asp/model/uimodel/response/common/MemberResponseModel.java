package com.caps.asp.model.uimodel.response.common;

public class MemberResponseModel {
    private int userId;
    private int roleId;
    private String username;

    public MemberResponseModel() {
    }

    public MemberResponseModel(int userId, int roleId, String username) {
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
