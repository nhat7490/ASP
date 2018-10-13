package com.caps.asp.service;

import com.caps.asp.model.TbPost;
import com.caps.asp.model.TbPostHasTbDistrict;
import com.caps.asp.model.uimodel.SearchRequestModel;
import com.caps.asp.repository.PostRepository;
import com.caps.asp.service.filter.Filter;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
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

    public void savePost(TbPost post) {
        postRepository.save(post);
    }

    public TbPost findByPostId(int postId) {
        return postRepository.findByPostId(postId);
    }

    public List<TbPost> findAllByUserId(int userId) {
        return postRepository.findAllByUserId(userId);
    }

    public Page<TbPost> finAllByFilter(int page, int items, Filter filter) {
        int actualPage = page - 1;
        Pageable pageable = PageRequest.of(actualPage, items);
        return postRepository.findAll(filter,pageable);
    }

    public List<TbPost> search(SearchRequestModel search){
        Filter specification = new Filter();
        specification.setCriteria(search);
        return postRepository.findAll(specification);
    }
}
