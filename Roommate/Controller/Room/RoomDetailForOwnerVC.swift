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
    
    let scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = UIColor.red
        return sv
    }()
    override func viewDidLoad() {
        view.addSubview(scrollView)
        scrollView.anchorCenterXAndY(view.centerXAnchor, view.centerYAnchor,view.frame.width,view.frame.height)
        scrollView.delegate = self
        
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
}
