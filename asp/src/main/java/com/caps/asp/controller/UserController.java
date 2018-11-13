package com.caps.asp.controller;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.request.UserLoginModel;
import com.caps.asp.model.uimodel.response.common.MemberResponseModel;
import com.caps.asp.service.PostService;
import com.caps.asp.service.RoomHasUserService;
import com.caps.asp.service.RoomService;
import com.caps.asp.service.UserService;
//import com.caps.asp.util.ResetPassword;
//import com.caps.asp.util.ResetPassword;
import com.caps.asp.util.ResetPassword;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.*;

import static com.caps.asp.constant.Constant.ADMIN;
import static com.caps.asp.constant.Constant.MEMBER;
import static org.springframework.http.HttpStatus.*;

@RestController
public class UserController {
    public final UserService userService;
    public final PostService postService;
    public final RoomService roomService;
    public final BCryptPasswordEncoder passwordEncoder;
    public final RoomHasUserService roomHasUserService;

    public UserController(UserService userService, PostService postService, RoomService roomService, RoomHasUserService roomHasUserService, BCryptPasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.postService = postService;
        this.roomService = roomService;
        this.passwordEncoder = passwordEncoder;
        this.roomHasUserService = roomHasUserService;
    }

    @PostMapping(value = "/user/login", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity login(@RequestBody UserLoginModel model) {
        try {
            TbUser user = userService.findByUsername(model.getUsername());
            boolean isRight = this.passwordEncoder.matches(model.getPassword(), user.getPassword());
            System.out.println(isRight);
            return isRight
                    ? ResponseEntity.status(OK).body(user)
                    : ResponseEntity.status(FORBIDDEN).build();//need to encrypt here
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @PostMapping(value = "/user/admin", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity adminLogin(@RequestBody UserLoginModel model) {
        try {
            TbUser user = userService.findByUsername(model.getUsername());
            boolean isRight = this.passwordEncoder.matches(model.getPassword(), user.getPassword());

            if (user.getRoleId() == ADMIN && isRight) {
                return ResponseEntity.status(OK).body(user);
            }
            return ResponseEntity.status(NOT_FOUND).build();
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @GetMapping("/user/findByUsername/{username}")
    public ResponseEntity<TbUser> findByUsername(@PathVariable String username) {
        try {
            TbUser user = userService.findByUsername(username);

            if (user != null) {
                MemberResponseModel memberResponseModel = new MemberResponseModel(user.getUserId()
                        , MEMBER, user.getUsername(), user.getPhone());

                if (roomHasUserService.findTbRoomHasUserByUserIdAnAndDateOutIsNull(user.getUserId()) == null) {
                    return ResponseEntity.status(OK)
                            .body(user);
                } else {
                    return ResponseEntity.status(CONFLICT)
                            .build();
                }
            } else {
                return ResponseEntity.status(NOT_FOUND).build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @GetMapping("/user/listUser")
    public ResponseEntity<List<TbUser>> getAllUsers() {
        try {
            return ResponseEntity.status(OK).body(userService.getAllUsers());
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @GetMapping("/user/findById/{id}")
    public ResponseEntity<TbUser> findById(@PathVariable int id) {
        try {
            return ResponseEntity.status(OK).body(userService.findById(id));
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @PutMapping("/user/updateUser")
    public ResponseEntity updateUserById(@RequestBody TbUser user) {
        try {
            userService.updateUserById(user);
            return ResponseEntity.status(OK).build();
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

    @PostMapping("/user/admin/createUser")
    public ResponseEntity createUSer(@RequestBody TbUser user) {
        try {
            TbUser tbUserDb = userService.findByUsername(user.getUsername());

            if (tbUserDb == null) {
                user.setPassword(passwordEncoder.encode(user.getPassword()));
                user.setUserId(0);
                int id = userService.saveUser(user);
                return ResponseEntity.status(CREATED).body(id);
            }
            return ResponseEntity.status(CONFLICT).build();
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

    @GetMapping("/user/memberPermission/{userId}")
    public ResponseEntity checkMemberPermission(@PathVariable int userId) {
        try {
            TbUser user = userService.findById(userId);

            if (user.getRoleId() == MEMBER) {
                return ResponseEntity.status(OK).build();
            }
            return ResponseEntity.status(FORBIDDEN).build();
        } catch (Exception e) {
            return ResponseEntity.status(FORBIDDEN).build();
        }
    }

    @GetMapping("/user/resetPassword/{email}")
    public ResponseEntity resetPassword(@PathVariable String email) {
        try {
            TbUser user = userService.findByEmail(email);

            if (user != null) {
                ResetPassword resetPassword = new ResetPassword();
                String newPassword = resetPassword.sendEmail(email);
                user.setPassword(passwordEncoder.encode(newPassword));
                userService.updateUserById(user);
                return ResponseEntity.status(OK).build();
            }
            return ResponseEntity.status(NOT_FOUND).build();
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }
}