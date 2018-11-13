package com.caps.asp.controller;

import com.caps.asp.model.TbDistrictReference;
import com.caps.asp.model.TbReference;
import com.caps.asp.model.TbUtilitiesReference;
import com.caps.asp.model.uimodel.request.FilterArgumentModel;
import com.caps.asp.service.DistrictReferenceService;
import com.caps.asp.service.ReferenceService;
import com.caps.asp.service.UtilityReferenceService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static org.springframework.http.HttpStatus.CONFLICT;
import static org.springframework.http.HttpStatus.CREATED;

@RestController
public class ReferenceController {

    public final UtilityReferenceService utilityReferenceService;
    public final DistrictReferenceService districtReferenceService;
    public final ReferenceService referenceService;

    public ReferenceController(UtilityReferenceService utilityReferenceService, DistrictReferenceService districtReferenceService, ReferenceService referenceService) {
        this.utilityReferenceService = utilityReferenceService;
        this.districtReferenceService = districtReferenceService;
        this.referenceService = referenceService;
    }

    @Transactional
    @PostMapping("/reference/create")
    public ResponseEntity createReference(@RequestBody FilterArgumentModel filterArgumentModel) {
        try {
            List<Double> prices = filterArgumentModel.getSearchRequestModel().getPrice();
            TbReference reference = new TbReference();
            reference.setMinPrice(prices.get(0));
            reference.setMaxPrice(prices.get(1));
            reference.setUserId(filterArgumentModel.getUserId());
            referenceService.save(reference);

            for (Integer utilityId : filterArgumentModel.getSearchRequestModel().getUtilities()) {
                TbUtilitiesReference tbUtilitiesReference = new TbUtilitiesReference();
                tbUtilitiesReference.setId(0);
                tbUtilitiesReference.setUserId(filterArgumentModel.getUserId());
                tbUtilitiesReference.setUtilityId(utilityId);
                utilityReferenceService.save(tbUtilitiesReference);
            }

            for (Integer districtId : filterArgumentModel.getSearchRequestModel().getDistricts()) {
                TbDistrictReference tbDistrictReference = new TbDistrictReference();
                tbDistrictReference.setId(0);
                tbDistrictReference.setUserId(filterArgumentModel.getUserId());
                tbDistrictReference.setDistrictId(districtId);
                districtReferenceService.save(tbDistrictReference);
            }

            return ResponseEntity.status(CREATED).build();
        } catch (Exception e) {
            return ResponseEntity.status(CONFLICT).build();
        }
    }
}
