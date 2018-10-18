package com.caps.asp.model.uimodel.request;

public class FilterArgumentModel {
    private SearchRequestModel searchRequestModel;
    private Integer page;
    private Integer offset;
    private Integer typeId;
    private String orderBy;

    public FilterArgumentModel() {
    }

    public FilterArgumentModel(SearchRequestModel searchRequestModel, Integer page, Integer offset, Integer typeId, String orderBy) {
        this.searchRequestModel = searchRequestModel;
        this.page = page;
        this.offset = offset;
        this.typeId = typeId;
        this.orderBy = orderBy;
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

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }
}
