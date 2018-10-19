package com.caps.asp.controller;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.room.RoomMemberModel;
import com.caps.asp.model.uimodel.room.RoomModel;
import com.caps.asp.model.uimodel.request.UtilityRequestModel;
import com.caps.asp.service.*;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static com.caps.asp.constant.Constant.*;
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

    @Transactional
    @PostMapping("/room/create")
    public ResponseEntity createRoom(@RequestBody RoomModel roomModel) {
        try {
            TbUser user = userService.findById(roomModel.getUserId());
            int roomId = 0;
            if (user.getRoleId() == HOUSE_OWNER) {
                TbRoom room = new TbRoom();
                room.setRoomId(0);
                room.setName(roomModel.getName());
                room.setPrice(roomModel.getPrice());
                room.setArea(roomModel.getArea());
                room.setAddress(roomModel.getAddress());
                room.setMaxGuest(roomModel.getMaxGuest());

                Date date = new Date(System.currentTimeMillis());
                room.setDate(date);
                room.setCurrentNumber(0);
                room.setDescription(roomModel.getDescription());
                room.setStatusId(AUTHENTICATED);
                room.setUserId(roomModel.getUserId());
                room.setCityId(roomModel.getCityId());
                room.setDistrictId(roomModel.getDistrictId());
                room.setLattitude(roomModel.getLatitude());
                room.setLongtitude(roomModel.getLongitude());
                roomId = roomService.saveRoom(room);

                for (UtilityRequestModel utilityRequestModel : roomModel.getUtilities()) {
                    TbRoomHasUtility roomHasUtility = new TbRoomHasUtility();
                    roomHasUtility.setId(0);
                    roomHasUtility.setRoomId(roomId);
                    roomHasUtility.setBrand(utilityRequestModel.getBrand());
                    roomHasUtility.setDescription(utilityRequestModel.getDescription());
                    roomHasUtility.setQuantity(utilityRequestModel.getQuantity());
                    roomHasUtility.setUtilityId(utilityRequestModel.getUtilityId());
                    roomHasUtilityService.saveRoomHasUtility(roomHasUtility);
                }

                for (String url : roomModel.getImageUrls()) {
                    TbImage image = new TbImage();
                    image.setImageId(0);
                    image.setRoomId(roomId);
                    image.setLinkUrl(url);
                    imageService.saveImage(image);
                }
                return ResponseEntity.status(CREATED).build();
            } else {
                return ResponseEntity.status((FORBIDDEN)).build();
            }
        } catch (Exception e) {
            return ResponseEntity.status((CONFLICT)).build();
        }
    }

    @Transactional
    @PutMapping("/room/update")
    public ResponseEntity updateRoom(@RequestBody RoomModel roomModel) {
        try {
            //update room info
            TbRoom room = roomService.findRoomById(roomModel.getRoomId());
            TbUser user = userService.findById(roomModel.getUserId());
            if (room != null) {
                room.setRoomId(roomModel.getRoomId());
                room.setName(roomModel.getName());
                room.setPrice(roomModel.getPrice());
                room.setArea(roomModel.getArea());
                room.setAddress(roomModel.getAddress());
                room.setMaxGuest(roomModel.getMaxGuest());
                room.setDate(new Date(System.currentTimeMillis()));//Edit with current time not in request
                room.setCurrentNumber(roomModel.getCurrentNumber());
                room.setDescription(roomModel.getDescription());
                room.setStatusId(roomModel.getStatus());
                room.setUserId(roomModel.getUserId());
                room.setCityId(roomModel.getCityId());
                room.setDistrictId(roomModel.getDistrictId());
                room.setLongtitude(roomModel.getLongitude());
                room.setLattitude(roomModel.getLatitude());
                roomService.saveRoom(room);
            }

            //update room utilities
            roomHasUtilityService.deleteAllRoomHasUtilityByRoomId(roomModel.getRoomId());
            for (UtilityRequestModel utilityRequestModel : roomModel.getUtilities()) {
                TbRoomHasUtility roomHasUtility = new TbRoomHasUtility();
                roomHasUtility.setRoomId(roomModel.getRoomId());
                roomHasUtility.setBrand(utilityRequestModel.getBrand());
                roomHasUtility.setDescription(utilityRequestModel.getDescription());
                roomHasUtility.setQuantity(utilityRequestModel.getQuantity());
                roomHasUtilityService.saveRoomHasUtility(roomHasUtility);
            }

            //update room images
            imageService.deleteAllImageByRoomId(roomModel.getRoomId());
            for (String url : roomModel.getImageUrls()) {
                TbImage image = new TbImage();
                image.setImageId(0);
                image.setRoomId(roomModel.getRoomId());
                image.setLinkUrl(url);
                imageService.saveImage(image);
            }

            return ResponseEntity.status(OK).build();
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

    @DeleteMapping("room/deleteRoom/{roomId}")
    public ResponseEntity deleteRoom(@PathVariable int roomId) {
        try {
            roomHasUtilityService.deleteAllRoomHasUtilityByRoomId(roomId);
            imageService.deleteAllImageByRoomId(roomId);

            roomService.deleteRoom(roomId);
            return ResponseEntity.status(OK).build();
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @GetMapping("room/viewRoom/{roomId}")
    public ResponseEntity findRoom(@PathVariable String roomId) {
        try {
            if (roomId == null) {
                return ResponseEntity.status(OK).body(roomService.findAllRoom());
            } else {
                return ResponseEntity.status(OK).body(roomService.findRoomById(Integer.parseInt(roomId)));
            }
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @PostMapping("room/addMember")
    public ResponseEntity addMember(@RequestBody RoomMemberModel roomMemberModel) {
        try {
            TbUser user = userService.findByUsername(roomMemberModel.getUsername());
            if (user == null) {
                return ResponseEntity.status(CONFLICT).build();
            } else {
                Date date = new Date(System.currentTimeMillis());
                if (date.getTime() < roomMemberModel.getDateout().getTime()) {
                    return ResponseEntity.status(CONFLICT).build();
                } else {
                    TbRoomHasUser tbRoomHasUser = new TbRoomHasUser();
                    tbRoomHasUser.setUserId(user.getUserId());
                    tbRoomHasUser.setDateIn(date);
                    tbRoomHasUser.setDateOut(roomMemberModel.getDateout());
                    tbRoomHasUser.setRoomId(roomMemberModel.getRoomId());
                    tbRoomHasUser.setUserId(user.getUserId());
                    roomHasUserService.addRoomMember(tbRoomHasUser);

                    List<TbRoomHasUser> roomHasUsers = roomHasUserService.getAllByRoomId(roomMemberModel.getRoomId());
                    List<Long> milis = new ArrayList<>();

                    for (TbRoomHasUser roomHasUser : roomHasUsers) {
                        milis.add(roomHasUser.getDateIn().getTime());
                    }

                    Collections.sort(milis);
                    for (TbRoomHasUser roomHasUser : roomHasUsers) {
                        if (roomHasUser.getDateIn().getTime() == milis.get(milis.size() - 1)) {
                            TbUser tbUser = userService.findById(roomHasUser.getUserId());
                            tbUser.setRoleId(ROOM_MASTER);
                            userService.updateUserById(tbUser);
                        }
                    }
                    return ResponseEntity.status(OK).build();
                }

            }
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

}
