package com.caps.asp.model.uimodel.request;

public class FilterArgumentModel {
    private SearchRequestModel searchRequestModel;
    private Integer page;
    private Integer offset;

    public FilterArgumentModel() {
    }

    public FilterArgumentModel(SearchRequestModel searchRequestModel, Integer page, Integer offset) {
        this.searchRequestModel = searchRequestModel;
        this.page = page;
        this.offset = offset;
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
}
