package com.caps.asp.repository;

import com.caps.asp.model.TbPost;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface PostRepository extends JpaRepository<TbPost, Integer>, JpaSpecificationExecutor<TbPost> {
    TbPost findByUserIdAndTypeId(int userId, int typeId);

    TbPost findByPostId(int postId);

    TbPost findByRoomId(int roomId);

    Page<TbPost> findAllByUserId(int userId, Pageable pageable);

    Page<TbPost> findAllByTypeId(int typeId, Pageable pageable);

}
