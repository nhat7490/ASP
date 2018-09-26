//
//  ViewController.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class MainViewVC: BaseVC {
    private lazy var mainTabBarVC:MainTabBarVC =  {
        let vc = MainTabBarVC()
        return vc
    }()
    private lazy var signInVC:SignInVC =  {
        let vc = Utilities.vcFromStoryBoard(vcName: Constants.VC_SIGN_IN, sbName: Constants.STORYBOARD_MAIN) as! SignInVC
        return vc
    }()
    private lazy var roomDetailVC:RoomDetailForOwnerVC = {
        let vc = RoomDetailForOwnerVC()
        return vc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Check Login
        if true{
            // self.add(UINavigationController(rootViewController:roomDetailVC))
            self.add(mainTabBarVC)
        }else{
            self.add(signInVC)
        }
    }


}

