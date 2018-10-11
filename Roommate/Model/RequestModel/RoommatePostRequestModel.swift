//
//  RoommatePostRequestModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/5/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
class RooommatePostRequestModel:BasePost{
    //Just for roommate post
    var districtIds:[Int]
    var lowPrice:Int
    var highPrice:Int
    var utilityIds:[Int]
    
    public init(post_id: Int?, phoneContact: String, genderPatner: Int, typeId: Int, userId: Int, cityId: Int,districtIds: [Int], lowPrice: Int, highPrice: Int, utilityIds: [Int]) {
        self.districtIds = districtIds
        self.lowPrice = lowPrice
        self.highPrice = highPrice
        self.utilityIds = utilityIds
        super.init(post_id: post_id, phoneContact: phoneContact, genderPatner: genderPatner, typeId: typeId, userId: userId, cityId: cityId)
    }
}

