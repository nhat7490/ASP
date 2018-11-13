package com.caps.asp.controller;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.request.FilterArgumentModel;
import com.caps.asp.model.uimodel.request.SearchRequestModel;
import com.caps.asp.model.uimodel.request.post.RoomPostRequestModel;
import com.caps.asp.model.uimodel.request.post.RoommatePostRequestModel;
import com.caps.asp.model.uimodel.request.suggest.BaseSuggestRequestModel;
import com.caps.asp.model.uimodel.response.UserResponeModel;
import com.caps.asp.model.uimodel.response.post.RoomPostResponseModel;
import com.caps.asp.model.uimodel.response.post.RoommatePostResponseModel;
import com.caps.asp.service.*;
import com.caps.asp.service.filter.BookmarkFilter;
import com.caps.asp.service.filter.Filter;
import com.caps.asp.service.Suggest;
import com.caps.asp.util.GoogleAPI;
import com.google.maps.model.GeocodingResult;
import org.springframework.data.domain.*;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.*;
import java.util.stream.Collectors;

import static com.caps.asp.constant.Constant.*;
import static org.springframework.http.HttpStatus.*;

@RestController
public class PostController {
    public final PostService postService;
    public final RoomService roomService;
    public final UserService userService;
    public final RoomHasUserService roomHasUserService;
    public final RoomHasUtilityService roomHasUtilityService;
    public final ImageService imageService;
    public final FavouriteService favouriteService;
    public final DistrictService districtService;
    public final UtilityReferenceService utilityReferenceService;
    public final DistrictReferenceService districtReferenceService;
    public final ReferenceService referenceService;
    public final Suggest suggest;
    public final CityService cityService;
    public final PostHasUtilityService postHasUtilityService;
    public final PostHasDistrictService postHasDistrictService;

    public PostController(PostService postService, RoomService roomService, UserService userService, RoomHasUserService roomHasUserService, RoomHasUtilityService roomHasUtilityService, ImageService imageService, FavouriteService favouriteService, DistrictService districtService, UtilityReferenceService utilityReferenceService, DistrictReferenceService districtReferenceService, ReferenceService referenceService, Suggest suggest, CityService cityService, PostHasUtilityService postHasUtilityService, PostHasDistrictService postHasDistrictService) {
        this.postService = postService;
        this.roomService = roomService;
        this.userService = userService;
        this.roomHasUserService = roomHasUserService;
        this.roomHasUtilityService = roomHasUtilityService;
        this.imageService = imageService;
        this.favouriteService = favouriteService;
        this.districtService = districtService;
        this.utilityReferenceService = utilityReferenceService;
        this.districtReferenceService = districtReferenceService;
        this.referenceService = referenceService;
        this.suggest = suggest;
        this.cityService = cityService;
        this.postHasUtilityService = postHasUtilityService;
        this.postHasDistrictService = postHasDistrictService;
    }

