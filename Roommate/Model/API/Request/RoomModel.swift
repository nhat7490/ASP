//
//  Room.swift
//  Roommate
//
//  Created by TrinhHC on 9/24/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
class RoomModel{
    var roomId:Int = 0
    var name:String
    var price:Float
    var area:Int
    var address:String
    var maxGuest:Int
    var date:Date
    var currentMember:Int
    var description:String?
    var status:StatusModel
    var city:CityModel
    var district:DistrictModel
    var image:[ImageModel]
    var utilities:[UtilityModel]
    var users:[User]?
    var requiredGender:Int
    
    public init(roomId: Int = 0, name: String, price: Float, area: Int, address: String, maxGuest: Int, date_create: Date, current_member: Int, description: String?, status: StatusModel, city: CityModel, district: DistrictModel, image: [ImageModel], utilities: [UtilityModel], users: [User]?, requiredGender: Int) {
        self.roomId = roomId
        self.name = name
        self.price = price
        self.area = area
        self.address = address
        self.maxGuest = maxGuest
        self.date = date_create
        self.currentMember = current_member
        self.description = description
        self.status = status
        self.city = city
        self.district = district
        self.image = image
        self.utilities = utilities
        self.users = users
        self.requiredGender = requiredGender
    }
}

