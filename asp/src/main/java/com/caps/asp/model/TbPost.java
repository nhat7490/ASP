package com.caps.asp.model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "tb_post", schema = "asp", catalog = "")
@IdClass(TbPostPK.class)
public class TbPost {
    private Integer postId;
    private String name;
    private String phoneContact;
    private Integer numberPartner;
    private Byte genderPartner;
    private Timestamp date;
    private Integer typeId;
    private Integer userId;
    private Integer roomId;

    @Id
    @Column(name = "post_id", nullable = false)
    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    @Basic
    @Column(name = "name", nullable = true, length = 45)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "phone_contact", nullable = true, length = 15)
    public String getPhoneContact() {
        return phoneContact;
    }

    public void setPhoneContact(String phoneContact) {
        this.phoneContact = phoneContact;
    }

    @Basic
    @Column(name = "number_partner", nullable = true)
    public Integer getNumberPartner() {
        return numberPartner;
    }

    public void setNumberPartner(Integer numberPartner) {
        this.numberPartner = numberPartner;
    }

    @Basic
    @Column(name = "gender_partner", nullable = true)
    public Byte getGenderPartner() {
        return genderPartner;
    }

    public void setGenderPartner(Byte genderPartner) {
        this.genderPartner = genderPartner;
    }

    @Basic
    @Column(name = "date", nullable = true)
    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    @Id
    @Column(name = "type_id", nullable = false)
    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    @Id
    @Column(name = "user_id", nullable = false)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    @Id
    @Column(name = "room_id", nullable = false)
    public Integer getRoomId() {
        return roomId;
    }

    public void setRoomId(Integer roomId) {
        this.roomId = roomId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbPost tbPost = (TbPost) o;
        return Objects.equals(postId, tbPost.postId) &&
                Objects.equals(name, tbPost.name) &&
                Objects.equals(phoneContact, tbPost.phoneContact) &&
                Objects.equals(numberPartner, tbPost.numberPartner) &&
                Objects.equals(genderPartner, tbPost.genderPartner) &&
                Objects.equals(date, tbPost.date) &&
                Objects.equals(typeId, tbPost.typeId) &&
                Objects.equals(userId, tbPost.userId) &&
                Objects.equals(roomId, tbPost.roomId);
    }

    @Override
    public int hashCode() {

        return Objects.hash(postId, name, phoneContact, numberPartner, genderPartner, date, typeId, userId, roomId);
    }
}
