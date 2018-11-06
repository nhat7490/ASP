//
//  HomeVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import CoreLocation
class HomeVC:BaseVC,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HorizontalRoomViewDelegate,VerticalPostViewDelegate,LocationSearchViewDelegate,AlertControllerDelegate,CLLocationManagerDelegate{
    
    var scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    var contentView:UIView = {
        let v = UIView()
        //        v.backgroundColor = .red
        return v
    }()
    
    var topContainerView:UIView = {
        let v = UIView()
        //        v.backgroundColor = .blue
        return v
    }()
    var bottomContainerView:UIView = {
        let v = UIView()
        //        v.backgroundColor = .blue
        return v
    }()
    
    var locationSearchView:LocationSearchView = {
        let lv:LocationSearchView = .fromNib()
        return lv
    }()
    
    var topNavigation:BaseHorizontalCollectionView = {
        let bv = BaseHorizontalCollectionView()
        return bv
    }()
    
    var suggestRoomView:HorizontalRoomView = {
        let hv:HorizontalRoomView  = .fromNib()
        return hv
    }()
    
    var newRoomView:VerticalPostView = {
        let vv:VerticalPostView = .fromNib()
        vv.verticalPostViewType = .room
        return vv
    }()
    var newRoommateView:VerticalPostView = {
        let vv:VerticalPostView = .fromNib()
        vv.verticalPostViewType = .roommate
        return vv
    }()
    var cities:[CityModel]?
    var suggestRooms:[RoomPostResponseModel] = []
    var newRooms:[RoomPostResponseModel] = []
    var newRoommates:[RoommatePostResponseModel] = []
    var city:CityModel?
    var filterForRoomPost = FilterArgumentModel()
    var filterForRoommatePost = FilterArgumentModel()
    var baseSuggestRequestModel = BaseSuggestRequestModel()
    
