package com.caps.asp.controller;

import com.caps.asp.exception.UserException;
import com.caps.asp.model.TbPost;
import com.caps.asp.model.TbPostHasTbDistrict;
import com.caps.asp.model.TbUser;
import com.caps.asp.model.uimodel.request.UserLoginModel;
import com.caps.asp.util.CalculateDistance;
import com.caps.asp.service.PostHasDistrictService;
import com.caps.asp.service.PostService;
import com.caps.asp.service.UserService;
import com.caps.asp.util.ResetPassword;
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
    public final PostHasDistrictService postHasDistrictService;
    public final BCryptPasswordEncoder passwordEncoder;
    public UserController(UserService userService, PostService postService, PostHasDistrictService postHasDistrictService,BCryptPasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.postService = postService;
        this.postHasDistrictService = postHasDistrictService;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/user/login")
    public ResponseEntity login(@RequestBody UserLoginModel model) {
        try {
            TbUser user = userService.findByUsername(model.getUsername());
            boolean isRigh = this.passwordEncoder.matches(model.getPassword(),user.getPassword());
            System.out.println(isRigh);
            return isRigh
                    ? ResponseEntity.status(OK).build()
                    : ResponseEntity.status(FORBIDDEN).build() ;//need to encrypt here
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

    @GetMapping("/user/suggestRoomMaster/{userId}")
    public ResponseEntity suggestPost(@PathVariable int userId) {
        try {
            TbPost tbPost = postService.findPostByUserIdAndTypeId(userId, PARTNER_POST);
            TbPostHasTbDistrict tbPostHasTbDistrict = postHasDistrictService.findByPostId(tbPost.getPostId());
            List<TbPostHasTbDistrict> tbPostHasTbDistrictList = postHasDistrictService.findAllByDistrictId(tbPostHasTbDistrict.getDistrictId());
            List<TbPost> tbPostList = postService.getPostList(tbPostHasTbDistrictList, tbPost.getPostId());

            CalculateDistance calculateDistance = new CalculateDistance();
            HashMap<TbPost, Double> listSort = new HashMap<>();

            for (int i = 0; i < tbPostList.size(); i++) {
                double distance = calculateDistance.distance(tbPost.getLattitude(), tbPost.getLongtitude(), tbPostList.get(i).getLattitude(), tbPostList.get(i).getLongtitude());
                listSort.put(tbPostList.get(i), distance);
            }
            List<Map.Entry<TbPost, Double>> list = new LinkedList<>(listSort.entrySet());

            Collections.sort(list, new Comparator<Map.Entry<TbPost, Double>>() {
                @Override
                public int compare(Map.Entry<TbPost, Double> e1, Map.Entry<TbPost, Double> e2) {
                    return (e1.getValue()).compareTo(e2.getValue());
                }
            });
            return ResponseEntity.status(OK).body(list);
        } catch (Exception e) {
            return ResponseEntity.status((NOT_FOUND)).build();
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
