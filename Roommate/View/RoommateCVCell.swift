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
    //        let mainContainerView:UIView = {
    //            let v = UIView()
    //            return v
    //        }()
    //
    //        let topContainerView:UIView = {
    //            let v = UIView()
    //    //        v.backgroundColor = .red
    //            return v
    //        }()
    //
    //        let bottomContainerView:UIView = {
    //            let v = UIView()
    //    //         v.backgroundColor = .blue
    //            return v
    //        }()
    //
    //        lazy var imgvAvatar:UIImageView = {
    //            let iv = UIImageView()
    //            iv.contentMode = .scaleAspectFit
    //            //        iv.layer.masksToBounds = true
    //            iv.clipsToBounds = true
    //            return iv
    //        }()
    //
    //        lazy var imgvBookmark:UIImageView = {
    //            let iv = UIImageView()
    //            iv.contentMode = .scaleAspectFit
    //            //        iv.layer.masksToBounds = true
    //            iv.clipsToBounds = true
    //            return iv
    //        }()
    //
    //        lazy var lblName:UILabel = {
    //            let lbl = UILabel()
    //            lbl.font = UIFont.boldSystemFont(ofSize:.medium)
    //            //        lbl.lineBreakMode = .byWordWrapping
    //            lbl.numberOfLines = 0
    //            //        lbl.sizeToFit()
    //            return lbl
    //        }()
    //
    //        lazy var lblPrice:UILabel = {
    //            let lbl = UILabel()
    //            lbl.font = UIFont.systemFont(ofSize: .small)
    //            lbl.textColor = .normalTitle
    //            return lbl
    //        }()
    //
    //        lazy var lblPriceValue:UILabel = {
    //            let lbl = UILabel()
    //            lbl.font = UIFont.boldSystemFont(ofSize: .small)
    //            lbl.numberOfLines = 0
    //            return lbl
    //        }()
    //
    //        lazy var lblPosition:UILabel = {
    //            let lbl = UILabel()
    //            lbl.font = UIFont.systemFont(ofSize:.small)
    //            //        lbl.sizeToFit()
    //            return lbl
    //        }()
    //
    //        lazy var lblPositionValue:UILabel = {
    //            let lbl = UILabel()
    //            lbl.font = UIFont.boldSystemFont(ofSize: .small)
    //            lbl.numberOfLines = 0
    //            //        lbl.sizeToFit()
    //            return lbl
    //        }()
    //
    //        lazy var lblCity:UILabel = {
    //            let lbl = UILabel()
    //            lbl.font = UIFont.systemFont(ofSize:.small)
    //            lbl.numberOfLines = 0
    //            return lbl
    //        }()
    //
    //        lazy var lblCityValue:UILabel = {
    //            let lbl = UILabel()
    //            lbl.font = UIFont.boldSystemFont(ofSize: .small)
    //            //        lbl.sizeToFit()
    //            lbl.numberOfLines = 0
    //            return lbl
    //        }()
    //
    //        lazy var line:UIView = {
    //            let v = UIView()
    //            v.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    //            return v
    //        }()
    //        override init(frame: CGRect) {
    //            super.init(frame: frame)
    //            setupUI()
    //        }
    //        func setupUI() {
    //            //Setup ui for mainContainerview
    //
    //            let mainContainerWidth = frame.width
    //            let mainContainerHeight = frame.height
    //
    //            let topContainerWidth = mainContainerWidth
    //            let topContainerHeight = CGFloat(50)
    //
    //            let bottomContainerWidth = mainContainerWidth
    //            let bottomContainerHeight = mainContainerHeight - topContainerHeight
    //
    //            addSubview(mainContainerView)
    //            _ = mainContainerView.anchorTopLeft(topAnchor, leftAnchor, mainContainerWidth, mainContainerHeight)
    //
    //            addSubview(line)
    //            _ = line.anchorTopLeft(mainContainerView.bottomAnchor, mainContainerView.leftAnchor, mainContainerWidth, 0.5)
    //
    //
    //            //Setup ui for containerview top and bottom
    //
    //            mainContainerView.addSubview(topContainerView)
    //            mainContainerView.addSubview(bottomContainerView)
    //
    //            _ = topContainerView.anchorTopLeft( mainContainerView.topAnchor, mainContainerView.leftAnchor,  topContainerWidth,  topContainerHeight)
    //
    //
    //            _ = bottomContainerView.anchorTopLeft( topContainerView.bottomAnchor,  mainContainerView.leftAnchor,0,Constants.MARGIN_6,bottomContainerWidth,  bottomContainerHeight)
    //
    //            //Setup ui for leftContainer
    //            topContainerView.addSubview(imgvAvatar)
    //            _ = imgvAvatar.anchorTopLeft(topContainerView.topAnchor, topContainerView.leftAnchor, Constants.MARGIN_6/2, 0, topContainerHeight-Constants.MARGIN_6, topContainerHeight - Constants.MARGIN_6)
    //
    //            topContainerView.addSubview(lblName)
    //            _ = lblName.anchorTopLeft( topContainerView.topAnchor,  imgvAvatar.rightAnchor, 0, 2*Constants.MARGIN_6, topContainerWidth -  (topContainerHeight+2*Constants.MARGIN_6)-16, topContainerHeight)
    //
    //            topContainerView.addSubview(imgvBookmark)
    //            _ = imgvBookmark.anchorTopRight(topContainerView.topAnchor, topContainerView.rightAnchor,Constants.MARGIN_6/2,-Constants.MARGIN_5/2, 24, 24)
    //
    //            //Setup ui for bottomContainer
    //
    //            //For price
    //            bottomContainerView.addSubview(lblPrice)
    //            _ = lblPrice.anchorTopLeft( lblName.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.1)
    //
    //            bottomContainerView.addSubview(lblPriceValue)
    //            _ = lblPriceValue.anchorTopLeft( lblPrice.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.2)
    //
    //            //For Position
    //            bottomContainerView.addSubview(lblPosition)
    //            _ = lblPosition.anchorTopLeft( lblPriceValue.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.1)
    //
    //            bottomContainerView.addSubview(lblPositionValue)
    //            _ = lblPositionValue.anchorTopLeft( lblPosition.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.3)
    //
    //            //For City
    //            bottomContainerView.addSubview(lblCity)
    //            _ = lblCity.anchorTopLeft( lblPositionValue.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.1)
    //
    //            bottomContainerView.addSubview(lblCityValue)
    //            _ = lblCityValue.anchorTopLeft( lblCity.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.2)
    //            //        layoutSubviews()
    //            layoutIfNeeded()
    //
    //
    //        }
    //        required init?(coder aDecoder: NSCoder) {
    //            fatalError("init(coder:) has not been implemented")
    //        }
    //
    //        func setData(roommate:Roommate)  {
    //            self.imgvAvatar.image = roommate.user.image
    //            self.lblName.text = roommate.user.name
    //            self.lblPrice.text = "ROMMATE_RIGHT_PRICE".localized
    //            self.lblPriceValue.text = "\(roommate.minPrice)vnd - \(roommate.maxPrice)vnd"
    //            self.lblPosition.text = "ROMMATE_RIGHT_POSITION".localized
    //            self.lblPositionValue.text = roommate.location.joined(separator: ",")
    //            self.lblCity.text = "ROMMATE_RIGHT_CITY".localized
    //            self.lblCityValue.text = roommate.city
    //            self.imgvBookmark.image = roommate.isBookMark ? UIImage(named: "bookmarked"):UIImage(named: "bookmark")
    //        }
    //        override func layoutSubviews() {
    //            imgvAvatar.layer.cornerRadius = (topContainerView.frame.height - Constants.MARGIN_6)/2
    //        }
    
    let mainContainerView:UIView = {
        let v = UIView()
        return v
    }()
    
    let leftContainerView:UIView = {
        let v = UIView()
        return v
    }()
    
    let rightContainerView:UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var imgvLeftAvatar:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        //        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        return iv
    }()
    lazy var imgvLeftBookmark:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
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
        lbl.font = UIFont.systemFont(ofSize: .small)
        lbl.textColor = .normalTitle
        return lbl
    }()
    
    lazy var lblRightPriceValue:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: .small)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var lblRightPosition:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize:.small)
        //        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var lblRightPositionValue:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: .small)
        lbl.numberOfLines = 0
        //        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var lblRightCity:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize:.small)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var lblRightCityValue:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: .small)
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
        
        let leftContainerWidth = mainContainerHeight
        let leftContainerHeight = mainContainerHeight
        
        let rightContainerWidth = mainContainerWidth - leftContainerWidth
        let rightContainerHeight = mainContainerHeight
        
        addSubview(mainContainerView)
        _ = mainContainerView.anchorTopLeft(topAnchor, leftAnchor, mainContainerWidth, mainContainerHeight)
        
        addSubview(line)
        _ = line.anchorTopLeft(mainContainerView.bottomAnchor, mainContainerView.leftAnchor, mainContainerWidth, 0.5)
        
        
        //Setup ui for containerview left and right
        
        mainContainerView.addSubview(leftContainerView)
        mainContainerView.addSubview(rightContainerView)
        
        _ = leftContainerView.anchorTopLeft( mainContainerView.topAnchor, mainContainerView.leftAnchor,  leftContainerWidth,  leftContainerHeight)
        
        
        _ = rightContainerView.anchorTopLeft( mainContainerView.topAnchor,  leftContainerView.rightAnchor,  rightContainerWidth,  rightContainerHeight)
        
        //Setup ui for leftContainer
        leftContainerView.addSubview(imgvLeftAvatar)
        _ = imgvLeftAvatar.anchorCenterXAndY(leftContainerView.centerXAnchor, leftContainerView.centerYAnchor, leftContainerWidth-4*Constants.MARGIN_6, leftContainerHeight-4*Constants.MARGIN_6)
        //        leftContainerView.addSubview(imgvLeftBookmark)
        //        _ = imgvLeftBookmark.anchorTopRight(leftContainerView.topAnchor, leftContainerView.rightAnchor,Constants.MARGIN_6/2,-Constants.MARGIN_5/2, 16, 16)
        
        //Setup ui for rightContainer
        
        //For User name
        rightContainerView.addSubview(lblRightName)
        _ = lblRightName.anchorTopLeft( rightContainerView.topAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.2)
        
        //For price
        rightContainerView.addSubview(lblRightPrice)
        _ = lblRightPrice.anchorTopLeft( lblRightName.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.1)
        
        rightContainerView.addSubview(lblRightPriceValue)
        _ = lblRightPriceValue.anchorTopLeft( lblRightPrice.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.2)
        
        //For Position
        rightContainerView.addSubview(lblRightPosition)
        _ = lblRightPosition.anchorTopLeft( lblRightPriceValue.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.1)
        
        rightContainerView.addSubview(lblRightPositionValue)
        _ = lblRightPositionValue.anchorTopLeft( lblRightPosition.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.2)
        
        //For City
        rightContainerView.addSubview(lblRightCity)
        _ = lblRightCity.anchorTopLeft( lblRightPositionValue.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.1)
        
        rightContainerView.addSubview(lblRightCityValue)
        _ = lblRightCityValue.anchorTopLeft( lblRightCity.bottomAnchor,  rightContainerView.leftAnchor,  rightContainerWidth, rightContainerHeight*0.1)
        
        //For bookmark
        rightContainerView.addSubview(imgvLeftBookmark)
        _ = imgvLeftBookmark.anchorTopRight(rightContainerView.topAnchor, rightContainerView.rightAnchor,Constants.MARGIN_6/2,-Constants.MARGIN_5/2, 22, 22)
        
        
        //        layoutSubviews()
        layoutIfNeeded()
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setData(roommate:RoommateModel)  {
        self.imgvLeftAvatar.image = roommate.user.image
        self.lblRightName.text = roommate.user.name
        self.lblRightPrice.text = "ROMMATE_RIGHT_PRICE".localized
        self.lblRightPriceValue.text = "\(roommate.minPrice)vnd - \(roommate.maxPrice)vnd"
        self.lblRightPosition.text = "ROMMATE_RIGHT_POSITION".localized
        self.lblRightPositionValue.text = roommate.location.joined(separator: ",")
        self.lblRightCity.text = "ROMMATE_RIGHT_CITY".localized
        self.lblRightCityValue.text = roommate.city
        self.imgvLeftBookmark.image = roommate.isBookMark ? UIImage(named: "bookmarked"):UIImage(named: "bookmark")
    }
    override func layoutSubviews() {
        imgvLeftAvatar.layer.cornerRadius = frame.height/2-2*Constants.MARGIN_6
    }
}
