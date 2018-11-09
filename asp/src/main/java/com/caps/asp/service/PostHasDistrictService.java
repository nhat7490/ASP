package com.caps.asp.service;

import com.caps.asp.model.TbPostHasTbDistrict;
import com.caps.asp.repository.PostHasDistrictRepository;
import org.springframework.stereotype.Service;

@Service
public class PostHasDistrictService {

    public final PostHasDistrictRepository postHasDistrictRepository;

    public PostHasDistrictService(PostHasDistrictRepository postHasDistrictRepository) {
        this.postHasDistrictRepository = postHasDistrictRepository;
    }

    public void removeAllByPostId(int postId){
        postHasDistrictRepository.removeAllByPostId(postId);
    }

    public void save(TbPostHasTbDistrict tbPostHasTbDistrict){
        postHasDistrictRepository.save(tbPostHasTbDistrict);
    }
}
