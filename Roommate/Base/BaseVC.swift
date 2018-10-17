//
//  BaseVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
class BaseVC:UIViewController{
    var navTitle:String?{
        didSet{
            navigationController?.navigationBar.topItem?.title = navTitle
        }
    }
    
    let group = DispatchGroup()
    
    lazy var indicator:UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        av.hidesWhenStopped = true
        return av
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditting))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func endEditting(){
        view.endEditing(true)
    }
    func showIndicator(){
        view.addSubview(indicator)
        _ = indicator.anchorCenterXAndY(view.centerXAnchor, view.centerYAnchor,100,100)
        view.bringSubview(toFront: indicator)
        indicator.color = UIColor.gray
        indicator.contentMode = .scaleAspectFill
        indicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    func hideIndicator(){
        indicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        indicator.removeFromSuperview()
    }
    func checkInitData(){
        if DBManager.shared.isExistedUtility(){
            
        }
    }
    
    func requestArray<T:Mappable>(apiRouter:APIRouter,returnType:T.Type,completion:@escaping (_ result:[T]?,_ error:ApiResponseErrorType?,_ statusCode:HTTPStatusCode?)->(Void)){
//        self.group.enter()
        APIConnection.requestArray(apiRouter: apiRouter, errorNetworkConnectedHander: {
            APIResponseAlert.defaultAPIResponseError(controller: self, error: .HTTP_ERROR)
        }, returnType: T.self) { (values, error, statusCode) -> (Void) in
            
            if error == .SERVER_NOT_RESPONSE {
//                self.group.leave()
                APIResponseAlert.defaultAPIResponseError(controller: self, error: .SERVER_NOT_RESPONSE)
            }else if error == .PARSE_RESPONSE_FAIL{
                //404
//                self.group.leave()
                APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
            }else{
                //200
                if statusCode == .OK{
                    guard let values = values else{
                        APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
//                        self.group.leave()
                        return
                    }
                    completion(values,error,statusCode)
                    
                    
                }
//                self.group.leave()
            }
        }
//        group.wait()
    }
    func requestArray<T:BaseModel>(apiRouter:APIRouter,returnType:T.Type){
        self.group.enter()
        APIConnection.requestArray(apiRouter: apiRouter, errorNetworkConnectedHander: {
            APIResponseAlert.defaultAPIResponseError(controller: self, error: .HTTP_ERROR)
        }, returnType: T.self) { (values, error, statusCode) -> (Void) in
            
            if error == .SERVER_NOT_RESPONSE {
                self.group.leave()
                APIResponseAlert.defaultAPIResponseError(controller: self, error: .SERVER_NOT_RESPONSE)
            }else if error == .PARSE_RESPONSE_FAIL{
                //404
                self.group.leave()
                APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
            }else{
                //200
                if statusCode == .OK{
                    guard let values = values else{
                        APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
                        self.group.leave()
                        return
                    }
                    _ = DBManager.shared.addRecords(ofType: T.self, objects: values)
                    
                    
                }
                self.group.leave()
            }
        }
        group.wait()
    }
}
