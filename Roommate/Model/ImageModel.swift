//
//  ImageModel.swift
//  Roommate
//
//  Created by TrinhHC on 9/30/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class ImageModel {
    var image_id:Int
    var link_url:String

    public init(id: Int, link_url: String) {
        self.image_id = id
        self.link_url = link_url
    }
    
}
