//
//  RoomResponseModel.swift
//  Roommate
//
//  Created by TrinhHC on 11/1/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import ObjectMapper
class RoomResponseModel: Mappable {
    var roomId:Int!
    var name:String!
    var price:Int!
    var area:Int!
    var address:String!
    var maxGuest:Int!
    var currentMember:Int!
    var userId:Int!
    var cityId:Int!
    var districtId:Int!
    var date:Date!
    var statusId:Int!
    var description:String?
    var utilities:[UtilityModel]!
    var imageUrls:[String]!
    var members:[MemberResponseModel]?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        roomId <- map["roomId"]
        name <- map["name"]
        price <- map["price"]
        area <- map["area"]
        address <- map["address"]
        maxGuest <- map["maxGuest"]
        currentMember <- map["currentMember"]
        userId <- map["userId"]
        cityId <- map["cityId"]
        districtId <- map["districtId"]
        statusId <- map["statusId"]
        description <- map["description"]
        utilities <- map["utilities"]
        imageUrls <- map["imageUrls"]
        members <- map["members"]
    }
    
}
