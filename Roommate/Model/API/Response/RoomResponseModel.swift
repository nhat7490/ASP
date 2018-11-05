//
//  RoomResponseModel.swift
//  Roommate
//
//  Created by TrinhHC on 11/1/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import ObjectMapper
class RoomResponseModel: Mappable,NSCopying {
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
    var phoneNumber:String!
    var utilities:[UtilityModel]!
    var imageUrls:[String]!
    var members:[MemberResponseModel]?

    public init(roomId: Int!, name: String!, price: Int!, area: Int!, address: String!, maxGuest: Int!, currentMember: Int!, userId: Int!, cityId: Int!, districtId: Int!, date: Date!, statusId: Int!, description: String?, phoneNumber: String!, utilities: [UtilityModel]!, imageUrls: [String]!, members: [MemberResponseModel]?) {
        self.roomId = roomId
        self.name = name
        self.price = price
        self.area = area
        self.address = address
        self.maxGuest = maxGuest
        self.currentMember = currentMember
        self.userId = userId
        self.cityId = cityId
        self.districtId = districtId
        self.date = date
        self.statusId = statusId
        self.description = description
        self.phoneNumber = phoneNumber
        self.utilities = utilities
        self.imageUrls = imageUrls
        self.members = members
    }


    
    
    init() {
        
    }
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
        phoneNumber <- map["phoneNumber"]
        utilities <- map["utilities"]
        imageUrls <- map["imageUrls"]
        members <- map["members"]
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let room = RoomResponseModel(roomId: self.roomId, name: self.name, price: self.price, area: self.area, address: self.address, maxGuest: self.maxGuest, currentMember: self.currentMember, userId: self.userId, cityId: self.cityId, districtId: self.districtId, date: self.date, statusId: self.statusId, description: self.description,phoneNumber:self.phoneNumber, utilities: self.utilities.copiedElements(), imageUrls: self.imageUrls.copiedElements(), members: self.members?.copiedElements())
        return room
    }
    
    
}
