//
//  SIgnUpVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
class SignUpVC: BaseVC {
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
        
        //scrollviewkeyboard
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Keyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    @objc func onBtnSignUpClick(sender:UIButton) {
        print("Btn Sign Up Click")
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
