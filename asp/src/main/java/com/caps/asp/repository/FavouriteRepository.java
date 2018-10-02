package com.caps.asp.repository;

import com.caps.asp.model.TbFavourite;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FavouriteRepository extends JpaRepository<TbFavourite, Integer> {
    List<TbFavourite> findAllByUserId(int userId);
}
