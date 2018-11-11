package com.caps.asp.controller;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.room.RoomModel;
import com.caps.asp.service.*;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import static com.caps.asp.constant.Constant.*;

@RestController
public class PageController {

    private final RoomService roomService;
    private final ImageService imageService;
    private final UserService userService;
    private final RoomHasUserService roomHasUserService;
    private final PostService postService;
    private final FavouriteService favouriteService;
    private final PostHasDistrictService postHasDistrictService;
    private final RoomHasUtilityService roomHasUtilityService;
    private final PostHasUtilityService postHasUtilityService;


    public PageController(RoomService roomService, ImageService imageService, UserService userService, RoomHasUserService roomHasUserService, PostService postService, FavouriteService favouriteService, PostHasDistrictService postHasDistrictService, RoomHasUtilityService roomHasUtilityService, PostHasUtilityService postHasUtilityService) {
        this.roomService = roomService;
        this.imageService = imageService;
        this.userService = userService;
        this.roomHasUserService = roomHasUserService;
        this.postService = postService;
        this.favouriteService = favouriteService;
        this.postHasDistrictService = postHasDistrictService;
        this.roomHasUtilityService = roomHasUtilityService;
        this.postHasUtilityService = postHasUtilityService;
    }

    @GetMapping("/")
    public ModelAndView loginPage() {
        return new ModelAndView("login");
    }

    @GetMapping("/room")
    public ModelAndView roomPage(HttpServletRequest request, @RequestParam(defaultValue = "1") int page,
                                 @RequestParam(defaultValue = "10") int size) {

        Page<TbRoom> rooms = roomService.getAllByStatusId(page, size, PENDING);
        Page<RoomModel> roomModels = rooms.map(tbRoom -> {
            RoomModel roomModel = new RoomModel();
            roomModel.setName(tbRoom.getName());
            roomModel.setRoomId(tbRoom.getRoomId());
            roomModel.setArea(tbRoom.getArea());
            roomModel.setPrice(tbRoom.getPrice());
            roomModel.setAddress(tbRoom.getAddress());
            roomModel.setDateCreated(tbRoom.getDate());

            List<TbImage> images = imageService.findAllByRoomId(tbRoom.getRoomId());
            roomModel.setImageUrls(imageService.findAllByRoomId(tbRoom.getRoomId())
                    .stream()
                    .map(tbImage -> tbImage.getLinkUrl())
                    .collect(Collectors.toList()));
            return roomModel;
        });
        request.setAttribute("ROOMS", roomModels.getContent());
        request.setAttribute("PAGE", rooms.getTotalPages());
        request.setAttribute("SIZE", size);
        request.setAttribute("CURRENTPAGE", page);
        return new ModelAndView("room");
    }

    //approve room
    @GetMapping("/room/approve/{roomId}")
    public void approveRoom(HttpServletResponse response, @PathVariable int roomId) throws IOException {
        TbRoom room = roomService.findRoomById(roomId);
        room.setStatusId(APPROVED);
        roomService.saveRoom(room);
        response.sendRedirect("/room");
    }

    @GetMapping("/room/decline/{roomId}")
    public void declineRoom(HttpServletResponse response, @PathVariable int roomId) throws IOException {
        TbRoom room = roomService.findRoomById(roomId);
        room.setStatusId(DECLINED);
        roomService.saveRoom(room);
        response.sendRedirect("/room");
    }

    @GetMapping("/users")
    public ModelAndView userPage(HttpServletRequest request, @RequestParam(defaultValue = "1") int page,
                                 @RequestParam(defaultValue = "10") int size) {
        Page<TbUser> users = userService.findAll(page, size);
        request.setAttribute("USERS", users.getContent());
        request.setAttribute("PAGE", users.getTotalPages());
        request.setAttribute("SIZE", size);
        request.setAttribute("CURRENTPAGE", page);

        return new ModelAndView("user");
    }

    @Transactional
    @GetMapping("/users/remove/{userId}")
    public void deleteUser(HttpServletResponse response, @PathVariable int userId) throws IOException {
        TbUser user = userService.findById(userId);
        if (user.getRoleId() == HOUSE_OWNER){
            List<TbRoom> rooms = roomService.getAllByUserId(userId);
            rooms.forEach(tbRoom -> {

                roomHasUtilityService.deleteAllRoomHasUtilityByRoomId(tbRoom.getRoomId());
                imageService.deleteAllImageByRoomId(tbRoom.getRoomId());

                List<TbRoomHasUser> roomHasUsers = roomHasUserService.getAllByRoomId(tbRoom.getRoomId());
                roomHasUsers.forEach(tbRoomHasUser -> {
                    TbUser tbUser = userService.findById(tbRoomHasUser.getUserId());
                    if (tbUser.getRoleId() == ROOM_MASTER){
                        tbUser.setRoleId(MEMBER);
                        userService.saveUser(tbUser);
                    }
                });

                roomHasUserService.removeAllByRoomId(tbRoom.getRoomId());
                List<TbPost> posts = postService.findAllByRoomId(tbRoom.getRoomId());
                posts.forEach(tbPost -> {
                    favouriteService.removeAllByPostId(tbPost.getPostId());
                    postHasDistrictService.removeAllByPostId(tbPost.getPostId());
                    postHasUtilityService.deleteAllPostHasUtilityByPostId(tbPost.getPostId());
                    postService.removeByRoomId(tbRoom.getRoomId());
                });
                roomService.deleteRoom(tbRoom.getRoomId());

            });

        }else{
            List<TbPost> posts = postService.findPostByUserId(userId);
            posts.forEach(tbPost -> {
                favouriteService.removeAllByPostId(tbPost.getPostId());
                postHasDistrictService.removeAllByPostId(tbPost.getPostId());
                postService.removeAllByUserId(userId);
            });
        }
        userService.deleteUser(userId);
        response.sendRedirect("/users");
    }
}
