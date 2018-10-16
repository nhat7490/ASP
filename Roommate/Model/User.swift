//
//  User.swift
//  Roommate
//
//  Created by TrinhHC on 9/22/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class User{
    var id:Int?
    var name:String
    var imageUrl:String
    var image:UIImage? = UIImage(named: "room")
    var roleInRom:Int

    public init(id: Int?, name: String, imageUrl: String, image: UIImage? = UIImage(named: "room"), roleInRom: Int) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.image = image
        self.roleInRom = roleInRom
    }
}
