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
    var roomFilter:FilterArgumentModel = FilterArgumentModel()
    var roommateFilter:FilterArgumentModel = FilterArgumentModel()
    
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
        return BaseVerticalCollectionView()
    }()
    lazy var bottomView:UIView = {
        let v = UIView()
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDataAndDelegate()
        
    }
    
    //MARK: Setup UI
    func setupUI(){
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        //        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height;
        //        let navigationBarHeight = navigationController?.navigationBar.frame.size.height;
        let tabBarHeight = self.tabBarController?.tabBar.frame.size.height;
        let adjustForTabbarInsets = UIEdgeInsets(top: 0,left: 0,bottom: tabBarHeight!,right: 0)
        navigationController?.navigationBar.backgroundColor = .white
        //For tabbar
        tabBarItem = UITabBarItem(title: allVCType == .all ? "ALL_VC".localized : "BOOKMARK_VC".localized, image: UIImage(named: "icons8-home-page-51")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icons8-home-page-50"))
        
        
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
        
        view.layoutIfNeeded()
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
        roomFilter.searchRequestModel = nil
        roomFilter.userId.value = DBManager.shared.getUser()!.userId//DBManager.shared.getUser()?.userId
        roomFilter.typeId.value = 1
        roomFilter.page.value = 1
        roomFilter.offset.value = 15
        roomFilter.cityId.value = 45
        roommateFilter.searchRequestModel = nil
        roommateFilter.userId.value = DBManager.shared.getUser()!.userId//DBManager.shared.getUser()?.userId
        roommateFilter.typeId.value = 2
        roommateFilter.page.value = 1
        roommateFilter.offset.value = 15
        roommateFilter.cityId.value = 45
//        if self.allVCType == .all{
//            apiRouter = APIRouter.postForAll(model: roomFilter)
//        }else if self.allVCType == .bookmark{
//            //            filterArgModel =
//            apiRouter = APIRouter.postForBookmark(model: roomFilter)
//        }
        loadRoomData()
    }
    
    func loadRoomData(){
        if !APIConnection.isConnectedInternet(){
            showErrorView(inView: self.bottomView, withTitle: "NETWORK_STATUS_CONNECTED_REQUEST_ERROR_MESSAGE".localized) {
                self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                    self.requestRoom(apiRouter:self.allVCType == .all ? APIRouter.postForAll(model: self.roomFilter) : APIRouter.postForBookmark(model: self.roomFilter),withNewFilterArgModel: true, page: 1)
                }
            }
        }else{
            self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                self.requestRoom(apiRouter: self.allVCType == .all ? APIRouter.postForAll(model: self.roomFilter) : APIRouter.postForBookmark(model: self.roomFilter), withNewFilterArgModel: true, page: 1)
            }
        }
    }
    func loadRoommateData(){
        if !APIConnection.isConnectedInternet(){
            showErrorView(inView: self.bottomView, withTitle: "NETWORK_STATUS_CONNECTED_REQUEST_ERROR_MESSAGE".localized) {
                self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                    self.requestRoommate(apiRouter: self.allVCType == .all ? APIRouter.postForAll(model: self.roommateFilter) : APIRouter.postForBookmark(model: self.roommateFilter),withNewFilterArgModel: true, page: 1)
                }
            }
        }else{
            self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                self.requestRoommate(apiRouter: self.allVCType == .all ? APIRouter.postForAll(model: self.roommateFilter) : APIRouter.postForBookmark(model: self.roommateFilter), withNewFilterArgModel: true, page: 1)
            }
        }
    }
