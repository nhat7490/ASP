//
//  BookmarkVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class BookmarkVC:BaseVC,UICollectionViewDataSource,
    UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,
    UITableViewDataSource,UITableViewDelegate,
RoomCVCellDelegate{
    
    
    
    //MARK: Data for UICollectionView And UITableView
    let roommates = [RoommateModel(id: 1, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice:  500_000, maxPrice: 1_000_000_000, location:["Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4","Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4","Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4"], city: "HCM",isBookmark:true),
                     RoommateModel(id: 2, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM",isBookmark:false),
                     RoommateModel(id: 3, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM",isBookmark:true),
                     RoommateModel(id: 4, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM",isBookmark:false)]
    var rooms = [Room(id:1,numberPerson: 2,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 3,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: true,isCertificate: true),Room(id:1,numberPerson: 2,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 1,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: true,isCertificate: false),Room(id:1,numberPerson: 3,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 2,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: true,isCertificate: true),Room(id:4,numberPerson: 2,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 3,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: true,isCertificate: false)]
    let orders = [
        OrderType.newest:"NEWEST",
        OrderType.lowToHightPrice:"LOW_TO_HIGH_PRICE",
        OrderType.hightToLowPrice:"HIGH_TO_LOW_PRICE"
    ]
    
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
    
    lazy var btnOrderBy:UIButton = {
        let btn = UIButton()
        btn.contentHorizontalAlignment = .left
        btn.contentVerticalAlignment = .center
        btn.titleLabel?.textAlignment = .left
        btn.setTitle(orders[selectedOrder]?.localized, for: .normal)
        btn.setTitleColor(UIColor(hexString: "00A8B5"), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: .small)
        btn.setImage(UIImage(named: "down-arrow"), for: .normal)
        btn.addTarget(self, action: #selector(onClickBtnOrder), for: .touchUpInside)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 126, bottom: 0, right: 0)
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
    
    var isTableVisible =  false
    var selectedOrder = OrderType.newest//default
    var tableHeightLayoutConstraint : NSLayoutConstraint?
    
    
    //MARK: Components for UICollectionView
    lazy var collectionView:UICollectionView = {
        return BaseVerticalCollectionView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK: Setup UI
    func setupUI(){
        view.backgroundColor = .white
        
        //For tabbar
        tabBarItem = UITabBarItem(title: "Bookmark", image: UIImage(named: "icons8-home-page-51")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icons8-home-page-50"))
        
        
        
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
        
        //UI for orderBy
        let orderByViewHeight = CGFloat(30.0)
        let orderByViewWidth = view.frame.width-Constants.MARGIN_5*4
        let orderByView = UIView()
        view.addSubview(orderByView)
        _ = orderByView.anchorTopLeft(view.topAnchor, view.leftAnchor, 64 ,Constants.MARGIN_5*2,orderByViewWidth, orderByViewHeight)
        
        orderByView.addSubview(btnOrderBy)
        _ =  btnOrderBy.anchorTopRight(orderByView.topAnchor, orderByView.rightAnchor, 150.0, orderByViewHeight)
        
        orderByView.addSubview(lblOrderBy)
        _ = lblOrderBy.anchorTopRight(orderByView.topAnchor, btnOrderBy.leftAnchor, orderByViewWidth-150.0, orderByViewHeight)
        
        
        //UI for navigation bar
        view.addSubview(collectionView)
        
        _ = collectionView.anchorTopLeft(orderByView.bottomAnchor, view.leftAnchor,0,Constants.MARGIN_5*3,view.frame.width-Constants.MARGIN_5*6, view.frame.height-orderByViewHeight)
        
        //Register delegate , datasource & cell collectionview
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RoommateCVCell.self, forCellWithReuseIdentifier: Constants.CELL_ROOMMATECV)
        collectionView.register(RoomCVCell.self, forCellWithReuseIdentifier: Constants.CELL_ROOMCV)
        
        //Register delegate , datasource & cell tableview
        view.addSubview(tableView)
        tableHeightLayoutConstraint = tableView.anchorTopRight(orderByView.bottomAnchor, btnOrderBy.rightAnchor, 150.0, 1)[3]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderTVCell.self, forCellReuseIdentifier: Constants.CELL_ORDERTV)
        view.layoutIfNeeded()
    }
    
    //MARK: UICollectionView DataSourse and Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roommates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentControl.selectedSegmentIndex == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_ROOMCV, for: indexPath) as! RoomCVCell
            cell.delegate = self
            cell.setData(room: rooms[indexPath.row],isEvenCell:indexPath.row%2==0)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_ROOMMATECV, for: indexPath) as! RoommateCVCell
            cell.setData(roommate: roommates[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if segmentControl.selectedSegmentIndex == 0{
            return CGSize(width: collectionView.frame.width/2, height: 240)
        }else{
            return CGSize(width: collectionView.frame.width, height: 120)
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
        btnOrderBy.setTitle(orders[selectedOrder]?.localized, for: .normal)
        onClickBtnOrder()
    }
    
    
    
    //MARK: Others delegate method
    //For segmentControl selected index change
    @objc func segmentChanged() {
        collectionView.reloadData()
    }
    
    //Filter bar button item event
    @objc func onClickBtnFilter(){
        
    }
    //Order button item event
    @objc func onClickBtnOrder(){
        
        UIView.animate(withDuration: 0.1) {
            if !self.isTableVisible{
                self.isTableVisible = true
                self.tableHeightLayoutConstraint?.constant = 150
            }else{
                self.isTableVisible = false
                self.tableHeightLayoutConstraint?.constant = 0
            }
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func roomCVCellDelegate(cell: RoomCVCell, onClickUIImageView imageView: UIImageView) {
//        if (cell.room?.isBookMark)!{
//            cell.room?.isBookMark = false
//        }else{
//            cell.room?.isBookMark = true
//        }
//        imageView.image = cell.room!.isBookMark ? UIImage(named: "bookmarked") : UIImage(named: "bookmark-white")
        let index = rooms.index { (room) -> Bool in
            room.id == cell.room?.id
        }
        rooms.remove(at: index!)
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
