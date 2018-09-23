//
//  Utilities.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class Utilities{
    static func vcFromStoryBoard(vcName:String,sbName:String) -> UIViewController {
        return UIStoryboard(name: sbName, bundle: nil).instantiateViewController(withIdentifier: vcName)
    }
    static func embedVCInNavigationVC(vc:UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: vc)
    }
}
