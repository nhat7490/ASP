//
//  BaseSuggestRequestModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/31/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import ObjectMapper
class BaseSuggestRequestModel: Mappable {
    var page:Int?
    var offset:Int?
    var typeId:Int?
    var userId:Int?
    var cityId:Int?
    var longitude:Double?
    var latitude:Double?
    //MARK: Objectmapper
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        offset <- map["offset"]
        typeId <- map["typeId"]
        userId <- map["userId"]
        cityId <- map["cityId"]
        userId <- map["longitude"]
        cityId <- map["latitude"]
    }
    init() {
        page = 1
        offset = Constants.MAX_OFFSET
        typeId = 1
        userId = DBManager.shared.getUser()?.userId
        cityId = DBManager.shared.getSetting()?.cityId
    }
}
