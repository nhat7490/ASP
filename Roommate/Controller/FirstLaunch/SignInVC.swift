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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        
        //scrollviewkeyboard
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    @objc func onBtnSignInClick(sender:UIButton) {
        print("Btn Sign in Click")
    }
    
    @objc func Keyboard(notification: Notification){
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame =  (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame,from: view.window)
        if notification.name == Notification.Name.UIKeyboardWillHide{
            scrollView.contentInset = UIEdgeInsets.zero
        }else{
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }

    
}
