//
//  BaseModel.swift
//  Roommate
//
//  Created by TrinhHC on 10/3/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class BaseModel:NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        let base = BaseModel()
        return base
    }
    
}
