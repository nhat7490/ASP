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
import AVFoundation
import PhotosUI
import CoreLocation
class BaseVC:UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AlertControllerDelegate{
    var hasBackImageButtonInNavigationBar:Bool? = false
    let locationManager = CLLocationManager()
    let group = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.defaultBlue]
        UINavigationBar.appearance().tintColor = .defaultBlue
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditting))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func registerNotificationForKeyboard(){
        //notification center
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoard), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoard), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func keyBoard(notification: Notification){}
    
    @objc func endEditting(){
        view.endEditing(true)
    }
    
    func resetFilter(filterType:FilterType){}
    func showNoDataView(inView view:UIView,withTitle title:String?){
        let noDataView:NoDataView = .fromNib()
        noDataView.title = title
        noDataView.frame = view.bounds
        view.addSubview(noDataView)
        view.bringSubview(toFront: noDataView)
        view.layoutSubviews()
    }
    func hideNoDataView(inView view:UIView){
        view.subviews.forEach { (view) in
            if view is NoDataView, let view = view as? NoDataView{
                view.removeFromSuperview()
            }
        }
    }
    func showErrorView(inView view:UIView,withTitle title:String?,onCompleted completed:@escaping ()->(Void)){
        let errorView:ErrorView = .fromNib()
        if let title = title {
            if APIConnection.isConnectedInternet(){
                errorView.title = title
            }else{
                errorView.title = "NETWORK_STATUS_CONNECTED_REQUEST_ERROR_MESSAGE".localized
            }
            
        }
        errorView.completed = completed
        errorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideErrorView(sender:))))
        errorView.frame = view.bounds
        view.addSubview(errorView)
        print(view.frame)
        view.bringSubview(toFront: errorView)
        view.layoutSubviews()
        //        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    @objc func hideErrorView(sender:UITapGestureRecognizer){
        let errorView = sender.view as! ErrorView
        errorView.removeFromSuperview()
        if let completed = errorView.completed{
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
            if !DBManager.shared.isExisted(ofType: UtilityModel.self){self.requestUtilitiesArray()}
            if !DBManager.shared.isExisted(ofType:CityModel.self){self.requestArray(apiRouter: APIRouter.city(), returnType:CityModel.self)}
            if !DBManager.shared.isExisted(ofType:DistrictModel.self){self.requestArray(apiRouter: APIRouter.district(), returnType:DistrictModel.self)}
            if DBManager.shared.getSingletonModel(ofType: UserModel.self)?.roleId == Constants.ROOMMASTER{
                self.requestCurrentRoom()
            }
            
            
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: view, animated: true)
                if !DBManager.shared.isExisted(ofType: UtilityModel.self) || !DBManager.shared.isExisted(ofType: CityModel.self) || !DBManager.shared.isExisted(ofType: DistrictModel.self){
                    
                    DispatchQueue.main.async {
                        self.showErrorView(inView: view, withTitle: "NETWORK_STATUS_ERROR_MESSAGE".localized,onCompleted:{
                            self.checkAndLoadInitData(inView: view,onCompleted: completed)
                        })
                    }
                }else{
                    if DBManager.shared.getSingletonModel(ofType: UserModel.self)?.roleId == Constants.ROOMMASTER{
                        if !DBManager.shared.isExisted(ofType: RoomModel.self){
                            DispatchQueue.main.async {
                                self.showErrorView(inView: view, withTitle: "NETWORK_STATUS_ERROR_MESSAGE".localized,onCompleted:{
                                    self.checkAndLoadInitData(inView: view,onCompleted: completed)
                                })
                            }
                        }else{
                            completed()
                        }
                    }else{
                        completed()
                    }
                    
                }
            }
            
            
        }
    }
    //For Objectmapper and realm
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
                    DispatchQueue.main.async {
                        if !DBManager.shared.isExisted(ofType: T.self){
                            _ = DBManager.shared.addRecords(ofType: T.self, objects: values)
                        }
                        
                        
                    }
                    
                }
            }
            self.group.leave()
        }
        self.group.wait()
    }
    func requestUtilitiesArray(){
        self.group.enter()
        APIConnection.requestArray(apiRouter: APIRouter.utility(), errorNetworkConnectedHander: nil, returnType: UtilityMappableModel.self) { (values, error, statusCode) -> (Void) in
            
            if error == nil{
                //200
                if statusCode == .OK{
                    guard let values = values else{
                        //                        APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
                        self.group.leave()
                        return
                    }
                    DispatchQueue.main.async {
                        if !DBManager.shared.isExisted(ofType: UtilityModel.self){
                            _ = DBManager.shared.addRecords(ofType: UtilityModel.self, objects: values.compactMap({ (utility) -> UtilityModel? in
                                UtilityModel(utilityMappableModel: utility)
                            }))
                        }
                        
                    }
                    
                }
            }
            self.group.leave()
        }
        self.group.wait()
    }
