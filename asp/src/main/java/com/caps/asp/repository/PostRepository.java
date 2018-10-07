package com.caps.asp.repository;

import com.caps.asp.model.TbPost;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PostRepository extends JpaRepository<TbPost, Integer> {
    TbPost findByUserIdAndTypeId(int userId, int typeId);
    TbPost findByPostId(int postId);
}
