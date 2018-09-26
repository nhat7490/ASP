//
//  ForgotPasswordVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class ResetPasswordVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add btn to main view
        tabBarItem = UITabBarItem(title: "Reset Password", image: UIImage(named: "icons8-home-page-51")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icons8-home-page-50"))
    }
    
}