    @PostMapping("/post/userPost")
    public ResponseEntity getPost(@RequestBody FilterArgumentModel filterArgumentModel) {
        try {
            //filter nay co page, offset, user id, typeid la co gia tri
            //search response model  = null
            //can mapping to Roommate response model va room response model
//        Page<TbPost> posts = postService.findAllByUserId(Integer.parseInt(page), 10, userId);
            if (filterArgumentModel.getTypeId() == MEMBER_POST) {//get member post
                Page<TbPost> posts = postService.findByUserIdAndTypeId(filterArgumentModel.getPage(), filterArgumentModel.getOffset(),
                        filterArgumentModel.getUserId(), filterArgumentModel.getTypeId());

                Page<RoommatePostResponseModel> roommatePostResponseModels = posts.map(tbPost -> {
                    RoommatePostResponseModel roommatePostResponseModel = new RoommatePostResponseModel();
                    UserResponeModel userResponeModel = new UserResponeModel(userService.findById(tbPost.getUserId()));
                    TbFavourite favourite = favouriteService
                            .findByUserIdAndPostId(filterArgumentModel.getUserId(), tbPost.getPostId());
                    List<TbUtilitiesReference> utilitiesReferences = utilityReferenceService.findAllByUserId(tbPost.getUserId());
                    List<TbDistrictReference> districtReferences = districtReferenceService.findAllByUserId(tbPost.getUserId());
                    TbDistrict district = new TbDistrict();

                    if (districtReferences != null && districtReferences.size() != 0) {
                        roommatePostResponseModel.setDistrictIds(districtReferences
                                .stream()
                                .map(tbDistrictReference -> tbDistrictReference.getDistrictId())
                                .collect(Collectors.toList()));
                        district = districtService.findByDistrictId(districtReferences.get(0).getDistrictId());
                        roommatePostResponseModel.setCityId(district.getCityId());
                    }

                    if (utilitiesReferences != null && utilitiesReferences.size() != 0) {
                        roommatePostResponseModel.setUtilityIds(utilitiesReferences
                                .stream()
                                .map(tbUtilitiesReference -> tbUtilitiesReference.getUtilityId())
                                .collect(Collectors.toList()));
                    }

                    roommatePostResponseModel.setPostId(tbPost.getPostId());
                    roommatePostResponseModel.setPhoneContact(tbPost.getPhoneContact());
                    roommatePostResponseModel.setDate(tbPost.getDatePost());
                    roommatePostResponseModel.setUserResponeModel(userResponeModel);

                    if (favourite != null) {
                        roommatePostResponseModel.setFavourite(true);
                        roommatePostResponseModel.setFavouriteId(favourite.getId());
                    } else {
                        roommatePostResponseModel.setFavourite(false);
                    }

                    roommatePostResponseModel.setMinPrice(tbPost.getMinPrice());
                    roommatePostResponseModel.setMaxPrice(tbPost.getMaxPrice());
                    return roommatePostResponseModel;
                });
                return ResponseEntity.status(OK).body(roommatePostResponseModels.getContent());
            } else {
                Page<TbPost> posts = postService.findByUserIdAndTypeId(filterArgumentModel.getPage(), filterArgumentModel.getOffset(),
                        filterArgumentModel.getUserId(), filterArgumentModel.getTypeId());
                Page<RoomPostResponseModel> roomPostResponseModels = posts.map(tbPost -> {
                    RoomPostResponseModel roomPostResponseModel = new RoomPostResponseModel();
                    TbRoom room = roomService.findRoomById(tbPost.getRoomId());
                    List<TbRoomHasUtility> roomHasUtilities = roomHasUtilityService.findAllByRoomId(room.getRoomId());
                    UserResponeModel userResponeModel = new UserResponeModel(userService.findById(tbPost.getUserId()));
                    TbFavourite favourite = favouriteService
                            .findByUserIdAndPostId(filterArgumentModel.getUserId(), tbPost.getPostId());
                    roomPostResponseModel.setName(tbPost.getName());
                    roomPostResponseModel.setPostId(tbPost.getPostId());
                    roomPostResponseModel.setPhoneContact(tbPost.getPhoneContact());
                    roomPostResponseModel.setDate(tbPost.getDatePost());
                    roomPostResponseModel.setUserResponeModel(userResponeModel);

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
                    return roomPostResponseModel;
                });
                return ResponseEntity.status(OK).body(roomPostResponseModels.getContent());
            }
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @Transactional
    @PostMapping("/post/createRoommatePost")
    public ResponseEntity createRoommatePost(@RequestBody RoommatePostRequestModel roommatePostRequestModel) {
        try {
            TbUser user = userService.findById(roommatePostRequestModel.getUserId());

            TbPost post = new TbPost();
            Date date = new Date(System.currentTimeMillis());
            post.setDatePost(date);
            post.setPhoneContact(roommatePostRequestModel.getPhoneContact());
            post.setTypeId(MEMBER_POST);
            post.setUserId(user.getUserId());
            post.setMaxPrice(roommatePostRequestModel.getMaxPrice());
            post.setMinPrice(roommatePostRequestModel.getMinPrice());
            post.setUserId(roommatePostRequestModel.getUserId());
            post.setPostId(0);
            int postId = postService.savePost(post);

            TbReference reference = referenceService.getByUserId(user.getUserId());
            reference.setMaxPrice(roommatePostRequestModel.getMaxPrice());
            reference.setMinPrice(roommatePostRequestModel.getMinPrice());
            referenceService.save(reference);

            utilityReferenceService.removeAllByUserId(user.getUserId());

            for (Integer utilityId : roommatePostRequestModel.getUtilityIds()) {
                TbPostHasUtility postHasUtility = new TbPostHasUtility();
                postHasUtility.setId(0);
                postHasUtility.setPostId(postId);
                postHasUtility.setUtilityId(utilityId);
                postHasUtilityService.save(postHasUtility);

                TbUtilitiesReference utilitiesReference = new TbUtilitiesReference();
                utilitiesReference.setId(0);
                utilitiesReference.setUserId(user.getUserId());
                utilitiesReference.setUtilityId(utilityId);
                utilityReferenceService.save(utilitiesReference);
            }

            districtReferenceService.removeAllByUserId(user.getUserId());

            for (Integer districtId : roommatePostRequestModel.getDistrictIds()) {
                TbPostHasTbDistrict postHasTbDistrict = new TbPostHasTbDistrict();
                postHasTbDistrict.setId(0);
                postHasTbDistrict.setPostId(postId);
                postHasTbDistrict.setDistrictId(districtId);
                postHasDistrictService.save(postHasTbDistrict);

                TbDistrictReference districtReference = new TbDistrictReference();
                districtReference.setId(0);
                districtReference.setUserId(user.getUserId());
                districtReference.setDistrictId(districtId);
                districtReferenceService.save(districtReference);
            }
            return ResponseEntity.status(CREATED).build();
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

    @PostMapping("/post/createRoomPost")
    public ResponseEntity createRoomPost(@RequestBody RoomPostRequestModel roomPostRequestModel) {
        try {
            TbUser user = userService.findById(roomPostRequestModel.getUserId());
            TbRoom room = roomService.findRoomById(roomPostRequestModel.getRoomId());
            TbRoomHasUser roomHasUser = roomHasUserService.findByUserIdAndRoomId(user.getUserId(), room.getRoomId());
//        TbPost excistedPost = postService.findByRoomId(room.getRoomId());

            if (user.getRoleId() == ROOM_MASTER && roomHasUser != null) {
                TbPost post = new TbPost();
                post.setTypeId(MEMBER_POST);
                post.setLongtitude(room.getLongtitude());
                post.setLattitude(room.getLattitude());
                Date date = new Date(System.currentTimeMillis());
                post.setDatePost(date);
                post.setNumberPartner(roomPostRequestModel.getNumberPartner());
                post.setPhoneContact(roomPostRequestModel.getPhoneContact());
                post.setName(roomPostRequestModel.getName());
                post.setRoomId(roomPostRequestModel.getRoomId());
                post.setGenderPartner(roomPostRequestModel.getGenderPartner());
                post.setUserId(roomPostRequestModel.getUserId());
                post.setPostId(0);

                int postId = postService.savePost(post);
                List<TbRoomHasUtility> roomHasUtilities = roomHasUtilityService.findAllByRoomId(roomPostRequestModel.getRoomId());

                for (TbRoomHasUtility tbRoomHasUtility : roomHasUtilities) {
                    TbPostHasUtility postHasUtility = new TbPostHasUtility();
                    postHasUtility.setId(0);
                    postHasUtility.setPostId(postId);
                    postHasUtility.setUtilityId(tbRoomHasUtility.getUtilityId());
                    postHasUtility.setBrand(tbRoomHasUtility.getBrand());
                    postHasUtility.setQuantity(tbRoomHasUtility.getQuantity());
                    postHasUtility.setDescription(tbRoomHasUtility.getDescription());
                    postHasUtilityService.save(postHasUtility);
                }

                TbPostHasTbDistrict tbPostHasTbDistrict = new TbPostHasTbDistrict();
                tbPostHasTbDistrict.setDistrictId(roomService
                        .findRoomById(roomPostRequestModel.getRoomId())
                        .getDistrictId());
                tbPostHasTbDistrict.setPostId(postId);
                tbPostHasTbDistrict.setId(0);
                postHasDistrictService.save(tbPostHasTbDistrict);
                return ResponseEntity.status(CREATED).build();
            } else {
                return ResponseEntity.status(CONFLICT).build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

    @PutMapping("/post/update")
    public ResponseEntity updatePost(@RequestBody TbPost post) {
        try {
            TbPost existedTbPost = postService.findByPostId(post.getPostId());
            if (existedTbPost != null) {
                existedTbPost.setName(post.getName());
                existedTbPost.setPhoneContact(post.getPhoneContact());
                existedTbPost.setNumberPartner(post.getNumberPartner());
                existedTbPost.setGenderPartner(post.getGenderPartner());
                existedTbPost.setDatePost(post.getDatePost());
                existedTbPost.setLattitude(post.getLattitude());
                existedTbPost.setLongtitude(post.getLongtitude());
                postService.savePost(existedTbPost);
                return ResponseEntity.status(CREATED).build();
            } else {
                return ResponseEntity.status(CONFLICT).build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }

    @PostMapping("/post/filter")
    public ResponseEntity getPostByFilter(@RequestBody FilterArgumentModel filterArgumentModel) {
        try {
            Filter filter = new Filter();
            filter.setFilterArgumentModel(filterArgumentModel);

            if (filter.getFilterArgumentModel().getTypeId() == MEMBER_POST) {//get member post
                Page<TbPost> posts = postService.finAllByFilter(filterArgumentModel.getPage()
                        , filterArgumentModel.getOffset(), filter);
                Page<RoommatePostResponseModel> roommatePostResponseModels = posts.map(tbPost -> {
                    RoommatePostResponseModel roommatePostResponseModel = new RoommatePostResponseModel();
                    UserResponeModel userResponeModel = new UserResponeModel(userService.findById(tbPost.getUserId()));
                    TbFavourite favourite = favouriteService
                            .findByUserIdAndPostId(filter.getFilterArgumentModel().getUserId(), tbPost.getPostId());
                    List<TbUtilitiesReference> utilitiesReferences = utilityReferenceService.findAllByUserId(tbPost.getUserId());
                    List<TbDistrictReference> districtReferences = districtReferenceService.findAllByUserId(tbPost.getUserId());
                    TbDistrict district = new TbDistrict();

                    if (districtReferences != null && districtReferences.size() != 0) {
                        roommatePostResponseModel.setDistrictIds(districtReferences
                                .stream()
                                .map(tbDistrictReference -> tbDistrictReference.getDistrictId())
                                .collect(Collectors.toList()));
                        district = districtService.findByDistrictId(districtReferences.get(0).getDistrictId());
                        roommatePostResponseModel.setCityId(district.getCityId());
                    }

                    if (utilitiesReferences != null && utilitiesReferences.size() != 0) {
                        roommatePostResponseModel.setUtilityIds(utilitiesReferences
                                .stream()
                                .map(tbUtilitiesReference -> tbUtilitiesReference.getUtilityId())
                                .collect(Collectors.toList()));
                    }

                    roommatePostResponseModel.setPostId(tbPost.getPostId());
                    roommatePostResponseModel.setPhoneContact(tbPost.getPhoneContact());
                    roommatePostResponseModel.setDate(tbPost.getDatePost());
                    roommatePostResponseModel.setUserResponeModel(userResponeModel);

                    if (favourite != null) {
                        roommatePostResponseModel.setFavourite(true);
                        roommatePostResponseModel.setFavouriteId(favourite.getId());
                    } else {
                        roommatePostResponseModel.setFavourite(false);
                    }

                    roommatePostResponseModel.setMinPrice(tbPost.getMinPrice());
                    roommatePostResponseModel.setMaxPrice(tbPost.getMaxPrice());
                    return roommatePostResponseModel;
                });
                return ResponseEntity.status(OK).body(roommatePostResponseModels.getContent());
            } else if (filter.getFilterArgumentModel().getTypeId() == MASTER_POST) {//get room master post
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
                    return roomPostResponseModel;
                });
                return ResponseEntity.status(OK).body(roomPostResponseModels.getContent());
            }
            return ResponseEntity.status(NOT_FOUND).build();
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @PostMapping("/post/favouriteFilter")
    public ResponseEntity getFavouriteByFilter(@RequestBody FilterArgumentModel filterArgumentModel) {
        try {
            BookmarkFilter filter = new BookmarkFilter();
            filter.setFilterArgumentModel(filterArgumentModel);

            if (filter.getFilterArgumentModel().getTypeId() == MEMBER_POST) {//get member post
                Page<TbPost> posts = postService.finAllBookmarkByFilter(filterArgumentModel.getPage()
                        , filterArgumentModel.getOffset(), filter);
                Page<RoommatePostResponseModel> roommatePostResponseModels = posts.map(tbPost -> {
                    RoommatePostResponseModel roommatePostResponseModel = new RoommatePostResponseModel();
                    TbFavourite favourite = favouriteService
                            .findByUserIdAndPostId(filter.getFilterArgumentModel().getUserId(), tbPost.getPostId());
                    List<TbUtilitiesReference> utilitiesReferences = utilityReferenceService.findAllByUserId(tbPost.getUserId());
                    List<TbDistrictReference> districtReferences = districtReferenceService.findAllByUserId(tbPost.getUserId());
                    TbDistrict district = new TbDistrict();

                    if (districtReferences != null) {
                        roommatePostResponseModel.setDistrictIds(districtReferences
                                .stream()
                                .map(tbDistrictReference -> tbDistrictReference.getDistrictId())
                                .collect(Collectors.toList()));
                        district = districtService.findByDistrictId(districtReferences.get(0).getDistrictId());
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
                    roommatePostResponseModel.setFavourite(true);
                    roommatePostResponseModel.setFavouriteId(favourite.getId());
                    roommatePostResponseModel.setMinPrice(tbPost.getMinPrice());
//                    roommatePostResponseModel.setMaxPrice(tbPost.getMaxPrice());
                    return roommatePostResponseModel;
                });
                return ResponseEntity.status(OK).body(roommatePostResponseModels.getContent());
            } else if (filter.getFilterArgumentModel().getTypeId() == MASTER_POST) {//get room master post
                Page<TbPost> posts = postService.finAllBookmarkByFilter(filterArgumentModel.getPage()
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
                    roomPostResponseModel.setFavourite(true);
                    roomPostResponseModel.setFavouriteId(favourite.getId());
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
                return ResponseEntity.status(OK).body(roomPostResponseModels.getContent());
            }
            return ResponseEntity.status(NOT_FOUND).build();
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @PostMapping("/post/suggest")
    public ResponseEntity suggestPost(@RequestBody BaseSuggestRequestModel baseSuggestRequestModel) {
        try {
            TbUser tbUser = userService.findById(baseSuggestRequestModel.getUserId());
            List<TbPost> checkPost = postService.findPostByUserIdAndTypeId(baseSuggestRequestModel.getUserId(), MASTER_POST);

            //sugesst for room master
            if (tbUser.getRoleId() == ROOM_MASTER && checkPost != null) {
                List<TbPost> postList = postService.getSuggestedList(baseSuggestRequestModel.getUserId()
                        , baseSuggestRequestModel.getPage(), baseSuggestRequestModel.getOffset());

                if (postList == null) {
                    return ResponseEntity
                            .status(OK)
                            .body(suggest.getNewPost(baseSuggestRequestModel)
                                    .getContent());
                }

                List<RoomPostResponseModel> roomPostResponseModels = new ArrayList<>();
                return ResponseEntity.status(OK).body(suggest.mappingRoomPost(postList, roomPostResponseModels, baseSuggestRequestModel.getUserId()));
            } else if (referenceService.getByUserId(baseSuggestRequestModel.getUserId()) != null) {//sugesst for room master
                SearchRequestModel searchRequestModel = new SearchRequestModel();
                List<TbUtilitiesReference> utilitiesReference = utilityReferenceService
                        .findAllByUserId(baseSuggestRequestModel.getUserId());
                List<Integer> utilityIds = utilitiesReference
                        .stream()
                        .map(tbUtilitiesReference -> tbUtilitiesReference.getUtilityId())
                        .collect(Collectors.toList());
                searchRequestModel.setUtilities(utilityIds);

                List<TbDistrictReference> districtReferences = districtReferenceService
                        .findAllByUserId(baseSuggestRequestModel.getUserId());
                List<Integer> districtIds = districtReferences
                        .stream()
                        .map(tbDistrictReference -> tbDistrictReference.getDistrictId())
                        .collect(Collectors.toList());
                searchRequestModel.setDistricts(districtIds);

                TbReference reference = referenceService.getByUserId(baseSuggestRequestModel.getUserId());
                List<Double> price = new ArrayList<>();
                price.add(reference.getMinPrice());
                price.add(reference.getMaxPrice());
                searchRequestModel.setPrice(price);

                FilterArgumentModel filterArgumentModel = new FilterArgumentModel();
                filterArgumentModel.setTypeId(baseSuggestRequestModel.getTypeId());
                filterArgumentModel.setPage(baseSuggestRequestModel.getPage());
                filterArgumentModel.setOffset(baseSuggestRequestModel.getOffset());
                filterArgumentModel.setOrderBy(NEWPOST);
                filterArgumentModel.setUserId(baseSuggestRequestModel.getUserId());
                filterArgumentModel.setCityId(baseSuggestRequestModel.getCityId());
                filterArgumentModel.setSearchRequestModel(searchRequestModel);

                Filter filter = new Filter();
                filter.setFilterArgumentModel(filterArgumentModel);
                Page<RoomPostResponseModel> roomPostResponseModels = suggest.partnerPostSuggestion(filter);
                if (roomPostResponseModels == null) {
                    return ResponseEntity
                            .status(OK)
                            .body(suggest.getNewPost(baseSuggestRequestModel)
                                    .getContent());
                }
                return ResponseEntity.status(OK).body(roomPostResponseModels.getContent());
            } else if (baseSuggestRequestModel.getLatitude() == null
                    && baseSuggestRequestModel.getLongitude() == null) { //not access location, suggest new post
                Page<RoomPostResponseModel> roomPostResponseModels = suggest.getNewPost(baseSuggestRequestModel);
                return ResponseEntity.status(OK).body(roomPostResponseModels.getContent());
            } else { //access location, suggest nearby post
                GoogleAPI googleAPI = new GoogleAPI();
                GeocodingResult geocodingResult = googleAPI.getLocationName(baseSuggestRequestModel.getLatitude(), baseSuggestRequestModel.getLongitude());

                String city = googleAPI.getCity(geocodingResult);
                int cityId = cityService.findByNameLike(city).getCityId();
                String district = googleAPI.getDistrict(geocodingResult);
                int districtId = districtService.findByNameLikeAndDistrictId(district, cityId).getDistrictId();

                List<TbPost> postList = postService.getSuggestedListForMember(Float.parseFloat(baseSuggestRequestModel.getLatitude().toString())
                        , Float.parseFloat(baseSuggestRequestModel.getLongitude().toString())
                        , districtId
                        , baseSuggestRequestModel.getPage(), baseSuggestRequestModel.getOffset());

                if (postList == null) {
                    return ResponseEntity
                            .status(OK)
                            .body(suggest.getNewPost(baseSuggestRequestModel)
                                    .getContent());
                }

                List<RoomPostResponseModel> roomPostResponseModels = new ArrayList<>();
                return ResponseEntity
                        .status(OK)
                        .body(suggest.mappingRoomPost(postList, roomPostResponseModels
                                , baseSuggestRequestModel.getUserId()));
            }
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }

    @PostMapping("post/suggestBestMatch")
    public ResponseEntity suggestBestMatch(@RequestBody FilterArgumentModel filterArgumentModel) {
        SearchRequestModel searchRequestModel = new SearchRequestModel();
        List<TbUtilitiesReference> utilitiesReference = utilityReferenceService
                .findAllByUserId(filterArgumentModel.getUserId());
        List<Integer> utilityIds = utilitiesReference
                .stream()
                .map(tbUtilitiesReference -> tbUtilitiesReference.getUtilityId())
                .collect(Collectors.toList());
        searchRequestModel.setUtilities(utilityIds);

        List<TbDistrictReference> districtReferences = districtReferenceService
                .findAllByUserId(filterArgumentModel.getUserId());
        List<Integer> districtIds = districtReferences
                .stream()
                .map(tbDistrictReference -> tbDistrictReference.getDistrictId())
                .collect(Collectors.toList());
        searchRequestModel.setDistricts(districtIds);

        TbReference reference = referenceService.getByUserId(filterArgumentModel.getUserId());
        List<Double> price = new ArrayList<>();
        price.add(reference.getMinPrice());
        price.add(reference.getMaxPrice());
        searchRequestModel.setPrice(price);

        filterArgumentModel.setSearchRequestModel(searchRequestModel);

        Filter filter = new Filter();
        filter.setFilterArgumentModel(filterArgumentModel);
        if (filterArgumentModel.getTypeId() == MASTER_POST) {

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

            return ResponseEntity.status(OK).body(roomPostResponseModels.getContent());
        } else {

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
            return ResponseEntity.status(OK).body(roommatePostResponseModels.getContent());

        }

    }
}
