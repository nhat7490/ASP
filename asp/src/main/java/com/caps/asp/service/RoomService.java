package com.caps.asp.service;

import com.caps.asp.model.TbRoom;
import com.caps.asp.repository.RoomRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class RoomService {
    public final RoomRepository roomRepository;

    public RoomService(RoomRepository roomRepository) {
        this.roomRepository = roomRepository;
    }

    public int saveRoom(TbRoom room) {
        return roomRepository.saveAndFlush(room).getRoomId();
    }

    public TbRoom findRoomByName(String roomName) {
        return roomRepository.findByName(roomName);
    }

    public TbRoom findRoomById(int roomId) {
        return roomRepository.findByRoomId(roomId);
    }

    public void deleteRoom(int roomId){
        roomRepository.deleteById(roomId);
    }

    public List<TbRoom> findAllRoom(){
        return roomRepository.findAll();
    }

    public TbRoom findByUserIdAndRoomId(int userId, int roomId){
        return roomRepository.findByUserIdAndRoomId(userId, roomId);
    }

    public List<TbRoom> findAllRoomByDistrictId(int districtId) {return roomRepository.findAllByDistrictId(districtId); }
}
