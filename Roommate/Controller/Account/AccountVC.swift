//
//  AccountVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import MBProgressHUD
class AccountVC:BaseVC,VerticalPostViewDelegate,UIScrollViewDelegate{
    
    lazy var scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    lazy var contentView:UIView = {
        let v = UIView()
        //        v.backgroundColor = .red
        return v
    }()
    
    lazy var topContainerView:UIView = {
        let v = UIView()
        //        v.backgroundColor = .blue
        return v
    }()
    lazy var bottomContainerView:UIView = {
        let v = UIView()
        //        v.backgroundColor = .blue
        return v
    }()
    
    lazy var horizontalImagesView:HorizontalImagesView = {
        let hv:HorizontalImagesView = .fromNib()
        hv.removePageControl()
        return hv
    }()
    lazy var verticalRoomView:VerticalPostView = {
        let vv:VerticalPostView = .fromNib()
        vv.verticalPostViewType = .roomOwner
        return vv
    }()
    lazy var btnSetting:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "setting"), for: .normal)
        return btn
    }()
    var contentViewHeightConstraint:NSLayoutConstraint?
    var topContainerViewHeight:CGFloat?
    var bottomContainerViewHeightConstraint:NSLayoutConstraint?
    var verticalRoomViewHeightConstraint:NSLayoutConstraint?
    var rooms:[RoomResponseModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegateAndDataSource()
        loadRemoteData()
        registerNotification()
    }
    
    func setupUI(){
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(named: "filter"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(onClickBtnSetting))
        navigationItem.rightBarButtonItem?.tintColor = .defaultBlue
        
        if #available(iOS 11.0, *) {
            self.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        let verticalRoomViewHeight:CGFloat = Constants.HEIGHT_DEFAULT_BEFORE_LOAD_DATA
        topContainerViewHeight = Constants.HEIGHT_CELL_IMAGECV
        let bottomContainerViewHeight:CGFloat = verticalRoomViewHeight
        let totalContentViewHeight:CGFloat = topContainerViewHeight! + bottomContainerViewHeight
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topContainerView)
        topContainerView.addSubview(horizontalImagesView)
        topContainerView.addSubview(btnSetting)
        contentView.addSubview(bottomContainerView)
        bottomContainerView.addSubview(verticalRoomView)
        if #available(iOS 11.0, *) {
            _ = scrollView.anchor(view.safeAreaLayoutGuide.topAnchor, view.leftAnchor, view.safeAreaLayoutGuide.bottomAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10))
        } else {
            // Fallback on earlier versions
            _ = scrollView.anchor(topLayoutGuide.bottomAnchor, view.leftAnchor, bottomLayoutGuide.topAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10))
        }
        
        _ = contentView.anchor(scrollView.topAnchor, scrollView.leftAnchor, scrollView.bottomAnchor, scrollView.rightAnchor)
        _ = contentView.anchorWidth(equalTo: scrollView.widthAnchor)
        contentViewHeightConstraint = contentView.anchorHeight(equalToConstrant:totalContentViewHeight)
        
        _ = topContainerView.anchor(contentView.topAnchor, contentView.leftAnchor, nil, contentView.rightAnchor,.zero,CGSize(width: 0, height: topContainerViewHeight!))
        bottomContainerViewHeightConstraint = bottomContainerView.anchor(topContainerView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor,.zero,CGSize(width: 0, height: bottomContainerViewHeight))[3]
        
        _ = horizontalImagesView.anchor(topContainerView.topAnchor, topContainerView.leftAnchor, topContainerView.bottomAnchor, topContainerView.rightAnchor)
        _ = btnSetting.anchor(topContainerView.topAnchor, nil, nil, topContainerView.rightAnchor,UIEdgeInsets(top: Constants.MARGIN_10, left: 0, bottom: 0, right: -Constants.MARGIN_10),CGSize(width: 24, height: 24))
        
        verticalRoomViewHeightConstraint = verticalRoomView.anchor(bottomContainerView.topAnchor, bottomContainerView.leftAnchor, nil, bottomContainerView.rightAnchor,.zero,CGSize(width: 0, height: verticalRoomViewHeight))[3]
        
        verticalRoomView.hidebtnViewAllButton()
        
    }
    func setupDelegateAndDataSource(){
        scrollView.delegate = self
        horizontalImagesView.images = [DBManager.shared.getUser()!.imageProfile!]
        verticalRoomView.delegate = self
        btnSetting.addTarget(self, action: #selector(onClickBtnSetting), for: .touchUpInside)
    }
    
    func registerNotification(){
        NotificationCenter.default.addObserver(self, selector:#selector(didReceiveRemoveRoomNotification(_:)), name: Constants.NOTIFICATION_REMOVE_ROOM, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(didReceiveEditRoomNotification(_:)), name: Constants.NOTIFICATION_EDIT_ROOM, object: nil)
    }
    //MARK: Notification
    @objc func didReceiveRemoveRoomNotification(_ notification:Notification){
        rooms.removeAll()
        loadRemoteData()
//        if notification.object is RoomResponseModel{
//            guard let room = notification.object as? RoomResponseModel,let index = rooms.index(of: room) else{
//                return
//            }
//            rooms.removeAll()
//            loadRemoteData()
////            rooms.remove(at: index)
////            self.verticalRoomView.roomsOwner = rooms
////            updateUI()
//        }
    }
    
    @objc func didReceiveEditRoomNotification(_ notification:Notification){
        if notification.object is RoomResponseModel{
            guard let room = notification.object as? RoomResponseModel,let index = rooms.index(of: room) else{
                return
            }
            rooms[index] = room
            verticalRoomView.roomsOwner  = rooms
        }
    }
    
    //MARK: Load Remote Data
    
    func loadRemoteData(){
        let hub = MBProgressHUD.showAdded(to: self.verticalRoomView.collectionView, animated: true)
        hub.mode = .indeterminate
        hub.bezelView.backgroundColor = .white
        hub.contentColor = .defaultBlue
        requestRoom(hub:hub,view: verticalRoomView.collectionView, apiRouter: APIRouter.getRoomsByUserId(userId: DBManager.shared.getUser()!.userId, page: 1, size: 12))
    }
    func  requestRoom(hub:MBProgressHUD,view:UICollectionView,apiRouter:APIRouter){
        //        roomFilter.searchRequestModel = nil
        
        DispatchQueue.global(qos: .background).async {
            self.requestArray(apiRouter:apiRouter,
                              errorNetworkConnectedHander: {
                                DispatchQueue.main.async {
                                    MBProgressHUD.hide(for: self.view, animated: true)
                                    self.updateUIForNoData()
                                    APIResponseAlert.defaultAPIResponseError(controller: self, error: .HTTP_ERROR)
                                    self.showErrorView(inView: view, withTitle: "NETWORK_STATUS_CONNECTED_ERROR_MESSAGE".localized, onCompleted: { () -> (Void) in
                                        hub.show(animated: true)
                                        self.requestRoom(hub:hub,view:view, apiRouter: apiRouter)
                                    })
                                }
                                
            }, returnType:RoomResponseModel.self, completion: { (values, error, statusCode) -> (Void) in
                DispatchQueue.main.async {
                    hub.hide(animated: true)
                }
                //404, cant parse
                if error != nil{
                    DispatchQueue.main.async {
                        self.updateUIForNoData()
                        self.showErrorView(inView: view, withTitle: "NETWORK_STATUS_PARSE_RESPONSE_FAIL_MESSAGE".localized, onCompleted: { () -> (Void) in
                            self.requestRoom(hub:hub,view:view, apiRouter: apiRouter)
                        })
                    }
                }else{
                    //200
                    if statusCode == .OK{
                        guard let values = values else{
                            return
                        }
                        if values.count == 0{
                            DispatchQueue.main.async {
                                self.updateUI()
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.rooms = values
                                self.verticalRoomView.roomsOwner = self.rooms
                                self.updateUI()
                            }
                            
                        }
                        
                        DispatchQueue.main.async {
                            view.reloadData()
                        }
                    }
                }
            })
        }
    }
    //MARK: UIScrollviewDelegate
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        print("OFFSET:\(scrollView.contentOffset.y)")
        print("ContentframeHeight:\(scrollView.frame.height)")
        print("ContentContentHeight:\(scrollView.contentSize.height)")
        print("Refresh Data:\(offset < -Constants.MAX_Y_OFFSET)")
        print("Load more data:\((offset - contentHeight + scrollView.frame.height) > Constants.MAX_Y_OFFSET)")
        if offset < -Constants.MAX_Y_OFFSET {
            let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
            rooms.removeAll()
            requestRoom(hub:hub,view: verticalRoomView.collectionView, apiRouter: APIRouter.getRoomsByUserId(userId: DBManager.shared.getUser()!.userId, page: 1, size: 12))
        }
    }
    //MARK: VerticalPostViewDelegate
    func verticalPostViewDelegate(verticalPostView view:VerticalPostView,collectionCell cell: UICollectionViewCell, didSelectCellAt indexPath: IndexPath?){
        let vc = RoomDetailVC()
        vc.viewType = .detailForOwner
        vc.room = rooms[indexPath!.row]
        let mainVC = UIViewController()
        let nv = UINavigationController(rootViewController: mainVC)
        present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
    }
    func verticalPostViewDelegate(verticalPostView view:VerticalPostView,onClickButton button:UIButton){
        
    }
    //MARK: Button Event
    @objc func onClickBtnSetting(){
        
    }
    //MARK: Other
    func updateUI(){
        if rooms.count != 0{
            self.hideNoDataView(inView: self.verticalRoomView.collectionView)
            self.updateUIForExistedData()
        }else{
            self.showNoDataView(inView:self.verticalRoomView.collectionView, withTitle: "NO_OWNER_ROOM".localized)
            self.updateUIForNoData()
        }
    }
    func updateUIForExistedData(){
        self.verticalRoomViewHeightConstraint?.constant = Constants.HEIGHT_CELL_ROOMFOROWNERCV*CGFloat(rooms.count) + 80.0
        self.bottomContainerViewHeightConstraint?.constant = self.verticalRoomViewHeightConstraint!.constant
        self.contentViewHeightConstraint?.constant = self.bottomContainerViewHeightConstraint!.constant + self.topContainerViewHeight!
        self.verticalRoomView.showbtnViewAllButton()
        self.view.layoutIfNeeded()
    }
    func updateUIForNoData(){
        self.verticalRoomViewHeightConstraint?.constant = Constants.HEIGHT_DEFAULT_BEFORE_LOAD_DATA
        self.bottomContainerViewHeightConstraint?.constant = self.verticalRoomViewHeightConstraint!.constant
        self.contentViewHeightConstraint?.constant = self.bottomContainerViewHeightConstraint!.constant + self.topContainerViewHeight!
        self.verticalRoomView.hidebtnViewAllButton()
        self.view.layoutIfNeeded()
    }
}
