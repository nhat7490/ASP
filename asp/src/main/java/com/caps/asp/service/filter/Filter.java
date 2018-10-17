package com.caps.asp.service.filter;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.request.SearchRequestModel;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

public class Filter implements Specification<TbPost> {

    private SearchRequestModel criteria;

    public SearchRequestModel getCriteria() {
        return criteria;
    }

    public void setCriteria(SearchRequestModel criteria) {
        this.criteria = criteria;
    }

    @Override
    public Predicate toPredicate(Root<TbPost> postRoot, CriteriaQuery<?> criteriaQuery, CriteriaBuilder cb) {
        if (criteria == null) return cb.conjunction();
        Root<TbRoom> roomRoot = criteriaQuery.from(TbRoom.class);
        Root<TbDistrict> districtRoot = criteriaQuery.from(TbDistrict.class);
        Root<TbRoomHasUtility> roomHasUtilityRoot = criteriaQuery.from(TbRoomHasUtility.class);
        Root<TbUtilities> utilitiesRoot = criteriaQuery.from(TbUtilities.class);

        List<Predicate> districtList = new ArrayList<>();
        List<Predicate> utilityList = new ArrayList<>();
        List<Predicate> priceList = new ArrayList<>();
        List<Predicate> genderList = new ArrayList<>();
        List<Predicate> typeList = new ArrayList<>();


        criteriaQuery.distinct(true);
        if(criteria.getOrderBy().equals("Cũ")){
            criteriaQuery.orderBy(cb.asc(postRoot.get("date")));
        }else {
            criteriaQuery.orderBy(cb.desc(postRoot.get("date")));
        }

        if (criteria.getDistricts().size() != 0) {
            for (Integer districtId : criteria.getDistricts()) {
                districtList.add(cb.equal(districtRoot.get("districtId"), districtId));
            }
        }

        if (criteria.getUtilities().size() != 0) {
            for (Integer utilityId : criteria.getUtilities()) {
                utilityList.add(cb.equal(utilitiesRoot.get("utilityId"), utilityId));
            }
        }

        if (criteria.getGender() != null)
            genderList.add(cb.equal(postRoot.get("genderPartner"), criteria.getGender()));

        if (criteria.getPrice().size() != 0) {
            priceList.add(cb.and(
                    cb.ge(roomRoot.get("price"), criteria.getPrice().get(0)),
                    cb.le(roomRoot.get("price"), criteria.getPrice().get(1))));
        }

        typeList.add(cb.equal(postRoot.get("typeId"), criteria.getTypeId()));

        if (districtList.size() == 0) districtList.add(cb.conjunction());
        if (utilityList.size() == 0) utilityList.add(cb.conjunction());
        if (genderList.size() == 0) genderList.add(cb.conjunction());
        if (priceList.size() == 0) priceList.add(cb.conjunction());

        Predicate result = cb.and(
                cb.equal(postRoot.get("roomId"), roomRoot.get("roomId")),
                cb.equal(roomRoot.get("districtId"), districtRoot.get("districtId")),
                cb.equal(roomRoot.get("roomId"), roomHasUtilityRoot.get("roomId")),
                cb.equal(roomHasUtilityRoot.get("utilityId"), utilitiesRoot.get("utilityId")),
                cb.or(typeList.toArray(new Predicate[typeList.size()])),

                cb.or(districtList.toArray(new Predicate[districtList.size()])),
                cb.or(utilityList.toArray(new Predicate[utilityList.size()])),
                cb.or(priceList.toArray(new Predicate[priceList.size()])),
                cb.or(genderList.toArray(new Predicate[genderList.size()]))
        );
        return result;
    }
}
