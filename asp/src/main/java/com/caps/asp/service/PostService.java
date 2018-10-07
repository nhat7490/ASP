package com.caps.asp.service;

import com.caps.asp.model.TbPost;
import com.caps.asp.repository.PostRepository;
import org.springframework.stereotype.Service;

@Service
public class PostService {
    public final PostRepository postRepository;

    public PostService(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    public TbPost findPostByUserIdAndTypeId(int userId, int type) {
        return postRepository.findByUserIdAndTypeId(userId, type);
    }
}
