package com.caps.asp.controller;

import com.caps.asp.service.UtilityService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.http.HttpStatus.OK;

@RestController
public class UtilityController {

    public final UtilityService utilityService;

    public UtilityController(UtilityService utilityService) {
        this.utilityService = utilityService;
    }

    @GetMapping("/utiliti/getAll")
    public ResponseEntity getAllUtilities() {
        return ResponseEntity.status(OK).body(utilityService.getAll());
    }
}
