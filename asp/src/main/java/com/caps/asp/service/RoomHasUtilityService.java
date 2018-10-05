package com.caps.asp.service;

import com.caps.asp.model.TbRoomHasUtility;
import com.caps.asp.repository.RoomHasUtilityRepository;
import org.springframework.stereotype.Service;

@Service
public class RoomHasUtilityService {
    public final RoomHasUtilityRepository roomHasUtilityRepository;

    public RoomHasUtilityService(RoomHasUtilityRepository roomHasUtilityRepository) {
        this.roomHasUtilityRepository = roomHasUtilityRepository;
    }

    public void saveRoomHasUtility(TbRoomHasUtility roomHasUtility){
        roomHasUtilityRepository.save(roomHasUtility);
    }
}
