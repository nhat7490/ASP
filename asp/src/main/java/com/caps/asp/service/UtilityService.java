package com.caps.asp.service;

import com.caps.asp.model.TbUtilities;
import com.caps.asp.repository.UtilitiRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UtilityService {

    public final UtilitiRepository utilitiRepository;

    public UtilityService(UtilitiRepository utilitiRepository) {
        this.utilitiRepository = utilitiRepository;
    }

    public List<TbUtilities> getAll(){
        return utilitiRepository.findAll();
    }
}
