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
        let mainContainerView:UIView = {
            let v = UIView()
            return v
        }()
    
        let topContainerView:UIView = {
            let v = UIView()
    //        v.backgroundColor = .red
            return v
        }()
    
        let bottomContainerView:UIView = {
            let v = UIView()
    //         v.backgroundColor = .blue
            return v
        }()
    
        lazy var imgvTopAvatar:UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            //        iv.layer.masksToBounds = true
            iv.clipsToBounds = true
            return iv
        }()
    
        lazy var imgvTopBookmark:UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFit
            //        iv.layer.masksToBounds = true
            iv.clipsToBounds = true
            return iv
        }()
    
        lazy var lblBottomName:UILabel = {
            let lbl = UILabel()
            lbl.font = UIFont.boldSystemFont(ofSize:.medium)
            //        lbl.lineBreakMode = .byWordWrapping
            lbl.numberOfLines = 0
            //        lbl.sizeToFit()
            return lbl
        }()
    
        lazy var lblBottomPrice:UILabel = {
            let lbl = UILabel()
            lbl.font = UIFont.systemFont(ofSize: .verySmall)
            lbl.textColor = .normalTitle
            return lbl
        }()
    
        lazy var lblBottomPriceValue:UILabel = {
            let lbl = UILabel()
            lbl.font = UIFont.boldSystemFont(ofSize: .verySmall)
            lbl.numberOfLines = 0
            return lbl
        }()
    
        lazy var lblBottomPosition:UILabel = {
            let lbl = UILabel()
            lbl.font = UIFont.systemFont(ofSize:.verySmall)
            //        lbl.sizeToFit()
            return lbl
        }()
    
        lazy var lblBottomPositionValue:UILabel = {
            let lbl = UILabel()
            lbl.font = UIFont.boldSystemFont(ofSize: .verySmall)
            lbl.numberOfLines = 0
            //        lbl.sizeToFit()
            return lbl
        }()
    
        lazy var lblBottomCity:UILabel = {
            let lbl = UILabel()
            lbl.font = UIFont.systemFont(ofSize:.verySmall)
            lbl.numberOfLines = 0
            return lbl
        }()
    
        lazy var lblBottomCityValue:UILabel = {
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
    
            let mainContainerWidth = frame.width
            let mainContainerHeight = frame.height
    
            let topContainerWidth = mainContainerWidth
            let topContainerHeight = CGFloat(50)
    
            let bottomContainerWidth = mainContainerWidth-2*Constants.MARGIN_6
            let bottomContainerHeight = mainContainerHeight - topContainerHeight
    
            addSubview(mainContainerView)
            _ = mainContainerView.anchorTopLeft(topAnchor, leftAnchor, mainContainerWidth, mainContainerHeight)
    
            addSubview(line)
            _ = line.anchorTopLeft(mainContainerView.bottomAnchor, mainContainerView.leftAnchor, mainContainerWidth, 0.5)
    
    
            //Setup ui for containerview left and right
    
            mainContainerView.addSubview(topContainerView)
            mainContainerView.addSubview(bottomContainerView)
    
            _ = topContainerView.anchorTopLeft( mainContainerView.topAnchor, mainContainerView.leftAnchor,  topContainerWidth,  topContainerHeight)
    
    
            _ = bottomContainerView.anchorTopLeft( topContainerView.bottomAnchor,  mainContainerView.leftAnchor,0,Constants.MARGIN_6,bottomContainerWidth,  bottomContainerHeight)
    
            //Setup ui for leftContainer
            topContainerView.addSubview(imgvTopAvatar)
            _ = imgvTopAvatar.anchorTopLeft(topContainerView.topAnchor, topContainerView.leftAnchor, Constants.MARGIN_6/2, 0, topContainerHeight-Constants.MARGIN_6, topContainerHeight - Constants.MARGIN_6)
    
            topContainerView.addSubview(lblBottomName)
            _ = lblBottomName.anchorTopLeft( topContainerView.topAnchor,  imgvTopAvatar.rightAnchor, 0, 2*Constants.MARGIN_6, topContainerWidth -  (topContainerHeight+2*Constants.MARGIN_6)-16, topContainerHeight)
    
            topContainerView.addSubview(imgvTopBookmark)
            _ = imgvTopBookmark.anchorTopRight(topContainerView.topAnchor, topContainerView.rightAnchor,Constants.MARGIN_6/2,-Constants.MARGIN_5/2, 16, 16)
    
            //Setup ui for rightContainer
    
            //For price
            bottomContainerView.addSubview(lblBottomPrice)
            _ = lblBottomPrice.anchorTopLeft( lblBottomName.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.1)
    
            bottomContainerView.addSubview(lblBottomPriceValue)
            _ = lblBottomPriceValue.anchorTopLeft( lblBottomPrice.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.2)
    
            //For Position
            bottomContainerView.addSubview(lblBottomPosition)
            _ = lblBottomPosition.anchorTopLeft( lblBottomPriceValue.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.1)
    
            bottomContainerView.addSubview(lblBottomPositionValue)
            _ = lblBottomPositionValue.anchorTopLeft( lblBottomPosition.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.2)
    
            //For City
            bottomContainerView.addSubview(lblBottomCity)
            _ = lblBottomCity.anchorTopLeft( lblBottomPositionValue.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.1)
    
            bottomContainerView.addSubview(lblBottomCityValue)
            _ = lblBottomCityValue.anchorTopLeft( lblBottomCity.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.1)
            //        layoutSubviews()
            layoutIfNeeded()
    
    
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        func setModel(roommate:RoommateModel)  {
            self.imgvTopAvatar.image = roommate.user.image
            self.lblBottomName.text = roommate.user.name
            self.lblBottomPrice.text = "ROMMATE_RIGHT_PRICE".localized
            self.lblBottomPriceValue.text = "\(roommate.minPrice)vnd - \(roommate.maxPrice)vnd"
            self.lblBottomPosition.text = "ROMMATE_RIGHT_POSITION".localized
            self.lblBottomPositionValue.text = roommate.location.joined(separator: ",")
            self.lblBottomCity.text = "ROMMATE_RIGHT_CITY".localized
            self.lblBottomCityValue.text = roommate.city
            self.imgvTopBookmark.image = roommate.isBookMark ? UIImage(named: "bookmarked"):UIImage(named: "bookmark")
        }
        override func layoutSubviews() {
            imgvTopAvatar.layer.cornerRadius = (topContainerView.frame.height - Constants.MARGIN_6)/2
        }
//
//    let mainContainerView:UIView = {
//        let v = UIView()
//        return v
//    }()
//
//    let leftContainerView:UIView = {
//        let v = UIView()
//        return v
//    }()
//
//    let rightContainerView:UIView = {
//        let v = UIView()
//        return v
//    }()
//
//    lazy var imgvLeftAvatar:UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFit
//        //        iv.layer.masksToBounds = true
//        iv.clipsToBounds = true
//        return iv
//    }()
//    lazy var imgvLeftBookmark:UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFit
//        //        iv.layer.masksToBounds = true
//        iv.clipsToBounds = true
//        return iv
//    }()
//
//    lazy var lblRightName:UILabel = {
//        let lbl = UILabel()
//        lbl.font = UIFont.boldSystemFont(ofSize:.medium)
//        //        lbl.lineBreakMode = .byWordWrapping
//        lbl.numberOfLines = 0
//        //        lbl.sizeToFit()
//        return lbl
//    }()
//
//    lazy var lblRightPrice:UILabel = {
//        let lbl = UILabel()
//        lbl.font = UIFont.systemFont(ofSize: .verySmall)
//        lbl.textColor = .normalTitle
//        return lbl
//    }()
//
//    lazy var lblRightPriceValue:UILabel = {
//        let lbl = UILabel()
//        lbl.font = UIFont.boldSystemFont(ofSize: .verySmall)
//        lbl.numberOfLines = 0
//        return lbl
//    }()
//
//    lazy var lblRightPosition:UILabel = {
//        let lbl = UILabel()
//        lbl.font = UIFont.systemFont(ofSize:.verySmall)
//        //        lbl.sizeToFit()
//        return lbl
//    }()
//
//    lazy var lblRightPositionValue:UILabel = {
//        let lbl = UILabel()
//        lbl.font = UIFont.boldSystemFont(ofSize: .verySmall)
//        lbl.numberOfLines = 0
//        //        lbl.sizeToFit()
//        return lbl
//    }()
//
//    lazy var lblRightCity:UILabel = {
//        let lbl = UILabel()
//        lbl.font = UIFont.systemFont(ofSize:.verySmall)
//        lbl.numberOfLines = 0
//        return lbl
//    }()
//
//    lazy var lblRightCityValue:UILabel = {
//        let lbl = UILabel()
//        lbl.font = UIFont.boldSystemFont(ofSize: .verySmall)
//        //        lbl.sizeToFit()
//        lbl.numberOfLines = 0
//        return lbl
//    }()
//
//    lazy var line:UIView = {
//        let v = UIView()
//        v.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
//        return v
//    }()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    func setupUI() {
//        //Setup ui for mainContainerview
//
//        let mainContainerWidth = frame.width
//        let mainContainerHeight = frame.height
//
//        let leftContainerWidth = CGFloat(80)
//        let leftContainerWHeight = mainContainerHeight
//
//        let rightContainerWidth = mainContainerWidth - leftContainerWidth
//        let rightContainerHeight = mainContainerHeight
//
//        addSubview(mainContainerView)
//        _ = mainContainerView.anchorTopLeft(topAnchor, leftAnchor, mainContainerWidth, mainContainerHeight)
//
//        addSubview(line)
//        _ = line.anchorTopLeft(mainContainerView.bottomAnchor, mainContainerView.leftAnchor, mainContainerWidth, 0.5)
//
//
//        //Setup ui for containerview left and right
//
//        mainContainerView.addSubview(leftContainerView)
//        mainContainerView.addSubview(rightContainerView)
//
//        _ = leftContainerView.anchorTopLeft( mainContainerView.topAnchor, mainContainerView.leftAnchor,  leftContainerWidth,  leftContainerWHeight)
//
//
//        _ = rightContainerView.anchorTopLeft( mainContainerView.topAnchor,  leftContainerView.rightAnchor,  rightContainerWidth,  rightContainerHeight)
//
//        //Setup ui for leftContainer
//        leftContainerView.addSubview(imgvLeftAvatar)
//        _ = imgvLeftAvatar.anchorCenterXAndY(leftContainerView.centerXAnchor, leftContainerView.centerYAnchor, leftContainerWidth-Constants.MARGIN_6, leftContainerWidth-Constants.MARGIN_6)
//        leftContainerView.addSubview(imgvLeftBookmark)
//        _ = imgvLeftBookmark.anchorTopRight(leftContainerView.topAnchor, leftContainerView.rightAnchor,Constants.MARGIN_6/2,-Constants.MARGIN_5/2, 16, 16)
//
//        //Setup ui for rightContainer
//
//        rightContainerView.addSubview(lblRightName)
//        _ = lblRightName.anchorTopLeft( rightContainerView.topAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.2)
//
//        //For price
//        rightContainerView.addSubview(lblRightPrice)
//        _ = lblRightPrice.anchorTopLeft( lblRightName.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.1)
//
//        rightContainerView.addSubview(lblRightPriceValue)
//        _ = lblRightPriceValue.anchorTopLeft( lblRightPrice.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.2)
//
//        //For Position
//        rightContainerView.addSubview(lblRightPosition)
//        _ = lblRightPosition.anchorTopLeft( lblRightPriceValue.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.1)
//
//        rightContainerView.addSubview(lblRightPositionValue)
//        _ = lblRightPositionValue.anchorTopLeft( lblRightPosition.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.2)
//
//        //For City
//        rightContainerView.addSubview(lblRightCity)
//        _ = lblRightCity.anchorTopLeft( lblRightPositionValue.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.1)
//
//        rightContainerView.addSubview(lblRightCityValue)
//        _ = lblRightCityValue.anchorTopLeft( lblRightCity.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.1)
//        //        layoutSubviews()
//        layoutIfNeeded()
//
//
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    func setModel(roommate:RoommateModel)  {
//        self.imgvLeftAvatar.image = roommate.user.image
//        self.lblRightName.text = roommate.user.name
//        self.lblRightPrice.text = "ROMMATE_RIGHT_PRICE".localized
//        self.lblRightPriceValue.text = "\(roommate.minPrice)vnd - \(roommate.maxPrice)vnd"
//        self.lblRightPosition.text = "ROMMATE_RIGHT_POSITION".localized
//        self.lblRightPositionValue.text = roommate.location.joined(separator: ",")
//        self.lblRightCity.text = "ROMMATE_RIGHT_CITY".localized
//        self.lblRightCityValue.text = roommate.city
//        self.imgvLeftBookmark.image = roommate.isBookMark ? UIImage(named: "bookmarked"):UIImage(named: "bookmark")
//    }
//    override func layoutSubviews() {
//        imgvLeftAvatar.layer.cornerRadius = leftContainerView.frame.width/2-Constants.MARGIN_6/2
//    }
}
