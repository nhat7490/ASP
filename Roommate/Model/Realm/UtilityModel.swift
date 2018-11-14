
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
    @objc dynamic var utilityId = 0
    @objc dynamic var name = ""
    @objc dynamic var quantity = 1
    @objc dynamic var brand = ""
    @objc dynamic var utilityDescription = ""
    override var hashValue: Int{
        return self.utilityId.hashValue
    }
    init(utilityId: Int){
        self.utilityId = utilityId
        super.init()
    }
    public init(utilityId: Int, name: String, quantity: Int, brand: String, utilityDescription: String) {
        self.utilityId = utilityId
        self.name = name
        self.quantity = quantity
        self.brand = brand
        self.utilityDescription = utilityDescription
        super.init()
    }
    override func copy(with zone: NSZone?) -> Any {
        let utilityModel = UtilityModel(utilityId: utilityId, name: name, quantity: quantity, brand: brand, utilityDescription: utilityDescription)
        return utilityModel
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        utilityId <- map["utilityId"]
        name <- map["name"]
        quantity <- map["quantity"]
        brand <- map["brand"]
        utilityDescription <- map["description"]
    }
    
    override class func primaryKey() -> String? {
        return "utilityId"
    }
    
    required init() {
        super.init()
//        print("Call init() for utility")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    static func ==(lhs:UtilityModel,rhs:UtilityModel)->Bool{
        return lhs.utilityId == rhs.utilityId
    }
}
