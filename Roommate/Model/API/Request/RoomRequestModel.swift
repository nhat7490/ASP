//
//  NewRoomModel.swift
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
class RoomRequestModel:BaseModel{
    @objc dynamic var roomId:Int = 0
    @objc dynamic var name:String?
    @objc dynamic var price:Double = 0.0
    @objc dynamic var area:Int = 0
    @objc dynamic var address:String?
    @objc dynamic var maxGuest = 0
    @objc dynamic var dateCreated:Date?
    @objc dynamic var currentNumber = 0
    @objc dynamic var roomDescription:String?
    @objc dynamic var status:Int = 0
    @objc dynamic var userId = 0
    @objc dynamic var cityId = 0
    @objc dynamic var districtId = 0
    @objc dynamic var longitude = 0.0
    @objc dynamic var latitude = 0.0
    var utilities = List<UtilityModel>()
    var imageUrls = [String]()
    
    //MARK: ObjectMapper
    required init?(map: Map) {
        super.init()
    }
    
    override func mapping(map: Map){
//        super.mapping(map: map)
        roomId <- map["roomId"]
        name <- map["name"]
        price <- map["price"]
        area <- map["area"]
        address <- map["address"]
        maxGuest <- map["maxGuest"]
        dateCreated <- (map["dateCreated"])
        currentNumber <- map["currentNumber"]
        roomDescription <- map["description"]
        status <- map["status"]
        userId <- map["userId"]
        cityId <- map["cityId"]
        districtId <- map["districtId"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        self.utilities <- (map["utilities"],CustomListTransform<UtilityModel>())
        imageUrls <- map["imageUrls"]
    }
//    
    override class func primaryKey() -> String? {
        return "roomId"
    }
//
//    //MARK: Object
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
