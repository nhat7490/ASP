package com.caps.asp.controller;

import com.caps.asp.model.TbImage;
import com.caps.asp.model.TbRoom;
import com.caps.asp.model.TbUser;
import com.caps.asp.model.uimodel.room.RoomModel;
import com.caps.asp.service.ImageService;
import com.caps.asp.service.RoomService;
import com.caps.asp.service.UserService;
import org.springframework.data.domain.Page;
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


    public PageController(RoomService roomService, ImageService imageService, UserService userService) {
        this.roomService = roomService;
        this.imageService = imageService;
        this.userService = userService;
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

    @GetMapping("/users/remove/{userId}")
    public void deleteUser(HttpServletResponse response, @PathVariable int userId) throws IOException {
        TbUser user = userService.findById(userId);
        if (user.getRoleId() == HOUSE_OWNER){
        }
        userService.deleteUser(userId);
        response.sendRedirect("/users");
    }
}
