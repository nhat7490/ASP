//
//  FilterArgumentModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/15/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import ObjectMapper

class FilterArgumentModel : Mappable{
    var searchRequestModel:SearchRequestModel?
    var page:Int?
    var offset:Int?
    var typeId:Int?
    var orderBy:Int?
    var userId:Int?
    var cityId:Int?
    //MARK: Objectmapper
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        print("Call mapping(map: Map) for SearchRequestModel")
        searchRequestModel <- map["searchRequestModel"]
        page <- map["page"]
        offset <- map["offset"]
        typeId <- map["typeId"]
        orderBy <- map["orderBy"]
        userId <- map["userId"]
        cityId <- map["cityId"]
    }
    init() {
        page = 1
        offset = Constants.MAX_OFFSET
        typeId = 1
        orderBy = 1
        userId = DBManager.shared.getUser()?.userId
    }
}
