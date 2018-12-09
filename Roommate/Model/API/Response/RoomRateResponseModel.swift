//
//  RoomRateResponseModel.swift
//  Roommate
//
//  Created by TrinhHC on 12/6/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import ObjectMapper
class RoomRateResponseModel: BaseRateResponseModel {
    var securityRate:Double?
    var locationRate:Double?
    var utilityRate:Double?
    override init() {
        super.init()
        self.securityRate = 0.0
        self.locationRate = 0.0
        self.utilityRate = 0.0
    }
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map:map)
        securityRate <- map["security"]
        locationRate <- map["location"]
        utilityRate <- map["utility"]
    }
}
