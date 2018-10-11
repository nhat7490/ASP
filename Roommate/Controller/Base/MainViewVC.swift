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
//    private lazy var signInVC:SignInVC =  {
//        let vc = Utilities.vcFromStoryBoard(vcName: Constants.VC_SIGN_IN, sbName: Constants.STORYBOARD_MAIN) as! SignInVC
//        return vc
//    }()
    private lazy var roomDetailVC:RoomDetailVC = {
        let vc = RoomDetailVC()
        return vc
    }()
    
    private lazy var ceRoomVC:CERoomVC = {
        let vc = CERoomVC()
        vc.modalPresentationStyle = .popover
        return vc
    }()
    
    private lazy var firstLanchVC:FirstLaunchVC = {
       let vc = Utilities.vcFromStoryBoard(vcName: Constants.VC_FIRST_LAUNCH, sbName: Constants.STORYBOARD_MAIN) as! FirstLaunchVC
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.add(UINavigationController(rootViewController:CERoomVC()))
//        self.present(ceRoomVC, animated: true, completion: nil)
        //Check Login
//        if let user = DBManager.shared.getUser(){
////            let filter = FilterVC()
////            filter.filterVCType = .roommate
////             self.add(UINavigationController(rootViewController:firstLanchVC))
////            self.add(UINavigationController(rootViewController:roomDetailVC))
//
////            self.add(UINavigationController(rootViewController: signInVC))
//            self.add(mainTabBarVC)
//        }else{
//            self.add(UINavigationController(rootViewController: firstLanchVC))
//        }
    }


}

