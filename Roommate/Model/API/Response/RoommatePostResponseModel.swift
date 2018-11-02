//
//  RoommatePostResponseModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/21/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import ObjectMapper
class RoommatePostResponseModel:BasePostResponseModel {
    var utilityIds:[Int]!
    var maxPrice:Int!
    var districtIds:[Int]!
    var cityId:Int!
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        utilityIds <- map["utilityIds"]
        maxPrice <- map["maxPrice"]
        districtIds <- map["districtIds"]
        cityId <- map["cityId"]
    }
    
}
