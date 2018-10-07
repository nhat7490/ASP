package com.caps.asp.repository;

import com.caps.asp.model.TbPostHasTbDistrict;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PostHasDistrictRepository extends JpaRepository<TbPostHasTbDistrict, Integer> {
    TbPostHasTbDistrict findByPostId(int postId);
    List<TbPostHasTbDistrict> findAllByDistrictId(int districtId);
}
