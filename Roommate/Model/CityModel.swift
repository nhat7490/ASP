//
//  CityModel.swift
//  Roommate
//
//  Created by TrinhHC on 9/30/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class CityModel :BaseModel{
    var city_id:Int
    var name:String

    public init(id: Int, name: String) {
        self.city_id = id
        self.name = name
    }
}
