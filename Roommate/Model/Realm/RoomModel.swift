//
//  RoomModel.swift
//  Roommate
//
//  Created by TrinhHC on 11/13/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm
import Realm
class RoomModel:BaseModel{
    @objc dynamic var roomId:Int = 0
    @objc dynamic var name:String = ""
    @objc dynamic var price:Int = 0
    @objc dynamic var area:Int = 0
    @objc dynamic var address:String = ""
    @objc dynamic var maxGuest:Int = 0
    @objc dynamic var currentMember:Int = 0
    @objc dynamic var userId:Int = 0
    @objc dynamic var cityId:Int = 0
    @objc dynamic var districtId:Int = 0
    @objc dynamic var date:Date?
    @objc dynamic var statusId:Int = 0
    @objc dynamic var roomDescription:String?
    @objc dynamic var phoneNumber:String = ""
    let utilities = List<UtilityModel>()
    let imageUrls = List<StringObject>()
    let members = List<MemberModel>()
    @objc dynamic var longitude:Double = 0.0
    @objc dynamic var latitude:Double = 0.0
    
    public convenience init(roomResponseModel:RoomResponseModel) {
        self.init()
        self.roomId = roomResponseModel.roomId
        self.name = roomResponseModel.name
        self.price = roomResponseModel.price
        self.area = roomResponseModel.area
        self.address = roomResponseModel.address
        self.maxGuest = roomResponseModel.maxGuest
        self.currentMember = roomResponseModel.currentMember
        self.userId = roomResponseModel.userId
        self.cityId = roomResponseModel.cityId
        self.districtId = roomResponseModel.districtId
        self.date = roomResponseModel.date
        self.statusId = roomResponseModel.statusId
        self.roomDescription = roomResponseModel.roomDescription
        self.phoneNumber = roomResponseModel.phoneNumber
        for model in roomResponseModel.utilities {
            self.utilities.append(model)
        }
        for util in roomResponseModel.utilities {
            self.utilities.append(util)
        }
        for url in roomResponseModel.imageUrls {
            self.imageUrls.append(StringObject(value:url))
        }
        for member in roomResponseModel.members ?? [] {
            MemberModel(userId: member.userId, roleId: member.roleId, username: member.username)
        }
        self.longitude = roomResponseModel.longitude
        self.latitude = roomResponseModel.latitude
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
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
class StringObject:Object{
    @objc dynamic var value:String = ""
    
    public convenience init(value:String){
        self.init()
        self.value = value
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
