package com.caps.asp.model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "tb_user", schema = "asp", catalog = "")
@IdClass(TbUserPK.class)
public class TbUser {
    private int userId;
    private String username;
    private String password;
    private String email;
    private String fullname;
    private String imageProfile;
    private Timestamp dob;
    private String phone;
    private Byte gender;
    private int roleId;

    @Id
    @Column(name = "user_id")
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "username")
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Basic
    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "fullname")
    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    @Basic
    @Column(name = "image_profile")
    public String getImageProfile() {
        return imageProfile;
    }

    public void setImageProfile(String imageProfile) {
        this.imageProfile = imageProfile;
    }

    @Basic
    @Column(name = "dob")
    public Timestamp getDob() {
        return dob;
    }

    public void setDob(Timestamp dob) {
        this.dob = dob;
    }

    @Basic
    @Column(name = "phone")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Basic
    @Column(name = "gender")
    public Byte getGender() {
        return gender;
    }

    public void setGender(Byte gender) {
        this.gender = gender;
    }

    @Id
    @Column(name = "role_id")
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
        TbUser tbUser = (TbUser) o;
        return userId == tbUser.userId &&
                roleId == tbUser.roleId &&
                Objects.equals(username, tbUser.username) &&
                Objects.equals(password, tbUser.password) &&
                Objects.equals(email, tbUser.email) &&
                Objects.equals(fullname, tbUser.fullname) &&
                Objects.equals(imageProfile, tbUser.imageProfile) &&
                Objects.equals(dob, tbUser.dob) &&
                Objects.equals(phone, tbUser.phone) &&
                Objects.equals(gender, tbUser.gender);
    }

    @Override
    public int hashCode() {

        return Objects.hash(userId, username, password, email, fullname, imageProfile, dob, phone, gender, roleId);
    }
}
