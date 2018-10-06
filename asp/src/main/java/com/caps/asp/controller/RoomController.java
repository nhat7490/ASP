package com.caps.asp.controller;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.RoomRequestModel;
import com.caps.asp.model.uimodel.UtilityRequestModel;
import com.caps.asp.service.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static org.springframework.http.HttpStatus.*;

@RestController
public class RoomController {
    public final RoomService roomService;
    public final RoomHasUtilityService roomHasUtilityService;
    public final ImageService imageService;
    public final UserService userService;
    public final RoomHasUserService roomHasUserService;

    public RoomController(RoomService roomService, RoomHasUtilityService roomHasUtilityService, ImageService imageService, UserService userService, RoomHasUserService roomHasUserService) {
        this.roomService = roomService;
        this.roomHasUtilityService = roomHasUtilityService;
        this.imageService = imageService;
        this.userService = userService;
        this.roomHasUserService = roomHasUserService;
    }

    @PostMapping("/room/create")
    public ResponseEntity createRoom(@RequestBody RoomRequestModel roomRequestModel) {
        try {
            TbRoom room = new TbRoom();
            room.setRoomId(roomRequestModel.getRoomId());
            room.setName(roomRequestModel.getName());
            room.setPrice(roomRequestModel.getPrice());
            room.setArea(roomRequestModel.getArea());
            room.setAddress(roomRequestModel.getAddress());
            room.setMaxGuest(roomRequestModel.getMaxGuest());
            room.setDate(roomRequestModel.getDateCreated());
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

            return ResponseEntity.status(CREATED).build();
        } catch (Exception e) {
            return ResponseEntity.status((CONFLICT)).build();
        }
    }

    @PutMapping("/room/update")
    public ResponseEntity updateRoom(@RequestBody RoomRequestModel roomRequestModel) {
        try {
            //update room info
            TbRoom room = roomService.findRoomById(roomRequestModel.getRoomId());
            if (room != null) {
                room.setRoomId(roomRequestModel.getRoomId());
                room.setName(roomRequestModel.getName());
                room.setPrice(roomRequestModel.getPrice());
                room.setArea(roomRequestModel.getArea());
                room.setAddress(roomRequestModel.getAddress());
                room.setMaxGuest(roomRequestModel.getMaxGuest());
                room.setDate(roomRequestModel.getDateCreated());
                room.setCurrentNumber(roomRequestModel.getCurrentNumber());
                room.setDescription(roomRequestModel.getDescription());
                room.setTbStatusStatusId(roomRequestModel.getStatus());
                room.setUserId(roomRequestModel.getUserId());
                room.setCityId(roomRequestModel.getCityId());
                room.setDistrictId(roomRequestModel.getDistrictId());
                roomService.saveRoom(room);
            }

            //update room utilities
            roomHasUtilityService.deleteAllRoomHasUtilityByRoomId(roomRequestModel.getRoomId());
            for (UtilityRequestModel utilityRequestModel : roomRequestModel.getUtilities()) {
                TbRoomHasUtility roomHasUtility = new TbRoomHasUtility();
                roomHasUtility.setRoomId(roomService.findRoomByName(roomRequestModel.getName()).getRoomId());
                roomHasUtility.setBrand(utilityRequestModel.getBrand());
                roomHasUtility.setDescription(utilityRequestModel.getDescription());
                roomHasUtility.setQuality(utilityRequestModel.getQuality());
                roomHasUtilityService.saveRoomHasUtility(roomHasUtility);
            }

            //update room iamges
            imageService.deleteAllImageByRoomId(roomRequestModel.getRoomId());
            for (String url : roomRequestModel.getImageUrls()) {
                TbImage image = new TbImage();
                image.setImageId(0);
                image.setRoomId(roomService.findRoomByName(roomRequestModel.getName()).getRoomId());
                image.setLinkUrl(url);
                imageService.saveImage(image);
            }

            return ResponseEntity.status(OK).build();
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

    @DeleteMapping("room/deleteRoom/{roomId}")
    public ResponseEntity deleteRoom(@PathVariable String roomId) {
        try {
            roomService.deleteRoom(Integer.parseInt(roomId));
            roomHasUtilityService.deleteAllRoomHasUtilityByRoomId(Integer.parseInt(roomId));
            imageService.deleteAllImageByRoomId(Integer.parseInt(roomId));
            return ResponseEntity.status(OK).build();
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @GetMapping("room/viewRoom/{roomId}")
    public ResponseEntity findRoom(@PathVariable String roomId) {
        try {
            if (roomId != null) {
                return ResponseEntity.status(OK).body(roomService.findAllRoom());
            } else {
                return ResponseEntity.status(OK).body(roomService.findRoomById(Integer.parseInt(roomId)));
            }
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @PostMapping("rom/addMember/{roomId}&{username}&{dateout}")
    public ResponseEntity addMember(@PathVariable int roomId, String username, Date dateout) {
        try {
            TbUser user = userService.findByUsername(username);
            if (user != null) {
                return ResponseEntity.status(CONFLICT).build();
            } else {
                TbRoomHasUser tbRoomHasUser = new TbRoomHasUser();
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
                LocalDateTime now = LocalDateTime.now();
                String startDate = dtf.format(now);
                SimpleDateFormat sdf1 = new SimpleDateFormat("dd-mm-yyyy");
                java.util.Date date = sdf1.parse(startDate);
                java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
                tbRoomHasUser.setDateIn(sqlStartDate);
                tbRoomHasUser.setDateOut(dateout);
                tbRoomHasUser.setRoomId(roomId);
                tbRoomHasUser.setUserId(user.getUserId());
                roomHasUserService.addRoomMember(tbRoomHasUser);

                List<TbRoomHasUser> roomHasUsers = roomHasUserService.getAllByRoomId(roomId);
                List<Long> milis = new ArrayList<>();

                for (TbRoomHasUser roomHasUser : roomHasUsers) {
                    milis.add(roomHasUser.getDateIn().getTime());
                }

                Collections.sort(milis);
                for (TbRoomHasUser roomHasUser : roomHasUsers) {
                    if (roomHasUser.getDateIn().getTime() == milis.get(milis.size()-1)){
                        TbUser tbUser = userService.findById(roomHasUser.getUserId());
                        tbUser.setRoleId(3);
                        userService.updateUserById(tbUser);
                    }
                }
                return ResponseEntity.status(OK).build();

            }
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

}
