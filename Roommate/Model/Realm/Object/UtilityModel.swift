//
// Created by TrinhHC on 11/26/18.
// Copyright (c) 2018 TrinhHC. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
class UtilityModel:Object{
    @objc dynamic var utilityId = 0
    @objc dynamic var name = ""
//    @objc dynamic var quantity = 1
//    @objc dynamic var brand = ""
//    @objc dynamic var utilityDescription = ""
    init(utilityMappableModel:UtilityMappableModel){
        super.init()
        self.utilityId = utilityMappableModel.utilityId
        self.name = utilityMappableModel.name
//        self.quantity = utilityMappableModel.quantity
//        self.brand = utilityMappableModel.brand
//        self.utilityDescription = utilityMappableModel.utilityDescription
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
}
