//
//  DistrictModel.swift
//  Roommate
//
//  Created by TrinhHC on 9/30/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import ObjectMapper
class DistrictModel :Mappable{
    
    var district_id:Int?
    var name:String?
    var city_id:Int?

     init(){
        self.district_id = 0
        self.name = ""
        self.city_id = 0
    }
    
    public init(district_id: Int, name: String, city_id: Int) {
        self.district_id = district_id
        self.name = name
        self.city_id = city_id
    }
    required init?(map: Map) {
        mapping(map: map)
    }

    func mapping(map: Map) {
        district_id <- map["district_id"]
        name <- map["name"]
        city_id <- map["city_id"]
    }
    
}
