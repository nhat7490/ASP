package com.caps.asp.model.uimodel.room;

import java.sql.Date;

public class RoomMemberModel {
     private int roomId;
     private String username;
     private Date dateout;

    public RoomMemberModel(int roomId, String username, Date dateout) {
        this.roomId = roomId;
        this.username = username;
        this.dateout = dateout;
    }

    public RoomMemberModel() {
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getDateout() {
        return dateout;
    }

    public void setDateout(Date dateout) {
        this.dateout = dateout;
    }
}
