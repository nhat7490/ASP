//
//  SIgnUpVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    var btnSignUp:UIButton={
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("Sign Up", for: .normal)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add btn to main view
        tabBarItem = UITabBarItem(title: "Sign Up", image: UIImage(named: "icons8-home-page-51")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icons8-home-page-50"))
        view.addSubview(btnSignUp)
        
        //config postion
        //x, y, width, height
        btnSignUp.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        btnSignUp.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        btnSignUp.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
        btnSignUp.heightAnchor.constraint(equalToConstant: 50)
        btnSignUp.addTarget(self, action: #selector(onBtnSignUpClick(sender:)), for:.touchUpInside)
        
    }
    @objc func onBtnSignUpClick(sender:UIButton) {
        print("Btn Sign Up Click")
    }
}
