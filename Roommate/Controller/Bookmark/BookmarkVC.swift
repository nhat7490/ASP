//
//  BookmarkVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class BookmarkVC:UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    let roommates = [Roommate(id: 1, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice:  500_000, maxPrice: 1_000_000_000, location:["Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4","Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4","Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4"], city: "HCM",isBookmark:true),
                 Roommate(id: 2, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM",isBookmark:false),
                 Roommate(id: 3, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM",isBookmark:true),
                 Roommate(id: 4, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM",isBookmark:false)]
    let rooms = [Room(numberPerson: 2,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 3,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: true,isCertificate: true),Room(numberPerson: 3,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 1,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: false,isCertificate: false),Room(numberPerson: 1,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 2,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: true,isCertificate: true),Room(numberPerson: 2,name: "Phòng ở quận tân bình gần sân bay tân sơn nhất",price: 8000_000,city: "HCM",gender: 3,location: "147 Hoa Lan, P. 2, Quận Phú Nhuận, TP. HCM",isBookMark: false,isCertificate: false)]
    lazy var segmentControl:UISegmentedControl={
        let sg = UISegmentedControl(items: ["SEGMENTED_CONTROL_ROOM".localized,"SEGMENTED_CONTROL_ROOMMATE".localized])
        sg.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        sg.selectedSegmentIndex = 0
//        sg.backgroundColor = UIColor(hexString: "00A8B5")
        sg.tintColor = UIColor(hexString: "00A8B5")
        return sg
    }()
    
    var filterItem : UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.done, target: self, action: nil)
        return item
    }()
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        cv.alwaysBounceVertical = true //when reach  bottom element it still scroll down or up a size
        cv.backgroundColor = .white
        cv.layer.borderWidth = 1
        cv.layer.borderColor = UIColor(hexString: "777").cgColor
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.backgroundColor = .white
        
        //For tabar
        tabBarItem = UITabBarItem(title: "Bookmark", image: UIImage(named: "icons8-home-page-51")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icons8-home-page-50"))
        

        
        //For segmentbar
        navigationItem.titleView = segmentControl
        
        //For Filter button for FilterBarButtonItem
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
        
        view.addSubview(collectionView)
        
        _ = collectionView.anchorCenterXAndY(view.centerXAnchor, view.centerYAnchor, view.frame.width-Constants.MARGIN_5*4, view.frame.height)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RoommateCVCell.self, forCellWithReuseIdentifier: Constants.CELL_ROOMMATECV)
        collectionView.register(RoomCVCell.self, forCellWithReuseIdentifier: Constants.CELL_ROOMCV)
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
    
    @objc func segmentChanged() {
        collectionView.reloadData()
    }
    
    //Filter bar button item event
    @objc func onClickBtnFilter(){
        
    }
    
}
