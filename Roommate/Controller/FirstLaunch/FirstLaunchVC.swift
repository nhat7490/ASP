//
//  FirstLaunchVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import Foundation
class FirstLaunchVC:BaseVC{
    @IBOutlet weak var btnSignIn: RoundButton!
    @IBOutlet weak var btnSignUpAsRoomOwner: RoundButton!
    @IBOutlet weak var btnSignUpAsGuest: RoundButton!
    @IBOutlet weak var imgvIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgvIcon.layer.cornerRadius = 15
        imgvIcon.clipsToBounds = true
        btnSignUpAsGuest.setTitle("SIGN_UP_AS_MEMBER_TITLE".localized, for: .normal)
        btnSignUpAsRoomOwner.setTitle("SIGN_UP_AS_ROOMOWNER_TITLE".localized, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backItem?.title = "BACK".localized
        navigationController?.setNavigationBarHidden(true, animated: true)
        edgesForExtendedLayout = .all
        automaticallyAdjustsScrollViewInsets = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func onClickBtnSignUpAsRoomOwner(_ sender: Any) {
        let vc = Utilities.vcFromStoryBoard(vcName: Constants.VC_SIGN_UP, sbName: Constants.STORYBOARD_MAIN) as! SignUpVC
        vc.user.roleId = Constants.MEMBER
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onClickBtnSignIn(_ sender: Any) {

        let vc = Utilities.vcFromStoryBoard(vcName: Constants.VC_SIGN_IN, sbName: Constants.STORYBOARD_MAIN)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickBtnSignUpAsGuest(_ sender: Any) {
        let vc = Utilities.vcFromStoryBoard(vcName: Constants.VC_SIGN_UP, sbName: Constants.STORYBOARD_MAIN) as! SignUpVC
        vc.user.roleId = Constants.ROOMOWNER
        navigationController?.pushViewController(vc, animated: true)
    }
}
