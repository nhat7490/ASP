package com.caps.asp.controller;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.request.MemberRequestModel;
import com.caps.asp.model.uimodel.room.RoomMemberRequestModel;
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
import java.util.stream.Collectors;

import static com.caps.asp.constant.Constant.*;
import static org.springframework.http.HttpStatus.*;

@RestController
public class RoomController {
    public final RoomService roomService;
    public final RoomHasUtilityService roomHasUtilityService;
    public final ImageService imageService;
    public final UserService userService;
    public final RoomHasUserService roomHasUserService;
    public final PostService postService;
    public final FavouriteService favouriteService;
    public final PostHasDistrictService postHasDistrictService;


    public RoomController(RoomService roomService, RoomHasUtilityService roomHasUtilityService, ImageService imageService, UserService userService, RoomHasUserService roomHasUserService, PostService postService, FavouriteService favouriteService, PostHasDistrictService postHasDistrictService) {
        this.roomService = roomService;
        this.roomHasUtilityService = roomHasUtilityService;
        this.imageService = imageService;
        this.userService = userService;
        this.roomHasUserService = roomHasUserService;
        this.postService = postService;
        this.favouriteService = favouriteService;
        this.postHasDistrictService = postHasDistrictService;
    }

    @Transactional
    @PostMapping("/room/create")
    public ResponseEntity createRoom(@RequestBody RoomModel roomModel) {
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

    }

    @Transactional
    @PutMapping("/room/update")
    public ResponseEntity updateRoom(@RequestBody RoomModel roomModel) {
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

    }

    @DeleteMapping("room/deleteRoom/{roomId}")
    public ResponseEntity deleteRoom(@PathVariable int roomId) {
        roomHasUtilityService.deleteAllRoomHasUtilityByRoomId(roomId);
        imageService.deleteAllImageByRoomId(roomId);

        roomService.deleteRoom(roomId);
        return ResponseEntity.status(OK).build();
    }

    @GetMapping("room/viewRoom/{roomId}")
    public ResponseEntity findRoom(@PathVariable String roomId) {
        if (roomId == null) {
            return ResponseEntity.status(OK).body(roomService.findAllRoom());
        } else {
            return ResponseEntity.status(OK).body(roomService.findRoomById(Integer.parseInt(roomId)));
        }
    }

    @Transactional
    @PostMapping("room/editMember")
    public ResponseEntity editMember(@RequestBody RoomMemberRequestModel roomMemberModel) {
        List<TbRoomHasUser> roomMembers = roomHasUserService.findByRoomIdAndDateOutIsNull(roomMemberModel.getRoomId());

        if (roomMemberModel.getMemberRequestModels() == null) {

            TbPost post = postService.findByRoomId(roomMemberModel.getRoomId());
//            roomHasUtilityService.deleteAllRoomHasUtilityByRoomId(roomMemberModel.getRoomId());
            postHasDistrictService.removeAllByPostId(post.getPostId());
            favouriteService.removeAllByPostId(post.getPostId());
            postService.removeByRoomId(roomMemberModel.getRoomId());

            roomMembers.forEach(tbRoomHasUser -> {

                TbUser user = userService.findById(tbRoomHasUser.getUserId());

                Date date = new Date(System.currentTimeMillis());
                tbRoomHasUser.setDateOut(date);
                roomHasUserService.saveRoomMember(tbRoomHasUser);
                user.setRoleId(MEMBER);
                userService.saveUser(user);
            });
        } else {

            List<MemberRequestModel> memberRequestModels = roomMemberModel.getMemberRequestModels();
            List<MemberRequestModel> roomHasUsersMapToMemberRequestModel = roomMembers.stream().map(tbRoomHasUser -> {
                TbUser user = userService.findById(tbRoomHasUser.getUserId());
                return new MemberRequestModel(user.getUserId(), user.getRoleId());
            }).collect(Collectors.toList());

            //Case 1: Existed in two list
            roomHasUsersMapToMemberRequestModel.stream().filter(memberRequestModels::contains).forEach(memberRequestModel -> {
                TbUser user = userService.findById(memberRequestModel.getUserId());
                user.setRoleId(memberRequestModel.getRoleId());
                userService.saveUser(user);
            });
            //Case 2: Exist in db but not in request list
            roomHasUsersMapToMemberRequestModel.stream().filter(memberRequestModel
                    -> !memberRequestModels.contains(memberRequestModel))
                    .forEach(memberRequestModel -> {
                        TbUser user = userService.findById(memberRequestModel.getUserId());
                        //Set role
                        user.setRoleId(MEMBER);
                        userService.saveUser(user);
                        //Set Date out
                        TbRoomHasUser roomHasUser = roomHasUserService.findByUserIdAndRoomId(memberRequestModel.getUserId()
                                , roomMemberModel.getRoomId());
                        Date date = new Date(System.currentTimeMillis());
                        roomHasUser.setDateOut(date);

                        roomHasUserService.saveRoomMember(roomHasUser);
                    });
            //Case 3: Exist in request list  but not in db list
            memberRequestModels.stream()
                    .filter(memberRequestModel -> !roomHasUsersMapToMemberRequestModel.contains(memberRequestModel))
                    .forEach(memberRequestModel -> {
                        TbUser user = userService.findById(memberRequestModel.getUserId());
                        //Set role
                        user.setRoleId(memberRequestModel.getRoleId());
                        userService.saveUser(user);
                        //Set Date in
                        TbRoomHasUser roomHasUser = new TbRoomHasUser();
                        Date date = new Date(System.currentTimeMillis());
                        roomHasUser.setDateIn(date);
                        roomHasUser.setUserId(memberRequestModel.getUserId());
                        roomHasUser.setRoomId(roomMemberModel.getRoomId());
                        roomHasUserService.saveRoomMember(roomHasUser);
                    });
        }
        return ResponseEntity.status(OK).build();
    }

    @DeleteMapping("/room/removeMember/{userId}")
    public ResponseEntity removeMember(@PathVariable int userId) {

        roomHasUserService.removeRoomMember(userId);
        TbUser user = userService.findById(userId);
        user.setRoleId(MEMBER);
        userService.updateUserById(user);

        TbRoomHasUser roomHasUser = roomHasUserService.findByUserId(userId);
        List<TbRoomHasUser> roomHasUsers = roomHasUserService.getAllByRoomId(roomHasUser.getRoomId());
        List<Long> milis = new ArrayList<>();

        for (TbRoomHasUser TbRoomHasUser : roomHasUsers) {
            milis.add(TbRoomHasUser.getDateIn().getTime());
        }

        Collections.sort(milis);
        for (TbRoomHasUser TbRoomHasUser : roomHasUsers) {
            if (TbRoomHasUser.getDateIn().getTime() == milis.get(milis.size() - 1)) {
                TbUser tbUser = userService.findById(TbRoomHasUser.getUserId());
                tbUser.setRoleId(ROOM_MASTER);
                userService.updateUserById(tbUser);
            }
        }
        return ResponseEntity.status(OK).build();
    }

}
