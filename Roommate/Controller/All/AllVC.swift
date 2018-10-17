//
//  AllVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class AllVC:BaseVC,UICollectionViewDataSource,
    UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,
    UITableViewDataSource,UITableViewDelegate,
NewRoomCVCellDelegate,RoommateCVCellDelegate{
    
    //MARK: Data for UICollectionView And UITableView
    var roommates:[RoommateModel] = []
    //        [RoommateModel(id: 1, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: "", roleInRom: 1), minPrice:  500_000, maxPrice: 1_000_000_000, location:["Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4","Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4","Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4"], city: "HCM",isBookmark:true),
    //                     RoommateModel(id: 2, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: "", roleInRom: 1), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM",isBookmark:true),
    //                     RoommateModel(id: 3, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: "", roleInRom: 1), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM",isBookmark:true),
    //                     RoommateModel(id: 4, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: "", roleInRom: 1), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM",isBookmark:true)]
    var rooms:[RoomPostResponseModel] = []
    //        [Room(id:1,numberPerson: 2,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 3,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: true,isCertificate: true),Room(id:1,numberPerson: 2,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 1,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: true,isCertificate: false),Room(id:1,numberPerson: 3,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 2,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: true,isCertificate: true),Room(id:4,numberPerson: 2,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 3,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: true,isCertificate: false)]
    let orders = [
        OrderType.newest:"NEWEST",
        OrderType.lowToHightPrice:"LOW_TO_HIGH_PRICE",
        OrderType.hightToLowPrice:"HIGH_TO_LOW_PRICE"
    ]
    var allVCType:AllVCType = .all
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
        orderByView.addSubview(btnOrderBy)
        orderByView.addSubview(lblOrderBy)
        btnOrderBy.addSubview(imageView)
        btnOrderBy.addSubview(lblSelectTitle)
        view.addSubview(tableView)
        
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
        
        view.addSubview(collectionView)
        if #available(iOS 11.0, *) {
            _ = collectionView.anchor(orderByView.bottomAnchor, view.leftAnchor, view.safeAreaLayoutGuide.bottomAnchor, view.rightAnchor)
        } else {
            // Fallback on earlier versions
            _ = collectionView.anchor(orderByView.bottomAnchor, view.leftAnchor, bottomLayoutGuide.topAnchor, view.rightAnchor)
        }
        
        view.bringSubview(toFront: tableView)
        tableHeightLayoutConstraint = tableView.anchorTopRight(orderByView.bottomAnchor, btnOrderBy.rightAnchor, 150.0, 1)[3]
        
        view.layoutIfNeeded()
    }
    
    func setupDataAndDelegate(){
        //Event for BtnOrderBy
        btnOrderBy.addTarget(self, action: #selector(onClickBtnOrder), for: .touchUpInside)
        showIndicator()
        
        //Register delegate , datasource & cell collectionview
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RoommateCVCell.self, forCellWithReuseIdentifier: Constants.CELL_ROOMMATECV)
        collectionView.register(UINib(nibName: Constants.CELL_NEWROOMCV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_NEWROOMCV)
        
        //Register delegate , datasource & cell tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderTVCell.self, forCellReuseIdentifier: Constants.CELL_ORDERTV)
        
        requestRoom(page: 1)
        
        
    }
    func  requestRoom(page:Int,offset:Int=15){
        self.requestArray(apiRouter: APIRouter.allRoom(), returnType: RoomPostResponseModel.self, completion: { (values, error, statusCode) -> (Void) in
            if error == .SERVER_NOT_RESPONSE {
                //                self.group.leave()
                DispatchQueue.main.async {
                    self.hideIndicator()
                }
                APIResponseAlert.defaultAPIResponseError(controller: self, error: .SERVER_NOT_RESPONSE)
            }else if error == .PARSE_RESPONSE_FAIL{
                //404
                DispatchQueue.main.async {
                    self.hideIndicator()
                }
                APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
            }else{
                //200
                if statusCode == .OK{
                    guard let values = values else{
                        APIResponseAlert.defaultAPIResponseError(controller: self, error: ApiResponseErrorType.PARSE_RESPONSE_FAIL)
                        //                        self.group.leave()
                        return
                    }
                    self.rooms = values
                    DispatchQueue.main.async {
                        self.hideIndicator()
                        self.collectionView.reloadData()
                    }
                }
            }
        })
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_ROOMMATECV, for: indexPath) as! RoommateCVCell
            cell.delegate = self
            cell.setData(roommate: roommates[indexPath.row], indexPath: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        if segmentControl.selectedSegmentIndex == 0{
        //            let vc = RoomDetailVC()
        //            vc.viewType = ViewType.detailForMember
        //            navigationController?.pushViewController(vc, animated: true)
        //        }else{
        //            let vc = RoomDetailVC()
        //            vc.viewType = ViewType.detailForMember
        //            navigationController?.pushViewController(vc, animated: true)
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if segmentControl.selectedSegmentIndex == 0{
            return CGSize(width: collectionView.frame.width/2, height: Constants.HEIGHT_CELL_NEWROOMCV.cgFloat)
        }else{
            return CGSize(width: collectionView.frame.width, height: Constants.HEIGHT_CELL_NEWROOMCV.cgFloat)
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
    }
    
    
    
    //MARK: Others delegate method
    //For segmentControl selected index change
    @objc func segmentChanged() {
        collectionView.reloadData()
    }
    
    //Filter bar button item event
    @objc func onClickBtnFilter(){
        let vc = FilterVC()
        if segmentControl.selectedSegmentIndex == 0{
            vc.filterVCType = .room
        }else{
            vc.filterVCType = .roommate
        }
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
    
    func roommateCVCellDelegate(roommateCVCell cell: RoommateCVCell, onClickUIImageView imgvBookmark: UIImageView, atIndextPath indexPath: IndexPath?) {
        guard let row = indexPath?.row else{
            return
        }
        
        let roommate = roommates[row]
        if allVCType == .all{
            roommate.isBookMark =  roommate.isBookMark == true ? false : true
        }else if allVCType == .bookmark{
            roommate.isBookMark =  false//for api
            roommates.remove(at: row)
        }
        collectionView.reloadData()
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
