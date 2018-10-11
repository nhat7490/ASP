//
//  UserModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/8/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class UserModel:BaseResponseModel  {

    @objc dynamic var userId = 0
    @objc dynamic var username:String!
    @objc dynamic var password:String!
    @objc dynamic var email:String?
    @objc dynamic var fullname:String?
    @objc dynamic var imageProfile:String?
    @objc dynamic var dob:Date?
    @objc dynamic var phone:String?
    @objc dynamic var gender = 0
    @objc dynamic var roleId = 0

    
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
        dob <- (map["dob"],CustomDateFormatTransform(formatString: ""))
        phone <- map["phone"]
        gender <- map["gender"]
        roleId <- map["roleId"]
        
    }

    override class func primaryKey() -> String? {
        return "userId"
    }
}
