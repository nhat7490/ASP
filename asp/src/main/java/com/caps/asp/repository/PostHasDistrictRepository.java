package com.caps.asp.repository;

import com.caps.asp.model.TbPostHasTbDistrict;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PostHasDistrictRepository extends JpaRepository<TbPostHasTbDistrict, Integer> {

    void removeAllByPostId(int postId);

}
