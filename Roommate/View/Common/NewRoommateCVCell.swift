//
//  NewRoommateCVCell.swift
//  Roommate
//
//  Created by TrinhHC on 10/21/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
protocol NewRoommateCVCellDelegate:class{
    func newRoommateCVCellDelegate(newRoommateCVCell cell:NewRoommateCVCell,onClickUIImageView imgvBookmark:UIImageView,atIndextPath indexPath:IndexPath?);
}
class NewRoommateCVCell: UICollectionViewCell {
    @IBOutlet weak var imgvLeftAvatar: UIImageView!
    @IBOutlet weak var imgvLeftBookmark: UIImageView!
    @IBOutlet weak var lblRightName: UILabel!
    @IBOutlet weak var lblRightPrice: UILabel!
    @IBOutlet weak var tvRightPriceValue: UITextView!
    @IBOutlet weak var lblRightPosition: UILabel!
    @IBOutlet weak var tvRightPositionValue: UITextView!
    @IBOutlet weak var lblRightCity: UILabel!
    @IBOutlet weak var tvRightCityValue: UITextView!
    var delegate:NewRoommateCVCellDelegate?
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
            self.tvRightPriceValue.text = "\(roommate!.minPrice.toString)vnd - \(roommate!.maxPrice.toString)vnd"
            self.lblRightPosition.text = "ROMMATE_RIGHT_POSITION".localized
            let dictrictsString = roommate?.districtIds?.map({ (districtId) -> String in
                (DBManager.shared.getRecord(id: districtId, ofType: DistrictModel.self)?.name)!
            })
            self.tvRightPositionValue.text = dictrictsString?.joined(separator: ",")
            self.lblRightCity.text = "ROMMATE_RIGHT_CITY".localized
            self.tvRightCityValue.text = DBManager.shared.getRecord(id: (roommate?.cityId)!, ofType: CityModel.self)?.name
            self.imgvLeftBookmark.image = (roommate?.favourite)! ? UIImage(named: "bookmarked"):UIImage(named: "bookmark-black")
            
        }
    }
    var indexPath:IndexPath?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickImgvBookmark(geture:)))
        imgvLeftBookmark.addGestureRecognizer(tap)
        imgvLeftBookmark.contentMode = .scaleAspectFill
        imgvLeftBookmark.isUserInteractionEnabled = true
        imgvLeftBookmark.clipsToBounds = true
        
        imgvLeftAvatar.contentMode = .scaleAspectFill
        imgvLeftAvatar.clipsToBounds = true
        imgvLeftAvatar.layer.cornerRadius = imgvLeftAvatar.frame.width/2
        
        lblRightName.font = UIFont.boldSystemFont(ofSize:.medium)
        lblRightPrice.font = UIFont.systemFont(ofSize: .small)
        lblRightPosition.font = UIFont.systemFont(ofSize: .small)
        lblRightCity.font = UIFont.systemFont(ofSize: .small)
        
        tvRightPositionValue.font = UIFont.boldSystemFont(ofSize: .small)
        tvRightCityValue.font = UIFont.boldSystemFont(ofSize: .small)
        tvRightPriceValue.font = UIFont.boldSystemFont(ofSize: .small)
        
        tvRightPositionValue.isEditable = false
        tvRightCityValue.isEditable = false
        tvRightPriceValue.isEditable = false
    }
    
    func setBookMark(isBookMark:Bool){
        imgvLeftBookmark.image = isBookMark ? UIImage(named: "bookmarked") : UIImage(named: "bookmark-black")
    }
    
    @objc func onClickImgvBookmark(geture:UITapGestureRecognizer) {
        delegate?.newRoommateCVCellDelegate(newRoommateCVCell: self, onClickUIImageView: imgvLeftBookmark, atIndextPath: indexPath)
        
    }
}
