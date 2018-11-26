package com.caps.asp.service;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.request.FilterArgumentModel;
import com.caps.asp.model.uimodel.request.common.BaseSuggestRequestModel;
import com.caps.asp.model.uimodel.response.common.UserResponseModel;
import com.caps.asp.model.uimodel.response.common.RoomRateResponseModel;
import com.caps.asp.model.uimodel.response.post.RoomPostResponseModel;
import com.caps.asp.service.filter.Filter;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static com.caps.asp.constant.Constant.NEWPOST;

@Service
public class UtilsService {

    private PostService postService;
    private RoomService roomService;
    private RoomHasUtilityService roomHasUtilityService;
    private UserService userService;
    private FavouriteService favouriteService;
    private ImageService imageService;
    private UtilityReferenceService utilityReferenceService;
    private DistrictReferenceService districtReferenceService;
    private DistrictService districtService;
    private RoomRateService roomRateService;
    private UserRateService userRateService;


    public UtilsService(PostService postService, RoomService roomService, RoomHasUtilityService roomHasUtilityService, UserService userService, FavouriteService favouriteService, ImageService imageService, UtilityReferenceService utilityReferenceService, DistrictReferenceService districtReferenceService, DistrictService districtService, RoomRateService roomRateService, UserRateService userRateService) {
        this.postService = postService;
        this.roomService = roomService;
        this.roomHasUtilityService = roomHasUtilityService;
        this.userService = userService;
        this.favouriteService = favouriteService;
        this.imageService = imageService;
        this.utilityReferenceService = utilityReferenceService;
        this.districtReferenceService = districtReferenceService;
        this.districtService = districtService;
        this.roomRateService = roomRateService;
        this.userRateService = userRateService;
    }

    public Page<RoomPostResponseModel> partnerPostSuggestion(Filter filter) {

        FilterArgumentModel filterArgumentModel = filter.getFilterArgumentModel();

        Page<TbPost> posts = postService.finAllByFilter(filterArgumentModel.getPage()
                , filterArgumentModel.getOffset(), filter);
        if (posts.getTotalElements() != 0) {
            Page<RoomPostResponseModel> roomPostResponseModels = posts.map(tbPost -> {
                RoomPostResponseModel roomPostResponseModel = new RoomPostResponseModel();

                TbRoom room = roomService.findRoomById(tbPost.getRoomId());
                List<TbRoomHasUtility> roomHasUtilities = roomHasUtilityService.findAllByRoomId(room.getRoomId());
//                UserResponseModel userResponseModel = new UserResponseModel(userService.findById(tbPost.getUserId()));
                TbFavourite favourite = favouriteService
                        .findByUserIdAndPostId(filter.getFilterArgumentModel().getUserId(), tbPost.getPostId());

                roomPostResponseModel.setName(tbPost.getName());
                roomPostResponseModel.setPostId(tbPost.getPostId());
                roomPostResponseModel.setPhoneContact(tbPost.getPhoneContact());
                roomPostResponseModel.setDate(tbPost.getDatePost());

                UserResponseModel userResponseModel = new UserResponseModel();
                TbUser userDb = userService.findById(tbPost.getUserId());
                userResponseModel.setDob(userDb.getDob());
                userResponseModel.setPhone(userDb.getPhone());
                userResponseModel.setGender(userDb.getGender());
                userResponseModel.setUserId(userDb.getUserId());
                userResponseModel.setFullname(userDb.getFullname());
                userResponseModel.setImageProfile(userDb.getImageProfile());
                List<TbUserRate> userRates = userRateService.findAllByUserId(tbPost.getUserId());
                userResponseModel.setUserRateList(userRates);

                roomPostResponseModel.setUserResponseModel(userResponseModel);

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

                List<TbRoomRate> roomRateList = roomRateService.findAllByRoomId(tbPost.getRoomId());
                List<RoomRateResponseModel> roomRateResponseModels = new ArrayList<>();
                if (roomRateList != null) {
                    roomRateList.forEach(tbRoomRate -> {
                        RoomRateResponseModel roomRateResponseModel = new RoomRateResponseModel();
                        roomRateResponseModel.setSecurity(tbRoomRate.getSecurityRate());
                        roomRateResponseModel.setLocation(tbRoomRate.getLocationRate());
                        roomRateResponseModel.setUtility(tbRoomRate.getUtilityRate());
                        UserResponseModel user = new UserResponseModel();
                        TbUser tbUser = userService.findById(tbRoomRate.getUserId());
                        user.setUserId(tbUser.getUserId());
                        user.setFullname(tbUser.getFullname());
                        user.setImageProfile(tbUser.getImageProfile());
                        List<TbUserRate> tbUserRates = userRateService.findAllByUserId(tbRoomRate.getUserId());
                        user.setUserRateList(tbUserRates);
                        roomRateResponseModel.setUserResponseModel(user);
                        roomRateResponseModel.setComment(tbRoomRate.getComment());
                        roomRateResponseModel.setDate(tbRoomRate.getDate());

                        roomRateResponseModels.add(roomRateResponseModel);
                    });
                    roomPostResponseModel.setRoomRateResponseModels(roomRateResponseModels);
                }
                return roomPostResponseModel;
            });
            return roomPostResponseModels;
        }
        return null;
    }

