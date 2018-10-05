package com.caps.asp.service;

import com.caps.asp.model.TbRoom;
import com.caps.asp.repository.RoomRepository;
import org.springframework.stereotype.Service;

@Service
public class RoomService {
    public final RoomRepository roomRepository;

    public RoomService(RoomRepository roomRepository) {
        this.roomRepository = roomRepository;
    }

    public void saveRoom(TbRoom room) {
        roomRepository.save(room);
    }

    public TbRoom findRoomByName(String roomName){
        return roomRepository.findByName(roomName);
    }
}
