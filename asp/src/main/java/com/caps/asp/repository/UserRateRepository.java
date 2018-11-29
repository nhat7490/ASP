package com.caps.asp.repository;

import com.caps.asp.model.TbUserRate;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRateRepository extends JpaRepository<TbUserRate, Integer> {
    TbUserRate findByUserIdAndOwnerId(Integer userId, Integer ownerId);
    List<TbUserRate> findAllByUserId(int userId);
}
