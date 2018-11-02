package com.caps.asp.controller;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.request.MemberRequestModel;
import com.caps.asp.model.uimodel.response.common.MemberResponseModel;
import com.caps.asp.model.uimodel.response.common.RoomResponseModel;
import com.caps.asp.model.uimodel.room.RoomMemberRequestModel;
import com.caps.asp.model.uimodel.room.RoomRequestModel;
import com.caps.asp.model.uimodel.request.UtilityRequestModel;
import com.caps.asp.service.*;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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
    public ResponseEntity createRoom(@RequestBody RoomRequestModel roomRequestModel) {
        TbUser user = userService.findById(roomRequestModel.getUserId());
        int roomId = 0;
        if (user.getRoleId() == HOUSE_OWNER) {
            TbRoom room = new TbRoom();
            room.setRoomId(0);
            room.setName(roomRequestModel.getName());
            room.setPrice(roomRequestModel.getPrice());
            room.setArea(roomRequestModel.getArea());
            room.setAddress(roomRequestModel.getAddress());
            room.setMaxGuest(roomRequestModel.getMaxGuest());

            Date date = new Date(System.currentTimeMillis());
            room.setDate(date);
            room.setCurrentNumber(0);
            room.setDescription(roomRequestModel.getDescription());
            room.setStatusId(AUTHENTICATED);
            room.setUserId(roomRequestModel.getUserId());
            room.setCityId(roomRequestModel.getCityId());
            room.setDistrictId(roomRequestModel.getDistrictId());
            room.setLattitude(roomRequestModel.getLatitude());
            room.setLongtitude(roomRequestModel.getLongitude());
            roomId = roomService.saveRoom(room);

            for (UtilityRequestModel utilityRequestModel : roomRequestModel.getUtilities()) {
                TbRoomHasUtility roomHasUtility = new TbRoomHasUtility();
                roomHasUtility.setId(0);
                roomHasUtility.setRoomId(roomId);
                roomHasUtility.setBrand(utilityRequestModel.getBrand());
                roomHasUtility.setDescription(utilityRequestModel.getDescription());
                roomHasUtility.setQuantity(utilityRequestModel.getQuantity());
                roomHasUtility.setUtilityId(utilityRequestModel.getUtilityId());
                roomHasUtilityService.saveRoomHasUtility(roomHasUtility);
            }

            for (String url : roomRequestModel.getImageUrls()) {
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
    public ResponseEntity updateRoom(@RequestBody RoomRequestModel roomRequestModel) {
        //update room info
        TbRoom room = roomService.findRoomById(roomRequestModel.getRoomId());
        TbUser user = userService.findById(roomRequestModel.getUserId());
        if (room != null) {
            room.setRoomId(roomRequestModel.getRoomId());
            room.setName(roomRequestModel.getName());
            room.setPrice(roomRequestModel.getPrice());
            room.setArea(roomRequestModel.getArea());
            room.setAddress(roomRequestModel.getAddress());
            room.setMaxGuest(roomRequestModel.getMaxGuest());
            room.setDate(new Date(System.currentTimeMillis()));//Edit with current time not in request
            room.setCurrentNumber(roomRequestModel.getCurrentNumber());
            room.setDescription(roomRequestModel.getDescription());
            room.setStatusId(roomRequestModel.getStatus());
            room.setUserId(roomRequestModel.getUserId());
            room.setCityId(roomRequestModel.getCityId());
            room.setDistrictId(roomRequestModel.getDistrictId());
            room.setLongtitude(roomRequestModel.getLongitude());
            room.setLattitude(roomRequestModel.getLatitude());
            roomService.saveRoom(room);
        }

        //update room utilities
        roomHasUtilityService.deleteAllRoomHasUtilityByRoomId(roomRequestModel.getRoomId());
        for (UtilityRequestModel utilityRequestModel : roomRequestModel.getUtilities()) {
            TbRoomHasUtility roomHasUtility = new TbRoomHasUtility();
            roomHasUtility.setRoomId(roomRequestModel.getRoomId());
            roomHasUtility.setBrand(utilityRequestModel.getBrand());
            roomHasUtility.setDescription(utilityRequestModel.getDescription());
            roomHasUtility.setQuantity(utilityRequestModel.getQuantity());
            roomHasUtilityService.saveRoomHasUtility(roomHasUtility);
        }

        //update room images
        imageService.deleteAllImageByRoomId(roomRequestModel.getRoomId());
        for (String url : roomRequestModel.getImageUrls()) {
            TbImage image = new TbImage();
            image.setImageId(0);
            image.setRoomId(roomRequestModel.getRoomId());
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

    @GetMapping("room/user/{userId}")
    public ResponseEntity findRoomByUserId(@PathVariable Integer userId,Pageable pageable) {
        if (userId != null) {
            List<TbRoom> rooms = roomService.findAllRoomByUserId(userId,PageRequest.of(pageable.getPageNumber() -1,pageable.getPageSize())).getContent();
            List<RoomResponseModel> roomResponseModels = new ArrayList();
            rooms.forEach(tbRoom -> {
                RoomResponseModel roomResponseModel = new RoomResponseModel();
                roomResponseModel.setRoomId(tbRoom.getRoomId());
                roomResponseModel.setName(tbRoom.getName());
                roomResponseModel.setPrice(tbRoom.getPrice());
                roomResponseModel.setArea(tbRoom.getArea());
                roomResponseModel.setAddress(tbRoom.getAddress());
                roomResponseModel.setMaxGuest(tbRoom.getMaxGuest());
                roomResponseModel.setCurrentMember(tbRoom.getCurrentNumber());
                roomResponseModel.setUserId(tbRoom.getUserId());
                roomResponseModel.setCityId(tbRoom.getCityId());
                roomResponseModel.setDistrictId(tbRoom.getDistrictId());
                roomResponseModel.setDate(tbRoom.getDate());
                roomResponseModel.setStatusId(tbRoom.getStatusId());
                roomResponseModel.setDescription(tbRoom.getDescription());

                roomResponseModel.setUtilities(roomHasUtilityService.findAllByRoomId(tbRoom.getRoomId()));
                roomResponseModel.setImageUrls(imageService.findAllByRoomId(tbRoom.getRoomId()).stream().map(tbImage -> tbImage.getLinkUrl()).collect(Collectors.toList()));
                roomResponseModel.setMembers(roomHasUserService.findByRoomIdAndDateOutIsNull(tbRoom.getRoomId()).stream().map(tbRoomHasUser -> {
                    return new MemberResponseModel(tbRoomHasUser.getUserId(),tbRoomHasUser.getRoomId(),userService.findById(tbRoomHasUser.getUserId()).getRoleId());
                }).collect(Collectors.toList()));
                roomResponseModels.add(roomResponseModel);
            });
            return ResponseEntity.status(OK).body(roomResponseModels);
        } else {
            return ResponseEntity.status(NOT_FOUND).build();
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
