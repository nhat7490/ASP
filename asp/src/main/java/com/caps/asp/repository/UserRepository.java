package com.caps.asp.repository;

import com.caps.asp.model.TbUser;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<TbUser, Integer> {

    TbUser findByUsername(String username);
    TbUser findByUserId(int id);
}