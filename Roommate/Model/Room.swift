//
//  Room.swift
//  Roommate
//
//  Created by TrinhHC on 9/30/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
class Room:BaseModel{
    var id:Int
    var numberPerson:Int
    var name:String
    var price:Int
    var city:String
    var gender:Int
    var location:String
    var isBookMark:Bool
    var isCertificate:Bool

    public init(id: Int, numberPerson: Int, name: String, price: Int, city: String, gender: Int, location: String, isBookMark: Bool, isCertificate: Bool) {
        self.id = id
        self.numberPerson = numberPerson
        self.name = name
        self.price = price
        self.city = city
        self.gender = gender
        self.location = location
        self.isBookMark = isBookMark
        self.isCertificate = isCertificate
    }
}
