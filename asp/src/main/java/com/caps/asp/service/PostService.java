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

    public List<TbPost> findByPostId(List<TbPostHasTbDistrict> tbPostHasTbDistrictList) {
        List<TbPost> list = new ArrayList<>();
//        for (int i = 0; i < tbPostHasTbDistrictList.size(); i++) {
//            list.add(postRepository.findByPostId(tbPostHasTbDistrictList.get(i).getPostId()));
//        }
        for (TbPostHasTbDistrict post: tbPostHasTbDistrictList) {
            list.add(postRepository.findByPostId(post.getPostId()));
        }
        return list;
    }
}
