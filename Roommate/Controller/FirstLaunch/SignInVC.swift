//
//  SignInVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SkyFloatingLabelTextField

//This class for sign up
class SignInVC: BaseVC,UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnSignIn: RoundButton!
    @IBOutlet weak var tfUsername: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPassword: SkyFloatingLabelTextField!
    private lazy var mainTabBarVC:MainTabBarVC =  {
        let vc = MainTabBarVC()
        return vc
    }()
    
    var username:String = ""
    var password:String = ""
//    var btnSignIn:UIButton={
//        let btn = UIButton(
//        btn.backgroundColor = .red
//        btn.setTitle("SIGN_IN_TITLE".localized, for: .normal)
//        return btn
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignIn.setTitle("SIGN_IN_TITLE".localized, for: .normal)
        tfUsername.returnKeyType = .done
        tfUsername.placeholder = "PLACE_HOLDER_USERNAME".localized
        tfUsername.title = "PLACE_HOLDER_USERNAME".localized
        tfUsername.errorColor = .red
        tfUsername.selectedLineColor = .defaultBlue
        tfUsername.selectedTitleColor = .defaultBlue
        tfUsername.delegate = self
        
        tfPassword.isSecureTextEntry = true
        tfPassword.returnKeyType = .done
        tfPassword.placeholder = "PLACE_HOLDER_PASSWORD".localized
        tfPassword.title = "PLACE_HOLDER_PASSWORD".localized
        tfPassword.errorColor = .red
        tfPassword.selectedLineColor = .defaultBlue
        tfPassword.selectedTitleColor = .defaultBlue
        tfPassword.delegate = self
        
        
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapView)))
        
        //scrollviewkeyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoard), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    @IBAction func onClickBtnSignIn(_ sender: Any) {
//        navigationController?.popToRootViewController(animated: false)
        //        navigationController?.pushViewController(mainTabBarVC, animated: true)
        //        let navigationController = UINavigationController(rootViewController: mainTabBarVC)
        
        //Valid
        if username.isValidUsername() && password.isValidPassword(){
            self.showIndicator()
            //Request for user
            requestUser()
        }else{
            AlertController.showAlertInfor(withTitle: "NETWORK_STATUS_TITLE".localized, forMessage: "ERROR_TYPE_INPUT".localized, inViewController: self)
        }
    }
            

    func requestUser(){
        APIConnection.requestObject(apiRouter: APIRouter.login(username: username, password: password), errorNetworkConnectedHander: {
            APIResponseAlert.defaultAPIResponseError(controller: self, error: .HTTP_ERROR)
        }, returnType: UserModel.self) { (user, error, statusCode) -> (Void) in
            
            if error == .SERVER_NOT_RESPONSE {
                self.hideIndicator()
                APIResponseAlert.defaultAPIResponseError(controller: self, error: .SERVER_NOT_RESPONSE)
            }else if error == .PARSE_RESPONSE_FAIL{
                //404
                self.hideIndicator()
                APIResponseAlert.apiResponseError(controller: self, type: APIResponseAlertType.invalidUsername)
            }else{
                //200
                if statusCode == .OK{
                    _ = DBManager.shared.addUser(user: user!)
                    self.hideIndicator()
                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    appdelegate.window!.rootViewController = self.mainTabBarVC
                    
                    //403
                }else if statusCode == .Forbidden {
                    APIResponseAlert.apiResponseError(controller: self, type: .invalidPassword)
                }
            }
        }
    }

    
    @objc func keyBoard(notification: Notification){
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame =  (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame,from: view.window)
        if notification.name == Notification.Name.UIKeyboardWillHide{
            scrollView.contentInset = UIEdgeInsets.zero
        }else{
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height + 30, right: 0)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }

    //MARK: UITextFieldDeleage
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let tfFloat = textField as? SkyFloatingLabelTextField,let updatedString = (tfFloat.text as NSString?)?.replacingCharacters(in: range, with: string){
            if tfFloat == tfUsername{
                if updatedString.isValidUsername(){
                    username = updatedString
                    tfFloat.errorMessage = ""
                }else{
                    tfFloat.errorMessage = "ERROR_TYPE_USERNAME".localized
                }
                
            }else{
                if updatedString.isValidPassword(){
                    password = updatedString
                    tfFloat.errorMessage = ""
                }else{
                    tfFloat.errorMessage = "ERROR_TYPE_PASSWORD".localized
                }
            }
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
