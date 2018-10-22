//
//  RoomCVCell.swift
//  Roommate
//
//  Created by TrinhHC on 9/22/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
protocol RoommateCVCellDelegate:class{
    func roommateCVCellDelegate(roommateCVCell cell:RoommateCVCell,onClickUIImageView imgvBookmark:UIImageView,atIndextPath indexPath:IndexPath?);
}
class RoommateCVCell:UICollectionViewCell{

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
        iv.isUserInteractionEnabled = true
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
    
    var delegate:RoommateCVCellDelegate?
    var roommate:RoommatePostResponseModel?{
        didSet{
            self.imgvLeftAvatar.sd_setImage(with: URL(string: (roommate?.userResponseModel?.imageProfile)!), placeholderImage: UIImage(named:"default_load_room"), options: [.continueInBackground,.retryFailed]) { (image, error, cacheType, url) in
                guard let image = image else{
                    return
                }
                DispatchQueue.main.async {
                    self.imgvLeftAvatar.image = image
                }
            }
            self.lblRightName.text = roommate?.userResponseModel?.fullname
            self.lblRightPrice.text = "ROMMATE_RIGHT_PRICE".localized
            self.lblRightPriceValue.text = "\(roommate!.minPrice.toString)vnd - \(roommate!.maxPrice.toString)vnd"
            self.lblRightPosition.text = "ROMMATE_RIGHT_POSITION".localized
            let dictrictsString = roommate?.districtIds?.map({ (districtId) -> String in
                (DBManager.shared.getRecord(id: districtId, ofType: DistrictModel.self)?.name)!
            })
            self.lblRightPositionValue.text = dictrictsString?.joined(separator: ",")
            self.lblRightCity.text = "ROMMATE_RIGHT_CITY".localized
            self.lblRightCityValue.text = DBManager.shared.getRecord(id: (roommate?.cityId)!, ofType: CityModel.self)?.name
            self.imgvLeftBookmark.image = (roommate?.favourite)! ? UIImage(named: "bookmarked"):UIImage(named: "bookmark")
        }
    }
    var indexPath:IndexPath?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupDelegate()
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
        
        layoutIfNeeded()
        
        
    }
    
    func setupDelegate()  {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickImgvBookmark(geture:)))
        imgvLeftBookmark.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        imgvLeftAvatar.layer.cornerRadius = frame.height/2-2*Constants.MARGIN_6
    }
    
    //MARK: Event for UI
    @objc func onClickImgvBookmark(geture:UITapGestureRecognizer) {
        delegate?.roommateCVCellDelegate(roommateCVCell: self, onClickUIImageView: imgvLeftBookmark, atIndextPath: indexPath)
        
    }
}
