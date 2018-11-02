//
//  RoomPostResponseModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/17/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import ObjectMapper
class RoomPostResponseModel:BasePostResponseModel {
    var name:String?
    var  area: Int?
    var address: String?
    var utilities: [UtilityModel]!
    var imageUrls: [String]?
    var numberPartner, genderPartner: Int?
    var postDesription: String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        area <- map["area"]
        address <- map["address"]
        utilities <- map["utilities"]
        imageUrls <- (map["imageUrls"])
        numberPartner <- map["numberPartner"]
        genderPartner <- map["genderPartner"]
        postDesription <- map["description"]
    }
}
