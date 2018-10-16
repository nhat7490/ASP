package com.caps.asp.controller;

import com.caps.asp.model.TbPost;
import com.caps.asp.model.TbRoom;
import com.caps.asp.model.TbRoomHasUser;
import com.caps.asp.model.TbUser;
import com.caps.asp.model.uimodel.request.FilterArgumentModel;
import com.caps.asp.model.uimodel.request.SearchRequestModel;
import com.caps.asp.model.uimodel.request.post.RoomPostRequestModel;
import com.caps.asp.model.uimodel.request.post.RoommatePostRequestModel;
import com.caps.asp.service.PostService;
import com.caps.asp.service.RoomHasUserService;
import com.caps.asp.service.RoomService;
import com.caps.asp.service.UserService;
import com.caps.asp.service.filter.Filter;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.stream.Collectors;

import static com.caps.asp.constant.Constant.*;
import static org.springframework.http.HttpStatus.*;

@RestController
public class PostController {
    public final PostService postService;
    public final RoomService roomService;
    public final UserService userService;
    public final RoomHasUserService roomHasUserService;

    public PostController(PostService postService, RoomService roomService, UserService userService, RoomHasUserService roomHasUserService) {
        this.postService = postService;
        this.roomService = roomService;
        this.userService = userService;
        this.roomHasUserService = roomHasUserService;
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
                post.setDate(date);
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
                post.setDate(date);
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
                existedTbPost.setDate(post.getDate());
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
//        try {
        Filter filter = new Filter();
        if (filterArgumentModel.getSearchRequestModel().getDistricts().size() == 0
                && filterArgumentModel.getSearchRequestModel().getUtilities().size() == 0
                && filterArgumentModel.getSearchRequestModel().getGender().size() == 0
                && filterArgumentModel.getSearchRequestModel().getPrice().size() == 0
                && filterArgumentModel.getSearchRequestModel().getTypeId() == null) {
            filter.setCriteria(null);
        } else {
            filter.setCriteria(filterArgumentModel.getSearchRequestModel());
        }

        Page<TbPost> posts = postService.finAllByFilter(filterArgumentModel.getPage(), filterArgumentModel.getOffset(), filter);
        return ResponseEntity.status(OK).body(posts.getContent().stream().distinct().collect(Collectors.toList()));

//        } catch (Exception e) {
//            return ResponseEntity.status(NOT_FOUND).build();
//        }
    }

    @GetMapping("/post/findByTypeId/{typeId}")
    public ResponseEntity getPostByTypeId(@PathVariable int typeId,
                                          @RequestParam(defaultValue = "1") String page) {
        try {
            Page<TbPost> posts = postService.findAllByTypeId(Integer.parseInt(page), 10, typeId);
            return ResponseEntity.status(OK)
                    .body(posts.getContent());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }


}