    public Page<RoomPostResponseModel> getNewPost(BaseSuggestRequestModel baseSuggestRequestModel) {
        FilterArgumentModel filterArgumentModel = new FilterArgumentModel();
        filterArgumentModel.setOrderBy(NEWPOST);
        filterArgumentModel.setPage(baseSuggestRequestModel.getPage());
        filterArgumentModel.setOffset(baseSuggestRequestModel.getOffset());
        filterArgumentModel.setTypeId(baseSuggestRequestModel.getTypeId());
        filterArgumentModel.setCityId(baseSuggestRequestModel.getCityId());
        filterArgumentModel.setUserId(baseSuggestRequestModel.getUserId());
        Filter filter = new Filter();
        filter.setFilterArgumentModel(filterArgumentModel);
        Page<RoomPostResponseModel> roomPostResponseModels = partnerPostSuggestion(filter);
        return roomPostResponseModels;
    }

    public List<RoomPostResponseModel> mappingRoomPost(List<TbPost> postList, List<RoomPostResponseModel> roomPostResponseModels, int userId) {
        for (TbPost tbPost : postList) {

            RoomPostResponseModel roomPostResponseModel = new RoomPostResponseModel();

            TbRoom room = roomService.findRoomById(tbPost.getRoomId());
            List<TbRoomHasUtility> roomHasUtilities = roomHasUtilityService.findAllByRoomId(room.getRoomId());
            TbFavourite favourite = favouriteService
                    .findByUserIdAndPostId(userId, tbPost.getPostId());

            roomPostResponseModel.setName(tbPost.getName());
            roomPostResponseModel.setPostId(tbPost.getPostId());
            roomPostResponseModel.setPhoneContact(tbPost.getPhoneContact());
            roomPostResponseModel.setDate(tbPost.getDatePost());

            UserResponseModel userResponseModel = new UserResponseModel();
            TbUser userDb = userService.findById(tbPost.getUserId());
            userResponseModel.setDob(userDb.getDob());
            userResponseModel.setPhone(userDb.getPhone());
            userResponseModel.setGender(userDb.getGender());
            userResponseModel.setUserId(userDb.getUserId());
            userResponseModel.setFullname(userDb.getFullname());
            userResponseModel.setImageProfile(userDb.getImageProfile());
            List<TbUserRate> userRates = userRateService.findAllByUserId(tbPost.getUserId());
            userResponseModel.setUserRateList(userRates);

            roomPostResponseModel.setUserResponseModel(userResponseModel);
            if (favourite != null) {
                roomPostResponseModel.setFavourite(true);
                roomPostResponseModel.setFavouriteId(favourite.getId());
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

            List<TbRoomRate> roomRateList = roomRateService.findAllByRoomId(tbPost.getRoomId());
            List<RoomRateResponseModel> roomRateResponseModels = new ArrayList<>();
            if (roomRateList != null) {
                roomRateList.forEach(tbRoomRate -> {
                    RoomRateResponseModel roomRateResponseModel = new RoomRateResponseModel();
                    roomRateResponseModel.setSecurity(tbRoomRate.getSecurityRate());
                    roomRateResponseModel.setLocation(tbRoomRate.getLocationRate());
                    roomRateResponseModel.setUtility(tbRoomRate.getUtilityRate());
                    UserResponseModel user = new UserResponseModel();
                    TbUser tbUser = userService.findById(tbRoomRate.getUserId());
                    user.setUserId(tbUser.getUserId());
                    user.setFullname(tbUser.getFullname());
                    user.setImageProfile(tbUser.getImageProfile());
                    List<TbUserRate> tbUserRates = userRateService.findAllByUserId(tbRoomRate.getUserId());
                    user.setUserRateList(tbUserRates);
                    roomRateResponseModel.setUserResponseModel(user);
                    roomRateResponseModel.setComment(tbRoomRate.getComment());
                    roomRateResponseModel.setDate(tbRoomRate.getDate());

                    roomRateResponseModels.add(roomRateResponseModel);
                });
            }
            roomPostResponseModel.setRoomRateResponseModels(roomRateResponseModels);
            roomPostResponseModels.add(roomPostResponseModel);
        }
        return roomPostResponseModels;
    }
}
