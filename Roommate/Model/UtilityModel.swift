//
//  UtilityModel.swift
//  Roommate
//
//  Created by TrinhHC on 9/30/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import ObjectMapper
class UtilityModel:BaseModel,Mappable {
    var utilityId:Int?
    var name:String?
    var quantity:Int?
    var brand:String?
    var description:String?

    public init(utility_id: Int, name: String, quantity: Int, brand: String, description: String) {
        self.utilityId = utility_id
        self.name = name
        self.quantity = quantity
        self.brand = brand
        self.description = description
    }
    override func copy(with zone: NSZone?) -> Any {
        let utilityModel = UtilityModel(utility_id: utilityId!, name: name!, quantity: quantity!, brand: brand!, description: description!)
        return utilityModel
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        utilityId <- map["utilityId"]
        name <- map["name"]
        quantity <- map["quantity"]
        brand <- map["brand"]
        description <- map["description"]
    }
}
