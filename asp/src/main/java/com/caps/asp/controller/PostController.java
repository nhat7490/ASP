package com.caps.asp.controller;

import com.caps.asp.model.TbPost;
import com.caps.asp.model.TbRoomHasUser;
import com.caps.asp.model.TbUser;
import com.caps.asp.service.PostService;
import com.caps.asp.service.RoomHasUserService;
import com.caps.asp.service.RoomService;
import com.caps.asp.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static com.caps.asp.constant.Constant.*;
import static org.springframework.http.HttpStatus.CONFLICT;
import static org.springframework.http.HttpStatus.CREATED;
import static org.springframework.http.HttpStatus.OK;

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

    @GetMapping("/post/findByUserId/{id}")
    public ResponseEntity<List<TbPost>> getPostByUserId(@PathVariable int userId) {
        try {
            return ResponseEntity.status(OK)
                    .body(postService.findAllByUserId(userId));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @PostMapping("/post/create")
    public ResponseEntity createPost(@RequestBody TbPost post) {
        try {
            TbUser user = userService.findById(post.getUserId());
            if (user.getRoleId() == MEMBER) {
                post.setTypeId(ROOM_POST);
                postService.savePost(post);
                return ResponseEntity.status(CREATED).build();
            } else {
                TbPost existedPost = postService.findByRoomId(post.getRoomId());
                TbRoomHasUser roomHasUser = roomHasUserService.findByUserIdAndRoomId(post.getUserId(), post.getRoomId());
                if (existedPost == null
                        && roomHasUser != null
                        && user.getRoleId() == ROOM_MASTER) {
                    post.setTypeId(PARTNER_POST);
                    postService.savePost(post);
                    return ResponseEntity.status(CREATED).build();
                } else {
                    return ResponseEntity.status(CONFLICT).build();
                }
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
}
