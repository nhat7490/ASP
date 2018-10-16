//
//  UtilityModel.swift
//  Roommate
//
//  Created by TrinhHC on 9/30/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//
import Foundation
import ObjectMapper
import RealmSwift
import Realm
import ObjectMapper_Realm
class UtilityModel:BaseModel {
    let utilityId = RealmOptional<Int>()
    @objc dynamic var name:String?
    @objc dynamic var quantity = 1
    @objc dynamic var brand = ""
    @objc dynamic var utilityDescription = ""

    public init(utilityId: Int, name: String, quantity: Int, brand: String, utilityDescription: String) {
        self.utilityId.value = utilityId
        self.name = name
        self.quantity = quantity
        self.brand = brand
        self.utilityDescription = utilityDescription
        super.init()
    }
    override func copy(with zone: NSZone?) -> Any {
        let utilityModel = UtilityModel(utilityId: utilityId.value!, name: name!, quantity: quantity, brand: brand, utilityDescription: utilityDescription)
        return utilityModel
    }
    
    required convenience init?(map: Map) {
        self.init()
        print("Call init?(map: Map) for utility")
    }
    
    override func mapping(map: Map) {
        print("Call mapping(map: Map) for utility")
        utilityId.value <- map["utilityId"]
        name <- map["name"]
        quantity <- map["quantity"]
        brand <- map["brand"]
        utilityDescription <- map["description"]
    }
    
    override class func primaryKey() -> String? {
        print("Call primaryKey() for utility")
        return "utilityId"
    }
    
    required init() {
        super.init()
        print("Call init() for utility")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
        print("Call init(realm: RLMRealm, schema: RLMObjectSchema) for utility")
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
        print("Call init(value: Any, schema: RLMSchema) for utility")
    }
}
