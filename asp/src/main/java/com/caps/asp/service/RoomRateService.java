package com.caps.asp.service;

import com.caps.asp.model.TbRoomRate;
import com.caps.asp.repository.RoomRateRepository;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class RoomRateService {
    public RoomRateRepository roomRateRepository;

    public RoomRateService(RoomRateRepository roomRateRepository) {
        this.roomRateRepository = roomRateRepository;
    }

    public TbRoomRate findAllByRoomIdAndUserId(Integer roomId, Integer userId) {
        return roomRateRepository.findByRoomIdAndUserId(roomId,userId);
    }

    public void saveRoomRate(TbRoomRate roomRate){
        roomRateRepository.saveAndFlush(roomRate);
    }


    public List<TbRoomRate> findAllByRoomId (int roomId) {
        return roomRateRepository.findAllByRoomId(roomId);
    }

    public void removeByRoomId(int roomId){
        roomRateRepository.removeAllByRoomId(roomId);
    }
}
