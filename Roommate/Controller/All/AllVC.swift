//
//  AllVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
class AllVC:BaseVC,UICollectionViewDataSource,
    UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,
    UITableViewDataSource,UITableViewDelegate,
NewRoomCVCellDelegate,NewRoommateCVCellDelegate,FilterVCDelegate{
    
    
    
    //MARK: Data for UICollectionView And UITableView
    var roommates:[RoommatePostResponseModel] = []
    var rooms:[RoomPostResponseModel] = []
    var roomFilter:FilterArgumentModel = {
        let filter = FilterArgumentModel()
        filter.cityId = DBManager.shared.getSetting()?.cityId
        return filter
    }()
    var roommateFilter:FilterArgumentModel = {
        let filter = FilterArgumentModel()
        filter.typeId = 2
        filter.cityId = DBManager.shared.getSetting()?.cityId
        return filter
    }()
//    var isLoadingData = false
    let orders = [
        OrderType.newest:"NEWEST",
        OrderType.lowToHightPrice:"LOW_TO_HIGH_PRICE",
        OrderType.hightToLowPrice:"HIGH_TO_LOW_PRICE"
    ]
    var allVCType:AllVCType = .all
    var apiRouter:APIRouter!
    //MARK: Components for Nav
    lazy var segmentControl:UISegmentedControl={
        let sg = UISegmentedControl(items: ["SEGMENTED_CONTROL_ROOM".localized,"SEGMENTED_CONTROL_ROOMMATE".localized])
        sg.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        sg.selectedSegmentIndex = 0
        sg.tintColor = UIColor(hexString: "00A8B5")
        return sg
    }()
    
    var filterItem : UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.done, target: self, action: nil)
        return item
    }()
    
    //MARK: Components for  Orderby
    lazy var lblOrderBy:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize:.small)
        lbl.textAlignment = .right
        //        lbl.backgroundColor = .red
        lbl.text = "ORDER_TITLE".localized
        return lbl
    }()
    
    lazy var  lblSelectTitle:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightSubTitle
        lbl.font = .small
        lbl.textAlignment = .left
        lbl.text = orders[selectedOrder]?.localized
        lbl.textColor = .defaultBlue
        lbl.font = UIFont.boldSystemFont(ofSize: .verySmall)
        return lbl
    }()
    
    let imageView:UIImageView = {
        let imgv = UIImageView(image: UIImage(named: "down-arrow"))
        imgv.tintColor = .defaultBlue
        return imgv
    }()
    
    lazy var btnOrderBy:UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.showsVerticalScrollIndicator = false
        tv.layer.cornerRadius = 5
        tv.clipsToBounds = true
        return tv
    }()
    
    
    var selectedOrder = OrderType.newest//default
    var tableHeightLayoutConstraint : NSLayoutConstraint?
    
    
    //MARK: Components for UICollectionView
    lazy var collectionView:UICollectionView = {
        let cv = BaseVerticalCollectionView()
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    lazy var bottomView:UIView = {
        let v = UIView()
        return v
    }()
    
    //MARK: Viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDataAndDelegate()
        loadRoomData(withNewFilterArgModel: true)
        registerNotification()
    }
    
    //MARK: Setup UI
    func setupUI(){
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height;
        let adjustForTabbarInsets = UIEdgeInsets(top: 0,left: 0,bottom: tabBarHeight!,right: 0)
        navigationController?.navigationBar.backgroundColor = .white
        
        
        //UI for navigation bar
        navigationItem.titleView = segmentControl
        
        let btnFilter = UIButton(type: .system)
        btnFilter.setImage(UIImage(named: "filter"), for: .normal)
        btnFilter.tintColor = UIColor(hexString: "00A8B5")
        btnFilter.contentVerticalAlignment = .fill
        btnFilter.contentHorizontalAlignment = .fill
        btnFilter.addTarget(self, action: #selector(onClickBtnFilter), for: .touchUpInside)
        btnFilter.imageView?.contentMode = .scaleAspectFill
        
        let btniFilter = UIBarButtonItem(customView: btnFilter)
        btnFilter.translatesAutoresizingMaskIntoConstraints = false
        let width = btniFilter.customView?.widthAnchor.constraint(equalToConstant: (navigationItem.titleView?.frame.height)!)
        width?.isActive = true
        let height = btniFilter.customView?.heightAnchor.constraint(equalToConstant: (navigationItem.titleView?.frame.height)!)
        height?.isActive = true
        navigationItem.rightBarButtonItem = btniFilter
        
        //Declare view
        let orderByView = UIView()
        
        //Add View
        view.addSubview(orderByView)
        view.addSubview(bottomView)
        view.addSubview(tableView)
        orderByView.addSubview(btnOrderBy)
        orderByView.addSubview(lblOrderBy)
        btnOrderBy.addSubview(imageView)
        btnOrderBy.addSubview(lblSelectTitle)
        bottomView.addSubview(collectionView)
        
        
        //Calculate constraint constant
        let orderByViewHeight = CGFloat(30.0)
        let orderByViewWidth = view.frame.width-Constants.MARGIN_5*4
        
        //Add Constraint
        _ = orderByView.anchor(view.topAnchor, view.leftAnchor, nil, nil, UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0), CGSize(width: orderByViewWidth, height: orderByViewHeight))
        if #available(iOS 11.0, *) {
            print(view.safeAreaLayoutGuide.topAnchor)
        } else {
            // Fallback on earlier versions
        }
        _ =  btnOrderBy.anchorTopRight(orderByView.topAnchor, orderByView.rightAnchor, 150.0, orderByViewHeight)
        _ = lblOrderBy.anchorTopRight(orderByView.topAnchor, btnOrderBy.leftAnchor, orderByViewWidth-150.0, orderByViewHeight)
        _ = imageView.anchor(btnOrderBy.topAnchor,nil,btnOrderBy.bottomAnchor,btnOrderBy.rightAnchor,UIEdgeInsets(top: 10, left: 0, bottom: -10, right: -10))
        _ = imageView.anchorWidth(equalTo: btnOrderBy.heightAnchor, constant: -10)
        _ = lblSelectTitle.anchor(btnOrderBy.topAnchor,btnOrderBy.leftAnchor,btnOrderBy.bottomAnchor,imageView.leftAnchor,UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        
        //        bottomView.backgroundColor = .red
        //        collectionView.backgroundColor = .blue
        if #available(iOS 11.0, *) {
            _ = bottomView.anchor(orderByView.bottomAnchor, view.leftAnchor, view.safeAreaLayoutGuide.bottomAnchor, view.rightAnchor,UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: -2, right: -Constants.MARGIN_10))
        } else {
            // Fallback on earlier versions
            _ = bottomView.anchor(orderByView.bottomAnchor, view.leftAnchor, bottomLayoutGuide.topAnchor, view.rightAnchor,UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: -2, right: -Constants.MARGIN_10))
        }
        _ = collectionView.anchor(view: bottomView)
        
        view.bringSubview(toFront: tableView)
        tableHeightLayoutConstraint = tableView.anchorTopRight(orderByView.bottomAnchor, btnOrderBy.rightAnchor, 150.0, 1)[3]
        
    }
    
    func setupDataAndDelegate(){
        //Event for BtnOrderBy
        btnOrderBy.addTarget(self, action: #selector(onClickBtnOrder), for: .touchUpInside)
        
        
        //Register delegate , datasource & cell collectionview
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.CELL_NEWROOMMATECV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_NEWROOMMATECV)
        collectionView.register(UINib(nibName: Constants.CELL_NEWROOMCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_NEWROOMCV)
        
        //Register delegate , datasource & cell tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderTVCell.self, forCellReuseIdentifier: Constants.CELL_ORDERTV)
        
        
        //        if self.allVCType == .all{
        //            apiRouter = APIRouter.postForAll(model: roomFilter)
        //        }else if self.allVCType == .bookmark{
        //            //            filterArgModel =
        //            apiRouter = APIRouter.postForBookmark(model: roomFilter)
        //        }
        
    }
    
    func loadRoomData(withNewFilterArgModel:Bool){
        if !APIConnection.isConnectedInternet(){
            showErrorView(inView: self.bottomView, withTitle: "NETWORK_STATUS_CONNECTED_REQUEST_ERROR_MESSAGE".localized) {
                self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                    self.requestRoom(apiRouter:self.allVCType == .all ? APIRouter.postForAll(model: self.roomFilter) : APIRouter.postForBookmark(model: self.roomFilter),withNewFilterArgModel: withNewFilterArgModel)
                }
            }
        }else{
            self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                self.requestRoom(apiRouter: self.allVCType == .all ? APIRouter.postForAll(model: self.roomFilter) : APIRouter.postForBookmark(model: self.roomFilter), withNewFilterArgModel: withNewFilterArgModel)
            }
        }
    }
    func loadRoommateData(withNewFilterArgModel:Bool){
        if !APIConnection.isConnectedInternet(){
            showErrorView(inView: self.bottomView, withTitle: "NETWORK_STATUS_CONNECTED_REQUEST_ERROR_MESSAGE".localized) {
                self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                    self.requestRoommate(apiRouter: self.allVCType == .all ? APIRouter.postForAll(model: self.roommateFilter) : APIRouter.postForBookmark(model: self.roommateFilter),withNewFilterArgModel: withNewFilterArgModel)
                }
            }
        }else{
            self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                self.requestRoommate(apiRouter: self.allVCType == .all ? APIRouter.postForAll(model: self.roommateFilter) : APIRouter.postForBookmark(model: self.roommateFilter), withNewFilterArgModel: withNewFilterArgModel)
            }
        }
    }
    //    if self.allVCType == AllVCType.
    
    func  requestRoom(apiRouter:APIRouter,withNewFilterArgModel newFilterArgModel:Bool){
        DispatchQueue.main.async {
            let hub = MBProgressHUD.showAdded(to: self.bottomView, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
            //            hub.label.text = "MB_LOAD_DATA_TITLE".localized
            //            MBProgressHUD.showAdded(to: self.bottomView, animated: true)
        }
        DispatchQueue.global(qos: .background).async {
            self.requestArray(apiRouter:apiRouter, returnType: RoomPostResponseModel.self, completion: { (values, error, statusCode) -> (Void) in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.bottomView, animated: true)
                }
                //404, cant parse
                if error != nil{
                    DispatchQueue.main.async {
                        self.showErrorView(inView: self.bottomView, withTitle: "NETWORK_STATUS_PARSE_RESPONSE_FAIL_MESSAGE".localized, onCompleted: { () -> (Void) in
                            self.requestRoom(apiRouter:apiRouter,withNewFilterArgModel: newFilterArgModel)
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
                        if newFilterArgModel {
                            self.rooms.removeAll()
                        }
                        if values.count == 0, self.roomFilter.page! > 1{
                            self.roomFilter.page = self.roomFilter.page!-1
                        }
                        self.rooms.append(contentsOf: values)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
//                            self.isLoadingData = false
                        }
                    }
                }
            })
        }
    }
    func  requestRoommate(apiRouter:APIRouter,withNewFilterArgModel newFilterArgModel:Bool){
        DispatchQueue.main.async {
            let hub = MBProgressHUD.showAdded(to: self.bottomView, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
            //            hub.label.text = "MB_LOAD_DATA_TITLE".localized
            //            MBProgressHUD.showAdded(to: self.bottomView, animated: true)
        }
        DispatchQueue.global(qos: .background).async {
            self.requestArray(apiRouter:apiRouter, returnType: RoommatePostResponseModel.self, completion: { (values, error, statusCode) -> (Void) in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.bottomView, animated: true)
                }
                //404, cant parse
                if error != nil{
                    DispatchQueue.main.async {
                        self.showErrorView(inView: self.bottomView, withTitle: "NETWORK_STATUS_PARSE_RESPONSE_FAIL_MESSAGE".localized, onCompleted: { () -> (Void) in
                            self.requestRoommate(apiRouter:apiRouter,withNewFilterArgModel: newFilterArgModel)
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
                        if newFilterArgModel { self.roommates.removeAll()}
                        self.roommates.append(contentsOf: values)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
//                            self.isLoadingData = false
                        }
                    }
                }
            })
        }
    }
    //MARK: Notification
    func registerNotification(){
        NotificationCenter.default.addObserver(self, selector:#selector(didReceiveAddBookmarkNotification(_:)), name: Constants.NOTIFICATION_ADD_BOOKMARK, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(didReceiveRemoveBookmarkNotification(_:)), name: Constants.NOTIFICATION_REMOVE_BOOKMARK, object: nil)
    }
    @objc func didReceiveRemoveBookmarkNotification(_ notification:Notification) {
        if allVCType == .all{
            if notification.object is RoomPostResponseModel{
                if let room = notification.object as? RoomPostResponseModel{
                    if let index = rooms.index(of: room){
                        rooms[index].isFavourite = room.isFavourite
                        self.collectionView.reloadData()
                    }
                }
            }else{
                if let roommate = notification.object as? RoommatePostResponseModel{
                    if let index = roommates.index(of: roommate){
                        roommates[index].isFavourite = roommate.isFavourite
                        self.collectionView.reloadData()
                    }
                }
            }
        }else if allVCType == .bookmark{
            if notification.object is RoomPostResponseModel{
                if let room = notification.object as? RoomPostResponseModel{
                    if let index = rooms.index(of: room){
                        rooms.remove(at: index)
                    }
                }
                self.collectionView.reloadData()
            }else{
                if let roommate = notification.object as? RoommatePostResponseModel{
                    if let index = roommates.index(of: roommate){
                        roommates.remove(at: index)
                    }
                }
                self.collectionView.reloadData()
            }
        }
    }
    @objc func didReceiveAddBookmarkNotification(_ notification:Notification) {
        if allVCType == .all{
            if notification.object is RoomPostResponseModel{
                if let room = notification.object as? RoomPostResponseModel{
                    if let index = rooms.index(of: room){
                        rooms[index].isFavourite = room.isFavourite
                        rooms[index].favouriteId = room.favouriteId
                        self.collectionView.reloadData()
                    }
                }
            }else{
                if let roommate = notification.object as? RoommatePostResponseModel{
                    if let index = roommates.index(of: roommate){
                        roommates[index].isFavourite = roommate.isFavourite
                        roommates[index].favouriteId = roommate.favouriteId
                        self.collectionView.reloadData()
                    }
                }
            }
        }else{
            if notification.object is RoomPostResponseModel{
                if let room = notification.object as? RoomPostResponseModel{
                    if rooms.index(of: room) == nil{
                        rooms.append(room)
                        self.collectionView.reloadData()
                    }
                }
            }else{
                if let roommate = notification.object as? RoommatePostResponseModel{
                    if roommates.index(of: roommate) == nil{
                        roommates.append(roommate)
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    //MARK: UICollectionView DataSourse and Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0{
            return rooms.count
        }else{
            return roommates.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentControl.selectedSegmentIndex == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_NEWROOMCV, for: indexPath) as! NewRoomCVCell
            cell.delegate = self
            cell.room = rooms[indexPath.row]
            cell.indexPath = indexPath
//            let tap = UITapGestureRecognizer(target: self, action: #selector(onClickImgvBookmark))
//            
//            cell.imgvBookMark.imgvBookMark.addGestureRecognizer(tap)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_NEWROOMMATECV, for: indexPath) as! NewRoommateCVCell
            cell.delegate = self
            cell.roommate = roommates[indexPath.row]
            cell.indexPath = indexPath
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if segmentControl.selectedSegmentIndex == 0{
            let vc = PostDetailVC()
            vc.viewType = ViewType.roomPostDetailForFinder
            vc.room = rooms[indexPath.row]
            let mainVC = UIViewController()
            let nv = UINavigationController(rootViewController: mainVC)
            present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
            //            present(vc, animated: true, completion: nil)
        }else{
            let vc = PostDetailVC()
            vc.viewType = ViewType.roommatePostDetailForFinder
            vc.roommate = roommates[indexPath.row]
            let mainVC = UIViewController()
            let nv = UINavigationController(rootViewController: mainVC)
            present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if segmentControl.selectedSegmentIndex == 0{
            return CGSize(width: collectionView.frame.width/2-5, height: Constants.HEIGHT_CELL_NEWROOMCV)
        }else{
            return CGSize(width: collectionView.frame.width, height: Constants.HEIGHT_CELL_NEWROOMMATECV)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //dif row space
        return 2
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
//            isLoadingData = true
            print("Refresh data")
            if segmentControl.selectedSegmentIndex == 0{
                roomFilter.page = 1
                loadRoomData(withNewFilterArgModel: true)//for remove all  and reload data
            }else{
                roommateFilter.page = 1
                loadRoommateData(withNewFilterArgModel: true)//for remove all  and reload data
            }
            
            //Load more data
            //because offset = 0 when view loading ==> need to plus scrollView.frame.height
            //to equal contentHeight
        }else if (offset - contentHeight + scrollView.frame.height) > Constants.MAX_Y_OFFSET{
//            isLoadingData = true
            print("Loading more data")
            if segmentControl.selectedSegmentIndex == 0{
                roomFilter.page = rooms.count/15+2
                loadRoomData(withNewFilterArgModel: false)//for remove all  and reload data
            }else{
                roommateFilter.page = roommates.count/15+2
                loadRoommateData(withNewFilterArgModel: false)//for remove all  and reload data
            }
        }
    }
    
    //MARK: UITableView DataSourse and Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_ORDERTV, for: indexPath) as! OrderTVCell
        setCellValueBaseOnIndexPath(cell: cell,indexPath:indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        self.isTableVisible = true
        selectedOrder = OrderType(rawValue: indexPath.row)!
        lblSelectTitle.text = orders[selectedOrder]?.localized
        onClickBtnOrder()
        if segmentControl.selectedSegmentIndex == 0{
            roomFilter.orderBy = indexPath.row + 1
            roomFilter.page = 1
            loadRoomData(withNewFilterArgModel: true)
        }else{
            
            roommateFilter.orderBy = indexPath.row + 1
            roommateFilter.page = 1
            loadRoommateData(withNewFilterArgModel: true)
        }
        
        
    }
    
    
    
    //MARK: Others delegate method
    //For segmentControl selected index change
    @objc func segmentChanged() {
        if segmentControl.selectedSegmentIndex == 0{
            if rooms.count == 0{
                loadRoomData(withNewFilterArgModel: true)
            }else{
                self.collectionView.reloadData()
            }
        }else{
            if roommates.count == 0{
                loadRoommateData(withNewFilterArgModel: true)
            }else{
                self.collectionView.reloadData()
            }
        }
        
    }
    
    //Filter bar button item event
    @objc func onClickBtnFilter(){
        let vc = FilterVC()
        if segmentControl.selectedSegmentIndex == 0{
            vc.filterArgumentModel = roomFilter
        }else{
            vc.filterArgumentModel = roommateFilter
        }
        
        
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    //Order button item event
    @objc func onClickBtnOrder(){
        
        UIView.animate(withDuration: 0.1) {
            if self.tableHeightLayoutConstraint?.constant == 0 {
                self.tableHeightLayoutConstraint?.constant = 150
            }else{
                self.tableHeightLayoutConstraint?.constant = 0
            }
            //            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func newRoomCVCellDelegate(roomCVCell: NewRoomCVCell, onClickUIImageView imageView: UIImageView,atIndextPath indexPath:IndexPath?) {
        guard let row = indexPath?.row else{
            return
        }
//
//        let room = rooms[row]
//        if allVCType == .all{
//            room.isFavourite =  room.isFavourite! == true ? false : true
//        }else if allVCType == .bookmark{
//            room.isFavourite =  false//for api
//            rooms.remove(at: row)
//        }
//        collectionView.reloadData()
        processBookmark(view: self.collectionView, model: rooms[row], row: row){model in
            if self.allVCType == .all{
                if model.isFavourite!{
                    NotificationCenter.default.post(name: Constants.NOTIFICATION_ADD_BOOKMARK, object: model)
                }else{
                    NotificationCenter.default.post(name: Constants.NOTIFICATION_REMOVE_BOOKMARK, object: model)
                }
            }else if self.allVCType == .bookmark{
//                model.isFavourite =  false//for api
                self.rooms.remove(at: row)
                 NotificationCenter.default.post(name: Constants.NOTIFICATION_REMOVE_BOOKMARK, object: model)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //    func roommateCVCellDelegate(roommateCVCell cell: RoommateCVCell, onClickUIImageView imgvBookmark: UIImageView, atIndextPath indexPath: IndexPath?) {
    //        guard let row = indexPath?.row else{
    //            return
    //        }
    //
    //        let roommate = roommates[row]

    //        collectionView.reloadData()
    //    }
    func newRoommateCVCellDelegate(newRoommateCVCell cell: NewRoommateCVCell, onClickUIImageView imgvBookmark: UIImageView, atIndextPath indexPath: IndexPath?) {
                guard let row = indexPath?.row else{
                    return
                }
        processBookmark(view: self.collectionView, model: roommates[row], row: row){model in
            if self.allVCType == .all{
                if model.isFavourite!{
                    NotificationCenter.default.post(name: Constants.NOTIFICATION_ADD_BOOKMARK, object: model)
                }else{
                    NotificationCenter.default.post(name: Constants.NOTIFICATION_REMOVE_BOOKMARK, object: model)
                }
            }else if self.allVCType == .bookmark{
                model.isFavourite =  false//for api
                self.roommates.remove(at: row)
                NotificationCenter.default.post(name: Constants.NOTIFICATION_REMOVE_BOOKMARK, object: model)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

//
//        cell.imgvLeftAvatar.isUserInteractionEnabled = false
//        let roommate = roommates[row]
//        let model = BookmarkRequestModel()
//        model.postId = roommate.postId!
//        model.userId = DBManager.shared.getUser()!.userId
//
//        let apiRouter = roommate.isFavourite == true ? APIRouter.removeBookmark(favoriteId: roommate.favouriteId!) : APIRouter.createBookmark(model: model)
//        APIConnection.requestObject(apiRouter: apiRouter, errorNetworkConnectedHander: {
//            APIResponseAlert.defaultAPIResponseError(controller: self, error: .HTTP_ERROR)
//        }, returnType: CreateResponseModel.self){ (value,error, statusCode) -> (Void) in
//            if error == .SERVER_NOT_RESPONSE{
//                APIResponseAlert.defaultAPIResponseError(controller: self, error: .SERVER_NOT_RESPONSE)
//            }else{
//                if statusCode == .OK{
//                    if let value = value{
//                        roommate.favouriteId = value.id
//                    }
//                    if self.allVCType == .all{
//                        roommate.isFavourite = roommate.isFavourite == true ? false : true
//                    }else if self.allVCType == .bookmark{
//                        roommate.isFavourite =  false
//                        self.roommates.remove(at: row)
//                    }
//                    DispatchQueue.main.async {
//                        cell.imgvLeftAvatar.isUserInteractionEnabled = true
//                        self.collectionView.reloadData()
//                    }
//                }else{
//                    APIResponseAlert.defaultAPIResponseError(controller: self, error: .PARSE_RESPONSE_FAIL)
//                }
//            }
//        }
//
        
        
    }
    //MARK: FilterVCDelegate
    
    func filterVCDelegate(filterVC: FilterVC, onCompletedWithFilter filter: FilterArgumentModel) {
//        print(filter.page)
//        print(filter.offset)
//        print(filter.userId)
//        print(filter.typeId)
//        print("Districts")
//        filter.searchRequestModel?.districts?.forEach({ (id) in
//            print(id)
//        })
//        print("Utilities")
//        filter.searchRequestModel?.utilities?.forEach({ (id) in
//            print(id)
//        })
//        print("Price")
//        filter.searchRequestModel?.price?.forEach({ (price) in
//            print(price)
//        })
//        print("Gender")
        print(filter.searchRequestModel?.gender)
        
        if segmentControl.selectedSegmentIndex == 0{
            self.roomFilter = filter
            loadRoomData(withNewFilterArgModel: true)
        }else{
            self.roommateFilter = filter
            loadRoommateData(withNewFilterArgModel: true)
        }
    }
    
    //MARK: Others custom method
    func setCellValueBaseOnIndexPath(cell:OrderTVCell,indexPath:IndexPath){
        if indexPath.row == OrderType.newest.rawValue{
            cell.setOrderTitle(title: orders[OrderType.newest]!, orderType: OrderType.newest)
        }else if indexPath.row == OrderType.lowToHightPrice.rawValue{
            cell.setOrderTitle(title: orders[OrderType.lowToHightPrice]!, orderType: OrderType.lowToHightPrice)
        }else if  indexPath.row == OrderType.hightToLowPrice.rawValue{
            cell.setOrderTitle(title: orders[OrderType.hightToLowPrice]!, orderType: OrderType.hightToLowPrice)
        }else{
            //for future order type
        }
    }
    
    override func resetFilter(filterType:FilterType) {
        self.collectionView.reloadData()
        selectedOrder = .newest
        lblSelectTitle.text = orders[selectedOrder]?.localized
        if filterType == .room{
            roomFilter.searchRequestModel = nil
            roomFilter.page = 1
            roomFilter.orderBy = 1
        }else{
            roommateFilter.searchRequestModel = nil
            roommateFilter.page = 1
            roommateFilter.orderBy = 1
        }
    }
    
    
}
