package com.caps.asp.service;

import com.caps.asp.model.TbPostHasUtility;
import com.caps.asp.repository.PostHasUtilityRepository;
import org.springframework.stereotype.Service;

@Service
public class PostHasUtilityService {

    public final PostHasUtilityRepository postHasUtilityRepository;

    public PostHasUtilityService(PostHasUtilityRepository postHasUtilityRepository) {
        this.postHasUtilityRepository = postHasUtilityRepository;
    }

    public void save(TbPostHasUtility tbPostHasUtility){
        postHasUtilityRepository.save(tbPostHasUtility);
    }
}
