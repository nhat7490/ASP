package com.caps.asp.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class PageController {

    @GetMapping("/")
    public ModelAndView loginPage() {
        return new ModelAndView("login");
    }

    @GetMapping("/room")
    public ModelAndView roomPage() {
        return new ModelAndView("room");
    }
}
