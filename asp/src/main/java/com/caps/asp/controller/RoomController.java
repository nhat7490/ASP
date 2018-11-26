package com.caps.asp.controller;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.request.MemberRequestModel;
import com.caps.asp.model.uimodel.response.common.UserResponseModel;
import com.caps.asp.model.uimodel.response.common.MemberResponseModel;
import com.caps.asp.model.uimodel.response.common.RoomRateResponseModel;
import com.caps.asp.model.uimodel.response.common.RoomResponseModel;
import com.caps.asp.model.uimodel.request.common.RoomMemberRequestModel;
import com.caps.asp.model.uimodel.request.common.RoomRequestModel;
import com.caps.asp.model.uimodel.request.UtilityRequestModel;
import com.caps.asp.service.*;
import org.springframework.data.domain.Page;
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
    public final PostHasUtilityService postHasUtilityService;
    public final ImageService imageService;
    public final UserService userService;
    public final RoomHasUserService roomHasUserService;
    public final PostService postService;
    public final FavouriteService favouriteService;
    public final PostHasDistrictService postHasDistrictService;
    public final AmazonService amazonService;
    public final RoomRateService roomRateService;
    public final UserRateService userRateService;


    public RoomController(RoomService roomService, RoomHasUtilityService roomHasUtilityService, PostHasUtilityService postHasUtilityService, ImageService imageService, UserService userService, RoomHasUserService roomHasUserService, PostService postService, FavouriteService favouriteService, PostHasDistrictService postHasDistrictService, AmazonService amazonService, RoomRateService roomRateService, UserRateService userRateService) {
        this.roomService = roomService;
        this.roomHasUtilityService = roomHasUtilityService;
        this.postHasUtilityService = postHasUtilityService;
        this.imageService = imageService;
        this.userService = userService;
        this.roomHasUserService = roomHasUserService;
        this.postService = postService;
        this.favouriteService = favouriteService;
        this.postHasDistrictService = postHasDistrictService;
        this.amazonService = amazonService;
        this.roomRateService = roomRateService;
        this.userRateService = userRateService;
    }

    @Transactional
    @PostMapping("/room/create")
    public ResponseEntity createRoom(@RequestBody RoomRequestModel roomRequestModel) {
        try {
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
                room.setStatusId(PENDING);
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
        } catch (Exception e) {
            return ResponseEntity.status(FORBIDDEN).build();
        }
    }

    @Transactional
    @PutMapping("/room/update")
    public ResponseEntity updateRoom(@RequestBody RoomRequestModel roomRequestModel) {
        try {
            //update room info
            TbRoom room = roomService.findRoomById(roomRequestModel.getRoomId());
            TbUser user = userService.findById(roomRequestModel.getUserId());

            if (user.getRoleId() == HOUSE_OWNER) {
                List<TbRoomHasUser> roomHasUsers = roomHasUserService.findByRoomIdAndDateOutIsNull(roomRequestModel.getRoomId());
                if (room != null && roomHasUsers.size() < roomRequestModel.getCurrentMember()) {
                    room.setRoomId(roomRequestModel.getRoomId());
                    room.setName(roomRequestModel.getName());
                    room.setPrice(roomRequestModel.getPrice());
                    room.setArea(roomRequestModel.getArea());
                    room.setMaxGuest(roomRequestModel.getMaxGuest());
                    room.setCurrentNumber(roomRequestModel.getCurrentMember());
                    room.setDescription(roomRequestModel.getDescription());
                    room.setStatusId(PENDING);
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
                    roomHasUtility.setId(0);
                    roomHasUtility.setUtilityId(utilityRequestModel.getUtilityId());
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

                roomHasUsers.forEach(tbRoomHasUser -> {
                    TbUser tbUser = userService.findById(tbRoomHasUser.getUserId());

                    if (tbUser.getRoleId() == ROOM_MASTER) {
                        TbPost post = postService.findAllByUserIdAndRoomIdOrderByDatePostDesc(tbUser.getUserId()
                                , roomRequestModel.getRoomId());

                        if (post != null && post.getDatePost().getTime() > tbRoomHasUser.getDateIn().getTime()) {
                            post.setMinPrice(roomRequestModel.getPrice());
                            postService.savePost(post);
                            postHasUtilityService.deleteAllPostHasUtilityByPostId(roomRequestModel.getRoomId());

                            for (UtilityRequestModel utilityRequestModel : roomRequestModel.getUtilities()) {
                                TbPostHasUtility postHasUtility = new TbPostHasUtility();
                                postHasUtility.setId(0);
                                postHasUtility.setUtilityId(utilityRequestModel.getUtilityId());
                                postHasUtility.setPostId(post.getPostId());
                                postHasUtility.setBrand(utilityRequestModel.getBrand());
                                postHasUtility.setDescription(utilityRequestModel.getDescription());
                                postHasUtility.setQuantity(utilityRequestModel.getQuantity());
                                postHasUtilityService.save(postHasUtility);
                            }
                        }
                    }
                });
                return ResponseEntity.status(OK).build();
            }
            return ResponseEntity.status(CONFLICT).build();
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

    @Transactional
    @DeleteMapping("room/deleteRoom/{roomId}")
    public ResponseEntity deleteRoom(@PathVariable int roomId) {
        try {
            roomHasUtilityService.deleteAllRoomHasUtilityByRoomId(roomId);
            imageService.deleteAllImageByRoomId(roomId);

            List<TbRoomHasUser> roomHasUsers = roomHasUserService.getAllByRoomId(roomId);
            roomHasUsers.forEach(tbRoomHasUser -> {
                TbUser tbUser = userService.findById(tbRoomHasUser.getUserId());

                if (tbUser.getRoleId() == ROOM_MASTER) {
                    tbUser.setRoleId(MEMBER);
                    userService.saveUser(tbUser);
                }
            });

            roomHasUserService.removeAllByRoomId(roomId);

            List<TbPost> posts = postService.findAllByRoomId(roomId);
            posts.forEach(tbPost -> {
                favouriteService.removeAllByPostId(tbPost.getPostId());
                postHasDistrictService.removeAllByPostId(tbPost.getPostId());
                postHasUtilityService.deleteAllPostHasUtilityByPostId(tbPost.getPostId());
                postService.removeByRoomId(roomId);
            });
            roomRateService.removeByRoomId(roomId);
            roomService.deleteRoom(roomId);
            return ResponseEntity.status(OK).build();
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
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

    @GetMapping("room/user/{userId}")
    public ResponseEntity findRoomByUserId(@PathVariable Integer userId, Pageable pageable) {
        try {
            if (userId != null) {
                List<TbRoom> rooms = roomService.findAllRoomByUserId(userId, PageRequest.of(pageable.getPageNumber() - 1, pageable.getPageSize())).getContent();
                List<RoomResponseModel> roomResponseModels = rooms.stream().map(tbRoom -> {
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
                    roomResponseModel.setDateCreated(tbRoom.getDate());
                    roomResponseModel.setStatusId(tbRoom.getStatusId());
                    roomResponseModel.setDescription(tbRoom.getDescription());
                    roomResponseModel.setLongitude(tbRoom.getLongtitude());
                    roomResponseModel.setLatitude(tbRoom.getLattitude());
                    roomResponseModel.setUtilities(roomHasUtilityService.findAllByRoomId(tbRoom.getRoomId()));
                    roomResponseModel.setImageUrls(imageService.findAllByRoomId(tbRoom.getRoomId())
                            .stream()
                            .map(tbImage -> tbImage.getLinkUrl())
                            .collect(Collectors.toList()));
                    roomResponseModel.setMembers(roomHasUserService.findByRoomIdAndDateOutIsNull(tbRoom.getRoomId())
                            .stream()
                            .map(tbRoomHasUser -> {
                                TbUser user = userService.findById(tbRoomHasUser.getUserId());
                                return new MemberResponseModel(user.getUserId()
                                        , user.getRoleId(), user.getUsername(), user.getPhone());
                            }).collect(Collectors.toList()));

                    List<TbRoomRate> roomRateList = roomRateService.findAllByRoomId(tbRoom.getRoomId());
                    List<RoomRateResponseModel> roomRateResponseModels = new ArrayList<>();
                    if (roomRateList != null) {
                        roomRateList.forEach(tbRoomRate -> {
                            RoomRateResponseModel roomRateResponseModel = new RoomRateResponseModel();
                            roomRateResponseModel.setSecurity(tbRoomRate.getSecurityRate());
                            roomRateResponseModel.setLocation(tbRoomRate.getLocationRate());
                            roomRateResponseModel.setUtility(tbRoomRate.getUtilityRate());
                            UserResponseModel user = new UserResponseModel();
                            TbUser tbUser = userService.findById(tbRoomRate.getUserId());
                            user.setUserId(tbUser.getUserId());
                            user.setFullname(tbUser.getFullname());
                            user.setImageProfile(tbUser.getImageProfile());
                            List<TbUserRate> tbUserRates = userRateService.findAllByUserId(tbRoomRate.getUserId());
                            user.setUserRateList(tbUserRates);
                            roomRateResponseModel.setUserResponseModel(user);
                            roomRateResponseModel.setComment(tbRoomRate.getComment());
                            roomRateResponseModel.setDate(tbRoomRate.getDate());

                            roomRateResponseModels.add(roomRateResponseModel);
                        });
                        roomResponseModel.setRoomRateResponseModels(roomRateResponseModels);
                    }


                    return roomResponseModel;
                }).collect(Collectors.toList());
                return ResponseEntity.status(OK).body(roomResponseModels);
            } else {
                return ResponseEntity.status(NOT_FOUND).build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @GetMapping("room/user/currentRoom/{userId}")
    public ResponseEntity getCurrentRoom(@PathVariable Integer userId) {
        try {
            TbRoomHasUser roomHasUser = roomHasUserService.getCurrentRoom(userId);

            if (roomHasUser != null) {
                TbRoom room = roomService.findRoomById(roomHasUser.getRoomId());
                TbUser roomOwner = userService.findById(room.getUserId());

                RoomResponseModel roomResponseModel = new RoomResponseModel();
                roomResponseModel.setRoomId(room.getRoomId());
                roomResponseModel.setName(room.getName());
                roomResponseModel.setPrice(room.getPrice());
                roomResponseModel.setArea(room.getArea());
                roomResponseModel.setAddress(room.getAddress());
                roomResponseModel.setMaxGuest(room.getMaxGuest());
                roomResponseModel.setCurrentMember(room.getCurrentNumber());
                roomResponseModel.setUserId(room.getUserId());
                roomResponseModel.setCityId(room.getCityId());
                roomResponseModel.setDistrictId(room.getDistrictId());
                roomResponseModel.setDateCreated(room.getDate());
                roomResponseModel.setStatusId(room.getStatusId());
                roomResponseModel.setDescription(room.getDescription());
                roomResponseModel.setPhoneNumber(roomOwner.getPhone());

                roomResponseModel.setUtilities(roomHasUtilityService.findAllByRoomId(room.getRoomId()));
                roomResponseModel.setImageUrls(imageService.findAllByRoomId(room.getRoomId())
                        .stream()
                        .map(tbImage -> tbImage.getLinkUrl())
                        .collect(Collectors.toList()));
                roomResponseModel.setMembers(roomHasUserService.findByRoomIdAndDateOutIsNull(room.getRoomId())
                        .stream()
                        .map(tbRoomHasUser -> {
                            TbUser user = userService.findById(tbRoomHasUser.getUserId());
                            return new MemberResponseModel(user.getUserId(), user.getRoleId()
                                    , user.getUsername(), user.getPhone());
                        }).collect(Collectors.toList()));

                List<TbRoomRate> roomRateList = roomRateService.findAllByRoomId(room.getRoomId());
                List<RoomRateResponseModel> roomRateResponseModels = new ArrayList<>();
                if (roomRateList != null) {
                    roomRateList.forEach(tbRoomRate -> {
                        RoomRateResponseModel roomRateResponseModel = new RoomRateResponseModel();
                        roomRateResponseModel.setSecurity(tbRoomRate.getSecurityRate());
                        roomRateResponseModel.setLocation(tbRoomRate.getLocationRate());
                        roomRateResponseModel.setUtility(tbRoomRate.getUtilityRate());
                        UserResponseModel user = new UserResponseModel();
                        TbUser tbUser = userService.findById(tbRoomRate.getUserId());
                        user.setUserId(tbUser.getUserId());
                        user.setFullname(tbUser.getFullname());
                        user.setImageProfile(tbUser.getImageProfile());
                        List<TbUserRate> tbUserRates = userRateService.findAllByUserId(tbRoomRate.getUserId());
                        user.setUserRateList(tbUserRates);
                        roomRateResponseModel.setUserResponseModel(user);
                        roomRateResponseModel.setComment(tbRoomRate.getComment());
                        roomRateResponseModel.setDate(tbRoomRate.getDate());

                        roomRateResponseModels.add(roomRateResponseModel);
                    });
                    roomResponseModel.setRoomRateResponseModels(roomRateResponseModels);
                }
                return ResponseEntity.status(OK).body(roomResponseModel);
            }
            return ResponseEntity.status(NOT_FOUND).build();
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @GetMapping("room/user/history/{userId}")
    public ResponseEntity getHistoryRoom(@PathVariable Integer userId, Pageable pageable) {
        try {
            Page<TbRoomHasUser> roomHasUsers = roomHasUserService.getHistoryRoom(pageable.getPageNumber(), pageable.getPageSize()
                    , userId);

            if (!roomHasUsers.getContent().isEmpty()) {
                Page<RoomResponseModel> roomResponseModels = roomHasUsers.map(tbRoomHasUser -> {
                    RoomResponseModel roomResponseModel = new RoomResponseModel();
                    TbRoom room = roomService.findRoomById(tbRoomHasUser.getRoomId());
                    TbUser roomOwner = userService.findById(room.getUserId());

                    roomResponseModel.setRoomId(room.getRoomId());
                    roomResponseModel.setName(room.getName());
                    roomResponseModel.setPrice(room.getPrice());
                    roomResponseModel.setArea(room.getArea());
                    roomResponseModel.setAddress(room.getAddress());
                    roomResponseModel.setMaxGuest(room.getMaxGuest());
                    roomResponseModel.setCurrentMember(room.getCurrentNumber());
                    roomResponseModel.setUserId(room.getUserId());
                    roomResponseModel.setCityId(room.getCityId());
                    roomResponseModel.setDistrictId(room.getDistrictId());
                    roomResponseModel.setDateCreated(room.getDate());
                    roomResponseModel.setStatusId(room.getStatusId());
                    roomResponseModel.setDescription(room.getDescription());
                    roomResponseModel.setPhoneNumber(roomOwner.getPhone());
                    roomResponseModel.setUtilities(roomHasUtilityService.findAllByRoomId(room.getRoomId()));
                    roomResponseModel.setImageUrls(imageService.findAllByRoomId(room.getRoomId())
                            .stream()
                            .map(tbImage -> tbImage.getLinkUrl())
                            .collect(Collectors.toList()));
                    roomResponseModel.setMembers(roomHasUserService.findByRoomIdAndDateOutIsNull(room.getRoomId())
                            .stream()
                            .map(roomHasUser -> {
                                TbUser user = userService.findById(tbRoomHasUser.getUserId());
                                return new MemberResponseModel(user.getUserId(), user.getRoleId()
                                        , user.getUsername(), user.getPhone());
                            }).collect(Collectors.toList()));

                    List<TbRoomRate> roomRateList = roomRateService.findAllByRoomId(room.getRoomId());
                    List<RoomRateResponseModel> roomRateResponseModels = new ArrayList<>();
                    if (roomRateList != null) {
                        roomRateList.forEach(tbRoomRate -> {
                            RoomRateResponseModel roomRateResponseModel = new RoomRateResponseModel();
                            roomRateResponseModel.setSecurity(tbRoomRate.getSecurityRate());
                            roomRateResponseModel.setLocation(tbRoomRate.getLocationRate());
                            roomRateResponseModel.setUtility(tbRoomRate.getUtilityRate());
                            UserResponseModel user = new UserResponseModel();
                            TbUser tbUser = userService.findById(tbRoomRate.getUserId());
                            user.setUserId(tbUser.getUserId());
                            user.setFullname(tbUser.getFullname());
                            user.setImageProfile(tbUser.getImageProfile());
                            List<TbUserRate> tbUserRates = userRateService.findAllByUserId(tbRoomRate.getUserId());
                            user.setUserRateList(tbUserRates);
                            roomRateResponseModel.setUserResponseModel(user);
                            roomRateResponseModel.setComment(tbRoomRate.getComment());
                            roomRateResponseModel.setDate(tbRoomRate.getDate());

                            roomRateResponseModels.add(roomRateResponseModel);
                        });
                        roomResponseModel.setRoomRateResponseModels(roomRateResponseModels);
                    }
                    return roomResponseModel;
                });
                return ResponseEntity.status(OK).body(roomResponseModels.getContent());
            }
            return ResponseEntity.status(NOT_FOUND).build();
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @Transactional
    @PostMapping("room/editMember")
    public ResponseEntity editMember(@RequestBody RoomMemberRequestModel roomMemberModel) {
        try {
            List<TbRoomHasUser> roomMembers = roomHasUserService.findByRoomIdAndDateOutIsNull(roomMemberModel.getRoomId());

            if (roomMemberModel.getMemberRequestModels() == null) {
//            TbPost post = postService.findByRoomId(roomMemberModel.getRoomId());
//            postHasDistrictService.removeAllByPostId(post.getPostId());
//            favouriteService.removeAllByPostId(post.getPostId());
//            postService.removeByRoomId(roomMemberModel.getRoomId());
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
                memberRequestModels.stream().filter(roomHasUsersMapToMemberRequestModel::contains).forEach(memberRequestModel -> {
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
                            roomHasUser.setId(0);
                            Date date = new Date(System.currentTimeMillis());
                            roomHasUser.setDateIn(date);
                            roomHasUser.setUserId(memberRequestModel.getUserId());
                            roomHasUser.setRoomId(roomMemberModel.getRoomId());
                            roomHasUserService.saveRoomMember(roomHasUser);
                        });
            }
            return ResponseEntity.status(OK).build();
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

    @DeleteMapping("/room/removeMember/{userId}")
    public ResponseEntity removeMember(@PathVariable int userId) {
        try {
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
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }
}