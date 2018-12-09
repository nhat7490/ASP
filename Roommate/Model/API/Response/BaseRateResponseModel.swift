//
//  BaseRateResponseModel.swift
//  Roommate
//
//  Created by TrinhHC on 12/6/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import ObjectMapper
class BaseRateResponseModel: Mappable {
    var username:String!
    var userId:Int!
    var imageProfile:String?
    var comment:String!
    var date:Date?
    public init(comment: String!, userId: Int!) {
        self.comment = comment
        self.userId = userId
        
    }
    
    init() {
        self.comment = ""
        self.userId = 0
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        username <- map["username"]
        userId <- map["userId"]
        imageProfile <- map["imageProfile"]
        comment <- map["comment"]
        date <- (map["date"],CustomDateFormatTransform(formatString:Constants.DATE_FORMAT))
        
    }
}
