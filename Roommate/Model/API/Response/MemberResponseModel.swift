//
//  MemberResponseModel.swift
//  Roommate
//
//  Created by TrinhHC on 11/1/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import ObjectMapper
class MemberResponseModel: Mappable {
    var userId:Int!
    var roleId:Int!
    var username:String!
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        roleId <- map["roleId"]
        username <- map["username"]
    }
    
    
}