    var actionsForMember:[[String]] = [
        ["Tìm phòng","find-room"],
        ["Tìm bạn","find-roommate"],
        ["Đăng tìm phòng","add-roommate"],
        ["Đăng tìm bạn","add-room"]
    ]
    var actionsForOnwer:[[String]] = [
        ["Đăng phòng","add-room"],
        ["Quản lý phòng","account"]
    ]
    lazy var user = DBManager.shared.getUser()
    var suggestRoomViewHeightConstraint:NSLayoutConstraint?
    var newRoomViewHeightConstraint:NSLayoutConstraint?
    var newRoommateViewHeightConstraint:NSLayoutConstraint?
    var contentViewHeightConstraint:NSLayoutConstraint?
    
    
    //MARK:ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegateAndDataSource()
        enableLocationServices()
        loadRemoteData()
        registerNotification()
    }
    //MARK: Setup UI and Delegate
    func setupUI(){
        
        view.backgroundColor  = .white
        let suggestRoomViewHeight:CGFloat = Constants.HEIGHT_DEFAULT_BEFORE_LOAD_DATA
        let newRoomViewHeight:CGFloat = Constants.HEIGHT_DEFAULT_BEFORE_LOAD_DATA
//            80 + Constants.HEIGHT_CELL_NEWROOMCV * CGFloat(Constants.MAX_ROOM_ROW) + Constants.HEIGHT_MEDIUM_SPACE
        let newRoommmateViewHeight:CGFloat = Constants.HEIGHT_DEFAULT_BEFORE_LOAD_DATA
//            80 + Constants.HEIGHT_CELL_NEWROOMMATECV * CGFloat(Constants.MAX_POST) + Constants.HEIGHT_MEDIUM_SPACE
        let totalContentViewHeight:CGFloat
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topContainerView)
        contentView.addSubview(bottomContainerView)
        topContainerView.addSubview(locationSearchView)
        topContainerView.addSubview(topNavigation)
        if user?.roleId != 2{
            totalContentViewHeight = newRoomViewHeight + newRoommmateViewHeight + Constants.HEIGHT_TOP_CONTAINER_VIEW + suggestRoomViewHeight
            bottomContainerView.addSubview(suggestRoomView)
        }else{
            totalContentViewHeight = newRoomViewHeight + newRoommmateViewHeight + Constants.HEIGHT_TOP_CONTAINER_VIEW
        }
        bottomContainerView.addSubview(newRoomView)
        bottomContainerView.addSubview(newRoommateView)
        
        if #available(iOS 11.0, *) {
            _ = scrollView.anchor(view.safeAreaLayoutGuide.topAnchor, view.leftAnchor, view.safeAreaLayoutGuide.bottomAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10))
        } else {
            // Fallback on earlier versions
            _ = scrollView.anchor(topLayoutGuide.bottomAnchor, view.leftAnchor, bottomLayoutGuide.topAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10))
        }
        _ = contentView.anchor(view: scrollView)
        _ = contentView.anchorWidth(equalTo: scrollView.widthAnchor)
        contentViewHeightConstraint = contentView.anchorHeight(equalToConstrant: totalContentViewHeight)
        
        _ = topContainerView.anchor(contentView.topAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, .zero, CGSize(width: 0, height: Constants.HEIGHT_TOP_CONTAINER_VIEW))
        _ = locationSearchView.anchor(topContainerView.topAnchor, topContainerView.leftAnchor, nil, topContainerView.rightAnchor, UIEdgeInsets(top: Constants.MARGIN_10, left: Constants.MARGIN_20, bottom: 0, right: -Constants.MARGIN_20), CGSize(width: 0, height: Constants.HEIGHT_LOCATION_SEARCH_VIEW))
        
        
        _ = topNavigation.anchor(locationSearchView.bottomAnchor, topContainerView.leftAnchor, topContainerView.bottomAnchor, topContainerView.rightAnchor,UIEdgeInsets(top: Constants.MARGIN_10, left: 0, bottom: 0, right: 0))
        
        topNavigation.backgroundColor = UIColor(hexString: "f7f7f7")
        topContainerView.layer.borderWidth  = 1
        topContainerView.layer.borderColor  = UIColor.lightGray.cgColor
        topContainerView.layer.cornerRadius = 15
        topContainerView.clipsToBounds = true
        
        _ = bottomContainerView.anchor(topContainerView.bottomAnchor, contentView.leftAnchor, contentView.bottomAnchor, contentView.rightAnchor)
        
        if user?.roleId != 2{
        suggestRoomViewHeightConstraint = suggestRoomView.anchor(bottomContainerView.topAnchor, bottomContainerView.leftAnchor, nil, bottomContainerView.rightAnchor,.zero,CGSize(width: 0, height:
            Constants.HEIGHT_HORIZONTAL_ROOM_VIEW))[3]
            newRoomViewHeightConstraint = newRoomView.anchor(suggestRoomView.bottomAnchor, bottomContainerView.leftAnchor, nil, bottomContainerView.rightAnchor,.zero,CGSize(width: 0, height: newRoomViewHeight))[3]
        }else{
            newRoomViewHeightConstraint = newRoomView.anchor(bottomContainerView.topAnchor, bottomContainerView.leftAnchor, nil, bottomContainerView.rightAnchor,.zero,CGSize(width: 0, height: newRoomViewHeight))[3]
        }
        newRoommateViewHeightConstraint = newRoommateView.anchor(newRoomView.bottomAnchor, bottomContainerView.leftAnchor, nil, bottomContainerView.rightAnchor,.zero,CGSize(width: 0, height: newRoommmateViewHeight))[3]
        
        
        //hide bottom button
        newRoomView.hidebtnViewAllButton()
        newRoommateView.hidebtnViewAllButton()
    }
    func setupDelegateAndDataSource(){
        //        horizontalRoomView.collectionView
        topNavigation.dataSource = self
        topNavigation.delegate = self
        topNavigation.register(UINib(nibName: Constants.CELL_NAVIGATIONCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_NAVIGATIONCV)
        locationSearchView.delegate = self
        newRoommateView.delegate = self
        newRoomView.delegate = self
        if user?.roleId != 2{suggestRoomView.delegate = self}
        
        filterForRoomPost.searchRequestModel = nil
        filterForRoommatePost.typeId = Constants.ROOM_POST
        filterForRoomPost.cityId = DBManager.shared.getSetting()?.cityId
        
        filterForRoommatePost.searchRequestModel = nil
        filterForRoommatePost.cityId = DBManager.shared.getSetting()?.cityId
        filterForRoommatePost.typeId = Constants.ROOMMATE_POST
    }
    
    //MARK: Notification
    func registerNotification(){
        NotificationCenter.default.addObserver(self, selector:#selector(didReceiveAddBookmarkNotification(_:)), name: Constants.NOTIFICATION_ADD_BOOKMARK, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(didReceiveRemoveBookmarkNotification(_:)), name: Constants.NOTIFICATION_REMOVE_BOOKMARK, object: nil)
    }
    @objc func didReceiveRemoveBookmarkNotification(_ notification:Notification) {
        if notification.object is RoomPostResponseModel{
            if let room = notification.object as? RoomPostResponseModel{
                if let index = newRooms.index(of: room){
                    newRooms[index].isFavourite = room.isFavourite
                    newRoomView.collectionView.reloadData()
                }
                if user?.roleId != 2{
                    if let index = suggestRooms.index(of: room){
                        suggestRooms[index].isFavourite = room.isFavourite
                        suggestRoomView.collectionView.reloadData()
                    }
                }
            }
        }else{
            if let roommate = notification.object as? RoommatePostResponseModel{
                if let index = newRoommates.index(of: roommate){
                    newRoommates[index].isFavourite = roommate.isFavourite
                    newRoommateView.collectionView.reloadData()
                }
            }
        }
    }
    @objc func didReceiveAddBookmarkNotification(_ notification:Notification) {
        if notification.object is RoomPostResponseModel{
            if let room = notification.object as? RoomPostResponseModel{
                if let index = newRooms.index(of: room){
                    newRooms[index].isFavourite = room.isFavourite
                    newRooms[index].favouriteId = room.favouriteId
                    newRoomView.collectionView.reloadData()
                }
                if user?.roleId != 2{
                    if let index = suggestRooms.index(of: room){
                        suggestRooms[index].isFavourite = room.isFavourite
                        suggestRooms[index].favouriteId = room.favouriteId
                        suggestRoomView.collectionView.reloadData()
                    }
                }
            }
        }else{
            if let roommate = notification.object as? RoommatePostResponseModel{
                if let index = newRoommates.index(of: roommate){
                    newRoommates[index].isFavourite = roommate.isFavourite
                    newRoommates[index].favouriteId = roommate.favouriteId
                    newRoommateView.collectionView.reloadData()
                }
            }
        }
    }
    //MARK: Remote Data
    func loadRemoteData(){
        
        
        if !APIConnection.isConnectedInternet(){
            showErrorView(inView: self.bottomContainerView, withTitle: "NETWORK_STATUS_CONNECTED_REQUEST_ERROR_MESSAGE".localized) {
                self.checkAndLoadInitData(inView: self.bottomContainerView) { () -> (Void) in
                    self.locationSearchView.location = DBManager.shared.getRecord(id: (DBManager.shared.getSetting()?.cityId)!, ofType: CityModel.self)?.name ?? "LIST_CITY_TITLE".localized
                    self.cities = DBManager.shared.getRecords(ofType: CityModel.self)?.toArray(type: CityModel.self)
                    if self.user?.roleId != 2{
                        self.requestRoom(view: self.suggestRoomView.collectionView, apiRouter:
                            APIRouter.suggest(model: self.baseSuggestRequestModel), offset:Constants.MAX_ROOM_ROW)
                    }
                    self.requestRoom(view: self.newRoomView.collectionView,  apiRouter: APIRouter.postForAll(model: self.filterForRoomPost), offset:Constants.MAX_POST)
                    self.requestRoommate(view: self.newRoommateView.collectionView, apiRouter: APIRouter.postForAll(model: self.filterForRoommatePost), offset:Constants.MAX_POST)
                }
            }
        }else{
            self.checkAndLoadInitData(inView: self.bottomContainerView) { () -> (Void) in
                self.locationSearchView.location = DBManager.shared.getRecord(id: (DBManager.shared.getSetting()?.cityId)!, ofType: CityModel.self)?.name ?? "LIST_CITY_TITLE".localized
                self.cities = DBManager.shared.getRecords(ofType: CityModel.self)?.toArray(type: CityModel.self)
                if self.user?.roleId != 2{
                    self.requestRoom(view: self.suggestRoomView.collectionView, apiRouter:
                        APIRouter.suggest(model: self.baseSuggestRequestModel), offset:Constants.MAX_ROOM_ROW)
                }
                self.requestRoom(view: self.newRoomView.collectionView,  apiRouter: APIRouter.postForAll(model: self.filterForRoomPost), offset:Constants.MAX_POST)
                self.requestRoommate(view: self.newRoommateView.collectionView, apiRouter: APIRouter.postForAll(model: self.filterForRoommatePost), offset:Constants.MAX_POST)
            }
        }
        
        
        
        
        
    }
    
    
    func  requestRoom(view:UICollectionView,apiRouter:APIRouter,offset:Int){
        //        roomFilter.searchRequestModel = nil
        if view == self.suggestRoomView.collectionView{
            baseSuggestRequestModel.offset = offset
        }else if view == self.newRoomView.collectionView{
            filterForRoomPost.offset = offset
        }
        DispatchQueue.main.async {
            let hub = MBProgressHUD.showAdded(to: view, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
            //            hub.label.text = "MB_LOAD_DATA_TITLE".localized
            //            MBProgressHUD.showAdded(to: self.bottomView, animated: true)
        }
        DispatchQueue.global(qos: .background).async {
            self.requestArray(apiRouter:apiRouter, returnType:RoomPostResponseModel.self, completion: { (values, error, statusCode) -> (Void) in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: view, animated: true)
                }
                //404, cant parse
                if error != nil{
                    DispatchQueue.main.async {
                        self.showErrorView(inView: view, withTitle: "NETWORK_STATUS_PARSE_RESPONSE_FAIL_MESSAGE".localized, onCompleted: { () -> (Void) in
                            self.requestRoom(view: view, apiRouter: apiRouter, offset:offset)
                        })
                    }
                }else{
                    //200
                    if statusCode == .OK{
                        guard let values = values else{
                            //                        APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
                            //                        self.group.leave()
                            return
                        }
                        
                        if view == self.suggestRoomView.collectionView{
                            self.suggestRooms.removeAll()
                            self.suggestRooms.append(contentsOf: values)
                            self.suggestRoomView.rooms = self.suggestRooms
                            self.suggestRoomView.translatesAutoresizingMaskIntoConstraints = false
                            self.suggestRoomViewHeightConstraint?.constant = Constants.HEIGHT_HORIZONTAL_ROOM_VIEW
                            self.updateContentViewHeight()
                        }else if view == self.newRoomView.collectionView{
                            self.newRooms.removeAll()
                            self.newRooms.append(contentsOf: values)
                            self.newRoomView.rooms = self.newRooms
                            self.newRoomView.translatesAutoresizingMaskIntoConstraints = false
                            self.newRoomViewHeightConstraint?.constant = 80 + Constants.HEIGHT_CELL_ROOMPOSTCV * CGFloat(Constants.MAX_ROOM_ROW)
                            self.newRoomView.showbtnViewAllButton()
                            self.updateContentViewHeight()
                        }
                        DispatchQueue.main.async {
                            self.view.layoutIfNeeded()
                            view.reloadData()
                        }
                    }
                }
            })
        }
    }
    
    func  requestRoommate(view:UICollectionView,apiRouter:APIRouter,offset:Int){
        //        roomFilter.searchRequestModel = nil
        filterForRoommatePost.offset = offset
        DispatchQueue.main.async {
            let hub = MBProgressHUD.showAdded(to: view, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
            //            hub.label.text = "MB_LOAD_DATA_TITLE".localized
            //            MBProgressHUD.showAdded(to: self.bottomView, animated: true)
        }
        DispatchQueue.global(qos: .background).async {
            self.requestArray(apiRouter:apiRouter, returnType:RoommatePostResponseModel.self, completion: { (values, error, statusCode) -> (Void) in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: view, animated: true)
                }
                //404, cant parse
                if error != nil{
                    DispatchQueue.main.async {
                        self.showErrorView(inView: view, withTitle: "NETWORK_STATUS_PARSE_RESPONSE_FAIL_MESSAGE".localized, onCompleted: { () -> (Void) in
                            self.requestRoommate(view: view, apiRouter: apiRouter, offset:offset)
                        })
                    }
                }else{
                    //200
                    if statusCode == .OK{
                        guard let values = values else{
                            //                        APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
                            //                        self.group.leave()
                            return
                        }
                        if view == self.newRoommateView.collectionView{
                            self.newRoommates.removeAll()
                            self.newRoommates.append(contentsOf: values)
                            self.newRoommateView.roommates = self.newRoommates
                            self.newRoommateView.translatesAutoresizingMaskIntoConstraints = false
                            self.newRoommateViewHeightConstraint?.constant = 80 + Constants.HEIGHT_CELL_ROOMMATEPOSTCV * CGFloat(Constants.MAX_POST)
                            self.newRoommateView.showbtnViewAllButton()
                            self.updateContentViewHeight()
                        }else{
                        }
                        DispatchQueue.main.async {
                            self.view.layoutIfNeeded()
                            view.reloadData()
                        }
                    }
                }
            })
        }
    }
    //MARK: UICollectionView Delegate and DataSource for TopNavigation
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.roleId != 2 ? actionsForMember.count : actionsForOnwer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView ==  topNavigation{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_NAVIGATIONCV, for: indexPath) as! NavigationCVCell
        
        cell.data = user?.roleId != 2 ? actionsForMember[indexPath.row] : actionsForOnwer[indexPath.row]
            cell.indexPath = indexPath
            return cell
