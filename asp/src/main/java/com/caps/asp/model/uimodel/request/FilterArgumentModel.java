package com.caps.asp.model.uimodel.request;

public class FilterArgumentModel {
    private SearchRequestModel searchRequestModel;
    private Integer page;
    private Integer offset;
    private Integer typeId;
    private Integer orderBy;
    private Integer userId;
    private Integer cityId;


    public FilterArgumentModel() {
    }

    public FilterArgumentModel(SearchRequestModel searchRequestModel, Integer page, Integer offset, Integer typeId, Integer orderBy, Integer userId, Integer cityId) {
        this.searchRequestModel = searchRequestModel;
        this.page = page;
        this.offset = offset;
        this.typeId = typeId;
        this.orderBy = orderBy;
        this.userId = userId;
        this.cityId = cityId;
    }

    public Integer getCityId() {
        return cityId;
    }

    public void setCityId(Integer cityId) {
        this.cityId = cityId;
    }

    public SearchRequestModel getSearchRequestModel() {
        return searchRequestModel;
    }

    public void setSearchRequestModel(SearchRequestModel searchRequestModel) {
        this.searchRequestModel = searchRequestModel;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getOffset() {
        return offset;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public Integer getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(Integer orderBy) {
        this.orderBy = orderBy;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}
