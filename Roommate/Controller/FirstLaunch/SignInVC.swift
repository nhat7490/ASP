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
import MBProgressHUD
//This class for sign up
class SignInVC: BaseVC,UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnSignIn: RoundButton!
    @IBOutlet weak var tfUsername: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var imgvIcon: UIImageView!
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
        setBackButtonForNavigationBar(isEmbedInNewNavigationController:  false)
        imgvIcon.layer.cornerRadius = 15
        imgvIcon.clipsToBounds = true
        
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
        
        registerNotificationForKeyboard()
        
        
        
    }
    
    //MARK: UIButton Event
    @IBAction func onClickBtnSignIn(_ sender: Any) {
//        navigationController?.popToRootViewController(animated: false)
        //        navigationController?.pushViewController(mainTabBarVC, animated: true)
        //        let navigationController = UINavigationController(rootViewController: mainTabBarVC)
        
        //Valid
        if username.isValidUsername() && password.isValidPassword(){
//            self.showIndicator()
            let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
            hub.label.text = "MB_SIGN_IN_TITLE".localized
            //Request for user
            requestUser()
        }else{
            AlertController.showAlertInfor(withTitle: "NETWORK_STATUS_TITLE".localized, forMessage: "ERROR_TYPE_INPUT".localized, inViewController: self)
        }
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
    
    //MARK:Other methods
    func requestUser(){
        APIConnection.requestObject(apiRouter: APIRouter.login(username: username, password: password), errorNetworkConnectedHander: {
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
                APIResponseAlert.defaultAPIResponseError(controller: self, error: .HTTP_ERROR)
            }
        }, returnType: UserModel.self) { (user, error, statusCode) -> (Void) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            if error == .SERVER_NOT_RESPONSE {
                APIResponseAlert.defaultAPIResponseError(controller: self, error: .SERVER_NOT_RESPONSE)
            }else if error == .PARSE_RESPONSE_FAIL{
                //404
                APIResponseAlert.apiResponseError(controller: self, type: APIResponseAlertType.invalidUsername)
            }else{
                //200
                if statusCode == .OK{
                    //                    DispatchQueue.global(qos: .userInteractive).async {
                    
                    //                        self.group.notify(queue: DispatchQueue.main, execute: {
                    _ = DBManager.shared.addUser(user: user!)
                    _ = DBManager.shared.addSingletonModel(ofType: SettingModel.self, object: SettingModel())
                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    appdelegate.window!.rootViewController = self.mainTabBarVC
                    
                    //403
                }else if statusCode == .Forbidden {
                    APIResponseAlert.apiResponseError(controller: self, type: .invalidPassword)
                }
            }
        }
    }
    
    
    @objc override func keyBoard(notification: Notification){
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
    
}
