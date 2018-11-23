package com.caps.asp.service;

import com.caps.asp.model.TbUserRate;
import com.caps.asp.repository.UserRateRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserRateService {
    public final UserRateRepository userRateRepository;

    public UserRateService(UserRateRepository userRateRepository) {
        this.userRateRepository = userRateRepository;
    }

    public List<TbUserRate> findAllByUserId(int userId) {
        return userRateRepository.findAllByUserId(userId);
    }
}
