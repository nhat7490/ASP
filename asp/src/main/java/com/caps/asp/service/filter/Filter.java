package com.caps.asp.service.filter;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.SearchRequestModel;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;

public class Filter implements Specification<TbPost> {

    private SearchRequestModel criteria ;

    public SearchRequestModel getCriteria() {
        return criteria;
    }

    public void setCriteria(SearchRequestModel criteria) {
        this.criteria = criteria;
    }


    @Override
    public Predicate toPredicate(Root<TbPost> postRoot, CriteriaQuery<?> criteriaQuery, CriteriaBuilder cb) {
        if (criteria == null) return cb.conjunction();
        Root<TbRoom>roomRoot = criteriaQuery.from(TbRoom.class);
        Root<TbDistrict>districtRoot = criteriaQuery.from(TbDistrict.class);
        Root<TbRoomHasUtility>roomHasUtilityRoot = criteriaQuery.from(TbRoomHasUtility.class);
        Root<TbUtilities>utilitiesRoot = criteriaQuery.from(TbUtilities.class);
        return cb.and(
                cb.equal(postRoot.get("roomId"),roomRoot.get("roomId")),
                cb.equal(roomRoot.get("districtId"),districtRoot.get("districtId")),
                cb.equal(roomRoot.get("roomId"),roomHasUtilityRoot.get("roomId")),
                cb.equal(roomHasUtilityRoot.get("utilityId"),utilitiesRoot.get("utilityId")),
                cb.and(
                        cb.and(districtRoot.get("name").in(criteria.getDistricts())),
                        cb.or(utilitiesRoot.get("name").in(criteria.getUtilities()))
                )
        );
    }
}