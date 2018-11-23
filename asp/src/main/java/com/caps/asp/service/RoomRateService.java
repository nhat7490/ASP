package com.caps.asp.service;

import com.caps.asp.model.TbRoom;
import com.caps.asp.model.TbRoomHasUtility;
import com.caps.asp.model.TbRoomRate;
import com.caps.asp.repository.RoomRateRepository;
import org.springframework.stereotype.Service;



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


}
