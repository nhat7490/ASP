//
//  FilterForRoomModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/3/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class FilterForRoomModel {
    var city:CityModel
    var district:DistrictModel
    var min_price:Float
    var max_price:Float
    var min_area:Int
    var max_area:Int
    var max_guest:Int
    var requiredGender:Int//1 male 2 female 3 both
    var utilities:[UtilityModel]
    var orderBy:OrderType

    public init(city: CityModel, district: DistrictModel, min_price: Float, max_price: Float, min_area: Int, max_area: Int, max_guest: Int, requiredGender: Int, utilities: [UtilityModel], orderBy: OrderType) {
        self.city = city
        self.district = district
        self.min_price = min_price
        self.max_price = max_price
        self.min_area = min_area
        self.max_area = max_area
        self.max_guest = max_guest
        self.requiredGender = requiredGender
        self.utilities = utilities
        self.orderBy = orderBy
    }
    

}
