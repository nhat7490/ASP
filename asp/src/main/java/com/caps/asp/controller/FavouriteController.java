package com.caps.asp.controller;

import com.caps.asp.model.TbFavourite;
import com.caps.asp.service.FavouriteService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import static org.springframework.http.HttpStatus.CONFLICT;
import static org.springframework.http.HttpStatus.NOT_FOUND;
import static org.springframework.http.HttpStatus.OK;

@RestController
public class FavouriteController {

    public final FavouriteService favouriteService;

    public FavouriteController(FavouriteService favouriteService) {
        this.favouriteService = favouriteService;
    }

    @PostMapping("/favourites/createFavourite")
    public ResponseEntity addFavorite(@RequestBody TbFavourite favourite) {
        try {
            favouriteService.addFavourite(favourite);
            return ResponseEntity.status(OK).build();
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

    @GetMapping("/favourites/getFavourite/{userId}")
    public ResponseEntity<List<TbFavourite>> findAllFavouritesByUserId(@PathVariable int userId) {
        try {
            return ResponseEntity.status(HttpStatus.OK)
                    .body(favouriteService.findAllByUserId(userId));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @DeleteMapping("/favourite/remove/{id}")
    public ResponseEntity remove(@PathVariable int id) {
        try {
            favouriteService.remove(id);
            return ResponseEntity.status(OK).build();
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }
}
