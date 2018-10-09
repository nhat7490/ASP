package com.caps.asp.service;

import com.caps.asp.model.TbRoomHasUser;
import com.caps.asp.repository.RoomHasUserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoomHasUserService {
    public final RoomHasUserRepository roomHasUserRepository;

    public RoomHasUserService(RoomHasUserRepository roomHasUserRepository) {
        this.roomHasUserRepository = roomHasUserRepository;
    }

    public void addRoomMember(TbRoomHasUser tbRoomHasUser) {
        roomHasUserRepository.save(tbRoomHasUser);
    }

    public List<TbRoomHasUser> getAllByRoomId(int roomId) {
        return roomHasUserRepository.findAllByRoomId(roomId);
    }

    public TbRoomHasUser findByUserIdAndRoomId(int userId, int roomId) {
        return roomHasUserRepository.findByUserIdAndRoomId(userId, roomId);
    }
}
