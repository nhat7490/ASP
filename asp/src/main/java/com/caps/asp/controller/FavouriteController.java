package com.caps.asp.controller;

import com.caps.asp.model.TbFavourite;
import com.caps.asp.service.FavouriteService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class FavouriteController {

    public final FavouriteService favouriteService;

    public FavouriteController(FavouriteService favouriteService) {
        this.favouriteService = favouriteService;
    }

    @GetMapping("/favourites/{userId}")
    public ResponseEntity<List<TbFavourite>> findAllFavouritesByUserId(@PathVariable int userId){
        try {
            return ResponseEntity.status(HttpStatus.OK)
                    .body(favouriteService.findAllByUserId(userId));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }
}
