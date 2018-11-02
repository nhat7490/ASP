package com.caps.asp.service;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.request.FilterArgumentModel;
import com.caps.asp.model.uimodel.response.UserResponeModel;
import com.caps.asp.model.uimodel.response.post.RoomPostResponseModel;
import com.caps.asp.model.uimodel.response.post.RoommatePostResponseModel;
import com.caps.asp.service.filter.Filter;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class Suggest {

    private PostService postService;
    private RoomService roomService;
    private RoomHasUtilityService roomHasUtilityService;
    private UserService userService;
    private FavouriteService favouriteService;
    private ImageService imageService;
    private UtilityReferenceService utilityReferenceService;
    private DistrictReferenceService districtReferenceService;
    private DistrictService districtService;


    public Suggest(PostService postService, RoomService roomService, RoomHasUtilityService roomHasUtilityService, UserService userService, FavouriteService favouriteService, ImageService imageService, UtilityReferenceService utilityReferenceService, DistrictReferenceService districtReferenceService, DistrictService districtService) {
        this.postService = postService;
        this.roomService = roomService;
        this.roomHasUtilityService = roomHasUtilityService;
        this.userService = userService;
        this.favouriteService = favouriteService;
        this.imageService = imageService;
        this.utilityReferenceService = utilityReferenceService;
        this.districtReferenceService = districtReferenceService;
        this.districtService = districtService;
    }

    public Page<RoomPostResponseModel> partnerPostSuggestion(Filter filter) {

        FilterArgumentModel filterArgumentModel = filter.getFilterArgumentModel();

        Page<TbPost> posts = postService.finAllByFilter(filterArgumentModel.getPage()
                , filterArgumentModel.getOffset(), filter);
        Page<RoomPostResponseModel> roomPostResponseModels = posts.map(tbPost -> {
            RoomPostResponseModel roomPostResponseModel = new RoomPostResponseModel();

            TbRoom room = roomService.findRoomById(tbPost.getRoomId());
            List<TbRoomHasUtility> roomHasUtilities = roomHasUtilityService.findAllByRoomId(room.getRoomId());
            UserResponeModel userResponeModel = new UserResponeModel(userService.findById(tbPost.getUserId()));
            TbFavourite favourite = favouriteService
                    .findByUserIdAndPostId(filter.getFilterArgumentModel().getUserId(), tbPost.getPostId());

            roomPostResponseModel.setName(tbPost.getName());
            roomPostResponseModel.setPostId(tbPost.getPostId());
            roomPostResponseModel.setPhoneContact(tbPost.getPhoneContact());
            roomPostResponseModel.setDate(tbPost.getDatePost());
            roomPostResponseModel.setUserResponeModel(userResponeModel);

            if (favourite != null) {
                roomPostResponseModel.setFavouriteId(favourite.getId());
                roomPostResponseModel.setFavourite(true);
            } else {
                roomPostResponseModel.setFavourite(false);
            }

            roomPostResponseModel.setMinPrice(tbPost.getMinPrice());//price for room post
            roomPostResponseModel.setAddress(room.getAddress());
            roomPostResponseModel.setArea(room.getArea());
            roomPostResponseModel.setGenderPartner(tbPost.getGenderPartner());
            roomPostResponseModel.setDescription(tbPost.getDescription());
            //missing
            List<TbImage> images = imageService.findAllByRoomId(room.getRoomId());
            roomPostResponseModel.setImageUrls(images
                    .stream()
                    .map(image -> image.getLinkUrl())
                    .collect(Collectors.toList()));

            roomPostResponseModel.setUtilities(roomHasUtilities);
            roomPostResponseModel.setNumberPartner(tbPost.getNumberPartner());
            return roomPostResponseModel;
        });
        return roomPostResponseModels;
    }

    public Page<RoommatePostResponseModel> roommatePostSuggestion(Filter filter) {

        FilterArgumentModel filterArgumentModel = filter.getFilterArgumentModel();
        Page<TbPost> posts = postService.finAllByFilter(filterArgumentModel.getPage()
                , filterArgumentModel.getOffset(), filter);
        Page<RoommatePostResponseModel> roommatePostResponseModels = posts.map(tbPost -> {

            RoommatePostResponseModel roommatePostResponseModel = new RoommatePostResponseModel();

            List<TbUtilitiesReference> utilitiesReferences = utilityReferenceService
                    .findAllByUserId(tbPost.getUserId());
            List<TbDistrictReference> districtReference = districtReferenceService
                    .findAllByUserId(tbPost.getUserId());
            TbFavourite favourite = favouriteService
                    .findByUserIdAndPostId(filter.getFilterArgumentModel().getUserId(), tbPost.getPostId());


            TbDistrict district = new TbDistrict();

            if (districtReference != null) {
                roommatePostResponseModel.setDistrictIds(districtReference
                        .stream()
                        .map(tbDistrictReference -> tbDistrictReference.getDistrictId())
                        .collect(Collectors.toList()));
                district = districtService.findByDistrictId(districtReference.get(0).getDistrictId());
                roommatePostResponseModel.setCityId(district.getCityId());
            }

            if (utilitiesReferences != null) {
                roommatePostResponseModel.setUtilityIds(utilitiesReferences
                        .stream()
                        .map(tbUtilitiesReference -> tbUtilitiesReference.getUtilityId())
                        .collect(Collectors.toList()));
            }

            UserResponeModel userResponeModel = new UserResponeModel(userService.findById(tbPost.getUserId()));
            roommatePostResponseModel.setPostId(tbPost.getPostId());
            roommatePostResponseModel.setPhoneContact(tbPost.getPhoneContact());
            roommatePostResponseModel.setDate(tbPost.getDatePost());
            roommatePostResponseModel.setUserResponeModel(userResponeModel);

            if (favourite != null) {
                roommatePostResponseModel.setFavouriteId(favourite.getId());
                roommatePostResponseModel.setFavourite(true);
            } else {
                roommatePostResponseModel.setFavourite(false);
            }

            roommatePostResponseModel.setMinPrice(tbPost.getMinPrice());
//                    roommatePostResponseModel.setMaxPrice(tbPost.getMaxPrice());
            return roommatePostResponseModel;
        });
        return roommatePostResponseModels;
    }
}