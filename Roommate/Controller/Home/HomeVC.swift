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
class HomeVC:BaseVC,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
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
    
    var horizontalRoomView:HorizontalRoomView = {
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
    var suggestRooms:[RoomPostResponseModel] = []
    var newRooms:[RoomPostResponseModel] = []
    var newRoommates:[RoommatePostResponseModel] = []
    var city:CityModel?
    var filterForRoomPost = FilterArgumentModel()
    var filterForRoommatePost = FilterArgumentModel()
    var actions:[[String]] = [
        ["Tìm phòng ở ghép","find-room"],
        ["Tìm bạn ở ghép","find-roommate"],
        ["Đăng tìm phòng ở ghép","add-roommate"],
        ["Đăng tìm bạn ở ghép","add-room"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegateAndDataSource()
        loadRemoteData()
    }
    
    func setupUI(){
        view.backgroundColor  = .white
        let newRoomViewHeight = 80 + Constants.HEIGHT_CELL_NEWROOMCV * Constants.MAX_ROOM_ROW.toDouble + Constants.HEIGHT_MEDIUM_SPACE
        let newRoommmateViewHeight = 80 + Constants.HEIGHT_CELL_NEWROOMMATECV * Constants.MAX_POST.toDouble + Constants.HEIGHT_MEDIUM_SPACE
        let totalContentViewHeight = newRoomViewHeight + newRoommmateViewHeight + Constants.HEIGHT_TOP_CONTAINER_VIEW + Constants.HEIGHT_HORIZONTAL_ROOM_VIEW
        
        print(newRoomViewHeight)
        print(newRoommmateViewHeight)
        print(totalContentViewHeight)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topContainerView)
        contentView.addSubview(bottomContainerView)
        topContainerView.addSubview(locationSearchView)
        topContainerView.addSubview(topNavigation)
        bottomContainerView.addSubview(horizontalRoomView)
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
        _ = contentView.anchorHeight(equalToConstrant: totalContentViewHeight.cgFloat)
        
        _ = topContainerView.anchor(contentView.topAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, .zero, CGSize(width: 0, height: Constants.HEIGHT_TOP_CONTAINER_VIEW))
        _ = locationSearchView.anchor(topContainerView.topAnchor, topContainerView.leftAnchor, nil, topContainerView.rightAnchor, UIEdgeInsets(top: Constants.MARGIN_10, left: Constants.MARGIN_20, bottom: 0, right: -Constants.MARGIN_20), CGSize(width: 0, height: Constants.HEIGHT_LOCATION_SEARCH_VIEW))
        
        
        _ = topNavigation.anchor(locationSearchView.bottomAnchor, topContainerView.leftAnchor, topContainerView.bottomAnchor, topContainerView.rightAnchor,UIEdgeInsets(top: Constants.MARGIN_10, left: 0, bottom: 0, right: 0))
        
        topNavigation.backgroundColor = UIColor(hexString: "f7f7f7")
        topContainerView.layer.borderWidth  = 1
        topContainerView.layer.borderColor  = UIColor.lightGray.cgColor
        topContainerView.layer.cornerRadius = 15
        topContainerView.clipsToBounds = true
        
        _ = bottomContainerView.anchor(topContainerView.bottomAnchor, contentView.leftAnchor, contentView.bottomAnchor, contentView.rightAnchor)
        
        _ = horizontalRoomView.anchor(bottomContainerView.topAnchor, bottomContainerView.leftAnchor, nil, bottomContainerView.rightAnchor,.zero,CGSize(width: 0, height: Constants.HEIGHT_HORIZONTAL_ROOM_VIEW))
        _ = newRoomView.anchor(horizontalRoomView.bottomAnchor, bottomContainerView.leftAnchor, nil, bottomContainerView.rightAnchor,.zero,CGSize(width: 0, height: newRoomViewHeight))
        _ = newRoommateView.anchor(newRoomView.bottomAnchor, bottomContainerView.leftAnchor, nil, bottomContainerView.rightAnchor,.zero,CGSize(width: 0, height: newRoommmateViewHeight))
        
        
        
        
    }
    func setupDelegateAndDataSource(){
        //        horizontalRoomView.collectionView
        topNavigation.dataSource = self
        topNavigation.delegate = self
        topNavigation.register(UINib(nibName: Constants.CELL_NAVIGATIONCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_NAVIGATIONCV)
    }
    func loadRemoteData(){
        filterForRoomPost.searchRequestModel = nil
        filterForRoomPost.cityId.value = 45
        filterForRoomPost.orderBy.value = 1
        filterForRoomPost.page.value = 1
        filterForRoomPost.typeId.value = 1
        filterForRoomPost.userId.value = DBManager.shared.getUser()?.userId
        
        filterForRoommatePost.searchRequestModel = nil
        filterForRoommatePost.cityId.value = 45
        filterForRoommatePost.orderBy.value = 1
        filterForRoommatePost.page.value = 1
        filterForRoommatePost.typeId.value = 2
        filterForRoommatePost.userId.value = DBManager.shared.getUser()?.userId
        
        if !APIConnection.isConnectedInternet(){
            showErrorView(inView: self.bottomContainerView, withTitle: "NETWORK_STATUS_CONNECTED_REQUEST_ERROR_MESSAGE".localized) {
                self.checkAndLoadInitData(inView: self.bottomContainerView) { () -> (Void) in
                    self.requestRoom(view: self.horizontalRoomView.collectionView, apiRouter: APIRouter.suggestBestMatch(model: self.filterForRoomPost), offset:Constants.MAX_ROOM_ROW)
                    self.requestRoom(view: self.newRoomView.collectionView,  apiRouter: APIRouter.postForAll(model: self.filterForRoomPost), offset:Constants.MAX_POST)
                    self.requestRoommate(view: self.newRoommateView.collectionView, apiRouter: APIRouter.postForAll(model: self.filterForRoommatePost), offset:Constants.MAX_POST)
                }
            }
        }else{
            self.checkAndLoadInitData(inView: self.bottomContainerView) { () -> (Void) in
                self.requestRoom(view: self.horizontalRoomView.collectionView, apiRouter: APIRouter.suggestBestMatch(model: self.filterForRoomPost), offset:Constants.MAX_ROOM_ROW)
                self.requestRoom(view: self.newRoomView.collectionView,  apiRouter: APIRouter.postForAll(model: self.filterForRoomPost), offset:Constants.MAX_POST)
                self.requestRoommate(view: self.newRoommateView.collectionView, apiRouter: APIRouter.postForAll(model: self.filterForRoommatePost), offset:Constants.MAX_POST)
            }
        }
        
        
        
        
        
    }
    
    
    func  requestRoom<T:UICollectionView>(view:T,apiRouter:APIRouter,offset:Int){
        //        roomFilter.searchRequestModel = nil
        filterForRoomPost.offset.value = offset
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
                        if view == self.horizontalRoomView.collectionView{
                            self.suggestRooms.removeAll()
                            self.suggestRooms.append(contentsOf: values)
                            self.horizontalRoomView.rooms = self.suggestRooms
                        }else if view == self.newRoomView.collectionView{
                            self.newRooms.removeAll()
                            self.newRooms.append(contentsOf: values)
                            self.newRoomView.rooms = self.newRooms
                        }
                        DispatchQueue.main.async {
                            view.reloadData()
                        }
                    }
                }
            })
        }
    }
    
    func  requestRoommate<T:UICollectionView>(view:T,apiRouter:APIRouter,offset:Int){
        //        roomFilter.searchRequestModel = nil
        filterForRoommatePost.offset.value = offset
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
                        }else{
                        }
                        DispatchQueue.main.async {
                            view.reloadData()
                        }
                    }
                }
            })
        }
    }
    //MARK: UICollectionView Delegate and DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView ==  topNavigation{
            return actions.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView ==  topNavigation{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_NAVIGATIONCV, for: indexPath) as! NavigationCVCell
            cell.data = actions[indexPath.row]
            cell.indexPath = indexPath
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_NAVIGATIONCV, for: indexPath) as! NavigationCVCell
            cell.data = actions[indexPath.row]
            cell.indexPath = indexPath
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView ==  topNavigation{
            return CGSize(width: topNavigation.frame.width/4, height: 100)
        }else{
            return CGSize(width: topNavigation.frame.width/4, height: 100)
        }
    }
}
