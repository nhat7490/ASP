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
    
    let model = [RoommateModel(id: 1, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice:  500_000, maxPrice: 1_000_000_000, location:["Quan 3","Quan 4","Quan 4","Quan 4","Quan 4","Quan 4"], city: "HCM"),
                 RoommateModel(id: 2, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM"),
                 RoommateModel(id: 3, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM"),
                 RoommateModel(id: 4, user: User(id: 1, name: "Ho nguyen hai trieu", imageUrl: ""), minPrice: 500_000, maxPrice: 1_000_000_000, location: ["Quan 3","Quan 4"], city: "HCM")]
    
    lazy var segmentControl:UISegmentedControl={
        let sg = UISegmentedControl(items: ["SEGMENTED_CONTROL_ROOM".localized,"SEGMENTED_CONTROL_ROOMMATE".localized])
        sg.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        sg.selectedSegmentIndex = 1
        return sg
    }()
    
    lazy var roommateCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        cv.alwaysBounceVertical = true //when reach  bottom element it still scroll down or up a size
        cv.backgroundColor = .white
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        //For Tabar
        tabBarItem = UITabBarItem(title: "Bookmark", image: UIImage(named: "icons8-home-page-51")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icons8-home-page-50"))
        
        //For segmentbar
        navigationItem.titleView = segmentControl
        
        view.addSubview(roommateCollectionView)
        
        _ = roommateCollectionView.anchorCenterXAndY(view.centerXAnchor, view.centerYAnchor, view.frame.width-Constants.MARGIN_5*2, view.frame.height)
        
        roommateCollectionView.delegate = self
        roommateCollectionView.dataSource = self
        roommateCollectionView.register(RoommateCVCell.self, forCellWithReuseIdentifier: Constants.CELL_ROOMMATECV)
    }
    
    //MARK: UICollectionView DataSourse and Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_ROOMMATECV, for: indexPath) as! RoommateCVCell
        cell.setModel(roommate: model[indexPath.row])
        cell.layoutSubviews()
        return cell
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
        return CGSize(width: roommateCollectionView.frame.width/2, height: 160)
    }
    @objc func segmentChanged() {
        
    }
    
}
