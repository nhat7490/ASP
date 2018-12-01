//
//  ShowAllVC.swift
//  Roommate
//
//  Created by TrinhHC on 11/6/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import MBProgressHUD
class ShowAllVC: BaseVC,UICollectionViewDataSource,
    UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,
    UITableViewDataSource,UITableViewDelegate,
RoomCVCellDelegate,RoommateCVCellDelegate{
    
    
    
    //MARK: Data for UICollectionView And UITableView
    var roommates:[RoommatePostResponseModel] = []
    var rooms:[RoomPostResponseModel] = []
    var roomResponseModels:[RoomMappableModel] = []
    var baseSuggestRequestModel:BaseSuggestRequestModel = BaseSuggestRequestModel()
    var filterArgumentModel:FilterArgumentModel = {
        let filter = FilterArgumentModel()
        return filter
    }()
    var currentUserId:Int = DBManager.shared.getUser()!.userId
    var roomForOwnerAndMemberPage = 1
    let orders = [
        OrderType.newest:"NEWEST",
        OrderType.lowToHightPrice:"LOW_TO_HIGH_PRICE",
        OrderType.hightToLowPrice:"HIGH_TO_LOW_PRICE"
    ]
    var showAllVCType:ShowAllVCType = .roomPostForCreatedUser{
        didSet{
            switch showAllVCType{
            case .suggestRoom:
                baseSuggestRequestModel.offset = Constants.MAX_OFFSET
            case .roomPostForCreatedUser:
                filterArgumentModel.typeId = Constants.ROOM_POST
            case .roommatePostForCreatedUser:
                filterArgumentModel.typeId = Constants.ROOMMATE_POST
            case .roomForOwner,.roomForMember:
                break
            }
        }
    }
    var apiRouter:APIRouter!
    
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
    lazy var collectionView:BaseVerticalCollectionView = {
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
        registerNotification()
    }
    
    //MARK: Setup UI
    func setupUI(){
        switch showAllVCType{
        case .suggestRoom:
            title = "SUGGEST".localized
        case .roomPostForCreatedUser:
            title = "TITLE_MEMBER_CREATED_ROOM_POST".localized
        case .roommatePostForCreatedUser:
            title = "TITLE_MEMBER_CREATED_ROOMMATE_POST".localized
        case .roomForOwner:
            title = "TITLE_CREATED_ROOM".localized
        case .roomForMember:
            title = "TITLE_HISTORY_MEMBER_ROOM".localized
        }
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.navigationBar.backgroundColor = .white
        setBackButtonForNavigationBar()
        
        view.addSubview(bottomView)
        bottomView.addSubview(collectionView)
        switch showAllVCType{
        case .roomPostForCreatedUser,.roommatePostForCreatedUser:
            //Declare view
            let orderByView = UIView()
            
            //Add View for .suggestRoom,.roomPost,.roommatePost
            view.addSubview(orderByView)
            view.addSubview(tableView)
            orderByView.addSubview(btnOrderBy)
            orderByView.addSubview(lblOrderBy)
            btnOrderBy.addSubview(imageView)
            btnOrderBy.addSubview(lblSelectTitle)
            
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
            tableHeightLayoutConstraint = tableView.anchorTopRight(orderByView.bottomAnchor, btnOrderBy.rightAnchor, 150.0, 1)[3]
            view.bringSubview(toFront: tableView)
        case .suggestRoom,.roomForOwner,.roomForMember:
            if #available(iOS 11.0, *) {
                _ = bottomView.anchor(view.safeAreaLayoutGuide.topAnchor, view.leftAnchor, view.safeAreaLayoutGuide.bottomAnchor, view.rightAnchor,UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: -2, right: -Constants.MARGIN_10))
            } else {
                // Fallback on earlier versions
                _ = bottomView.anchor(topLayoutGuide.bottomAnchor, view.leftAnchor, bottomLayoutGuide.topAnchor, view.rightAnchor,UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: -2, right: -Constants.MARGIN_10))
            }
        }
        _ = collectionView.anchor(view: bottomView)
    }
    
    func setupDataAndDelegate(){
        //Event for BtnOrderBy
        btnOrderBy.addTarget(self, action: #selector(updateUIWhenClickBtnOrder), for: .touchUpInside)
        
        
        //Register delegate , datasource & cell collectionview
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.CELL_ROOMMATEPOSTCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_ROOMMATEPOSTCV)
        collectionView.register(UINib(nibName: Constants.CELL_ROOMPOSTCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_ROOMPOSTCV)
        collectionView.register(UINib(nibName: Constants.CELL_ROOMCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_ROOMCV)
        
        //Register delegate , datasource & cell tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderTVCell.self, forCellReuseIdentifier: Constants.CELL_ORDERTV)
        
        
        switch showAllVCType{
        case .suggestRoom:
            self.apiRouter = APIRouter.suggest(model: baseSuggestRequestModel)
            loadRoomData(withNewFilterArgModel: true)
        case .roomForMember:
            self.apiRouter = APIRouter.getHistoryRoom(userId: currentUserId, page: roomForOwnerAndMemberPage, size: Constants.MAX_OFFSET)
            loadRoomForOwnerOrMemberData(withNewFilterArgModel: true)
        case .roomForOwner:
            self.apiRouter = APIRouter.getRoomsByUserId(userId: currentUserId, page: roomForOwnerAndMemberPage, size: Constants.MAX_OFFSET)
            loadRoomForOwnerOrMemberData(withNewFilterArgModel: true)
        case .roomPostForCreatedUser:
            self.apiRouter = APIRouter.getUserPost(model: filterArgumentModel)
            loadRoomData(withNewFilterArgModel: true)
        case .roommatePostForCreatedUser:
            self.apiRouter = APIRouter.getUserPost(model: filterArgumentModel)
            loadRoommateData(withNewFilterArgModel: true)
        }
    }
    
    func loadRoomData(withNewFilterArgModel:Bool){
        if !APIConnection.isConnectedInternet(){
            showErrorView(inView: self.bottomView, withTitle: "NETWORK_STATUS_CONNECTED_REQUEST_ERROR_MESSAGE".localized) {
                self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                    
                    self.requestRoomPost(apiRouter:self.apiRouter,withNewFilterArgModel: withNewFilterArgModel)
                }
            }
        }else{
            self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                self.requestRoomPost(apiRouter: self.apiRouter, withNewFilterArgModel: withNewFilterArgModel)
            }
        }
    }
    func loadRoommateData(withNewFilterArgModel:Bool){
        if !APIConnection.isConnectedInternet(){
            showErrorView(inView: self.bottomView, withTitle: "NETWORK_STATUS_CONNECTED_REQUEST_ERROR_MESSAGE".localized) {
                self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                    self.requestRoommatePost(apiRouter: self.apiRouter,withNewFilterArgModel: withNewFilterArgModel)
                }
            }
        }else{
            self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                self.requestRoommatePost(apiRouter:self.apiRouter, withNewFilterArgModel: withNewFilterArgModel)
            }
        }
    }
    
    func loadRoomForOwnerOrMemberData(withNewFilterArgModel:Bool){
        if !APIConnection.isConnectedInternet(){
            showErrorView(inView: self.bottomView, withTitle: "NETWORK_STATUS_CONNECTED_REQUEST_ERROR_MESSAGE".localized) {
                self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                    self.requestRoom(apiRouter:self.apiRouter,withNewFilterArgModel: withNewFilterArgModel)
                }
            }
        }else{
            self.checkAndLoadInitData(inView: self.bottomView) { () -> (Void) in
                self.requestRoom(apiRouter: self.apiRouter, withNewFilterArgModel: withNewFilterArgModel)
            }
        }
    }
    
    func  requestRoomPost(apiRouter:APIRouter,withNewFilterArgModel newFilterArgModel:Bool){
        DispatchQueue.main.async {
            let hub = MBProgressHUD.showAdded(to: self.bottomView, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
            //            hub.label.text = "MB_LOAD_DATA_TITLE".localized
            //            MBProgressHUD.showAdded(to: self.bottomView, animated: true)
        }
        DispatchQueue.global(qos: .background).async {
            APIConnection.requestArray(apiRouter:apiRouter, returnType: RoomPostResponseModel.self) { (values, error, statusCode) -> (Void) in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.bottomView, animated: true)
                }
                if error != nil {
                    DispatchQueue.main.async {
                        self.showErrorView(inView: self.bottomView, withTitle: error == .SERVER_NOT_RESPONSE ? "NETWORK_STATUS_CONNECTED_SERVER_MESSAGE".localized : "NETWORK_STATUS_PARSE_RESPONSE_FAIL_MESSAGE".localized, onCompleted: { () -> (Void) in
                            self.requestRoomPost(apiRouter: apiRouter, withNewFilterArgModel: newFilterArgModel)
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
                        if values.count == 0, self.filterArgumentModel.page! > 1{
                            self.filterArgumentModel.page = self.filterArgumentModel.page!-1
                        }
                        self.rooms.append(contentsOf: values)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                            //                            self.isLoadingData = false
                        }
                    }else if statusCode == .NotFound{
                        self.roomResponseModels.removeAll()
                        self.showNoDataView(inView: self.collectionView, withTitle: "NO_DATA".localized)
                    }
                }
            }
        }
    }
    
    func  requestRoommatePost(apiRouter:APIRouter,withNewFilterArgModel newFilterArgModel:Bool){
        DispatchQueue.main.async {
            let hub = MBProgressHUD.showAdded(to: self.bottomView, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
            //            hub.label.text = "MB_LOAD_DATA_TITLE".localized
            //            MBProgressHUD.showAdded(to: self.bottomView, animated: true)
        }
        DispatchQueue.global(qos: .background).async {
            APIConnection.requestArray(apiRouter:apiRouter, returnType: RoommatePostResponseModel.self) { (values, error, statusCode) -> (Void) in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.bottomView, animated: true)
                }
                if error != nil {
                    DispatchQueue.main.async {
                        self.showErrorView(inView: self.bottomView, withTitle: error == .SERVER_NOT_RESPONSE ? "NETWORK_STATUS_CONNECTED_SERVER_MESSAGE".localized : "NETWORK_STATUS_PARSE_RESPONSE_FAIL_MESSAGE".localized, onCompleted: { () -> (Void) in
                            self.requestRoommatePost(apiRouter: apiRouter, withNewFilterArgModel: newFilterArgModel)
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
                        if values.count == 0, self.filterArgumentModel.page! > 1{
                            self.filterArgumentModel.page = self.filterArgumentModel.page!-1
                        }
                        self.roommates.append(contentsOf: values)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                            //                            self.isLoadingData = false
                        }
                    }else if statusCode == .NotFound{
                        self.roomResponseModels.removeAll()
                        self.showNoDataView(inView: self.collectionView, withTitle: "NO_DATA".localized)
                    }
                }
            }
        }
    }
    func  requestRoom(apiRouter:APIRouter,withNewFilterArgModel newFilterArgModel:Bool){
        DispatchQueue.main.async {
            let hub = MBProgressHUD.showAdded(to: self.bottomView, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
        }
        DispatchQueue.global(qos: .background).async {
            APIConnection.requestArray(apiRouter:apiRouter, returnType: RoomMappableModel.self){ (values, error, statusCode) -> (Void) in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.bottomView, animated: true)
                }
                if error != nil {
                    DispatchQueue.main.async {
                        self.showErrorView(inView: self.bottomView, withTitle:error == .SERVER_NOT_RESPONSE ?  "NETWORK_STATUS_CONNECTED_SERVER_MESSAGE".localized : "NETWORK_STATUS_PARSE_RESPONSE_FAIL_MESSAGE".localized, onCompleted: { () -> (Void) in
                            self.requestRoom(apiRouter: apiRouter,withNewFilterArgModel: newFilterArgModel)
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
                        if newFilterArgModel { self.roomResponseModels.removeAll()}
                        if values.count == 0, self.roomForOwnerAndMemberPage > 1{
                            self.roomForOwnerAndMemberPage = self.roomForOwnerAndMemberPage-1
                        }
                        self.roomResponseModels.append(contentsOf: values)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                            //                            self.isLoadingData = false
                        }
                    }else if statusCode == .NotFound{
                        self.roomResponseModels.removeAll()
                        self.showNoDataView(inView: self.collectionView, withTitle: "NO_DATA".localized)
                    }

                }
            }
        }
    }
    
    
    //MARK: Notification
    func registerNotification(){
        NotificationCenter.default.addObserver(self, selector:#selector(didReceiveRemoveRoomNotification(_:)), name: Constants.NOTIFICATION_REMOVE_ROOM, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(didReceiveEditRoomNotification(_:)), name: Constants.NOTIFICATION_EDIT_ROOM, object: nil)
    }
    
    @objc func didReceiveRemoveRoomNotification(_ notification:Notification){
        
        switch showAllVCType{
        case .roomForOwner:
            rooms.removeAll()
            loadRoomForOwnerOrMemberData(withNewFilterArgModel: true)
        default:
            break
        }
    }
    
    @objc func didReceiveEditRoomNotification(_ notification:Notification){
        switch showAllVCType{
        case .roomForOwner:
            if notification.object is RoomMappableModel {
                guard let room = notification.object as? RoomMappableModel, let index = roomResponseModels.index(of: room) else{
                    return
                }
                roomResponseModels[index] = room
                collectionView.reloadData()
            }
        default:
            break
        }
        
    }
    //MARK: UICollectionView DataSourse and Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch showAllVCType{
        case .suggestRoom,.roomPostForCreatedUser:
            return rooms.count
        case .roommatePostForCreatedUser:
            return roommates.count
        case .roomForOwner,.roomForMember:
            return roomResponseModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch showAllVCType{
        case .suggestRoom,.roomPostForCreatedUser:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_ROOMPOSTCV, for: indexPath) as! RoomPostCVCell
            cell.delegate = self
            cell.room = rooms[indexPath.row]
            cell.indexPath = indexPath
            return cell
        case .roommatePostForCreatedUser:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_ROOMMATEPOSTCV, for: indexPath) as! RoommatePostCVCell
            cell.delegate = self
            cell.roommate = roommates[indexPath.row]
            cell.indexPath = indexPath
            return cell
        case .roomForOwner,.roomForMember:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_ROOMCV, for: indexPath) as! RoomCVCell
            cell.room = roomResponseModels[indexPath.row]
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch showAllVCType{
        case .suggestRoom,.roomPostForCreatedUser:
            let vc = PostDetailVC()
            
            vc.viewType = showAllVCType == .suggestRoom ? .roomPostDetailForFinder : .roomPostDetailForCreatedUser
            vc.room = rooms[indexPath.row]
//            let mainVC = UIViewController()
//            let nv = UINavigationController(rootViewController: mainVC)
//            present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
            presentInNewNavigationController(viewController: vc)
        case .roommatePostForCreatedUser:
            let vc = PostDetailVC()
            vc.viewType = showAllVCType == .suggestRoom ? .roommatePostDetailForFinder : .roommatePostDetailForCreatedUser
            vc.roommate = roommates[indexPath.row]
//            let mainVC = UIViewController()
//            let nv = UINavigationController(rootViewController: mainVC)
//            present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
            presentInNewNavigationController(viewController: vc)
        case .roomForOwner:
            let vc = RoomDetailVC()
            vc.viewType = .detailForOwner
            vc.room = roomResponseModels[indexPath.row]
//            let mainVC = UIViewController()
//            let nv = UINavigationController(rootViewController: mainVC)
//            present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
            presentInNewNavigationController(viewController: vc)
        case .roomForMember:
            let vc = RoomDetailVC()
            vc.viewType = .detailForMember
            vc.room = roomResponseModels[indexPath.row]
//            let mainVC = UIViewController()
//            let nv = UINavigationController(rootViewController: mainVC)
//            present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
            presentInNewNavigationController(viewController: vc)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch showAllVCType{
        case .suggestRoom,.roomPostForCreatedUser:
            return CGSize(width: collectionView.frame.width/2-5, height: Constants.HEIGHT_CELL_ROOMPOSTCV)
        case .roommatePostForCreatedUser:
            return CGSize(width: collectionView.frame.width, height: Constants.HEIGHT_CELL_ROOMMATEPOSTCV)
        case .roomForOwner,.roomForMember:
            return CGSize(width: collectionView.frame.width, height: Constants.HEIGHT_CELL_ROOMFOROWNERCV)
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
            
            switch showAllVCType{
            case .suggestRoom:
                baseSuggestRequestModel.page = 1
                loadRoomData(withNewFilterArgModel: true)
            case .roomPostForCreatedUser:
                filterArgumentModel.page = 1
                loadRoomData(withNewFilterArgModel: true)
            case .roommatePostForCreatedUser:
                filterArgumentModel.page = 1
                loadRoommateData(withNewFilterArgModel: true)
            case .roomForOwner,.roomForMember:
                roomForOwnerAndMemberPage = 1
                loadRoomData(withNewFilterArgModel: true)
            }
            //Load more data
            //because offset = 0 when view loading ==> need to plus scrollView.frame.height
            //to equal contentHeight
        }else if (offset - contentHeight + scrollView.frame.height) > Constants.MAX_Y_OFFSET{
            //            isLoadingData = true
            print("Loading more data")
            switch showAllVCType{
            case .suggestRoom:
                baseSuggestRequestModel.page = rooms.count/Constants.MAX_OFFSET+2
                loadRoomData(withNewFilterArgModel: false)
            case .roomPostForCreatedUser:
                filterArgumentModel.page = rooms.count/Constants.MAX_OFFSET+2
                loadRoomData(withNewFilterArgModel: false)
            case .roommatePostForCreatedUser:
                filterArgumentModel.page = roommates.count/Constants.MAX_OFFSET+2
                loadRoommateData(withNewFilterArgModel: false)
            case .roomForOwner,.roomForMember:
                roomForOwnerAndMemberPage = roomResponseModels.count/Constants.MAX_OFFSET+2
                loadRoommateData(withNewFilterArgModel: false)
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
        //Need to change method to updateUIWhenClickBtnOrder
        updateUIWhenClickBtnOrder()
        switch showAllVCType{
        case .suggestRoom,.roomPostForCreatedUser:
            filterArgumentModel.page = 1
            loadRoomData(withNewFilterArgModel: true)
        case .roommatePostForCreatedUser:
            filterArgumentModel.orderBy = indexPath.row + 1
            filterArgumentModel.page = 1
            loadRoommateData(withNewFilterArgModel: true)
        default:
            break
        }
        
        
    }
    
    //Order button item event
    @objc func updateUIWhenClickBtnOrder(){
        
        UIView.animate(withDuration: 0.1) {
            if self.tableHeightLayoutConstraint?.constant == 0 {
                self.tableHeightLayoutConstraint?.constant = 150
            }else{
                self.tableHeightLayoutConstraint?.constant = 0
            }
            //            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func roomCVCellDelegate(roomCVCell: RoomPostCVCell, onClickUIImageView imageView: UIImageView,atIndextPath indexPath:IndexPath?) {
        guard let row = indexPath?.row else{
            return
        }
        processBookmark(view: self.collectionView, model: rooms[row], row: row){model in
            if model.isFavourite!{
                NotificationCenter.default.post(name: Constants.NOTIFICATION_ADD_BOOKMARK, object: model)
            }else{
                NotificationCenter.default.post(name: Constants.NOTIFICATION_REMOVE_BOOKMARK, object: model)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func roommateCVCellDelegate(roommateCVCell cell: RoommatePostCVCell, onClickUIImageView imgvBookmark: UIImageView, atIndextPath indexPath: IndexPath?) {
        guard let row = indexPath?.row else{
            return
        }
        processBookmark(view: self.collectionView, model: roommates[row], row: row){model in
            if model.isFavourite!{
                NotificationCenter.default.post(name: Constants.NOTIFICATION_ADD_BOOKMARK, object: model)
            }else{
                NotificationCenter.default.post(name: Constants.NOTIFICATION_REMOVE_BOOKMARK, object: model)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
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
