package com.caps.asp.repository;

import com.caps.asp.model.TbRoomHasUtility;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoomHasUtilityRepository extends JpaRepository<TbRoomHasUtility, Integer> {
    void deleteAllByRoomId(int roomId);
}
