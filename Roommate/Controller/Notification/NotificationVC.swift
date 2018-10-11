//
//  NotificationVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class NotificationVC:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    lazy var collectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 2 // space between cell in difference row
        flowLayout.minimumInteritemSpacing = 0 // space between cell in same row
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        cv.alwaysBounceVertical = true //when reach  bottom element it still scroll down or up a size
        cv.backgroundColor = .white
        return cv
    }()
    var notifications:[NotificationModel] =  {
        var arr = [
            NotificationModel(id: 1, title: "Bài đăng của bạn đã được duyệt", date: Date()),
            NotificationModel(id: 2, title: "Bài đăng của bạn đã được duyệt", date: Date()),
            NotificationModel(id: 3, title: "Bài đăng của bạn đã được duyệt", date: Date()),
            ]
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initData
        
        //SetupUI
        setupUI()
    }
    func setupUI() {
        //For Tabar
        tabBarItem = UITabBarItem(title: "Notification", image: UIImage(named: "icons8-home-page-51")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icons8-home-page-50"))
        
        //For collectionView
        view.addSubview(collectionView)
        _ = collectionView.anchorTopLeft( view.topAnchor,  view.leftAnchor,  view.widthAnchor,  view.heightAnchor)
        collectionView.register(NotificationCVCell.self, forCellWithReuseIdentifier:Constants.CELL_NOTIFICATIONCV)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //For top right title of notification
        
    }
    
    
    //MARK: UICollectionView delegate and datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CELL_NOTIFICATIONCV, for: indexPath) as! NotificationCVCell
        cell.setModel(model: notifications[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch UIScreen.main.bounds.width {
        case 0...375: //4 to less than 4.7 inch
            return CGSize(width: view.frame.width, height: 80)
        case 376..<768://more than 4,7 to  7.9 inch
            return CGSize(width: view.frame.width, height: 100)
        default://more than 7,9 inch
            return CGSize(width: view.frame.width, height: 120)
        }
    }
    

}
