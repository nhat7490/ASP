package com.caps.asp.controller;

import com.caps.asp.model.TbFavourite;
import com.caps.asp.model.uimodel.response.common.CreateResponseModel;
import com.caps.asp.service.FavouriteService;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
        if (favouriteService.findByUserIdAndPostId(favourite.getUserId(), favourite.getPostId()) == null) {
            favourite.setId(0);
            return ResponseEntity.status(OK).body(new CreateResponseModel(favouriteService.addFavourite(favourite).getId()));
        }
        return ResponseEntity.status(CONFLICT).build();
    }

    @GetMapping("/favourites/getFavourite/{userId}")
    public ResponseEntity findAllFavouritesByUserId(@PathVariable int userId,
                                                    @RequestParam(defaultValue = "1") String page) {
        Page<TbFavourite> favourites = favouriteService.findAllByUserId(userId, Integer.parseInt(page), 10);
        return ResponseEntity.status(HttpStatus.OK)
                .body(favourites.getContent());
    }

    @DeleteMapping("/favourite/remove/{id}")
    public ResponseEntity remove(@PathVariable int id) {
        favouriteService.remove(id);
        return ResponseEntity.status(OK).build();

    }

    @PostMapping("/favourite/remove/v1")
    public ResponseEntity remove(@RequestBody TbFavourite favourite) {
        favouriteService.remove(favourite.getUserId(), favourite.getPostId());
        return ResponseEntity.status(OK).build();

    }
}
