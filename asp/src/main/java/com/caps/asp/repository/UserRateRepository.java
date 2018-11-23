package com.caps.asp.repository;

import com.caps.asp.model.TbUser;
import com.caps.asp.model.TbUserRate;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRateRepository extends JpaRepository<TbUserRate, Integer> {
    TbUserRate findByUserIdAndOwnerId(Integer userId, Integer ownerId);
}
