package com.caps.asp.controller;

import com.caps.asp.model.TbPost;
import com.caps.asp.service.PostService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PostController {
    public final PostService postService;

    public PostController(PostService postService) {
        this.postService = postService;
    }

    @GetMapping("/post/findById/{id}")
    public ResponseEntity<TbPost> getPostByUserId(@PathVariable int userId) {
        try {
            return ResponseEntity.status(HttpStatus.OK)
                    .body(postService.findPostByUserIdAndTypeId(userId, 1));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }
}
