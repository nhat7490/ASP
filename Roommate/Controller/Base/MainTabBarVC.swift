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
//        self.navigationController?.navigationBar.isHidden = true
        setupUI();
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        checkInitData()
        viewControllers?.forEach({ (vc) in
            if vc is UINavigationController{
                let _ = (vc as! UINavigationController).topViewController?.view
            }else{
                let _ = vc.view
            }
        })
    }
    
    func setupUI() {
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .defaultBlue
//        self.tabBar.barTintColor = .white
//        self.tabBar.unselectedItemTintColor = .black
        var vcs = [UIViewController]()
        
        let home = HomeVC()
        home.tabBarItem = UITabBarItem(title: "HOME_VC".localized , image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "home"))
        
        let all = AllVC()
        all.allVCType = .all
        all.tabBarItem = UITabBarItem(title: "ALL_VC".localized , image: UIImage(named: "all")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "all"))
        
        let bookmark = AllVC()
        bookmark.allVCType = .bookmark
        bookmark.tabBarItem = UITabBarItem(title: "BOOKMARK_VC".localized , image: UIImage(named: "bookmark-blue")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bookmark-blue"))
        
        let notification = NotificationVC()
        notification.tabBarItem = UITabBarItem(title: "NOTIFICATION_VC".localized, image: UIImage(named: "notification")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "notification"))
        
        let account = AccountVC()
        account.accountVCType =  DBManager.shared.getUser()?.roleId == Constants.ROOMOWNER ? AccountVCType.roomOwner : AccountVCType.member
        account.tabBarItem = UITabBarItem(title: "ACCOUNT_VC".localized, image: UIImage(named: "account")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "manage-account"))
        vcs.append(home)
        vcs.append(all)
        vcs.append(bookmark)
        vcs.append(notification)
        vcs.append(account)
        viewControllers = vcs.map({
//            let _ = $0.view
            if $0 is AccountVC || $0 is NotificationVC{
                return $0
            }else{
                return UINavigationController(rootViewController: $0)
            }
            
        })
        
    }
    
    override var selectedIndex: Int{
        didSet{
            
        }
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        view.layoutIfNeeded()
        return true
    }
    
}
//
