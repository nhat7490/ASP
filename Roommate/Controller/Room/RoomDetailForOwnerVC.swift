//
//  RoomDetailVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class RoomDetailForOwnerVC:BaseVC,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var room = RoomModel(name: "Thanh xuân -  Dalab", price: 500000, area: 50, address: "1B Nguyễn thị Minh Khai", max_guest: 5, date_create: Date(), current_member: 3, description: "Mình rất yêu căn phòng này nhưng do đi làm xa quá mình cho thuê lại giá 1.7tr, toilet riêng, rửa chén riêng, như hình, có giếng trời mát lắm điện 2.500, xe free ko thêm gì, à quên nước tháng hình như 40k thì phải mình ko Care luôn, bà chủ dễ thương dịu dàng, nhà cực sạch , an ninh, 11h tối đóng cửa, đi khua hơn thì báo tiếng là đc Alo cho mình nha - oanh", status: StatusModel(status: 1, name: "Active"), city: CityModel(id: 1, name: "Hồ chí minh"), district: DistrictModel(district_id: 1, name: "Quận 1"), image: [ImageModel(id: 1, link_url: "https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?cs=srgb&dl=4k-wallpaper-background-beautiful-853199.jpg&fm=jpg"),ImageModel(id: 2, link_url: "https://images.pexels.com/photos/534049/pexels-photo-534049.jpeg?cs=srgb&dl=beach-calm-cliffs-534049.jpg&fm=jpg"),ImageModel(id: 2, link_url: "https://images.pexels.com/photos/534049/pexels-photo-534049.jpeg?cs=srgb&dl=beach-calm-cliffs-534049.jpg&fm=jpg")
        ], utilities: [UtilityModel(utility_id: 1, name: "24-hours", quantity: 15, brand: "Hello", value: "nothing"),UtilityModel(utility_id: 1, name: "24-hours", quantity: 15, brand: "Hello", value: "nothing"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      UtilityModel(utility_id: 1, name: "24-hours", quantity: 15, brand: "Hello", value: "nothing"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      UtilityModel(utility_id: 2, name: "aircondition", quantity: 15, brand: "Hello", value: "nothing"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      UtilityModel(utility_id: 3, name: "cctv", quantity: 15, brand: "Hello", value: "nothing"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      UtilityModel(utility_id: 4, name: "cooking", quantity: 15, brand: "Hello", value: "nothing"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      UtilityModel(utility_id: 5, name: "fan", quantity: 15, brand: "Hello", value: "nothing")])
    
    let scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceHorizontal = false
        sv.alwaysBounceVertical = false
        sv.bounces = false
        sv.contentSize.height = 1500
        sv.contentOffset = CGPoint(x: 0, y:0)
        sv.backgroundColor = UIColor.blue
        sv.showsVerticalScrollIndicator = false
        return sv
        
        
    }()
    let pageControl:UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.pageIndicatorTintColor = .lightGray
        return pc
    }()
    let collectionView:UICollectionView = {
        print("Here")
        return BaseHorizontalCollectionView()
    }()
    
    override func viewDidLoad() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if #available(iOS 11, *){
            scrollView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        view.addSubview(scrollView)
        if #available(iOS 11, *){
            _ = scrollView.anchorTopLeft(view.topAnchor, view.leftAnchor, view.frame.width, view.frame.height)
        }else{
            //less than ios 11
            
            _ = scrollView.anchorEntire(view.topAnchor, view.leftAnchor, bottomLayoutGuide.topAnchor, view.rightAnchor)
        }
        scrollView.delegate = self

        let mainContainerView = UIView()
        let topContainerView = UIView()// Container for collectionview
        topContainerView.backgroundColor = .green
        let bottomContainerView = UIView()// Container for room detail
        bottomContainerView.backgroundColor = .brown
        
        let mainContainerViewWidth = view.frame.width
        let mainContainerViewHeight = scrollView.contentSize.height
        let topContainerViewHeight = CGFloat(200.0)
        let bottomContainerViewHeight = CGFloat(800.0)
        
        //MainContainer
        scrollView.addSubview(mainContainerView)
        _ = mainContainerView.anchorTopLeft(scrollView.topAnchor, scrollView.leftAnchor, view.frame.width, mainContainerViewHeight)

        
        
        //Top Container View containt images
        mainContainerView.addSubview(topContainerView)
        _ = topContainerView.anchorTopLeft(mainContainerView.topAnchor, mainContainerView.leftAnchor, mainContainerViewWidth, topContainerViewHeight)
        
        ///Images
        topContainerView.addSubview(collectionView)
        _ = collectionView.anchorEntire(view: topContainerView)
        collectionView.register(UINib(nibName: Constants.CELL_IMAGECV, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.CELL_IMAGECV)
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = room.image.count
        topContainerView.addSubview(pageControl)
        _ = pageControl.anchor(topContainerView.centerXAnchor, nil, nil, nil, topContainerView.bottomAnchor, nil,nil,nil, 0, 0,-5,0,150,20)
        
        //Bottom ContainerView
        mainContainerView.addSubview(bottomContainerView)
        _ = bottomContainerView.anchorTopLeft(topContainerView.bottomAnchor, mainContainerView.leftAnchor,0,2*Constants.MARGIN_6, mainContainerViewWidth-4*Constants.MARGIN_5, bottomContainerViewHeight)
        
        bottomContainerView.backgroundColor  = .gray
        
        
//        //Utility
//        let utilitiesView:UtilitiesView = .fromNib()
//        let heightOfCollectionViewBaseOnContent = room.utilities.count%4==0 ? CGFloat(room.utilities.count/4) * (view.frame.width-30) : CGFloat(room.utilities.count/4+1) * (view.frame.width-30)
//        bottomContainerView.addSubview(utilitiesView)
//        _  = utilitiesView.anchorTopLeft(bottomContainerView.topAnchor, bottomContainerView.leftAnchor, bottomContainerView.widthAnchor, heightOfCollectionViewBaseOnContent)
//        utilitiesView.data = room.utilities
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.subviews.forEach{
            $0.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }

    
    //MARK: UICollectionView DataSourse and Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return room.image.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.CELL_IMAGECV, for: indexPath) as! ImageCVCell
        cell.link_url = room.image[indexPath.row].link_url
        cell.backgroundColor = .red
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200.0)
    }
    
    
    //MARK: ScrollViewDelegate
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(targetContentOffset.pointee)
        print(collectionView.frame.width)
        let currentPage = Int(targetContentOffset.pointee.x/collectionView.frame.width)
        pageControl.currentPage = currentPage
    }
    
    
    
}
