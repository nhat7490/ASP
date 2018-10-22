//
//  RoomPostResponseModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/17/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm
class RoomPostResponseModel:Mappable {
    var postId: Int?
    var name:String?
    var phoneContact:String!
    var date: Date?
    var userResponseModel: UserResponseModel?
    var minPrice, area: Int?
    var address: String?
    var utilities: [UtilityModel]!
    var imageUrls: [String]?
    var numberPartner, genderPartner: Int?
    var favourite: Bool?
    var postDesription: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        postId <- map["postId"]
        name <- map["name"]
        print("PostName:\(map["name"].currentValue)")
        phoneContact <- map["phoneContact"]
        date <- (map["date"],DateTransform())
        userResponseModel <- map["userResponeModel"]
        minPrice <- map["minPrice"]
        area <- map["area"]
        address <- map["address"]
        utilities <- map["utilities"]
        imageUrls <- (map["imageUrls"])
        numberPartner <- map["numberPartner"]
        genderPartner <- map["genderPartner"]
        favourite <- map["favourite"]
        postDesription <- map["description"]
    }
    
}
