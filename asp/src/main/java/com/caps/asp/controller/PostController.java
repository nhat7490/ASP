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
import com.caps.asp.util.CalculateDistance;
import org.springframework.data.domain.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

    public PostController(PostService postService, RoomService roomService, UserService userService, RoomHasUserService roomHasUserService, RoomHasUtilityService roomHasUtilityService, ImageService imageService, FavouriteService favouriteService, DistrictService districtService, UtilityReferenceService utilityReferenceService, DistrictReferenceService districtReferenceService, ReferenceService referenceService) {
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
    }

    @GetMapping("/post/findByUserId/{userId}")
    public ResponseEntity getPostByUserId(@PathVariable int userId,
                                          @RequestParam(defaultValue = "1") String page) {
        try {
            Page<TbPost> posts = postService.findAllByUserId(Integer.parseInt(page), 10, userId);
            return ResponseEntity.status(OK)
                    .body(posts.getContent());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @PostMapping("/post/createRoommatePost")
    public ResponseEntity createRoommatePost(@RequestBody RoommatePostRequestModel roommatePostRequestModel) {
        try {
            TbUser user = userService.findById(roommatePostRequestModel.getUserId());
            if (user.getRoleId() == MEMBER) {
                TbPost post = new TbPost();
                post.setTypeId(PARTNER_POST);
                Date date = new Date(System.currentTimeMillis());
                post.setDatePost(date);
                post.setPhoneContact(roommatePostRequestModel.getPhoneContact());
                post.setTypeId(ROOM_POST);
                post.setUserId(user.getUserId());
                post.setMaxPrice(roommatePostRequestModel.getMaxPrice());
                post.setMinPrice(roommatePostRequestModel.getMinPrice());

                post.setUserId(roommatePostRequestModel.getUserId());
                post.setPostId(0);
                postService.savePost(post);
                return ResponseEntity.status(CREATED).build();
            } else {
                return ResponseEntity.status(CONFLICT).build();
            }
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
            TbPost excistedPost = postService.findByRoomId(room.getRoomId());
            if (user.getRoleId() == ROOM_MASTER
                    && roomHasUser != null
                    && excistedPost == null) {
                TbPost post = new TbPost();
                post.setTypeId(ROOM_POST);
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
                postService.savePost(post);
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

            if (filter.getFilterArgumentModel().getTypeId() == ROOM_POST) {//get member post

                Page<TbPost> posts = postService.finAllByFilter(filterArgumentModel.getPage(), filterArgumentModel.getOffset(), filter);
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
                    } else {
                        roommatePostResponseModel.setFavourite(false);
                    }
                    roommatePostResponseModel.setMinPrice(tbPost.getMinPrice());
                    roommatePostResponseModel.setMaxPrice(tbPost.getMaxPrice());

                    return roommatePostResponseModel;
                });
                return ResponseEntity.status(OK).body(roommatePostResponseModels.getContent());

            } else if (filter.getFilterArgumentModel().getTypeId() == PARTNER_POST) {//get room master post

                Page<TbPost> posts = postService.finAllByFilter(filterArgumentModel.getPage(), filterArgumentModel.getOffset(), filter);
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

            if (filter.getFilterArgumentModel().getTypeId() == ROOM_POST) {//get member post

                Page<TbPost> posts = postService.finAllBookmarkByFilter(filterArgumentModel.getPage(), filterArgumentModel.getOffset(), filter);
                Page<RoommatePostResponseModel> roommatePostResponseModels = posts.map(tbPost -> {

                    RoommatePostResponseModel roommatePostResponseModel = new RoommatePostResponseModel();

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
                    roommatePostResponseModel.setMinPrice(tbPost.getMinPrice());
//                    roommatePostResponseModel.setMaxPrice(tbPost.getMaxPrice());
                    return roommatePostResponseModel;
                });
                return ResponseEntity.status(OK).body(roommatePostResponseModels.getContent());

            } else if (filter.getFilterArgumentModel().getTypeId() == PARTNER_POST) {//get room master post

                Page<TbPost> posts = postService.finAllBookmarkByFilter(filterArgumentModel.getPage(), filterArgumentModel.getOffset(), filter);
                Page<RoomPostResponseModel> roomPostResponseModels = posts.map(tbPost -> {
                    RoomPostResponseModel roomPostResponseModel = new RoomPostResponseModel();

                    TbRoom room = roomService.findRoomById(tbPost.getRoomId());
                    List<TbRoomHasUtility> roomHasUtilities = roomHasUtilityService.findAllByRoomId(room.getRoomId());
                    UserResponeModel userResponeModel = new UserResponeModel(userService.findById(tbPost.getUserId()));

                    roomPostResponseModel.setName(tbPost.getName());
                    roomPostResponseModel.setPostId(tbPost.getPostId());
                    roomPostResponseModel.setPhoneContact(tbPost.getPhoneContact());
                    roomPostResponseModel.setDate(tbPost.getDatePost());
                    roomPostResponseModel.setUserResponeModel(userResponeModel);
                    roomPostResponseModel.setFavourite(true);
                    roomPostResponseModel.setMinPrice(tbPost.getMinPrice());//price for room post
                    roomPostResponseModel.setAddress(room.getAddress());
                    roomPostResponseModel.setArea(room.getArea());
                    roomPostResponseModel.setGenderPartner(tbPost.getGenderPartner());
                    roomPostResponseModel.setDescription(tbPost.getDescription());
                    //missing
                    List<TbImage> images = imageService.findAllByRoomId(room.getRoomId());
                    roomPostResponseModel.setImageUrls(images.stream().map(image -> image.getLinkUrl()).collect(Collectors.toList()));

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

    @GetMapping("/post/{typeId}")
    public ResponseEntity getAll(@PathVariable int typeId) {
        try {
            List<TbPost> tbPostList = postService.findAllByTypeId(typeId);
            List<RoomPostResponseModel> roomPostResponseModels = new ArrayList<>();
            tbPostList.forEach(tbPost -> {
                RoomPostResponseModel roomPostResponseModel = new RoomPostResponseModel();

                TbRoom room = roomService.findRoomById(tbPost.getRoomId());
                List<TbRoomHasUtility> roomHasUtilities = roomHasUtilityService.findAllByRoomId(room.getRoomId());
                UserResponeModel userResponeModel = new UserResponeModel(userService.findById(tbPost.getUserId()));
                roomPostResponseModel.setName(tbPost.getName());
                roomPostResponseModel.setPostId(tbPost.getPostId());
                roomPostResponseModel.setPhoneContact(tbPost.getPhoneContact());
                roomPostResponseModel.setDate(tbPost.getDatePost());
                roomPostResponseModel.setUserResponeModel(userResponeModel);
                roomPostResponseModel.setFavourite(false);
                roomPostResponseModel.setMinPrice(room.getPrice());//missing
                roomPostResponseModel.setAddress(room.getAddress());
                roomPostResponseModel.setArea(room.getArea());
                roomPostResponseModel.setGenderPartner(tbPost.getGenderPartner());
                roomPostResponseModel.setImageUrls(Arrays.asList("http://gracehotel.com.au/sites/default/files/field/gallery/2018/08/5DM48071-HDR.jpg", "http://gracehotel.com.au/sites/default/files/field/gallery/2018/08/5DM48071-HDR.jpg", "http://gracehotel.com.au/sites/default/files/field/gallery/2018/08/5DM48071-HDR.jpg"));
                roomPostResponseModel.setUtilities(roomHasUtilities);
                roomPostResponseModel.setNumberPartner(tbPost.getNumberPartner());
                roomPostResponseModels.add(roomPostResponseModel);

            });
            return ResponseEntity.status(OK)
                    .body(roomPostResponseModels);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }


    @PostMapping("/user/suggestRoomMaster")
    public ResponseEntity suggestPost(@RequestBody BaseSuggestRequestModel baseSuggestRequestModel) {
        try {
            TbPost tbPost = postService.findPostByUserIdAndTypeId(baseSuggestRequestModel.getUserId(), PARTNER_POST);
            TbRoom tbRoom = roomService.findRoomById(tbPost.getRoomId());
            List<TbRoom> roomList = roomService.findAllRoomByDistrictId(tbRoom.getDistrictId());
            List<TbPost> postList = postService.getPostList(roomList, tbRoom.getRoomId());

            CalculateDistance calculateDistance = new CalculateDistance();
            HashMap<TbPost, Double> listSort = new HashMap<>();

            for (int i = 0; i < postList.size(); i++) {
                double distance = calculateDistance.distance(tbPost.getLattitude(), tbPost.getLongtitude(),
                        postList.get(i).getLattitude(), postList.get(i).getLongtitude());
                listSort.put(postList.get(i), distance);
            }
            List<Map.Entry<TbPost, Double>> postAfterSort = new LinkedList<>(listSort.entrySet());

            Collections.sort(postAfterSort, new Comparator<Map.Entry<TbPost, Double>>() {
                @Override
                public int compare(Map.Entry<TbPost, Double> e1, Map.Entry<TbPost, Double> e2) {
                    return (e1.getValue()).compareTo(e2.getValue());
                }
            });

            for (Map.Entry<TbPost, Double> entry : postAfterSort) {
                System.out.println(entry.getKey().getPostId() + " : " + entry.getValue());
            }

            List<TbPost> posts = new ArrayList<>();
            for (Map.Entry<TbPost, Double> post : postAfterSort) {
                posts.add(post.getKey());
            }

            int page = 1;
            int size = 10;
            int toIndex = (page - 1) * size + size;

            List<RoomPostResponseModel> roomPostResponseModels = new ArrayList<>();
            for (TbPost post : posts) {
                RoomPostResponseModel roomPostResponseModel = new RoomPostResponseModel();
                TbRoom room = roomService.findRoomById(post.getRoomId());
                List<TbRoomHasUtility> roomHasUtilities = roomHasUtilityService.findAllByRoomId(room.getRoomId());
                UserResponeModel userResponeModel = new UserResponeModel(userService.findById(post.getUserId()));

                roomPostResponseModel.setName(post.getName());
                roomPostResponseModel.setPostId(post.getPostId());
                roomPostResponseModel.setPhoneContact(post.getPhoneContact());
                roomPostResponseModel.setDate(post.getDatePost());
                roomPostResponseModel.setUserResponeModel(userResponeModel);
                roomPostResponseModel.setFavourite(true);
                roomPostResponseModel.setMinPrice(post.getMinPrice());//price for room post
                roomPostResponseModel.setAddress(room.getAddress());
                roomPostResponseModel.setArea(room.getArea());
                roomPostResponseModel.setGenderPartner(post.getGenderPartner());
                roomPostResponseModel.setDescription(post.getDescription());
                //missing
                List<TbImage> images = imageService.findAllByRoomId(room.getRoomId());
                roomPostResponseModel.setImageUrls(images.stream().map(image -> image.getLinkUrl()).collect(Collectors.toList()));

                roomPostResponseModel.setUtilities(roomHasUtilities);
                roomPostResponseModel.setNumberPartner(post.getNumberPartner());
                roomPostResponseModels.add(roomPostResponseModel);
            }

            return ResponseEntity.status(OK).body(roomPostResponseModels.subList((page - 1) * size, roomPostResponseModels.size() < toIndex ? roomPostResponseModels.size() : toIndex));

        } catch (Exception e) {
            return ResponseEntity.status((NOT_FOUND)).build();
        }
    }

    @PostMapping("post/suggestBestMatch")
    public ResponseEntity suggestBestMatch(@RequestBody FilterArgumentModel filterArgumentModel) {
        try {

            SearchRequestModel searchRequestModel = new SearchRequestModel();
            List<TbUtilitiesReference> utilitiesReference = utilityReferenceService.findAllByUserId(filterArgumentModel.getUserId());
            List<Integer> utilityIds = utilitiesReference
                    .stream()
                    .map(tbUtilitiesReference -> tbUtilitiesReference.getUtilityId())
                    .collect(Collectors.toList());
            searchRequestModel.setUtilities(utilityIds);

            List<TbDistrictReference> districtReferences = districtReferenceService.findAllByUserId(filterArgumentModel.getUserId());
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
            Page<TbPost> posts = postService.finAllByFilter(filterArgumentModel.getPage(), filterArgumentModel.getOffset(), filter);
            Page<RoomPostResponseModel> roomPostResponseModels = posts.map(tbPost -> {
                RoomPostResponseModel roomPostResponseModel = new RoomPostResponseModel();

                TbRoom room = roomService.findRoomById(tbPost.getRoomId());
                List<TbRoomHasUtility> roomHasUtilities = roomHasUtilityService.findAllByRoomId(room.getRoomId());
                UserResponeModel userResponeModel = new UserResponeModel(userService.findById(tbPost.getUserId()));

                roomPostResponseModel.setName(tbPost.getName());
                roomPostResponseModel.setPostId(tbPost.getPostId());
                roomPostResponseModel.setPhoneContact(tbPost.getPhoneContact());
                roomPostResponseModel.setDate(tbPost.getDatePost());
                roomPostResponseModel.setUserResponeModel(userResponeModel);
                roomPostResponseModel.setFavourite(true);
                roomPostResponseModel.setMinPrice(tbPost.getMinPrice());//price for room post
                roomPostResponseModel.setAddress(room.getAddress());
                roomPostResponseModel.setArea(room.getArea());
                roomPostResponseModel.setGenderPartner(tbPost.getGenderPartner());
                roomPostResponseModel.setDescription(tbPost.getDescription());
                //missing
                List<TbImage> images = imageService.findAllByRoomId(room.getRoomId());
                roomPostResponseModel.setImageUrls(images.stream().map(image -> image.getLinkUrl()).collect(Collectors.toList()));

                roomPostResponseModel.setUtilities(roomHasUtilities);
                roomPostResponseModel.setNumberPartner(tbPost.getNumberPartner());
                return roomPostResponseModel;
            });

            return ResponseEntity.status(OK).body(roomPostResponseModels.getContent());

        }catch(Exception e){
            return ResponseEntity.status((NOT_FOUND)).build();
        }

    }

}
