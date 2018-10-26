package com.caps.asp.service;

import com.caps.asp.model.TbPost;
import com.caps.asp.model.TbRoom;
import com.caps.asp.repository.PostRepository;
import com.caps.asp.service.filter.BookmarkFilter;
import com.caps.asp.service.filter.Filter;
import com.caps.asp.util.CalculateDistance;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Transactional
public class PostService {
    public final PostRepository postRepository;

    public PostService(PostRepository postRepository) {
        this.postRepository = postRepository;
    }

    public TbPost findPostByUserIdAndTypeId(int userId, int typeId) {
        return postRepository.findByUserIdAndTypeId(userId, typeId);
    }

    public List<TbPost> getPostList(List<TbRoom> roomList, int roomId) {
        //roomId : is room of people who is suggested
        List<TbPost> list = new ArrayList<>();
        for (TbRoom room : roomList) {
            if (room.getRoomId() != roomId) {
                TbPost tbPost = new TbPost();
                tbPost = postRepository.findByRoomId(room.getRoomId());
                if (tbPost != null)
                    list.add(tbPost);
            }
        }
        return list;
    }

    public Page<TbPost> getAllPostByRoomIds(int page, int items, List<Integer> roomIds) {
        int actualPage = page - 1;
        Pageable pageable = PageRequest.of(actualPage, items);

        return postRepository.findAllByRoomIdIn(roomIds, pageable);
    }

    public List<TbPost> findAllPostByRoomIds(List<Integer> roomIds) {
        return postRepository.findAllByRoomIdIn(roomIds);
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

    public Page<TbPost> findAllByUserId(int page, int items, int userId) {
        int actualPage = page - 1;
        Pageable pageable = PageRequest.of(actualPage, items);
        return postRepository.findAllByUserId(userId, pageable);
    }

    public Page<TbPost> finAllByFilter(int page, int items, Filter filter) {
        int actualPage = page - 1;
        Pageable pageable = PageRequest.of(actualPage, items);
        return postRepository.findAll(filter,pageable);
    }

    public Page<TbPost> finAllBookmarkByFilter(int page, int items, BookmarkFilter filter) {
        int actualPage = page - 1;
        Pageable pageable = PageRequest.of(actualPage, items);
        return postRepository.findAll(filter,pageable);
    }

    public Page<TbPost> findAllByTypeId(int page, int items, int typeId){
        int actualPage = page - 1;
        Pageable pageable = PageRequest.of(actualPage, items);
        return postRepository.findAllByTypeId(typeId, pageable);
    }
    public List<TbPost> findAllByTypeId(int typeId){
        return   postRepository.findAllByTypeId(typeId);

    }
    public List<TbPost> search(Filter filter){
        return postRepository.findAll(filter);
    }
}