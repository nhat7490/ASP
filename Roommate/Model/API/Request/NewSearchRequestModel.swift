
//
//  SearchRequestModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/15/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//
import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm
class NewSearchRequestModel: BaseModel {
    //default send nil for backend
    var utilities = List<IntObject>()
    var districts = List<IntObject>()
    var price = List<IntObject>()
    var gender = RealmOptional<Int>()
    var userId = RealmOptional<Int>()
    
    //MARK: Objectmapper
    required init?(map: Map) {
        super.init()
    }
    
    override func mapping(map: Map) {
        print("Call mapping(map: Map) for SearchRequestModel")
        utilities <- (map["utilities"],CustomListTransform<IntObject>())
        districts <- map["districts"]
        price <- map["price"]
        gender.value <- map["gender"]
        userId.value <- map["userId"]
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
    
    //MARK: Copy
    override func copy(with zone: NSZone? = nil) -> Any {
        let base = BaseModel()
        return base
    }
    
    
}
class IntObject:Object,Mappable{
    
    var value:Int = 0
    init(value: Int) {
        super.init()
        self.value = value
    }
    required init?(map: Map) {
        super.init()
    }

    func mapping(map: Map) {

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
