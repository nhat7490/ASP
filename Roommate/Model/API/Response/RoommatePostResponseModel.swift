//
//  RoommatePostResponseModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/21/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm
class RoommatePostResponseModel:Mappable {
    var postId: Int?
    var name:String?
    var phoneContact:String!
    var date: Date?
    var userResponseModel: UserResponseModel!
    var minPrice: Double!
    var favourite: Bool!
    var utilityIds:[Int]!
    var maxPrice:Double!
    var districtIds:[Int]!
    var cityId:Int!
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
        favourite <- map["favourite"]
        utilityIds <- map["utilityIds"]
        maxPrice <- map["maxPrice"]
        districtIds <- map["districtIds"]
        cityId <- map["cityId"]
    }
    
}
