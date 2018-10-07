package com.caps.asp.service;

import com.caps.asp.model.TbPostHasTbDistrict;
import com.caps.asp.repository.PostHasDistrictRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostHasDistrictService {
    public final PostHasDistrictRepository postHasDistrictRepository;

    public PostHasDistrictService(PostHasDistrictRepository postHasDistrictRepository) {
        this.postHasDistrictRepository = postHasDistrictRepository;
    }

    public TbPostHasTbDistrict findByPostId(int postId) {
        return postHasDistrictRepository.findByPostId(postId);
    }

    public List<TbPostHasTbDistrict> findAllByDistrictId(int districtId) {
        return postHasDistrictRepository.findAllByDistrictId(districtId);
    }
}
