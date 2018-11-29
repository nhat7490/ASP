package com.caps.asp.controller;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.common.UserSuggestSettingModel;
import com.caps.asp.model.uimodel.request.UserLoginModel;
import com.caps.asp.model.uimodel.response.common.CreateResponseModel;
import com.caps.asp.model.uimodel.response.common.MemberResponseModel;
import com.caps.asp.model.uimodel.response.common.UserResponseModel;
import com.caps.asp.service.*;
//import com.caps.asp.util.ResetPassword;
//import com.caps.asp.util.ResetPassword;
import com.caps.asp.util.ResetPassword;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

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
    public final ReferenceService referenceService;
    public final UtilityReferenceService utilityReferenceService;
    public final DistrictReferenceService districtReferenceService;

    public UserController(UserService userService, PostService postService, RoomService roomService, RoomHasUserService roomHasUserService, BCryptPasswordEncoder passwordEncoder, ReferenceService referenceService, UtilityReferenceService utilityReferenceService, DistrictReferenceService districtReferenceService) {
        this.userService = userService;
        this.postService = postService;
        this.roomService = roomService;
        this.passwordEncoder = passwordEncoder;
        this.roomHasUserService = roomHasUserService;
        this.referenceService = referenceService;
        this.utilityReferenceService = utilityReferenceService;
        this.districtReferenceService = districtReferenceService;
    }

    @PostMapping(value = "/user/login", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity login(@RequestBody UserLoginModel model) {
        try {
            TbUser user = userService.findByUsername(model.getUsername());
            boolean isRight = this.passwordEncoder.matches(model.getPassword(), user.getPassword());
            if (isRight){
                UserResponseModel userResponseModel = new UserResponseModel(user);
                UserSuggestSettingModel userSuggestSettingModel = new UserSuggestSettingModel();


                TbReference  reference = referenceService.getByUserId(user.getUserId());
                userSuggestSettingModel.setPrice(Arrays.asList(reference.getMinPrice(),reference.getMaxPrice()));

                List<TbUtilitiesReference> utilitiesReference = utilityReferenceService.findAllByUserId(user.getUserId());
                userSuggestSettingModel.setUtilities(utilitiesReference.stream().map(
                        tbUtilitiesReference -> tbUtilitiesReference.getUtilityId())
                        .collect(Collectors.toList()));

                List<TbDistrictReference> districtReferences = districtReferenceService.findAllByUserId(user.getUserId());
                userSuggestSettingModel.setDistricts(districtReferences.stream().map(
                        tbDistrictReference -> tbDistrictReference.getDistrictId())
                        .collect(Collectors.toList()));

                userResponseModel.setUserSuggestSettingModel(userSuggestSettingModel);

                return ResponseEntity.status(OK).body(userResponseModel);
            }else {
                return ResponseEntity.status(FORBIDDEN).build();
            }
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

    @GetMapping("/user/findExitedUserInRoom/{username}")
    public ResponseEntity<TbUser> findExitedUserInRoom(@PathVariable String username) {
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
    @GetMapping("/user/findByUsername/{username}")
    public ResponseEntity<TbUser> findByUsername(@PathVariable String username) {
        TbUser user = userService.findByUsername(username);
        return ResponseEntity.status(user!=null ? OK : NOT_FOUND).build();
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

    @PostMapping("/user/createUser")
    public ResponseEntity createUser(@RequestBody TbUser user) {
            TbUser tbUserDb = userService.findByUsername(user.getUsername());
            if (tbUserDb == null) {
                user.setPassword(passwordEncoder.encode(user.getPassword()));
                user.setUserId(0);
                int id = userService.saveUser(user);
                return ResponseEntity.status(CREATED).body(new CreateResponseModel(id));
            }
            return ResponseEntity.status(CONFLICT).build();
    }

    @PostMapping("/user/admin/createUser")
    public ResponseEntity createUserForAdmin(@RequestBody TbUser user) {
        TbUser tbUserDb = userService.findByUsername(user.getUsername());
        if (tbUserDb == null) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            user.setUserId(0);
            int id = userService.saveUser(user);
            return ResponseEntity.status(CREATED).body(id);
        }
        return ResponseEntity.status(CONFLICT).build();
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