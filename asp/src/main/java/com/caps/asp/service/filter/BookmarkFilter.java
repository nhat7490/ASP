package com.caps.asp.service.filter;

import com.caps.asp.model.*;
import com.caps.asp.model.uimodel.request.FilterArgumentModel;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

public class BookmarkFilter implements Specification<TbPost> {

    private FilterArgumentModel filterArgumentModel;

    public FilterArgumentModel getFilterArgumentModel() {
        return filterArgumentModel;
    }

    public void setFilterArgumentModel(FilterArgumentModel filterArgumentModel) {
        this.filterArgumentModel = filterArgumentModel;
    }

    @Override
    public Predicate toPredicate(Root<TbPost> postRoot, CriteriaQuery<?> criteriaQuery, CriteriaBuilder cb) {
        if (filterArgumentModel.getSearchRequestModel() == null && filterArgumentModel.getTypeId() == null)
            return cb.conjunction();
        criteriaQuery.distinct(true);

        if (filterArgumentModel.getTypeId() == 1) {

            if (filterArgumentModel.getSearchRequestModel() != null) {
                Root<TbRoom> roomRoot = criteriaQuery.from(TbRoom.class);
                Root<TbDistrict> districtRoot = criteriaQuery.from(TbDistrict.class);
                Root<TbRoomHasUtility> roomHasUtilityRoot = criteriaQuery.from(TbRoomHasUtility.class);
                Root<TbUtilities> utilitiesRoot = criteriaQuery.from(TbUtilities.class);
                Root<TbFavourite> favouriteRoot = criteriaQuery.from(TbFavourite.class);
                Root<TbUser> userRoot = criteriaQuery.from(TbUser.class);

                List<Predicate> districtList = new ArrayList<>();
                List<Predicate> utilityList = new ArrayList<>();
                List<Predicate> priceList = new ArrayList<>();
                List<Predicate> genderList = new ArrayList<>();
                List<Predicate> typeList = new ArrayList<>();
                List<Predicate> userList = new ArrayList<>();

                if (filterArgumentModel.getOrderBy() == 1) {
                    criteriaQuery.orderBy(cb.desc(postRoot.get("datePost")));
                } else if (filterArgumentModel.getOrderBy() == 2) {
                    criteriaQuery.orderBy(cb.asc(postRoot.get("minPrice")));
                } else if (filterArgumentModel.getOrderBy() == 3) {
                    criteriaQuery.orderBy(cb.desc(postRoot.get("minPrice")));
                }

                if (filterArgumentModel.getSearchRequestModel().getDistricts() != null) {
                    for (Integer districtId : filterArgumentModel.getSearchRequestModel().getDistricts()) {
                        districtList.add(cb.equal(districtRoot.get("districtId"), districtId));
                    }
                } else {
                    districtList.add(cb.conjunction());
                }

                if (filterArgumentModel.getSearchRequestModel().getUtilities() != null) {
                    for (Integer utilityId : filterArgumentModel.getSearchRequestModel().getUtilities()) {
                        utilityList.add(cb.equal(utilitiesRoot.get("utilityId"), utilityId));
                    }
                } else {
                    utilityList.add(cb.conjunction());
                }

                if (filterArgumentModel.getSearchRequestModel().getGender() == 1
                        || filterArgumentModel.getSearchRequestModel().getGender() == 2) {

                    genderList.add(cb.equal(postRoot.get("genderPartner"), filterArgumentModel.getSearchRequestModel().getGender()));
                } else {
                    genderList.add(cb.conjunction());
                }

                if (filterArgumentModel.getSearchRequestModel().getPrice() != null
                        && filterArgumentModel.getSearchRequestModel().getPrice().size() == 2) {
                    priceList.add(cb.and(
                            cb.ge(postRoot.get("minPrice"), filterArgumentModel.getSearchRequestModel().getPrice().get(0)),
                            cb.le(postRoot.get("minPrice"), filterArgumentModel.getSearchRequestModel().getPrice().get(1))));
                }

                typeList.add(cb.equal(postRoot.get("typeId"), filterArgumentModel.getTypeId()));
                userList.add(cb.equal(userRoot.get("userId"), filterArgumentModel.getUserId()));

                if (districtList.size() == 0) districtList.add(cb.conjunction());
                if (utilityList.size() == 0) utilityList.add(cb.conjunction());
                if (genderList.size() == 0) genderList.add(cb.conjunction());
                if (priceList.size() == 0) priceList.add(cb.conjunction());
                return cb.and(
                        cb.equal(postRoot.get("postId"), favouriteRoot.get("postId")),
                        cb.equal(favouriteRoot.get("userId"), userRoot.get("userId")),
                        cb.equal(postRoot.get("roomId"), roomRoot.get("roomId")),
                        cb.equal(roomRoot.get("districtId"), districtRoot.get("districtId")),
                        cb.equal(roomRoot.get("roomId"), roomHasUtilityRoot.get("roomId")),
                        cb.equal(roomHasUtilityRoot.get("utilityId"), utilitiesRoot.get("utilityId")),
                        cb.or(userList.toArray(new Predicate[userList.size()])),
                        cb.or(typeList.toArray(new Predicate[typeList.size()])),
                        cb.or(districtList.toArray(new Predicate[districtList.size()])),
                        cb.or(utilityList.toArray(new Predicate[utilityList.size()])),
                        cb.or(genderList.toArray(new Predicate[genderList.size()])),
                        cb.or(priceList.toArray(new Predicate[priceList.size()]))

                );
            } else {
                Root<TbFavourite> favouriteRoot = criteriaQuery.from(TbFavourite.class);
                Root<TbUser> userRoot = criteriaQuery.from(TbUser.class);

                if (filterArgumentModel.getOrderBy() == 1) {
                    criteriaQuery.orderBy(cb.desc(postRoot.get("datePost")));
                } else if (filterArgumentModel.getOrderBy() == 2) {
                    criteriaQuery.orderBy(cb.asc(postRoot.get("minPrice")));
                } else if (filterArgumentModel.getOrderBy() == 3) {
                    criteriaQuery.orderBy(cb.desc(postRoot.get("minPrice")));
                }
                return cb.and(
                        cb.equal(postRoot.get("postId"), favouriteRoot.get("postId")),
                        cb.equal(favouriteRoot.get("userId"), userRoot.get("userId")),
                        cb.equal(postRoot.get("typeId"), filterArgumentModel.getTypeId()),
                        cb.equal(userRoot.get("userId"), filterArgumentModel.getUserId())

                );
            }
        } else {
            Root<TbFavourite> favouriteRoot = criteriaQuery.from(TbFavourite.class);
            Root<TbUser> userRoot = criteriaQuery.from(TbUser.class);
            return cb.and(
                    cb.equal(postRoot.get("postId"), favouriteRoot.get("postId")),
                    cb.equal(favouriteRoot.get("userId"), userRoot.get("userId")),
                    cb.equal(postRoot.get("typeId"), filterArgumentModel.getTypeId()),
                    cb.equal(userRoot.get("userId"), filterArgumentModel.getUserId())
            );
        }
    }
}