//        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if user?.roleId == 2{
                let vc = CERoomVC()
                let mainVC = UIViewController()
                let nv = UINavigationController(rootViewController: mainVC)
                present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
            }else{
                let vc = (self.tabBarController?.viewControllers![1] as! UINavigationController)
                self.tabBarController?.selectedViewController = vc
                let allVC = vc.viewControllers.first as! AllVC
                allVC.segmentControl.selectedSegmentIndex = 0
                allVC.resetFilter(filterType: .room)
                allVC.loadRoomData(withNewFilterArgModel: true)
            }
        case 1:
            if user?.roleId == 2{
                let vc = CERoomVC()
                let mainVC = UIViewController()
                let nv = UINavigationController(rootViewController: mainVC)
                present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
            }else{
                let vc = (self.tabBarController?.viewControllers![1] as! UINavigationController)
                self.tabBarController?.selectedViewController = vc
                let allVC = vc.viewControllers.first as! AllVC
                allVC.segmentControl.selectedSegmentIndex = 1
                allVC.resetFilter(filterType: .roommmate)
                allVC.loadRoommateData(withNewFilterArgModel: true)
            }
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView ==  topNavigation{
        return user?.roleId != 2  ? CGSize(width: topNavigation.frame.width/4, height: Constants.HEIGHT_CELL_NAVIGATIONCV) : CGSize(width: topNavigation.frame.width/4, height: Constants.HEIGHT_CELL_NAVIGATIONCV)
//        }
    }
    //MARK: LocationSearchViewDelegate
    func locationSearchViewDelegate(locationSearchView view: LocationSearchView, onClickButtonLocation btnLocation: UIButton) {
        let alert = AlertController.showAlertList(withTitle: "LIST_CITY_TITLE".localized, andMessage: nil, alertStyle: .alert,alertType: .city, forViewController: self, data: cities?.map({ (city) -> String     in
            city.name!
        }), rhsButtonTitle: "DONE".localized)
        alert.delegate = self
    }
    //MARK: UIAlertControllerDelegate
    func alertControllerDelegate(alertController: AlertController,withAlertType type:AlertType, onCompleted indexs: [IndexPath]?) {
        guard let indexs = indexs else {
            return
        }
        if type == AlertType.city{
            guard let city = cities?[(indexs.first?.row)!]  else{
                return
            }
            guard let setting = DBManager.shared.getSetting() else{
                return
            }
            locationSearchView.location = city.name
            let newSetting = SettingModel()
            newSetting.id = setting.id
            newSetting.cityId = city.cityId
            newSetting.latitude = setting.latitude
            newSetting.longitude = setting.longitude
            _ = DBManager.shared.addSetting(setting: newSetting)
        }
    }
    //MARK: HorizontalRoomViewDelegate
    func horizontalRoomViewDelegate(horizontalRoomView view:HorizontalRoomView,collectionCell cell: RoomPostCVCell, onClickUIImageView imgvBookmark: UIImageView, atIndexPath indexPath: IndexPath?) {
        guard let row = indexPath?.row else{
            return
        }
        processBookmark(view: view.collectionView, model: suggestRooms[row], row: row){model in
            if model.isFavourite!{
                NotificationCenter.default.post(name: Constants.NOTIFICATION_ADD_BOOKMARK, object: model)
            }else{
                NotificationCenter.default.post(name: Constants.NOTIFICATION_REMOVE_BOOKMARK, object: model)
            }
            DispatchQueue.main.async {
                view.collectionView.reloadData()
            }
        }
    }
    
    
    func horizontalRoomViewDelegate(horizontalRoomView view:HorizontalRoomView,collectionCell cell: RoomPostCVCell, didSelectCellAt indexPath: IndexPath?) {
        let vc = PostDetailVC()
        vc.viewType = ViewType.roomPostDetailForFinder
        vc.room = suggestRooms[indexPath!.row]
        let mainVC = UIViewController()
        let nv = UINavigationController(rootViewController: mainVC)
        present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
    }
    
    func horizontalRoomViewDelegate(horizontalRoomView view:HorizontalRoomView,onClickButton button: UIButton) {
        let vc = ShowAllVC()
        vc.showAllVCType = .suggestRoom
        let mainVC = UIViewController()
        let nv = UINavigationController(rootViewController: mainVC)
        present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
    }
    //MARK: VerticalPostViewDelegate
    
    func verticalPostViewDelegate(verticalPostView view: VerticalPostView, collectionCell cell: UICollectionViewCell, didSelectCellAt indexPath: IndexPath?) {
        
        let vc = PostDetailVC()
        
        if view == newRoomView{
            vc.viewType = ViewType.roomPostDetailForFinder
            vc.room = newRooms[indexPath!.row]
        }else{
            vc.viewType = ViewType.roommatePostDetailForFinder
            vc.roommate = newRoommates[indexPath!.row]
        }
        let mainVC = UIViewController()
        let nv = UINavigationController(rootViewController: mainVC)
        present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
        
    }
    func verticalPostViewDelegate(verticalPostView view: VerticalPostView, collectionCell cell: UICollectionViewCell, onClickUIImageView: UIImageView, atIndexPath indexPath: IndexPath?) {
        guard let row = indexPath?.row else{
            return
        }
        if view == newRoomView{
            processBookmark(view: view.collectionView, model: newRooms[row], row: row){model in
                if model.isFavourite!{
                    NotificationCenter.default.post(name: Constants.NOTIFICATION_ADD_BOOKMARK, object: model)
                }else{
                    NotificationCenter.default.post(name: Constants.NOTIFICATION_REMOVE_BOOKMARK, object: model)
                }
                DispatchQueue.main.async {
                    view.collectionView.reloadData()
                }
            }
        }else{
            processBookmark(view: view.collectionView, model: newRoommates[row], row: row){model in
                if model.isFavourite!{
                    NotificationCenter.default.post(name: Constants.NOTIFICATION_ADD_BOOKMARK, object: model)
                }else{
                    NotificationCenter.default.post(name: Constants.NOTIFICATION_REMOVE_BOOKMARK, object: model)
                }
                DispatchQueue.main.async {
                    view.collectionView.reloadData()
                }
            }
        }
    }

    func verticalPostViewDelegate(verticalPostView view: VerticalPostView, onClickButton button: UIButton) {
        
        if view == newRoomView{
            let vc = (self.tabBarController?.viewControllers![1] as! UINavigationController)
            self.tabBarController?.selectedViewController = vc
            let allVC = vc.viewControllers.first as! AllVC
            allVC.segmentControl.selectedSegmentIndex = 0
            allVC.resetFilter(filterType: .room)
            allVC.rooms = []
            allVC.loadRoomData(withNewFilterArgModel: true)
        }else{
            let vc = (self.tabBarController?.viewControllers![1] as! UINavigationController)
            self.tabBarController?.selectedViewController = vc
            let allVC = vc.viewControllers.first as! AllVC
            allVC.segmentControl.selectedSegmentIndex = 1
            allVC.resetFilter(filterType: .roommmate)
            allVC.roommates = []
            allVC.loadRoommateData(withNewFilterArgModel: true)
        }
        
    }
    
    //MARK: Location
    func enableLocationServices() {
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            print("App get notDetermined location service")
        case .restricted, .denied:
            // Disable location features
            print("App get restricted,denied location service")
//            disableMyLocationBasedFeatures()
            
        case .authorizedWhenInUse:
            // Enable basic location features
            print("App get authorizedWhenInUse location service")
            locationManager.startUpdatingLocation()
//            enableMyWhenInUseFeatures()
        case .authorizedAlways:
            // Enable any of your app's location features
            print("App get authorizedAlways location service")
//            enableMyAlwaysFeatures()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let setting = DBManager.shared.getSetting() else{
            return
        }
        guard let location = locations.last else {
            return
        }
