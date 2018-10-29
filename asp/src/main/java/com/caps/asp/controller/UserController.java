package com.caps.asp.controller;

import com.caps.asp.exception.UserException;
import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.request.UserLoginModel;
import com.caps.asp.service.PostService;
import com.caps.asp.service.RoomService;
import com.caps.asp.service.UserService;
//import com.caps.asp.util.ResetPassword;
//import com.caps.asp.util.ResetPassword;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.*;

import static com.caps.asp.constant.Constant.MEMBER;
import static org.springframework.http.HttpStatus.*;

@RestController
public class UserController {
    public final UserService userService;
    public final PostService postService;
    public final RoomService roomService;
    public final BCryptPasswordEncoder passwordEncoder;

    public UserController(UserService userService, PostService postService, RoomService roomService, BCryptPasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.postService = postService;
        this.roomService = roomService;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/user/login")
    public ResponseEntity login(@RequestBody UserLoginModel model) {
        TbUser user = userService.findByUsername(model.getUsername());
        boolean isRight = this.passwordEncoder.matches(model.getPassword(), user.getPassword());
        System.out.println(isRight);
        return isRight
                ? ResponseEntity.status(OK).body(user)
                : ResponseEntity.status(FORBIDDEN).build();//need to encrypt here
    }

    @GetMapping("/user/findByUsername/{username}")
    public ResponseEntity<TbUser> findByUsername(@PathVariable String username) {
        return ResponseEntity.status(OK)
                .body(userService.findByUsername(username));
    }

    @GetMapping("/user/listUser")
    public ResponseEntity<List<TbUser>> getAllUsers() {
        return ResponseEntity.status(OK)
                .body(userService.getAllUsers());
    }

    @GetMapping("/user/findById/{id}")
    public ResponseEntity<TbUser> findById(@PathVariable int id) {
        return ResponseEntity.status(OK)
                .body(userService.findById(id));
    }

    @PutMapping("/user/updateUser")
    public ResponseEntity updateUserById(@RequestBody TbUser user) {
        userService.updateUserById(user);
        return ResponseEntity.status(OK).build();
    }

    @PostMapping("/user/createUser")
    public ResponseEntity createUSer(@RequestBody TbUser user) {
        TbUser tbUser = userService.findByUsername(user.getUsername());
        if (tbUser != null) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            user.setRoleId(MEMBER);
            int id = userService.saveUser(user);
            return ResponseEntity.status(CREATED).body(id);
        }
        return ResponseEntity.status(CONFLICT).build();
    }


    @GetMapping("/user/memberPermission/{userId}")
    public ResponseEntity checkMemberPermission(@PathVariable int userId) {
        TbUser user = userService.findById(userId);
        if (user.getRoleId() == MEMBER) {
            return ResponseEntity.status(OK).build();
        }
        return ResponseEntity.status(FORBIDDEN).build();
    }


}
