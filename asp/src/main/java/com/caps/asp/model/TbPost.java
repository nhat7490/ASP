package com.caps.asp.model;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Table(name = "tb_post", schema = "asp", catalog = "")
@IdClass(TbPostPK.class)
public class TbPost {
    private int postId;
    private String name;
    private Double price;
    private Integer area;
    private String address;
    private String phoneContact;
    private Integer numberPartner;
    private String description;
    private Byte genderPartner;
    private String adminFeedback;
    private Timestamp dateCreated;
    private int typeId;
    private int userId;
    private int roomId;

    @Id
    @Column(name = "post_id")
    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "price")
    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    @Basic
    @Column(name = "area")
    public Integer getArea() {
        return area;
    }

    public void setArea(Integer area) {
        this.area = area;
    }

    @Basic
    @Column(name = "address")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Basic
    @Column(name = "phone_contact")
    public String getPhoneContact() {
        return phoneContact;
    }

    public void setPhoneContact(String phoneContact) {
        this.phoneContact = phoneContact;
    }

    @Basic
    @Column(name = "number_partner")
    public Integer getNumberPartner() {
        return numberPartner;
    }

    public void setNumberPartner(Integer numberPartner) {
        this.numberPartner = numberPartner;
    }

    @Basic
    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Basic
    @Column(name = "gender_partner")
    public Byte getGenderPartner() {
        return genderPartner;
    }

    public void setGenderPartner(Byte genderPartner) {
        this.genderPartner = genderPartner;
    }

    @Basic
    @Column(name = "admin_feedback")
    public String getAdminFeedback() {
        return adminFeedback;
    }

    public void setAdminFeedback(String adminFeedback) {
        this.adminFeedback = adminFeedback;
    }

    @Basic
    @Column(name = "date_created")
    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    @Id
    @Column(name = "type_id")
    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    @Id
    @Column(name = "user_id")
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Id
    @Column(name = "room_id")
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbPost tbPost = (TbPost) o;
        return postId == tbPost.postId &&
                typeId == tbPost.typeId &&
                userId == tbPost.userId &&
                roomId == tbPost.roomId &&
                Objects.equals(name, tbPost.name) &&
                Objects.equals(price, tbPost.price) &&
                Objects.equals(area, tbPost.area) &&
                Objects.equals(address, tbPost.address) &&
                Objects.equals(phoneContact, tbPost.phoneContact) &&
                Objects.equals(numberPartner, tbPost.numberPartner) &&
                Objects.equals(description, tbPost.description) &&
                Objects.equals(genderPartner, tbPost.genderPartner) &&
                Objects.equals(adminFeedback, tbPost.adminFeedback) &&
                Objects.equals(dateCreated, tbPost.dateCreated);
    }

    @Override
    public int hashCode() {

        return Objects.hash(postId, name, price, area, address, phoneContact, numberPartner, description, genderPartner, adminFeedback, dateCreated, typeId, userId, roomId);
    }
}
