//
//  RoomResponseModel.swift
//  Roommate
//
//  Created by TrinhHC on 11/1/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import ObjectMapper
class RoomResponseModel: Mappable,NSCopying,Equatable,Hashable {
    var roomId:Int = 0
    var name:String = ""
    var price:Int = 0
    var area:Int = 0
    var address:String = ""
    var maxGuest:Int = 0
    var currentMember:Int = 0
    var userId:Int = 0
    var cityId:Int = 0
    var districtId:Int = 0
    var date:Date?
    var statusId:Int = 0
    var roomDescription:String?
    var phoneNumber:String = ""
    var utilities:[UtilityModel]  = []
    var imageUrls:[String] = []
    var members:[MemberResponseModel]?
    var longitude:Double = 0.0
    var latitude:Double = 0.0

    public init(roomId: Int = 0, name: String = "", price: Int = 0, area: Int = 0, address: String = "", maxGuest: Int = 0, currentMember: Int = 0, userId: Int = 0, cityId: Int = 0, districtId: Int = 0, date: Date?, statusId: Int = 0, roomDescription: String?, phoneNumber: String = "", utilities: [UtilityModel]  = [], imageUrls: [String] = [], members: [MemberResponseModel]?, longitude: Double = 0.0, latitude: Double = 0.0) {
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
        self.roomDescription = roomDescription
        self.phoneNumber = phoneNumber
        self.utilities = utilities
        self.imageUrls = imageUrls
        self.members = members
        self.longitude = longitude
        self.latitude = latitude
    }

    


    
    var hashValue: Int{
        return roomId.hashValue
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
        date <- map["dateCreated"]
        statusId <- map["statusId"]
        roomDescription <- map["description"]
        phoneNumber <- map["phoneNumber"]
        utilities <- map["utilities"]
        imageUrls <- map["imageUrls"]
        members <- map["members"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        if members == nil{
            members = []
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let room = RoomResponseModel(roomId: self.roomId, name: self.name, price: self.price, area: self.area, address: self.address, maxGuest: self.maxGuest, currentMember: self.currentMember, userId: self.userId, cityId: self.cityId, districtId: self.districtId, date: self.date, statusId: self.statusId, roomDescription: self.roomDescription,phoneNumber:self.phoneNumber, utilities: self.utilities.copiedElements(), imageUrls: self.imageUrls.copiedElements(), members: self.members?.copiedElements())
        return room
    }
    static func == (lhs: RoomResponseModel, rhs: RoomResponseModel) -> Bool {
        return lhs.roomId == rhs.roomId
    }
    
    
}
