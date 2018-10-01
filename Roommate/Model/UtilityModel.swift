//
//  UtilityModel.swift
//  Roommate
//
//  Created by TrinhHC on 9/30/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class UtilityModel: NSObject {
    var utility_id:Int
    var name:String
    var quantity:Int
    var brand:String
    var value:String

    public init(utility_id: Int, name: String, quantity: Int, brand: String, value: String) {
        self.utility_id = utility_id
        self.name = name
        self.quantity = quantity
        self.brand = brand
        self.value = value
    }
}
