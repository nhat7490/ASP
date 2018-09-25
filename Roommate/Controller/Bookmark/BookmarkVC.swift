//
//  BookmarkVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class BookmarkVC:BaseVC,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate{
    
    //MARK: model for collectionview and table view
    let roommates = [Roommate(id: 1, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice:  500_000, maxPrice: 1_000_000_000, location:["Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4","Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4","Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4"], city: "HCM",isBookmark:true),
                 Roommate(id: 2, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM",isBookmark:false),
                 Roommate(id: 3, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM",isBookmark:true),
                 Roommate(id: 4, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM",isBookmark:false)]
    let rooms = [Room(numberPerson: 2,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 3,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: true,isCertificate: true),Room(numberPerson: 3,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 1,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: false,isCertificate: false),Room(numberPerson: 1,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 2,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: true,isCertificate: true),Room(numberPerson: 2,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 3,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: false,isCertificate: false)]
    let orders = [
        OrderType.lowToHightPrice:"LOW_TO_HIGH_PRICE",
        OrderType.hightToLowPrice:"HIGH_TO_LOW_PRICE"
    ]
    
    //MARK: UI for navigation bar
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
    
    //MARK: UI for Orderby
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
//        btn.titleLabel?.textColor  = UIColor(hexString: "00A8B5")
        btn.setTitle("LOW_TO_HIGH_PRICE".localized, for: .normal)
        btn.setTitleColor(UIColor(hexString: "00A8B5"), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: .small)
        btn.setImage(UIImage(named: "down-arrow"), for: .normal)
//        btn.tintColor = .red//UIColor(hexString: "00A8B5")
//        btn.addTarget(self, action: #selector(onClickBtnFilter), for: .touchUpInside)
//        btn.imageView?.contentMode = .scaleAspectFill
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 126, bottom: 0, right: 0)
        return btn
    }()
    
    lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        return tv
    }()
    
    //MARK: UI for navigation bar room and roommate collectionview
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        cv.alwaysBounceVertical = true //when reach  bottom element it still scroll down or up a size
        cv.backgroundColor = .white
//        cv.layer.borderWidth = 1
//        cv.layer.borderColor = UIColor(hexString: "777").cgColor
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK: UI for entire ViewController
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
        
        let bbtniFilter = UIBarButtonItem(customView: btnFilter)
        let width = bbtniFilter.customView?.widthAnchor.constraint(equalToConstant: (navigationItem.titleView?.frame.height)!)
        width?.isActive = true
        let height = bbtniFilter.customView?.heightAnchor.constraint(equalToConstant: (navigationItem.titleView?.frame.height)!)
        height?.isActive = true
        navigationItem.rightBarButtonItem = bbtniFilter
        
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
        
        _ = collectionView.anchorTopLeft(orderByView.bottomAnchor, view.leftAnchor,0,Constants.MARGIN_5*2,view.frame.width-Constants.MARGIN_5*4, view.frame.height-orderByViewHeight)
        
        //Register delegate , datasource & cell collectionview
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RoommateCVCell.self, forCellWithReuseIdentifier: Constants.CELL_ROOMMATECV)
        collectionView.register(RoomCVCell.self, forCellWithReuseIdentifier: Constants.CELL_ROOMCV)
        
        //Register delegate , datasource & cell tableview
        view.addSubview(tableView)
        _ = tableView.anchorTopRight(orderByView.bottomAnchor, btnOrderBy.rightAnchor, 150.0, 150.0)
        
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
            cell.setModel(room: rooms[indexPath.row])
            cell.layoutSubviews()
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_ROOMMATECV, for: indexPath) as! RoommateCVCell
            cell.setModel(roommate: roommates[indexPath.row])
            cell.layoutSubviews()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch UIScreen.main.bounds.width {
//        case 0...375: //4 to less than 4.7 inch
//            return CGSize(width: view.frame.width, height: 80)
//        case 376..<768://more than 4,7 to  7.9 inch
//            return CGSize(width: view.frame.width, height: 100)
//        default://more than 7,9 inch
//            return CGSize(width: view.frame.width, height: 120)
//        }
         if segmentControl.selectedSegmentIndex == 0{
            return CGSize(width: collectionView.frame.width/2, height: 200)
         }else{
            return CGSize(width: collectionView.frame.width/2, height: 160)
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
        if indexPath.row == OrderType.lowToHightPrice.rawValue{
            cell.setOrderTitle(title: orders[OrderType.lowToHightPrice]!, orderType: OrderType.lowToHightPrice)
        }else if  indexPath.row == OrderType.hightToLowPrice.rawValue{
            cell.setOrderTitle(title: orders[OrderType.hightToLowPrice]!, orderType: OrderType.hightToLowPrice)
        }else{
            //for future order type
        }
        return cell
    }
    
    
    //MARK: Others delegate method
    //For segmentControl selected index change
    @objc func segmentChanged() {
        collectionView.reloadData()
    }
    
    //Filter bar button item event
    @objc func onClickBtnFilter(){
        
    }
    
}