//    if self.allVCType == AllVCType.
    
    func  requestRoom(apiRouter:APIRouter,withNewFilterArgModel newFilterArgModel:Bool,page:Int,offset:Int=15){
//        roomFilter.searchRequestModel = nil
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
                            self.requestRoom(apiRouter:apiRouter,withNewFilterArgModel: newFilterArgModel, page: page,offset: offset)
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
                        if newFilterArgModel { self.rooms.removeAll()}
                        values.forEach({ (room) in
                            print(room.postId)
                            print(room.name)
                        })
                        self.rooms.append(contentsOf: values)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
            })
        }
    }
    func  requestRoommate(apiRouter:APIRouter,withNewFilterArgModel newFilterArgModel:Bool,page:Int,offset:Int=15){
        roomFilter.searchRequestModel = nil
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
                            self.requestRoommate(apiRouter:apiRouter,withNewFilterArgModel: newFilterArgModel, page: page,offset: offset)
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
                        }
                    }
                }
            })
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
            //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_ROOMCV, for: indexPath) as! RoomCVCell
            //            cell.delegate = self
            //            cell.setData(room: rooms[indexPath.row], indexPath: indexPath,isEvenCell:indexPath.row%2==0)
            //            return cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_NEWROOMCV, for: indexPath) as! NewRoomCVCell
            cell.delegate = self
            cell.room = rooms[indexPath.row]
            cell.indexPath = indexPath
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
//        if segmentControl.selectedSegmentIndex == 0{
//            
//            let vc = RoomDetailForFinderVC()
//            vc.viewType = ViewType.detailForFinder
//            vc.room = rooms[indexPath.row]
////            let mainVC = UIViewController()
////            let nv = UINavigationController(rootViewController: mainVC)
////            present(nv, animated: false) {
//            //                nv.pushViewController(vc, animated: false)}
//            present(vc, animated: true, completion: nil)
//        }else{
//            //                    let vc = RoomDetailForFinderVC()
//            //                    vc.viewType = ViewType.detailForMember
//            //                    navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if segmentControl.selectedSegmentIndex == 0{
            return CGSize(width: collectionView.frame.width/2-5, height: Constants.HEIGHT_CELL_NEWROOMCV.cgFloat)
        }else{
            return CGSize(width: collectionView.frame.width, height: Constants.HEIGHT_CELL_NEWROOMMATECV.cgFloat)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //dif row space
        return 2
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        //same row
//        return 0
//    }
    
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
            roomFilter.orderBy.value = indexPath.row + 1
            loadRoomData()
        }else{
            
            roommateFilter.orderBy.value = indexPath.row + 1
            loadRoommateData()
        }
        
        
    }
    
    
    
    //MARK: Others delegate method
    //For segmentControl selected index change
    @objc func segmentChanged() {
        if segmentControl.selectedSegmentIndex == 0{
            if rooms.count == 0{
                loadRoomData()
            }
        }else{
            if roommates.count == 0{
                loadRoommateData()
            }
        }
        collectionView.reloadData()
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
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func newRoomCVCellDelegate(cell: NewRoomCVCell, onClickUIImageView imageView: UIImageView,atIndextPath indexPath:IndexPath?) {
        guard let row = indexPath?.row else{
            return
        }
        
        let room = rooms[row]
        if allVCType == .all{
            room.favourite =  room.favourite! == true ? false : true
        }else if allVCType == .bookmark{
            room.favourite =  false//for api
            rooms.remove(at: row)
        }
        collectionView.reloadData()
    }
    
//    func roommateCVCellDelegate(roommateCVCell cell: RoommateCVCell, onClickUIImageView imgvBookmark: UIImageView, atIndextPath indexPath: IndexPath?) {
//        guard let row = indexPath?.row else{
//            return
//        }
//
//        let roommate = roommates[row]
//        if allVCType == .all{
//            roommate.favourite =  roommate.favourite == true ? false : true
//        }else if allVCType == .bookmark{
//            roommate.favourite =  false//for api
//            roommates.remove(at: row)
//        }
//        collectionView.reloadData()
//    }
    func newRoommateCVCellDelegate(newRoommateCVCell cell: NewRoommateCVCell, onClickUIImageView imgvBookmark: UIImageView, atIndextPath indexPath: IndexPath?) {
        guard let row = indexPath?.row else{
            return
        }
        
        let roommate = roommates[row]
        let model = BookmarkRequestModel()
        model.postId = roommate.postId!
        model.userId = DBManager.shared.getUser()!.userId
        if allVCType == .all{
            let apiRouter = roommate.favourite == true ? APIRouter.removeBookmark(id: 0) : APIRouter.createBookmark(model: model)
            self.request(apiRouter: apiRouter, errorNetworkConnectedHander: {
                APIResponseAlert.defaultAPIResponseError(controller: self, error: .HTTP_ERROR)
            }) { (error, statusCode) -> (Void) in
                if error == .SERVER_NOT_RESPONSE{
                        APIResponseAlert.defaultAPIResponseError(controller: self, error: .SERVER_NOT_RESPONSE)
                }else{
                    if statusCode == .OK{
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }else{
                        APIResponseAlert.defaultAPIResponseError(controller: self, error: .PARSE_RESPONSE_FAIL)
                    }
                }
            }
            
        }else if allVCType == .bookmark{
            roommate.favourite =  false//for api
            roommates.remove(at: row)
        }
        
    }
    //MARK: FilterVCDelegate
    
    func filterVCDelegate(filterVC: FilterVC, onCompletedWithFilter filter: FilterArgumentModel) {
        print(filter.page.value)
        print(filter.offset.value)
        print(filter.userId.value)
        print(filter.typeId.value)
        print("Districts")
        filter.searchRequestModel?.districts.forEach({ (id) in
            print(id)
        })
        print("Utilities")
        filter.searchRequestModel?.utilities.forEach({ (id) in
            print(id)
        })
        print("Price")
        filter.searchRequestModel?.price.forEach({ (price) in
            print(price)
        })
        print("Gender")
        print(filter.searchRequestModel?.gender.value)
        
        if segmentControl.selectedSegmentIndex == 0{
            self.roomFilter = filter
            loadRoomData()
        }else{
            self.roommateFilter = filter
            loadRoommateData()
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
    
    
    
}
