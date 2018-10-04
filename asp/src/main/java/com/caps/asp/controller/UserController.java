package com.caps.asp.controller;

import com.caps.asp.model.TbUser;
import com.caps.asp.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class UserController {
    public final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/findByUsername/{username}")
    public ResponseEntity<TbUser> findByUsername(@PathVariable String username) {
        try {
            return ResponseEntity.status(HttpStatus.OK)
                    .body(userService.findByUsername(username));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }
    //Test 
    @RequestMapping("/")
    public String home(){
        return "redirect:/user";
    }
    //Test
    @GetMapping("/users")
    public ResponseEntity<List<TbUser>> getAllUsers() {
        try {
            return ResponseEntity.status(HttpStatus.OK)
                    .body(userService.getAllUsers());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @GetMapping("/findById/{id}")
    public ResponseEntity<TbUser> findById(@PathVariable int id) {
        try {
            return ResponseEntity.status(HttpStatus.OK)
                    .body(userService.findById(id));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @PostMapping("/updateUser")
    public ResponseEntity updateUSerById(@RequestBody TbUser user) {
        try {
            userService.updateUserById(user);
            return ResponseEntity.status(HttpStatus.OK).build();
        } catch (Exception e) {
            return ResponseEntity.status((HttpStatus.NOT_MODIFIED)).build();
        }
    }

    @PostMapping("/createUser")
    public ResponseEntity createUSer(@RequestBody TbUser user) {
        try {
            userService.createUser(user);
            return ResponseEntity.status(HttpStatus.OK).build();
        } catch (Exception e) {
            return ResponseEntity.status((HttpStatus.CONFLICT)).build();
        }
    }
}
