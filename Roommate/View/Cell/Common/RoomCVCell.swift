//
//  RoomCell.swift
//  Roommate
//
//  Created by TrinhHC on 9/24/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class RoomCVCell:UICollectionViewCell{
    let mainContainerView:UIView = {
        let v = UIView()
        return v
    }()
    
    let topContainerView:UIView = {
        let v = UIView()
//                v.backgroundColor = .red
        return v
    }()
    
    let bottomContainerView:UIView = {
        let v = UIView()
//                 v.backgroundColor = .blue
        return v
    }()
    
    lazy var imgvAvatar:UIImageView = {
        let iv = UIImageView()
        iv.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        iv.contentMode = .scaleAspectFill // OR .scaleAspectFill
        //        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var imgvBookmark:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        //        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        return iv
    }()
    lazy var imgvCertificate:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        //        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var lblMaxNumberOfPerson:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize:.small)
        //        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        //        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var lblRoomName:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: .medium)
        lbl.textColor = .normalTitle
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var lblPrice:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: .small)
        lbl.textColor = UIColor(hexString: Constants.COLOR_SUB_TITLE_DEFAULT)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var lblLocation:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize:.small)
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
        
        let mainContainerWidth = frame.width-Constants.MARGIN_6/2
        let mainContainerHeight = frame.height
        
        let topContainerWidth = mainContainerWidth
        let topContainerHeight = mainContainerHeight/2
        
        let bottomContainerWidth = mainContainerWidth
        let bottomContainerHeight = mainContainerHeight/2
        
        addSubview(mainContainerView)
        _ = mainContainerView.anchorTopLeft(topAnchor, leftAnchor, mainContainerWidth, mainContainerHeight)
        
        addSubview(line)
        _ = line.anchorTopLeft(mainContainerView.bottomAnchor, mainContainerView.leftAnchor, mainContainerWidth, 0.5)
        
        
        //Setup ui for containerview top and bottom
        
        mainContainerView.addSubview(topContainerView)
        mainContainerView.addSubview(bottomContainerView)
        
        _ = topContainerView.anchorTopLeft( mainContainerView.topAnchor, mainContainerView.leftAnchor,  topContainerWidth,  topContainerHeight)
        
        
        _ = bottomContainerView.anchorTopLeft( topContainerView.bottomAnchor,  mainContainerView.leftAnchor,bottomContainerWidth,  bottomContainerHeight)
        
        //Setup ui for topContainer
        
        //For image
        topContainerView.addSubview(imgvAvatar)
        _ = imgvAvatar.anchorCenterXAndY(topContainerView.centerXAnchor, topContainerView.centerYAnchor,topContainerWidth,topContainerHeight)
        
        topContainerView.addSubview(imgvBookmark)
        _ = imgvBookmark.anchorTopRight(topContainerView.topAnchor, topContainerView.rightAnchor,Constants.MARGIN_6/2,-Constants.MARGIN_5/2, 24, 24)

        topContainerView.addSubview(imgvCertificate)
        _ = imgvCertificate.anchorBottomRight(topContainerView.bottomAnchor, topContainerView.rightAnchor,-Constants.MARGIN_6/2,-Constants.MARGIN_5/2, 24, 24)
        


        //Setup ui for BottomContainer

        //For number of person
        bottomContainerView.addSubview(lblMaxNumberOfPerson)
        _ = lblMaxNumberOfPerson.anchorTopLeft( bottomContainerView.topAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.2)

        //For room name
        bottomContainerView.addSubview(lblRoomName)
        _ = lblRoomName.anchorTopLeft( lblMaxNumberOfPerson.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.3)

        //For price
        bottomContainerView.addSubview(lblPrice)
        _ = lblPrice.anchorTopLeft( lblRoomName.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.2)

        //For location
        bottomContainerView.addSubview(lblLocation)
        _ = lblLocation.anchorTopLeft( lblPrice.bottomAnchor,  bottomContainerView.leftAnchor,  bottomContainerWidth, bottomContainerHeight*0.3)
//
        layoutIfNeeded()
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(room:Room)  {
        imgvAvatar.image = UIImage(named: "room")
        imgvBookmark.image = room.isBookMark ? UIImage(named: "bookmarked") : UIImage(named: "bookmark-white")
        imgvCertificate.image = room.isCertificate ? UIImage(named: "certificated") : UIImage(named: "certificate")
        lblMaxNumberOfPerson.text = room.gender == 1 ?
                                                        String(format: "NUMBER_OF_PERSON".localized,room.numberPerson,"MALE".localized) :
                                    room.gender == 2 ? String(format: "NUMBER_OF_PERSON".localized,room.numberPerson,"FEMALE".localized) :
                                                        String(format: "NUMBER_OF_PERSON".localized,room.numberPerson,"\("MALE".localized)/\("FEMALE".localized)")
        lblRoomName.text = room.name
        lblPrice.text = String(format: "PRICE_OF_ROOM".localized,room.price,"PERSON".localized)
        lblLocation.text = room.location
    }
    override func layoutSubviews() {
        imgvAvatar.layer.cornerRadius = 5
    }
}
