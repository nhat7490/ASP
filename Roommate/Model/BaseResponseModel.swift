//
//  BaseResponseModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/10/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
class BaseResponseModel:Object ,Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
//        map[""]
    }
}
