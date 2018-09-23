//
//  RoommateModel.swift
//  Roommate
//
//  Created by TrinhHC on 9/22/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
class RoommateModel{
    var id:Int?
    var user:User
    var minPrice:Int
    var maxPrice:Int
    var location:[String]
    var city:String
    
    convenience init(user:User,minPrice:Int,maxPrice:Int,location:[String],city:String) {
        self.init(id: nil, user: user, minPrice: minPrice, maxPrice: maxPrice, location: location, city: city)
    }
    
    init(id:Int?,user:User,minPrice:Int,maxPrice:Int,location:[String],city:String) {
        self.id = id
        self.user = user
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.location = location
        self.city = city
    }
}
