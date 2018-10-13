package com.caps.asp.service;

import com.caps.asp.model.TbCity;
import com.caps.asp.repository.CityRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CityService {
    public final CityRepository cityRepository;

    public CityService(CityRepository cityRepository) {
        this.cityRepository = cityRepository;
    }

    public List<TbCity> findAll(){
        return cityRepository.findAll();
    }
}