//    func requestArray<T:Mappable>(apiRouter:APIRouter,errorNetworkConnectedHander:(()->Void)? =  nil,returnType:T.Type,completion:@escaping (_ result:[T]?,_ error:ApiResponseErrorType?,_ statusCode:HTTPStatusCode?)->(Void)){
//        //        self.group.enter()
//        APIConnection.requestArray(apiRouter: apiRouter, errorNetworkConnectedHander: errorNetworkConnectedHander, returnType: T.self) { (values, error, statusCode) -> (Void) in
//            if error == nil{
//                //200
//                if statusCode == .OK{
//                    guard let values = values else{
//                        //                        APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
//                        //                        self.group.leave()
//                        return
//                    }
//                    completion(values,error,statusCode)
//                }else{
//                    completion(nil,nil,statusCode)
//                }
//                //
//            }else{
//                completion(nil,error,statusCode)
//            }
//            //            self.group.leave()
//        }
//        //        self.group.wait()
//        
//    }
//    func request(apiRouter:APIRouter,errorNetworkConnectedHander:@escaping ()->Void,completion:@escaping (_ error:ApiResponseErrorType?,_ statusCode:HTTPStatusCode?)->(Void)){
//        APIConnection.request(apiRouter: apiRouter, errorNetworkConnectedHander: nil) { (error, statusCode) -> (Void) in
//            if error == ApiResponseErrorType.SERVER_NOT_RESPONSE{
//                completion(error,statusCode)
//            }else{
//                completion(nil,statusCode)
//            }
//        }
//    }
    
