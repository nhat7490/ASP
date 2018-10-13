package com.caps.asp.controller;

import com.caps.asp.model.TbDistrict;
import com.caps.asp.service.DistrictService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static org.springframework.http.HttpStatus.NOT_FOUND;
import static org.springframework.http.HttpStatus.OK;

@RestController
public class DistrictController {

    public final DistrictService districtService;

    public DistrictController(DistrictService districtService) {
        this.districtService = districtService;
    }

    @GetMapping("/district")
    public ResponseEntity<List<TbDistrict>> getAllDistrict() {
        try {
            return ResponseEntity.status(OK).body(districtService.findAll());
        } catch (Exception e) {
            return ResponseEntity.status(NOT_FOUND).build();
        }
    }
}
