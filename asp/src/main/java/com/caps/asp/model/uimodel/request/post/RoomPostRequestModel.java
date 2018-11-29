package com.caps.asp.model.uimodel.request.post;

// find partner
public class RoomPostRequestModel extends BasePostRequestModel{
    private String name;
    private Integer numberPartner;
    private Integer genderPartner;
    private String description;
    private int roomId;

    public RoomPostRequestModel() {
    }

    public RoomPostRequestModel(Integer userId, double minPrice, String phoneContact, String name, Integer numberPartner, Integer genderPartner, String description, int roomId) {
        super(userId, minPrice, phoneContact);
        this.name = name;
        this.numberPartner = numberPartner;
        this.genderPartner = genderPartner;
        this.description = description;
        this.roomId = roomId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public Integer getNumberPartner() {
        return numberPartner;
    }

    public void setNumberPartner(Integer numberPartner) {
        this.numberPartner = numberPartner;
    }

    public Integer getGenderPartner() {
        return genderPartner;
    }

    public void setGenderPartner(Integer genderPartner) {
        this.genderPartner = genderPartner;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }
}
