package com.caps.asp.controller;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.request.FilterArgumentModel;
import com.caps.asp.model.uimodel.request.post.RoomPostRequestModel;
import com.caps.asp.model.uimodel.request.post.RoommatePostRequestModel;
import com.caps.asp.model.uimodel.response.UserResponeModel;
import com.caps.asp.model.uimodel.response.post.RoomPostResponseModel;
import com.caps.asp.model.uimodel.response.post.RoommatePostResponseModel;
import com.caps.asp.service.*;
import com.caps.asp.service.filter.Filter;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static com.caps.asp.constant.Constant.*;
import static org.springframework.http.HttpStatus.*;

@RestController
public class PostController {
    public final PostService postService;
    public final RoomService roomService;
    public final UserService userService;
    public final RoomHasUserService roomHasUserService;
    public final RoomHasUtilityService roomHasUtilityService;
    public final ImageService imageService;
    public final FavouriteService favouriteService;

    public PostController(PostService postService, RoomService roomService, UserService userService, RoomHasUserService roomHasUserService, RoomHasUtilityService roomHasUtilityService, ImageService imageService, FavouriteService favouriteService) {
        this.postService = postService;
        this.roomService = roomService;
        this.userService = userService;
        this.roomHasUserService = roomHasUserService;
        this.roomHasUtilityService = roomHasUtilityService;
        this.imageService = imageService;
        this.favouriteService = favouriteService;
    }

