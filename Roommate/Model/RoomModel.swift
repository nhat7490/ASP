//
//  Room.swift
//  Roommate
//
//  Created by TrinhHC on 9/24/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
class RoomModel{
    var room_id:Int = 0
    var name:String
    var price:Float
    var area:Int
    var address:String
    var max_guest:Int
    var date_create:Date
    var current_member:Int
    var description:String?
    var status:StatusModel
    var city:CityModel
    var district:DistrictModel
    var image:[ImageModel]
    var utilities:[UtilityModel]

    public init(room_id: Int = 0, name: String, price: Float, area: Int, address: String, max_guest: Int, date_create: Date, current_member: Int, description: String?, status: StatusModel, city: CityModel, district: DistrictModel, image: [ImageModel], utilities: [UtilityModel]) {
        self.room_id = room_id
        self.name = name
        self.price = price
        self.area = area
        self.address = address
        self.max_guest = max_guest
        self.date_create = date_create
        self.current_member = current_member
        self.description = description
        self.status = status
        self.city = city
        self.district = district
        self.image = image
        self.utilities = utilities
    }


    
}
