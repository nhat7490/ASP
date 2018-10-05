package com.caps.asp.controller;

import com.caps.asp.model.TbImage;
import com.caps.asp.model.TbRoom;
import com.caps.asp.model.TbRoomHasUtility;
import com.caps.asp.model.uimodel.RoomRequestModel;
import com.caps.asp.model.uimodel.UtilityRequestModel;
import com.caps.asp.service.ImageService;
import com.caps.asp.service.RoomHasUtilityService;
import com.caps.asp.service.RoomService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Timestamp;

import static org.springframework.http.HttpStatus.*;

@RestController
public class RoomController {
    public final RoomService roomService;
    public final RoomHasUtilityService roomHasUtilityService;
    public final ImageService imageService;

    public RoomController(RoomService roomService, RoomHasUtilityService roomHasUtilityService, ImageService imageService) {
        this.roomService = roomService;
        this.roomHasUtilityService = roomHasUtilityService;
        this.imageService = imageService;
    }

    @GetMapping("/room/create")
    public ResponseEntity createRoom(@RequestBody RoomRequestModel roomRequestModel) {
        try {
            TbRoom room = new TbRoom();
            room.setRoomId(roomRequestModel.getRoomId());
            room.setName(roomRequestModel.getName());
            room.setPrice(roomRequestModel.getPrice());
            room.setArea(roomRequestModel.getArea());
            room.setAddress(roomRequestModel.getAddress());
            room.setMaxGuest(roomRequestModel.getMaxGuest());
            room.setDate((Timestamp) roomRequestModel.getDateCreated());
            room.setCurrentNumber(roomRequestModel.getCurrentNumber());
            room.setDescription(roomRequestModel.getDescription());
            room.setTbStatusStatusId(roomRequestModel.getStatus());
            room.setUserId(roomRequestModel.getUserId());
            room.setCityId(roomRequestModel.getCityId());
            room.setDistrictId(roomRequestModel.getDistrictId());
            roomService.saveRoom(room);

            for (UtilityRequestModel utilityRequestModel : roomRequestModel.getUtilities()) {
                TbRoomHasUtility roomHasUtility = new TbRoomHasUtility();
                roomHasUtility.setRoomId(roomService.findRoomByName(roomRequestModel.getName()).getRoomId());
                roomHasUtility.setBrand(utilityRequestModel.getBrand());
                roomHasUtility.setDescription(utilityRequestModel.getDescription());
                roomHasUtility.setQuality(utilityRequestModel.getQuality());
                roomHasUtilityService.saveRoomHasUtility(roomHasUtility);
            }

            for (String url : roomRequestModel.getImageUrls()) {
                TbImage image = new TbImage();
                image.setImageId(0);
                image.setRoomId(roomService.findRoomByName(roomRequestModel.getName()).getRoomId());
                image.setLinkUrl(url);
                imageService.saveImage(image);
            }

            return ResponseEntity.status(OK).build();
        } catch (Exception e) {
            return ResponseEntity.status((CONFLICT)).build();
        }
    }
}
