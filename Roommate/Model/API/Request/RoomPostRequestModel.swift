//
//  File.swift
//  Roommate
//
//  Created by TrinhHC on 10/5/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import ObjectMapper
class RoomPostRequestModel: BasePostResquestModel {
//    
//    //Just for room member
    var roomId:Int!
    var name:String!
    var numberPartner:Int = 1
    var genderPartner:Int = 0
    var roomDescription:String?
    
    override init() {
        super.init()
    }
    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)
        roomId <- map["roomId"]
        name <- map["name"]
        numberPartner <- map["numberPartner"]
        genderPartner <- map["genderPartner"]
        roomDescription <- map["description"]

    }
}
