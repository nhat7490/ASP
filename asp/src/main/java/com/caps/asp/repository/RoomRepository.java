package com.caps.asp.repository;

import com.caps.asp.model.TbRoom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoomRepository extends JpaRepository<TbRoom, Integer> {

    TbRoom findByName(String roomName);
    TbRoom findByRoomId(int roomId);
    void deleteByRoomId(int roomId);
    List<TbRoom> findAll();
}