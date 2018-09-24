//
//  SignInVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
//This class for sign up
class SignInVC: UIViewController {
    var btnSignIn:UIButton={
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("SIGNIN_TITLE".localized, for: .normal)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add btn to main view
        tabBarItem = UITabBarItem(title: "Sign In", image: UIImage(named: "icons8-home-page-51")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icons8-home-page-50"))
        view.addSubview(btnSignIn)
        
        //config postion
        //x, y, width, height
        btnSignIn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        btnSignIn.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        btnSignIn.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
        btnSignIn.heightAnchor.constraint(equalToConstant: 50)
        btnSignIn.addTarget(self, action: #selector(onBtnSignInClick(sender:)), for:.touchUpInside)
        
    }
    @objc func onBtnSignInClick(sender:UIButton) {
        print("Btn Sign in Click")
    }
    

    
}
