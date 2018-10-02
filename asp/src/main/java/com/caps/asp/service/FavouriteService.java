package com.caps.asp.service;

import com.caps.asp.model.TbFavourite;
import com.caps.asp.repository.FavouriteRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FavouriteService {

    public final FavouriteRepository favouriteRepository;

    public FavouriteService(FavouriteRepository favouriteRepository) {
        this.favouriteRepository = favouriteRepository;
    }

    public List<TbFavourite> findAllByUserId(int userId){
        return favouriteRepository.findAllByUserId(userId);
    }
}
