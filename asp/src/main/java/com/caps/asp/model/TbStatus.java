package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_status", schema = "asp", catalog = "")
@IdClass(TbStatusPK.class)
public class TbStatus {
    private int statusId;
    private String name;
    private int roomId;

    @Id
    @Column(name = "status_id")
    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
        TbStatus tbStatus = (TbStatus) o;
        return statusId == tbStatus.statusId &&
                roomId == tbStatus.roomId &&
                Objects.equals(name, tbStatus.name);
    }

    @Override
    public int hashCode() {

        return Objects.hash(statusId, name, roomId);
    }
}
