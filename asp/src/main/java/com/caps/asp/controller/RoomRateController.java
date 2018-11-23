package com.caps.asp.controller;

import com.caps.asp.model.TbRoomHasUser;
import com.caps.asp.model.TbRoomRate;
import com.caps.asp.model.uimodel.request.RoomRateRequestModel;
import com.caps.asp.service.RoomHasUserService;
import com.caps.asp.service.RoomRateService;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Date;

import static org.springframework.http.HttpStatus.CONFLICT;
import static org.springframework.http.HttpStatus.CREATED;


@RestController
public class RoomRateController {
    private final RoomRateService roomRateService;
    private final RoomHasUserService roomHasUserService;

    public RoomRateController(RoomRateService roomRateService, RoomHasUserService roomHasUserService) {
        this.roomRateService = roomRateService;
        this.roomHasUserService = roomHasUserService;
    }


    @Transactional
    @PostMapping("/roomrate/create")
    public ResponseEntity createRoomRate(@RequestBody RoomRateRequestModel roomRateRequestModel) {
        TbRoomRate roomRate = roomRateService.findAllByRoomIdAndUserId(roomRateRequestModel.getRoomId(), roomRateRequestModel.getUserId());
        TbRoomHasUser roomHasUser = roomHasUserService.findByUserIdAndRoomIdAndDateOutIsNull(roomRateRequestModel.getUserId(), roomRateRequestModel.getRoomId());
        if (roomHasUser != null ){
            if (roomRate == null) {
                TbRoomRate rate = new TbRoomRate();
                rate.setComment(roomRateRequestModel.getComment());
                Date date = new Date(System.currentTimeMillis());
                rate.setDate(date);
                rate.setLocationRate(roomRateRequestModel.getLocationRate());
                rate.setSecurityRate(roomRateRequestModel.getSecurityRate());
                rate.setUtilityRate(roomRateRequestModel.getUtilityRate());
                rate.setRoomId(roomRateRequestModel.getRoomId());
                rate.setUserId(roomRateRequestModel.getUserId());
                rate.setId(0);
                roomRateService.saveRoomRate(rate);
                return ResponseEntity.status(CREATED).build();
            }else{
                roomRate.setComment(roomRateRequestModel.getComment());
                roomRate.setLocationRate(roomRateRequestModel.getLocationRate());
                roomRate.setSecurityRate(roomRateRequestModel.getSecurityRate());
                roomRate.setUtilityRate(roomRateRequestModel.getUtilityRate());
                Date date = new Date(System.currentTimeMillis());
                roomRate.setDate(date);
                roomRateService.saveRoomRate(roomRate);
                return ResponseEntity.status(CREATED).build();
            }
        }
       return ResponseEntity.status(CONFLICT).build();
    }
}

