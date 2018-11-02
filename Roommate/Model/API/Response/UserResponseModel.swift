//
//  UserResponeModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/17/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//
import Foundation
import ObjectMapper
class UserResponseModel: Mappable {
    var userId: Int?
    var fullname: String?
    var imageProfile: String!
    var dob, phone: String?
    var gender: Int?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        gender <- map["gender"]
        fullname <- map["fullname"]
        imageProfile <- map["imageProfile"]
        dob <- map["dob"]
        phone <- map["phone"]
    }
}
