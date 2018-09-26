//
//  RoomDetailVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class RoomDetailForOwnerVC:BaseVC,UIScrollViewDelegate{
    //,UICollectionViewDelegate,UICollectionViewDataSource
    let scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = UIColor.red
        return sv
    }()
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0 //same row
        layout.minimumInteritemSpacing = 0 //dif row
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.allowsMultipleSelection = false
        cv.alwaysBounceHorizontal  = true
        cv.isPagingEnabled = true
        return cv
    }()
    
    override func viewDidLoad() {
//        navigationController?.navigationBar.isTranslucent = true //default
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        view.addSubview(scrollView)
        _ = scrollView.anchorCenterXAndY(view.centerXAnchor, view.centerYAnchor,view.frame.width,view.frame.height)
        scrollView.delegate = self
        
        let mainContainerView = UIView()
        let topContainerView = UIView()// Container for collectionview
        let bottomContainerView = UIView()// Container for room detail
        
        let scrollViewWidth = view.frame.width
        let scrollViewHeight = view.frame.height
        
        let mainContainerViewHeight = scrollViewHeight*2
        
        let topContainerViewHeight = CGFloat(150.0)
        let bottomContainerViewHeight = mainContainerViewHeight - topContainerViewHeight
        
        scrollView.addSubview(mainContainerView)
        _ = mainContainerView.anchor(nil, nil, scrollView.topAnchor, scrollView.leftAnchor, scrollView.bottomAnchor, scrollView.rightAnchor, nil, nil, 0, 0, 0, 0, 0, 1000)
        
        mainContainerView.addSubview(topContainerView)
        _ = topContainerView.anchorTopLeft(mainContainerView.topAnchor, mainContainerView.leftAnchor, scrollViewWidth, mainContainerViewHeight)
        
        
    }

    //MARK: CollectionView Delegate and Datasource
    
    
    
    //MARK: ScrollViewDelegate
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
}
