package com.caps.asp.controller;

import com.caps.asp.exception.UserException;
import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.request.UserLoginModel;
import com.caps.asp.model.uimodel.request.suggest.BaseSuggestRequestModel;
import com.caps.asp.model.uimodel.response.UserResponeModel;
import com.caps.asp.model.uimodel.response.post.RoomPostResponseModel;
import com.caps.asp.service.PostService;
import com.caps.asp.service.RoomService;
import com.caps.asp.service.UserService;
//import com.caps.asp.util.ResetPassword;
import com.caps.asp.util.CalculateDistance;
import com.caps.asp.util.ResetPassword;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.*;

import static com.caps.asp.constant.Constant.PARTNER_POST;
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
        try {
            TbUser user = userService.findByUsername(model.getUsername());
            boolean isRigh = this.passwordEncoder.matches(model.getPassword(), user.getPassword());
            System.out.println(isRigh);
            return isRigh
                    ? ResponseEntity.status(OK).build()
                    : ResponseEntity.status(FORBIDDEN).build();//need to encrypt here
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @GetMapping("/user/findByUsername/{username}")
    public ResponseEntity<TbUser> findByUsername(@PathVariable String username) {
        try {
            return ResponseEntity.status(OK)
                    .body(userService.findByUsername(username));
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @GetMapping("/user/listUser")
    public ResponseEntity<List<TbUser>> getAllUsers() {
        try {
            return ResponseEntity.status(OK)
                    .body(userService.getAllUsers());
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @GetMapping("/user/findById/{id}")
    public ResponseEntity<TbUser> findById(@PathVariable int id) {
        try {
            return ResponseEntity.status(OK)
                    .body(userService.findById(id));
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
            return ResponseEntity.status((NOT_MODIFIED)).build();
        }
    }

    @PostMapping("/user/createUser")
    public ResponseEntity createUSer(@RequestBody TbUser user) {
        try {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            int id = userService.createUser(user);
            return ResponseEntity.status(CREATED).body(id);
        } catch (UserException.UsernameExistedException e) {
            return ResponseEntity.status((CONFLICT)).build();
        }
    }


    @GetMapping("/user/resetPassword/{email}")
    public ResponseEntity resetPassword(@PathVariable String email) {
        try {
            TbUser user = userService.findByEmail(email);
            ResetPassword resetPassword = new ResetPassword();
            String newPassword = resetPassword.sendEmail(email);
            user.setPassword(passwordEncoder.encode(newPassword));
            userService.updateUserById(user);
            return ResponseEntity.status(OK).build();
        } catch (Exception e) {
            return ResponseEntity.status((NOT_FOUND)).build();
        }
    }
}
