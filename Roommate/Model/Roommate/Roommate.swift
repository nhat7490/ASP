//
//  RoommateModel.swift
//  Roommate
//
//  Created by TrinhHC on 9/22/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
class Roommate{
    var id:Int?
    var user:User
    var minPrice:Int
    var maxPrice:Int
    var location:[String]
    var city:String
    var isBookMark:Bool
    convenience init(user:User,minPrice:Int,maxPrice:Int,location:[String],city:String,isBookMark:Bool) {
        self.init(id: nil, user: user, minPrice: minPrice, maxPrice: maxPrice, location: location, city: city,isBookmark:isBookMark)
    }
    
    init(id:Int?,user:User,minPrice:Int,maxPrice:Int,location:[String],city:String,isBookmark:Bool) {
        self.id = id
        self.user = user
        self.minPrice = minPrice
        self.maxPrice = maxPrice
        self.location = location
        self.city = city
        self.isBookMark = isBookmark
    }
}
