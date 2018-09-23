//
//  RoomCVCell.swift
//  Roommate
//
//  Created by TrinhHC on 9/22/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class RoommateCVCell:UICollectionViewCell{
    var side:CellSide?
    let mainContainerView:UIView = {
        let v = UIView()
        return v
    }()
    
    
    lazy var imgvLeft:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
//        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var lblRightName:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize:.medium)
//        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
//        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var lblRightPrice:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: .verySmall)
        lbl.textColor = .normalTitle
        return lbl
    }()
    
    lazy var lblRightPriceValue:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: .verySmall)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var lblRightPosition:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize:.verySmall)
//        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var lblRightPositionValue:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: .verySmall)
        lbl.numberOfLines = 0
//        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var lblRightCity:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize:.verySmall)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var lblRightCityValue:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: .verySmall)
//        lbl.sizeToFit()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var line:UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return v
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    func setupUI() {
        //Setup ui for mainContainerview
        
        let mainContainerWidth = side==CellSide.left ? frame.width-Constants.MARGIN_6 : frame.width-Constants.MARGIN_6/2
        let mainContainerHeight = frame.height
        
        let leftContainerWidth = CGFloat(80)
        let leftContainerWHeight = mainContainerHeight
        
        let rightContainerWidth = mainContainerWidth - leftContainerWidth
        let rightContainerHeight = mainContainerHeight
        
        addSubview(mainContainerView)
        _ = mainContainerView.anchorTopLeft(topAnchor, leftAnchor, mainContainerWidth, mainContainerHeight)
        
        addSubview(line)
        _ = line.anchorTopLeft(mainContainerView.bottomAnchor, mainContainerView.leftAnchor, mainContainerWidth, 0.5)
        

        //Setup ui for containerview left and right
        let leftContainerView = UIView()
        let rightContainerView = UIView()
        
        mainContainerView.addSubview(leftContainerView)
        mainContainerView.addSubview(rightContainerView)
        
        _ = leftContainerView.anchorTopLeft( mainContainerView.topAnchor, mainContainerView.leftAnchor,  leftContainerWidth,  leftContainerWHeight)
        
        
         _ = rightContainerView.anchorTopLeft( mainContainerView.topAnchor,  leftContainerView.rightAnchor,  rightContainerWidth,  rightContainerHeight)
        
        //Setup ui for leftContainer
        leftContainerView.addSubview(imgvLeft)
        _ = imgvLeft.anchorCenterXAndY(leftContainerView.centerXAnchor, leftContainerView.centerYAnchor, leftContainerWidth-Constants.MARGIN_6, leftContainerWidth-Constants.MARGIN_6)
        imgvLeft.layer.cornerRadius = leftContainerWidth/2-Constants.MARGIN_6/2
        
        //Setup ui for rightContainer
        
        rightContainerView.addSubview(lblRightName)
        _ = lblRightName.anchorTopLeft( rightContainerView.topAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.2,true)
        
        //For price
        rightContainerView.addSubview(lblRightPrice)
        _ = lblRightPrice.anchorTopLeft( lblRightName.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.1)

        rightContainerView.addSubview(lblRightPriceValue)
        _ = lblRightPriceValue.anchorTopLeft( lblRightPrice.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.2,true)

        //For Position
        rightContainerView.addSubview(lblRightPosition)
        _ = lblRightPosition.anchorTopLeft( lblRightPriceValue.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.1)

        rightContainerView.addSubview(lblRightPositionValue)
        _ = lblRightPositionValue.anchorTopLeft( lblRightPosition.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.2,true)

        //For City
        rightContainerView.addSubview(lblRightCity)
        _ = lblRightCity.anchorTopLeft( lblRightPositionValue.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.1)

        rightContainerView.addSubview(lblRightCityValue)
        _ = lblRightCityValue.anchorTopLeft( lblRightCity.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.1,true)
        layoutSubviews()
        layoutIfNeeded()
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(roommate:RoommateModel)  {
        self.imgvLeft.image = roommate.user.image
        self.lblRightName.text = roommate.user.name
        
        
        
        
        self.lblRightPrice.text = "ROMMATE_RIGHT_PRICE".localized
        self.lblRightPriceValue.text = "\(roommate.minPrice)vnd - \(roommate.maxPrice)vnd"
        self.lblRightPosition.text = "ROMMATE_RIGHT_POSITION".localized
        self.lblRightPositionValue.text = roommate.location.joined(separator: ",")
        
//        lblRightPositionValue.lineBreakMode = .byWordWrapping
//        lblRightPositionValue.numberOfLines = 0
//        lblRightPositionValue.sizeToFit()
//        lblRightPositionValue.layoutIfNeeded()
//        lblRightPositionValue.backgroundColor = .green
//
//        lblRightPositionValue.set
        
        self.lblRightCity.text = "ROMMATE_RIGHT_CITY".localized
        self.lblRightCityValue.text = roommate.city
        
        
    }
}
