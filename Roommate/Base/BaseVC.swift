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
import MBProgressHUD
class BaseVC:UIViewController{
    var navTitle:String?{
        didSet{
            navigationController?.navigationBar.topItem?.title = navTitle
        }
    }
    
    let group = DispatchGroup()
    
    lazy var errorView:ErrorView = {
        let ev:ErrorView = .fromNib()
        return ev
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
    func showErrorView(inView view:UIView,withTitle title:String?,onCompleted completed:@escaping ()->(Void)){
        if let title = title {
            if APIConnection.isConnectedInternet(){
                errorView.title = title
            }else{
                errorView.title = "NETWORK_STATUS_CONNECTED_REQUEST_ERROR_MESSAGE".localized
            }
            
        }
        errorView.completed = completed
        errorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideErrorView)))
        view.addSubview(errorView)
        _ = errorView.anchor(view: view)
        view.bringSubview(toFront: errorView)
        //        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    @objc func hideErrorView(){
        self.errorView.removeFromSuperview()
        if let completed = self.errorView.completed{
            completed()
        }
        
    }
    func checkAndLoadInitData(inView view:UIView,onCompleted completed:@escaping ()->Void){
        
        DispatchQueue.main.async {
            let hub = MBProgressHUD.showAdded(to: view, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
        }
        DispatchQueue.global(qos: .background).async {
            if !DBManager.shared.isExisted(ofType: UtilityModel.self){self.requestArray(apiRouter: APIRouter.utility(), returnType:UtilityModel.self)}
            if !DBManager.shared.isExisted(ofType:CityModel.self){self.requestArray(apiRouter: APIRouter.city(), returnType:CityModel.self)}
            if !DBManager.shared.isExisted(ofType:DistrictModel.self){self.requestArray(apiRouter: APIRouter.district(), returnType:DistrictModel.self)}
            
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: view, animated: true)
            }
            if !DBManager.shared.isExisted(ofType: UtilityModel.self) || !DBManager.shared.isExisted(ofType: CityModel.self) || !DBManager.shared.isExisted(ofType: DistrictModel.self){
                DispatchQueue.main.async {
                    self.showErrorView(inView: view, withTitle: "NETWORK_STATUS_ERROR_MESSAGE".localized,onCompleted:{
                        self.checkAndLoadInitData(inView: view,onCompleted: completed)
                    })
                }
            }else{
                completed()
            }
            
        }
    }
    
    func requestArray<T:Mappable>(apiRouter:APIRouter,errorNetworkConnectedHander:(()->Void)? =  nil,returnType:T.Type,completion:@escaping (_ result:[T]?,_ error:ApiResponseErrorType?,_ statusCode:HTTPStatusCode?)->(Void)){
        //        self.group.enter()
        APIConnection.requestArray(apiRouter: apiRouter, errorNetworkConnectedHander: errorNetworkConnectedHander, returnType: T.self) { (values, error, statusCode) -> (Void) in
            if error == nil{
                //200
                if statusCode == .OK{
                    guard let values = values else{
                        //                        APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
                        //                        self.group.leave()
                        return
                    }
                    completion(values,error,statusCode)
                }else{
                    completion(nil,nil,statusCode)
                }
                //
            }else{
                completion(nil,error,statusCode)
            }
//            self.group.leave()
        }
//        self.group.wait()
        
    }
    func request(apiRouter:APIRouter,errorNetworkConnectedHander:@escaping ()->Void,completion:@escaping (_ error:ApiResponseErrorType?,_ statusCode:HTTPStatusCode?)->(Void)){
        APIConnection.request(apiRouter: apiRouter, errorNetworkConnectedHander: nil) { (error, statusCode) -> (Void) in
            if error == ApiResponseErrorType.SERVER_NOT_RESPONSE{
                completion(error,statusCode)
            }else{
                completion(nil,statusCode)
            }
        }
    }
    func requestArray<T:BaseModel>(apiRouter:APIRouter,returnType:T.Type){
        self.group.enter()
        APIConnection.requestArray(apiRouter: apiRouter, errorNetworkConnectedHander: nil, returnType: T.self) { (values, error, statusCode) -> (Void) in
            
            if error == nil{
                //200
                if statusCode == .OK{
                    guard let values = values else{
                        //                        APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
                        self.group.leave()
                        return
                    }
                    print(DBManager.shared.addRecords(ofType: T.self, objects: values))
                }
            }
            self.group.leave()
        }
        self.group.wait()
    }
    
}
