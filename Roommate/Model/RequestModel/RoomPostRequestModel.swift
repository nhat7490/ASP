//
//  File.swift
//  Roommate
//
//  Created by TrinhHC on 10/5/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
class RoomPostRequestModel:BasePost{
    
    //Just for room member
    var roomId:Int
    var name:String?
    var area:Int?
    var address:String
    var numberPatner:Int
    var utilities:[UtilityModel]
    var description:String

    public init(post_id: Int?, phoneContact: String, genderPatner: Int, typeId: Int, userId: Int, cityId: Int,roomId: Int, name: String?, area: Int?, address: String, numberPatner: Int, utilities: [UtilityModel], description: String) {
        self.roomId = roomId
        self.name = name
        self.area = area
        self.address = address
        self.numberPatner = numberPatner
        self.utilities = utilities
        self.description = description
        super.init(post_id: post_id, phoneContact: phoneContact, genderPatner: genderPatner, typeId: typeId, userId: userId, cityId: cityId)
    }
   

}
