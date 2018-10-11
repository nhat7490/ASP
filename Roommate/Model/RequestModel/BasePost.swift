//
// Created by TrinhHC on 10/5/18.
// Copyright (c) 2018 TrinhHC. All rights reserved.
//

import Foundation
class BasePost {
    //common
    var post_id: Int?
    var phoneContact: String
    var genderPatner: Int
    var typeId: Int
    var userId: Int
    var cityId: Int

    public init(post_id: Int?, phoneContact: String, genderPatner: Int, typeId: Int, userId: Int, cityId: Int) {
        self.post_id = post_id
        self.phoneContact = phoneContact
        self.genderPatner = genderPatner
        self.typeId = typeId
        self.userId = userId
        self.cityId = cityId
    }
}
