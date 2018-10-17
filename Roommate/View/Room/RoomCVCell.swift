//
//  RoomCell.swift
//  Roommate
//
//  Created by TrinhHC on 9/24/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
protocol RoomCVCellDelegate:class {
    func roomCVCellDelegate(cell roomCVCell:RoomCVCell,onClickUIImageView imgvBookmark:UIImageView,atIndextPath indexPath:IndexPath?);
}

class RoomCVCell:UICollectionViewCell{
    //MARK: Var for Data & Delegate
    var room : RoomPostResponseModel?
    var indexPath:IndexPath?
    weak var delegate:RoomCVCellDelegate?
    
    //MARK: Var for ui
    var mainConstraints: [NSLayoutConstraint]?
    
    let mainContainerView:UIView = {
        let v = UIView()
        return v
    }()
    
    let topContainerView:UIView = {
        let v = UIView()
        return v
    }()
    
    let bottomContainerView:UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var imgvAvatar:UIImageView = {
        let iv = UIImageView()
        iv.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
        iv.contentMode = .scaleAspectFill // OR .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var imgvBookmark:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true
        iv.clipsToBounds = true
        return iv
    }()
    lazy var imgvCertificate:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var lblMaxNumberOfPerson:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize:.small)
        lbl.numberOfLines = 0
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
        //MARK: Setup UI
        //Setup ui for mainContainerview
        let mainContainerWidth = frame.width-1.5*Constants.MARGIN_5
        let mainContainerHeight = frame.height
        
        let topContainerWidth = mainContainerWidth
        let topContainerHeight = mainContainerHeight/2
        
        let bottomContainerWidth = mainContainerWidth
        let bottomContainerHeight = mainContainerHeight/2
        
        addSubview(mainContainerView)
        mainConstraints =  mainContainerView.anchorTopLeft(topAnchor, leftAnchor,0,0, mainContainerWidth, mainContainerHeight)
        
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
        
        //MARK: Setup Event for UI
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickImgvBookmark))
        imgvBookmark.addGestureRecognizer(tap)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(room:RoomPostResponseModel,indexPath:IndexPath,isEvenCell:Bool)  {
        self.room = room
        self.indexPath = indexPath
        imgvAvatar.image = UIImage(named: "room")
        setBookMark(isBookMark: room.favourite!)
        imgvCertificate.image =  UIImage(named: "certificated")
        lblMaxNumberOfPerson.text = room.genderPartner == 1 ?
            String(format: "NUMBER_OF_PERSON".localized,room.numberPartner!,"MALE".localized) :
            room.genderPartner == 2 ? String(format: "NUMBER_OF_PERSON".localized,room.numberPartner!,"FEMALE".localized) :
            String(format: "NUMBER_OF_PERSON".localized,room.numberPartner!,"\("MALE".localized)/\("FEMALE".localized)")
        lblRoomName.text = room.name
        lblPrice.text = String(format: "PRICE_OF_ROOM".localized,room.minPrice!,"PERSON".localized)
        lblLocation.text = room.address
        if !isEvenCell{
            mainConstraints?[1].constant = 1.5*Constants.MARGIN_5
        }else{
            mainConstraints?[1].constant = 0
        }
    }
    
    func setBookMark(isBookMark:Bool){
        imgvBookmark.image = isBookMark ? UIImage(named: "bookmarked") : UIImage(named: "bookmark-white")
    }
    
    override func layoutSubviews() {
        imgvAvatar.layer.cornerRadius = 5
    }
    
    //MARK: Event for UI
    @objc func onClickImgvBookmark(geture:UITapGestureRecognizer) {
        delegate?.roomCVCellDelegate(cell: self, onClickUIImageView: imgvBookmark,atIndextPath: indexPath)
        
    }
    
}
