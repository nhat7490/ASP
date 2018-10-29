package com.caps.asp.repository;

import com.caps.asp.model.TbRoomHasUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoomHasUserRepository extends JpaRepository<TbRoomHasUser, Integer> {

    List<TbRoomHasUser> findAllByRoomId(int roomId);
    TbRoomHasUser findByUserIdAndRoomId(int userId, int roomId);
}
