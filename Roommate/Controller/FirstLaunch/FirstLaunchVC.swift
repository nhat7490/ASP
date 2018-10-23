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
    @IBOutlet weak var btnSignUp: RoundButton!
    @IBOutlet weak var imgvIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgvIcon.layer.cornerRadius = 15
        imgvIcon.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        edgesForExtendedLayout = .all
        automaticallyAdjustsScrollViewInsets = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func onClickBtnSignUp(_ sender: Any) {
    }
    @IBAction func onClickBtnSignIn(_ sender: Any) {
        let vc = Utilities.vcFromStoryBoard(vcName: Constants.VC_SIGN_IN, sbName: Constants.STORYBOARD_MAIN)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}