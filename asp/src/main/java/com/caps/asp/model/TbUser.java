package com.caps.asp.model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "tb_user", schema = "asp", catalog = "")
@IdClass(TbUserPK.class)
public class TbUser {
    private Integer userId;
    private String username;
    private String password;
    private String email;
    private String fullname;
    private String imageProfile;
    private Timestamp dob;
    private String phone;
    private Byte gender;
    private Integer roleId;

    @Id
    @Column(name = "user_id", nullable = false)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "username", nullable = false, length = 45)
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Basic
    @Column(name = "password", nullable = false, length = 45)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "email", nullable = false, length = 100)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Basic
    @Column(name = "fullname", nullable = true, length = 100)
    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    @Basic
    @Column(name = "image_profile", nullable = true, length = 255)
    public String getImageProfile() {
        return imageProfile;
    }

    public void setImageProfile(String imageProfile) {
        this.imageProfile = imageProfile;
    }

    @Basic
    @Column(name = "dob", nullable = true)
    public Timestamp getDob() {
        return dob;
    }

    public void setDob(Timestamp dob) {
        this.dob = dob;
    }

    @Basic
    @Column(name = "phone", nullable = true, length = 15)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Basic
    @Column(name = "gender", nullable = true)
    public Byte getGender() {
        return gender;
    }

    public void setGender(Byte gender) {
        this.gender = gender;
    }

    @Id
    @Column(name = "role_id", nullable = false)
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
        TbUser tbUser = (TbUser) o;
        return Objects.equals(userId, tbUser.userId) &&
                Objects.equals(username, tbUser.username) &&
                Objects.equals(password, tbUser.password) &&
                Objects.equals(email, tbUser.email) &&
                Objects.equals(fullname, tbUser.fullname) &&
                Objects.equals(imageProfile, tbUser.imageProfile) &&
                Objects.equals(dob, tbUser.dob) &&
                Objects.equals(phone, tbUser.phone) &&
                Objects.equals(gender, tbUser.gender) &&
                Objects.equals(roleId, tbUser.roleId);
    }

    @Override
    public int hashCode() {

        return Objects.hash(userId, username, password, email, fullname, imageProfile, dob, phone, gender, roleId);
    }
}
