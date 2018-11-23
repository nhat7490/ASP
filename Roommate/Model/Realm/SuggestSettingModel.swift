//
//  SuggestSettingModel.swift
//  Roommate
//
//  Created by TrinhHC on 11/22/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
import RealmSwift
import Realm
import ObjectMapper_Realm
class SuggestSettingModel: BaseModel {
    @objc dynamic var userId = 0
    @objc dynamic var roleId = 0
    @objc dynamic var username = ""
    //default send nil for backend
    var utilities:[Int]?
    var districts:[Int]?
    var price:[Float]?
    var gender:Int?
//    var userId:Int?
    
    public convenience init(userId: Int?, roleId: Int?, username: String!) {
        self.init()
        self.userId = userId!
        self.roleId = roleId!
        self.username = username
    }
    
   
    //MARK: Objectmapper
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        utilities <- map["utilities"]
        districts <- map["districts"]
        price <- map["price"]
        gender <- map["gender"]
        userId <- map["userId"]
    }
    
    //MARK: Object
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    override class func primaryKey() -> String? {
        return "userId"
    }
}
