//
//  BaseTabBarVC.swift
//  Roommate
//
//  Created by TrinhHC on 10/13/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class BaseTabBarVC: UITabBarController {
//    let group = DispatchGroup()
//    lazy var indicator:UIActivityIndicatorView = {
//        let av = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        av.hidesWhenStopped = true
//        return av
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    func showIndicator(){
//        view.addSubview(indicator)
//        _ = indicator.anchorCenterXAndY(view.centerXAnchor, view.centerYAnchor,100,100)
//        view.bringSubview(toFront: indicator)
//        indicator.color = UIColor.gray
//        indicator.contentMode = .scaleAspectFill
//        indicator.startAnimating()
//        UIApplication.shared.beginIgnoringInteractionEvents()
//    }
//    func hideIndicator(){
//        UIApplication.shared.endIgnoringInteractionEvents()
//        indicator.stopAnimating()
//        indicator.removeFromSuperview()
//    }
//    func checkInitData(){
//        showIndicator()
//        DispatchQueue.global(qos: .background).async {
//            if !DBManager.shared.isExistedUtility(){self.requestUtilitiesArray()}
//            if !DBManager.shared.isExistedCity(){self.requestArray(apiRouter: APIRouter.city(), returnType:CityModel.self)}
//            if !DBManager.shared.isExistedDistrict(){self.requestArray(apiRouter: APIRouter.district(), returnType:DistrictModel.self)}
//        }
//        self.group.notify(queue: DispatchQueue.main, execute: {
//            self.hideIndicator()
//        })
//        if !DBManager.shared.isExistedUtility() || !DBManager.shared.isExistedCity() || !DBManager.shared.isExistedDistrict(){
//            APIResponseAlert.defaultAPIResponseError(controller: self, error: .SERVER_NOT_RESPONSE)
//        }
//        DBManager.shared.getRecords(ofType: UtilityModel.self)?.forEach({ (model) in
//            print(model.name)
//        })
//        DBManager.shared.getRecords(ofType: CityModel.self)?.forEach({ (model) in
//            print(model.name)
//        })
//        DBManager.shared.getRecords(ofType: DistrictModel.self)?.forEach({ (model) in
//            print(model.name)
//        })
//    }
    
//    func requestArray<T:BaseModel>(apiRouter:APIRouter,returnType:T.Type){
//        self.group.enter()
//        APIConnection.requestArray(apiRouter: apiRouter, errorNetworkConnectedHander: {
//            self.hideIndicator()
//            self.group.leave()
//            APIResponseAlert.defaultAPIResponseError(controller: self, error: .HTTP_ERROR)
//        }, returnType: T.self) { (values, error, statusCode) -> (Void) in
//            if error == .SERVER_NOT_RESPONSE || error == .PARSE_RESPONSE_FAIL{
//                self.group.leave()
////                self.group.leave()
////                APIResponseAlert.defaultAPIResponseError(controller: self, error: .SERVER_NOT_RESPONSE)
////            }else if error == .PARSE_RESPONSE_FAIL{
////                //404
////                self.group.leave()
////                APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
//            }else{
//                //200
//                if statusCode == .OK{
//                    guard let values = values else{
//                        self.group.leave()
//                        return
//                    }
//                    _ = DBManager.shared.addRecords(ofType: T.self, objects: values)
//                    
////                    APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
//                }
//                self.group.leave()
//            }
//        }
//        group.wait()
//    }

}