    @GetMapping("/post/findByUserId/{userId}")
    public ResponseEntity getPostByUserId(@PathVariable int userId,
                                          @RequestParam(defaultValue = "1") String page) {
        try {
            Page<TbPost> posts = postService.findAllByUserId(Integer.parseInt(page), 10, userId);
            return ResponseEntity.status(OK)
                    .body(posts.getContent());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @PostMapping("/post/createRoommatePost")
    public ResponseEntity createRoommatePost(@RequestBody RoommatePostRequestModel roommatePostRequestModel) {
        try {
            TbUser user = userService.findById(roommatePostRequestModel.getUserId());
            if (user.getRoleId() == MEMBER) {
                TbPost post = new TbPost();
                post.setTypeId(PARTNER_POST);
                Date date = new Date(System.currentTimeMillis());
                post.setDatePost(date);
//                post.setNumberPartner(roomPostRequestModel.getNumberPartner());
//                post.setPhoneContact(roomPostRequestModel.getPhoneContact());
//                post.setName(roomPostRequestModel.getName());
//                post.setRoomId(roomPostRequestModel.getRoomId());
//                post.setGenderPartner(roomPostRequestModel.getGenderPartner());
                post.setUserId(roommatePostRequestModel.getUserId());
                post.setPostId(0);
                postService.savePost(post);
                return ResponseEntity.status(CREATED).build();
            } else {
                return ResponseEntity.status(CONFLICT).build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

    @PostMapping("/post/createRoomPost")
    public ResponseEntity createRoomPost(@RequestBody RoomPostRequestModel roomPostRequestModel) {
        try {
            TbUser user = userService.findById(roomPostRequestModel.getUserId());
            TbRoom room = roomService.findRoomById(roomPostRequestModel.getRoomId());
            TbRoomHasUser roomHasUser = roomHasUserService.findByUserIdAndRoomId(user.getUserId(), room.getRoomId());
            TbPost excistedPost = postService.findByRoomId(room.getRoomId());
            if (user.getRoleId() == ROOM_MASTER
                    && roomHasUser != null
                    && excistedPost == null) {
                TbPost post = new TbPost();
                post.setTypeId(ROOM_POST);
                post.setLongtitude(room.getLongtitude());
                post.setLattitude(room.getLattitude());
                Date date = new Date(System.currentTimeMillis());
                post.setDatePost(date);
                post.setNumberPartner(roomPostRequestModel.getNumberPartner());
                post.setPhoneContact(roomPostRequestModel.getPhoneContact());
                post.setName(roomPostRequestModel.getName());
                post.setRoomId(roomPostRequestModel.getRoomId());
                post.setGenderPartner(roomPostRequestModel.getGenderPartner());
                post.setUserId(roomPostRequestModel.getUserId());
                post.setPostId(0);
                postService.savePost(post);
                return ResponseEntity.status(CREATED).build();
            } else {
                return ResponseEntity.status(CONFLICT).build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }


    @PutMapping("/post/update")
    public ResponseEntity updatePost(@RequestBody TbPost post) {
        try {
            TbPost existedTbPost = postService.findByPostId(post.getPostId());
            if (existedTbPost != null) {
                existedTbPost.setName(post.getName());
                existedTbPost.setPhoneContact(post.getPhoneContact());
                existedTbPost.setNumberPartner(post.getNumberPartner());
                existedTbPost.setGenderPartner(post.getGenderPartner());
                existedTbPost.setDatePost(post.getDatePost());
                existedTbPost.setLattitude(post.getLattitude());
                existedTbPost.setLongtitude(post.getLongtitude());
                postService.savePost(existedTbPost);
                return ResponseEntity.status(CREATED).build();
            } else {
                return ResponseEntity.status(CONFLICT).build();
            }

        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

    @PostMapping("/post/filter")
    public ResponseEntity getPostByFilter(@RequestBody FilterArgumentModel filterArgumentModel) {
        try {
            Filter filter = new Filter();
            if (filterArgumentModel.getSearchRequestModel() == null) {
                filter.setCriteria(null);
            } else {
                filter.setCriteria(filterArgumentModel.getSearchRequestModel());
            }
            if (filter.getCriteria().getTypeId() == 1) {
                Page<TbPost> posts = postService.finAllByFilter(filterArgumentModel.getPage(), filterArgumentModel.getOffset(), filter);
                Page<RoomPostResponseModel> roomPostResponseModels = posts.map(tbPost -> {
                    RoomPostResponseModel roomPostResponseModel = new RoomPostResponseModel();

                    TbRoom room = roomService.findRoomById(tbPost.getRoomId());
                    List<TbRoomHasUtility> roomHasUtilities = roomHasUtilityService.findAllByRoomId(room.getRoomId());
                    UserResponeModel userResponeModel = new UserResponeModel(userService.findById(tbPost.getUserId()));
                    TbFavourite favourite = favouriteService.findByUserIdAndPostId(filter.getCriteria().getUserId(), tbPost.getPostId());

                    roomPostResponseModel.setName(tbPost.getName());
                    roomPostResponseModel.setPostId(tbPost.getPostId());
                    roomPostResponseModel.setPhoneContact(tbPost.getPhoneContact());
                    roomPostResponseModel.setDate(tbPost.getDatePost());
                    roomPostResponseModel.setUserResponeModel(userResponeModel);
                    if(favourite!=null){
                        roomPostResponseModel.setFavourite(true);
                    }else {
                        roomPostResponseModel.setFavourite(false);
                    }
                    roomPostResponseModel.setMinPrice(tbPost.getMinPrice());//price for room post
                    roomPostResponseModel.setAddress(room.getAddress());
                    roomPostResponseModel.setArea(room.getArea());
                    roomPostResponseModel.setGenderPartner(tbPost.getGenderPartner());
                    roomPostResponseModel.setDescription(tbPost.getDescription());
                    //missing
                    List<TbImage> images = imageService.findAllByRoomId(room.getRoomId());
                    roomPostResponseModel.setImageUrls(images.stream().map(image -> image.getLinkUrl()).collect(Collectors.toList()));

                    roomPostResponseModel.setUtilities(roomHasUtilities);
                    roomPostResponseModel.setNumberPartner(tbPost.getNumberPartner());
                    return roomPostResponseModel;
                });

                return ResponseEntity.status(OK).body(roomPostResponseModels);
            } else {
                Page<TbPost> posts = postService.finAllByFilter(filterArgumentModel.getPage(), filterArgumentModel.getOffset(), filter);
                Page<RoommatePostResponseModel> roommatePostResponseModels = posts.map(tbPost -> {
                    RoommatePostResponseModel roommatePostResponseModel = new RoommatePostResponseModel();
                    UserResponeModel userResponeModel = new UserResponeModel(userService.findById(tbPost.getUserId()));
                    TbFavourite favourite = favouriteService.findByUserIdAndPostId(filter.getCriteria().getUserId(), tbPost.getPostId());

                    roommatePostResponseModel.setPostId(tbPost.getPostId());
                    roommatePostResponseModel.setPhoneContact(tbPost.getPhoneContact());
                    roommatePostResponseModel.setDate(tbPost.getDatePost());
                    roommatePostResponseModel.setUserResponeModel(userResponeModel);
                    if(favourite!=null){
                        roommatePostResponseModel.setFavourite(true);
                    }else {
                        roommatePostResponseModel.setFavourite(false);
                    }
                    roommatePostResponseModel.setMinPrice(tbPost.getMinPrice());
                    roommatePostResponseModel.setMaxPrice(tbPost.getMaxPrice());
                    roommatePostResponseModel.setUtilityIds(null);
                    roommatePostResponseModel.setDistrictIds(null);
                    return roommatePostResponseModel;
                });
                return ResponseEntity.status(OK).body(roommatePostResponseModels);
            }

        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @GetMapping("/post/{typeId}")
    public ResponseEntity getAll(@PathVariable int typeId) {
        try {
            List<TbPost> tbPostList = postService.findAllByTypeId(typeId);
            List<RoomPostResponseModel> roomPostResponseModels = new ArrayList<>();
            tbPostList.forEach(tbPost -> {
                RoomPostResponseModel roomPostResponseModel = new RoomPostResponseModel();

                TbRoom room = roomService.findRoomById(tbPost.getRoomId());
                List<TbRoomHasUtility> roomHasUtilities = roomHasUtilityService.findAllByRoomId(room.getRoomId());
                UserResponeModel userResponeModel = new UserResponeModel(userService.findById(tbPost.getUserId()));
                roomPostResponseModel.setName(tbPost.getName());
                roomPostResponseModel.setPostId(tbPost.getPostId());
                roomPostResponseModel.setPhoneContact(tbPost.getPhoneContact());
                roomPostResponseModel.setDate(tbPost.getDatePost());
                roomPostResponseModel.setUserResponeModel(userResponeModel);
                roomPostResponseModel.setFavourite(false);
                roomPostResponseModel.setMinPrice(room.getPrice());//missing
                roomPostResponseModel.setAddress(room.getAddress());
                roomPostResponseModel.setArea(room.getArea());
                roomPostResponseModel.setGenderPartner(tbPost.getGenderPartner());
                roomPostResponseModel.setImageUrls(Arrays.asList("http://gracehotel.com.au/sites/default/files/field/gallery/2018/08/5DM48071-HDR.jpg", "http://gracehotel.com.au/sites/default/files/field/gallery/2018/08/5DM48071-HDR.jpg", "http://gracehotel.com.au/sites/default/files/field/gallery/2018/08/5DM48071-HDR.jpg"));
                roomPostResponseModel.setUtilities(roomHasUtilities);
                roomPostResponseModel.setNumberPartner(tbPost.getNumberPartner());
                roomPostResponseModels.add(roomPostResponseModel);

            });
            return ResponseEntity.status(OK)
                    .body(roomPostResponseModels);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

}
