package com.caps.asp.repository;

import com.caps.asp.model.TbRoomHasUser;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoomHasUserRepository extends JpaRepository<TbRoomHasUser, Integer> {

    List<TbRoomHasUser> findAllByRoomId(int roomId);

    TbRoomHasUser findByUserIdAndRoomId(int userId, int roomId);

    void removeByUserId(int userId);

    TbRoomHasUser findByUserId(int userId);

    List<TbRoomHasUser> findAllByRoomIdAndDateOutIsNull(int roomId);

    TbRoomHasUser findByUserIdAndDateOutIsNull(int userId);

    void readAllByRoomId(int roomId);

    Page<TbRoomHasUser> findAllByUserIdAndDateOutIsNotNullOrderByDateOutDesc(int userId, Pageable pageable);
}
