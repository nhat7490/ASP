//
//  UserModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/8/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm
class UserModel:BaseModel{
    
    
    
    @objc dynamic var userId = 0
    @objc dynamic var username:String?
    @objc dynamic var password:String?
    @objc dynamic var email:String?
    @objc dynamic var fullname:String?
    @objc dynamic var imageProfile:String?
    @objc dynamic var dob:Date?
    @objc dynamic var phone:String?
    @objc dynamic var gender = 1
    @objc dynamic var roleId = 4
    
    //MARK: ObjectMapper
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map){
        super.mapping(map: map)
        userId <- map["userId"]
        username <- map["username"]
        password <- map["password"]
        email <- map["email"]
        fullname <- map["fullname"]
        imageProfile <- map["imageProfile"]
        dob <- (map["dob"],CustomDateFormatTransform(formatString: "yyyy-MM-dd"))
        phone <- map["phone"]
        gender <- map["gender"]
        roleId <- map["roleId"]

    }

    override class func primaryKey() -> String? {
        return "userId"
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
    

}
