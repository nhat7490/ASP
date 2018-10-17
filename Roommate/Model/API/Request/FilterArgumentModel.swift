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
class FilterArgumentModel : BaseModel{
    @objc dynamic var searchRequestModel:SearchRequestModel?
    let page = RealmOptional<Int>()
    let offset = RealmOptional<Int>()
    
    //MARK: Objectmapper
    required init?(map: Map) {
        super.init()
    }
    
    override func mapping(map: Map) {
        print("Call mapping(map: Map) for SearchRequestModel")
        searchRequestModel <- map["searchRequestModel"]
        page.value <- map["page"]
        offset.value <- map["offset"]
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
