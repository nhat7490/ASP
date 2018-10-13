package com.caps.asp.service;

import com.caps.asp.model.TbDistrict;
import com.caps.asp.repository.DistrictRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DistrictService {

    public final DistrictRepository districtRepository;

    public DistrictService(DistrictRepository districtRepository) {
        this.districtRepository = districtRepository;
    }

    public List<TbDistrict>findAll(){
        return districtRepository.findAll();
    }
}
