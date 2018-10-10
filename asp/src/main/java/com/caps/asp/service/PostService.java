package com.caps.asp.service;

import com.caps.asp.model.TbPost;
import com.caps.asp.model.TbPostHasTbDistrict;
import com.caps.asp.repository.PostRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PostService {
    public final PostRepository postRepository;

    public PostService(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    public TbPost findPostByUserIdAndTypeId(int userId, int typeId) {
        return postRepository.findByUserIdAndTypeId(userId, typeId);
    }

    public List<TbPost> getPostList(List<TbPostHasTbDistrict> tbPostHasTbDistrictList, int postId) {
        List<TbPost> list = new ArrayList<>();
        for (TbPostHasTbDistrict post : tbPostHasTbDistrictList) {
            if (post.getPostId() != postId) {
                list.add(postRepository.findByPostId(post.getPostId()));
            }
        }
        return list;
    }

    public TbPost findByRoomId(int roomId) {
        return postRepository.findByRoomId(roomId);
    }

    public void savePost(TbPost post){
        postRepository.save(post);
    }

    public TbPost findByPostId(int postId){
        return postRepository.findByPostId(postId);
    }

    public List<TbPost> findAllByUserId(int userId){
        return postRepository.findAllByUserId(userId);
    }
}
