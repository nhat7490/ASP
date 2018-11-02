//
//  FilterArgumentModel.swift
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
class NewFilterArgumentModel : BaseModel{
    @objc dynamic var searchRequestModel : NewSearchRequestModel? = NewSearchRequestModel()
    let page = RealmOptional<Int>()
    let offset = RealmOptional<Int>()
    let typeId = RealmOptional<Int>()
    let orderBy = RealmOptional<Int>()
    let userId = RealmOptional<Int>()
    let cityId = RealmOptional<Int>()
    //MARK: Objectmapper
    required init?(map: Map) {
        super.init()
    }
    
    override func mapping(map: Map) {
        print("Call mapping(map: Map) for SearchRequestModel")
        searchRequestModel <- map["searchRequestModel"]
        page.value <- map["page"]
        offset.value <- map["offset"]
        typeId.value <- map["typeId"]
        orderBy.value <- map["orderBy"]
        userId.value <- map["userId"]
        cityId.value <- map["cityId"]
    }
    //MARK: Object
    required init() {
        super.init()
        page.value = 1
        offset.value = Constants.MAX_OFFSET
        typeId.value = 1
        orderBy.value = 1
        userId.value  = 0
        cityId.value = 0
//        userId.value = DBManager.shared.getUser()?.userId
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
