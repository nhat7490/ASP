package com.caps.asp.service;

import com.caps.asp.model.TbUserRate;
import com.caps.asp.repository.UserRateRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserRateService {
    public UserRateRepository userRateRepository;

    public UserRateService(UserRateRepository userRateRepository) {
        this.userRateRepository = userRateRepository;
    }

    public TbUserRate findByUserIdAndOwnerId(int userId, int ownerId){
        return userRateRepository.findByUserIdAndOwnerId(userId,ownerId);
    }
    public void saveUserRate(TbUserRate userRate){
        userRateRepository.saveAndFlush(userRate);
    }



    public List<TbUserRate> findAllByUserId(int userId) {
        return userRateRepository.findAllByUserId(userId);
    }
}
