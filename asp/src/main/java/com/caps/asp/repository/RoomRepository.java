package com.caps.asp.repository;

import com.caps.asp.model.TbRoom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoomRepository extends JpaRepository<TbRoom, Integer> {

    TbRoom findByName(String roomName);
}