//        print("Update Location")
//        print("Latitude-\(location.coordinate.latitude)")
//        print("Longitude-\(location.coordinate.longitude)")
        let newSetting = SettingModel()
        newSetting.id = setting.id
        newSetting.cityId = setting.cityId
        newSetting.latitude.value = location.coordinate.latitude
        newSetting.longitude.value = location.coordinate.longitude
        _ = DBManager.shared.addSetting(setting: newSetting)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .restricted, .denied:
                // Disable your app's location features
//                disableMyLocationBasedFeatures()
                print("App get restricted,denied location service")
                break
            
            case .authorizedWhenInUse:
                // Enable only your app's when-in-use features.
//                enableMyWhenInUseFeatures()
                locationManager.startUpdatingLocation()
                break
            
            case .authorizedAlways:
                // Enable any of your app's location services.
//                enableMyAlwaysFeatures()
                break
            
            case .notDetermined:
                break
        }
    }
    
    //MARK: update constraint
    func updateContentViewHeight(){
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        if user?.roleId == Constants.ROOMOWNER{
            self.contentViewHeightConstraint?.constant = self.newRoomViewHeightConstraint!.constant + self.newRoommateViewHeightConstraint!.constant + Constants.HEIGHT_TOP_CONTAINER_VIEW +  Constants.HEIGHT_MEDIUM_SPACE
        }else{
            self.contentViewHeightConstraint?.constant = self.suggestRoomViewHeightConstraint!.constant + self.newRoomViewHeightConstraint!.constant + self.newRoommateViewHeightConstraint!.constant + Constants.HEIGHT_TOP_CONTAINER_VIEW + Constants.HEIGHT_MEDIUM_SPACE
        }
        
    }
}
