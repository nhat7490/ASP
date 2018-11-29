package com.caps.asp.controller;

import com.caps.asp.model.TbRoom;
import com.caps.asp.model.TbRoomHasUser;
import com.caps.asp.model.TbUserRate;
import com.caps.asp.model.uimodel.request.UserRateRequestModel;
import com.caps.asp.service.RoomHasUserService;
import com.caps.asp.service.RoomService;
import com.caps.asp.service.UserRateService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Date;
import java.sql.Timestamp;

import static org.springframework.http.HttpStatus.CONFLICT;
import static org.springframework.http.HttpStatus.CREATED;

@RestController
public class UserRateController {
    private UserRateService userRateService;
    private RoomHasUserService roomHasUserService;
    private RoomService roomService;

    public UserRateController(UserRateService userRateService, RoomHasUserService roomHasUserService, RoomService roomService) {
        this.userRateService = userRateService;
        this.roomHasUserService = roomHasUserService;
        this.roomService = roomService;
    }


    @PostMapping("/userrate/create")
    public ResponseEntity createUserRate(@RequestBody UserRateRequestModel userRateRequestModel) {
        TbUserRate userRate = userRateService.findByUserIdAndOwnerId(userRateRequestModel.getUserId(), userRateRequestModel.getOwnerId());
            TbRoomHasUser roomHasUser = roomHasUserService.getCurrentRoom(userRateRequestModel.getUserId());
            if (roomHasUser != null) {
                int roomId = roomHasUser.getRoomId();
                TbRoom room = roomService.findRoomById(roomId);
                int ownerId = room.getUserId();
                if (userRateRequestModel.getOwnerId() == ownerId) {
                    if (userRate == null) {
                        TbUserRate rate = new TbUserRate();
                        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
                        rate.setDate(timestamp);
                        rate.setBehaviourRate(userRateRequestModel.getBehaviourRate());
                        rate.setLifeStyleRate(userRateRequestModel.getLifeStyleRate());
                        rate.setPaymentRate(userRateRequestModel.getPaymentRate());
                        rate.setComment(userRateRequestModel.getComment());
                        rate.setUserId(userRateRequestModel.getUserId());
                        rate.setOwnerId(userRateRequestModel.getOwnerId());
                        rate.setId(0);
                        userRateService.saveUserRate(rate);
                        return ResponseEntity.status(CREATED).build();
                    } else {
                        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
                        userRate.setDate(timestamp);
                        userRate.setPaymentRate(userRateRequestModel.getPaymentRate());
                        userRate.setLifeStyleRate(userRateRequestModel.getLifeStyleRate());
                        userRate.setBehaviourRate(userRateRequestModel.getBehaviourRate());
                        userRate.setComment(userRateRequestModel.getComment());
                        userRateService.saveUserRate(userRate);
                        return ResponseEntity.status(CREATED).build();
                    }
                }
                return ResponseEntity.status(CONFLICT).build();
            }

        return ResponseEntity.status(CONFLICT).build();
    }
}