//    func requestObject<T:BaseModel>(apiRouter:APIRouter,returnType:T.Type){
//        self.group.enter()
//        APIConnection.requestObject(apiRouter: APIRouter.getCurrentRoom(userId: DBManager.shared.getUser()!.userId), returnType: T.self){ (value,error, statusCode) -> (Void) in
//
//            if error == nil{
//                //200
//                if statusCode == .OK{
//                    guard let value = value else{
//                        //                        APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
//                        self.group.leave()
//                        return
//                    }
//                    print(DBManager.shared.addSingletonModel(ofType: T.self, object: value))
//                }
//            }
//            self.group.leave()
//        }
//        self.group.wait()
//    }
    func requestCurrentRoom(){
        self.group.enter()
        APIConnection.requestObject(apiRouter: APIRouter.getCurrentRoom(userId: DBManager.shared.getUser()!.userId), returnType: RoomMappableModel.self){ (value, error, statusCode) -> (Void) in
            
            if error == nil{
                //200
                if statusCode == .OK{
                    guard let value = value else{
                        //                        APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
                        self.group.leave()
                        return
                    }
                    print(DBManager.shared.addSingletonModel(ofType:RoomModel.self, object: RoomModel(roomResponseModel: value)))
                }else if statusCode == .NotFound{
                    DBManager.shared.deleteAllRecords(ofType: RoomModel.self)
                }
            }
            self.group.leave()
        }
        self.group.wait()
    }
    
    
    //MARK: Process bookmark
    func processBookmark(view:UIView,model:BasePostResponseModel,row:Int,completed:@escaping (_ model:BasePostResponseModel)->(Void)){
        let bookmarkRequestModel = BookmarkRequestModel()
        bookmarkRequestModel.postId = model.postId!
        bookmarkRequestModel.userId = DBManager.shared.getUser()!.userId
        let apiRouter = model.isFavourite == true ? APIRouter.removeBookmark(favoriteId: model.favouriteId!) : APIRouter.createBookmark(model: bookmarkRequestModel)
        //        imageView.isUserInteractionEnabled = false
        
        DispatchQueue.main.async {
            let hub = MBProgressHUD.showAdded(to: view, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
        }
        
        APIConnection.requestObject(apiRouter: apiRouter, errorNetworkConnectedHander: {
            APIResponseAlert.defaultAPIResponseError(controller: self, error: .HTTP_ERROR)
        }, returnType: CreateResponseModel.self){ (value,error, statusCode) -> (Void) in
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: view, animated: true)
            }
            if error == .SERVER_NOT_RESPONSE{
                APIResponseAlert.defaultAPIResponseError(controller: self, error: .SERVER_NOT_RESPONSE)
            }else if error == .PARSE_RESPONSE_FAIL{
                APIResponseAlert.defaultAPIResponseError(controller: self, error: .PARSE_RESPONSE_FAIL)
            }else{
                if statusCode == .OK{
                    if let value = value{
                        model.favouriteId = value.id
                    }
                    model.isFavourite = (model.isFavourite == true ? false : true)
                    completed(model)
                    
                }else  if statusCode == .Conflict{
                    APIResponseAlert.defaultAPIResponseError(controller: self, error: .PARSE_RESPONSE_FAIL)
                }
            }
        }
        
    }
    
    //MARK: alertControllerDelegate
    func alertControllerDelegate(alertController: AlertController, onSelected selectedIndexs: [IndexPath]?) {
    }
    func alertControllerDelegate(alertController: AlertController, withAlertType type: AlertType, onCompleted indexs: [IndexPath]?) {
        
    }
    //MARK: Permission
    func checkPermission(type:UIImagePickerControllerSourceType){
        if type == .camera{
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let status = AVCaptureDevice.authorizationStatus(for: .video)
                switch status{
                case .denied:
                    showAlertToAllowAccessViaSetting(type: type)
                case .authorized:
                    showPickerController(type: .camera)
                default:
                    showRequiredPermissionAccess(type: type)
                }
            }else{
                AlertController.showAlertInfor(withTitle: "INFORMATION".localized, forMessage: "DEVICE_CAMERA_NOT_EXISTED".localized, inViewController: self, rhsButtonHandler: nil)
            }
        }else if type == .photoLibrary{
            switch PHPhotoLibrary.authorizationStatus(){
            case .denied:
                showAlertToAllowAccessViaSetting(type: type)
            case .authorized:
                showPickerController(type: .photoLibrary)
            default:
                showRequiredPermissionAccess(type: type)
            }
        }
    }
    //MARK: Show Alert for permission
    func showAlertToAllowAccessViaSetting(type:UIImagePickerControllerSourceType){
        if type == .camera{
            AlertController.showAlertConfirm(withTitle: "INFORMATION".localized, andMessage: "ROOM_UPLOAD_OPEN_CAMERA_SETTING".localized, alertStyle: .alert, forViewController: self, lhsButtonTitle: "ROOM_UPLOAD_SKIP".localized, rhsButtonTitle: "ROOM_UPLOAD_OPEN_SETTING".localized, lhsButtonHandler: nil) { (action) in
                if let appSettingUrl = URL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.shared.open(appSettingUrl, options: [:], completionHandler: {(result) in
                        
                    })
                }
            }
        }else if type == .photoLibrary{
            AlertController.showAlertConfirm(withTitle: "INFORMATION".localized, andMessage: "ROOM_UPLOAD_OPEN_PHOTO_SETTING".localized, alertStyle: .alert, forViewController: self, lhsButtonTitle: "ROOM_UPLOAD_SKIP".localized, rhsButtonTitle: "ROOM_UPLOAD_OPEN_SETTING".localized, lhsButtonHandler: nil) { (action) in
                if let appSettingUrl = URL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.shared.open(appSettingUrl, options: [:], completionHandler: {(result) in
                        
                    })
                }
            }
        }
        
    }
    func showRequiredPermissionAccess(type:UIImagePickerControllerSourceType){
        if type == .camera{
            AlertController.showAlertConfirm(withTitle: "INFORMATION".localized, andMessage: "ROOM_UPLOAD_CAMERA_QUESTION".localized, alertStyle: .alert, forViewController: self, lhsButtonTitle: "NO".localized, rhsButtonTitle: "YES".localized, lhsButtonHandler: nil) { (action) in
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { (result) in
                    DispatchQueue.main.async {
                        self.checkPermission(type: type)
                    }
                })
                
            }
        }else if type == .photoLibrary{
            AlertController.showAlertConfirm(withTitle: "INFORMATION".localized, andMessage: "ROOM_UPLOAD_PHOTO_QUESTION".localized, alertStyle: .alert, forViewController: self, lhsButtonTitle: "NO".localized, rhsButtonTitle: "YES".localized, lhsButtonHandler: nil) { (action) in
                PHPhotoLibrary.requestAuthorization({ (status) in
                    DispatchQueue.main.async {
                        self.checkPermission(type: type)
                    }
                })
                
            }
        }
        
    }
    func showPickerController(type:UIImagePickerControllerSourceType){
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.delegate = self
        picker.modalPresentationStyle = .currentContext
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    }
    func generateImageName()->String{
        return "\(Date().string("HH_mm_ss_dd_MM_yyyy")).jpg"
    }
    //MARK: Back button on navigation bar
    
    
    func setBackButtonForNavigationBar(){
        //Back button
        if hasBackImageButtonInNavigationBar!{
            let backImage = UIImage(named: "back")
            navigationItem.leftBarButtonItem =  UIBarButtonItem(image: backImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(dimissEntireNavigationController))
        }else{
            navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "BACK".localized, style: .plain, target: self, action:#selector(popSelfInNavigationController))
        }
        
        navigationItem.leftBarButtonItem?.tintColor = .defaultBlue
        
        
    }
    func transparentNavigationBarBottomBorder(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
    }
    func presentInNewNavigationController(viewController:BaseVC,flag:Bool? = true,animated:Bool? = true){
        if flag!{
            viewController.hasBackImageButtonInNavigationBar = flag
            let mainVC = UIViewController()
            mainVC.view.backgroundColor = .white
            let nv = UINavigationController(rootViewController: viewController)
            present(nv, animated: animated!) {
//                nv.pushViewController(viewController, animated: animated!)
            }
        }else{
            self.navigationController?.pushViewController(viewController, animated: animated!)
        }
        
    }
    
    @objc func dimissEntireNavigationController(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func popSelfInNavigationController(){
        self.navigationController?.popViewController(animated: true)
    }
}