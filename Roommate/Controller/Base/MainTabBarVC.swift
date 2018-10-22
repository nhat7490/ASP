//
//  MainTabBarVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class MainTabBarVC: BaseTabBarVC,UITabBarControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        checkInitData()
    }
    func setupUI() {
        self.tabBar.backgroundColor = .white
        let all = AllVC()
        let bookmark = AllVC()
        bookmark.allVCType = .bookmark
        var vcs = [UIViewController]()
                vcs.append(CERoomVC())
        vcs.append(all)
        vcs.append(bookmark)
        vcs.append(NotificationVC())
        //        vcs.append(Utilities.vcFromStoryBoard(vcName: Constants.VC_SIGN_IN, sbName: Constants.STORYBOARD_MAIN))
        //        vcs.append(Utilities.vcFromStoryBoard(vcName: Constants.VC_SIGN_UP, sbName: Constants.STORYBOARD_MAIN))
        //        vcs.append(Utilities.vcFromStoryBoard(vcName: Constants.VC_RESET_PASSWORD, sbName: Constants.STORYBOARD_MAIN))
        //        vcs.append(Utilities.vcFromStoryBoard(vcName: Constants.VC_SIGN_UP, sbName: Constants.STORYBOARD_MAIN))
        
        viewControllers = vcs.map({UINavigationController(rootViewController: $0)})
        self.selectedIndex = 1
    }
    

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        view.layoutIfNeeded()
        return true
    }
    
}
//
