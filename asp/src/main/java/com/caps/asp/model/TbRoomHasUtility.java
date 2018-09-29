package com.caps.asp.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "tb_room_has_utility", schema = "asp", catalog = "")
@IdClass(TbRoomHasUtilityPK.class)
public class TbRoomHasUtility {
    private int roomId;
    private int utilityId;

    @Id
    @Column(name = "room_id")
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    @Id
    @Column(name = "utility_id")
    public int getUtilityId() {
        return utilityId;
    }

    public void setUtilityId(int utilityId) {
        this.utilityId = utilityId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TbRoomHasUtility that = (TbRoomHasUtility) o;
        return roomId == that.roomId &&
                utilityId == that.utilityId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(roomId, utilityId);
    }
}
