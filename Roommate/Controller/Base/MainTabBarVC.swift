//
//  MainTabBarVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController,UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }
    
    func setupUI() {
        var vcs = [UIViewController]()
        vcs.append(NotificationVC())
        vcs.append(BookmarkVC())
//        vcs.append(Utilities.vcFromStoryBoard(vcName: Constants.VC_SIGN_UP, sbName: Constants.STORYBOARD_MAIN))
        
        viewControllers = vcs.map({UINavigationController(rootViewController: $0)})
        self.selectedIndex = 1
//    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor(hexString: "555")], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor(hexString: "00A8B5")], for: .selected)
//        UITabBarItem.appearance().set
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.backgroundColor : UIColor(hexString: "00A8B5")], for: .selected)
    }
    

}
