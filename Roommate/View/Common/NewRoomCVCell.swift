//
//  RoomCVCell.swift
//  Roommate
//
//  Created by TrinhHC on 10/17/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import SDWebImage
protocol NewRoomCVCellDelegate:class {
    func newRoomCVCellDelegate(cell roomCVCell:NewRoomCVCell,onClickUIImageView imgvBookmark:UIImageView,atIndextPath indexPath:IndexPath?);
}
class NewRoomCVCell: UICollectionViewCell {
    @IBOutlet weak var imgvFavorite: UIImageView!
    @IBOutlet weak var imgvAvatar: UIImageView!
    @IBOutlet weak var tvNumberOfPatner: UITextView!
    @IBOutlet weak var tvName: UITextView!
    @IBOutlet weak var tvPrice: UITextView!
    @IBOutlet weak var tvAddress: UITextView!
    var delegate:NewRoomCVCellDelegate?
    var room:RoomPostResponseModel?{
        didSet{
            imgvAvatar.sd_setImage(with: URL(string: (room?.imageUrls?.first)!), placeholderImage: UIImage(named:"default_load_room"), options: [.continueInBackground,.scaleDownLargeImages,.retryFailed,]) { (image, error, cacheType, url) in
                guard let image = image else{
                    return
                }
                DispatchQueue.main.async {
                    self.imgvAvatar.image = image
                }
            }
            guard let favorite = room?.favourite ,let genderOfPatner = room?.genderPartner,let numberOfPatner = room?.numberPartner,let name = room?.name,let price = room?.minPrice,let address = room?.address else {
                return
            }
            imgvFavorite.image = favorite ? UIImage(named: "bookmarked") : UIImage(named: "bookmark-white")
            tvNumberOfPatner.text = genderOfPatner == 1 ? String(format: "NUMBER_OF_PERSON".localized,numberOfPatner,"MALE".localized) :
                genderOfPatner == 2 ? String(format: "NUMBER_OF_PERSON".localized,numberOfPatner,"FEMALE".localized) : String(format: "NUMBER_OF_PERSON".localized,numberOfPatner,"\("MALE".localized)/\("FEMALE".localized)")
            tvName.text = name
            tvPrice.text = String(format: "PRICE_OF_ROOM".localized,price,"PERSON".localized)
            tvAddress.text = address
        }
    }
    var indexPath:IndexPath?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        imgvAvatar.layer.cornerRadius = 5
        imgvAvatar.clipsToBounds  = true
        tvNumberOfPatner.isEditable = false
        tvName.isEditable = false
        tvPrice.isEditable = false
        tvAddress.isEditable = false
        
        tvNumberOfPatner.font = .verySmall
        tvName.font = .medium
        tvPrice.font = .small
        tvAddress.font = .small
        
        tvPrice.textColor = .defaultBlue
        tvNumberOfPatner.textColor = .lightGray
        
        imgvFavorite.image = UIImage(named: "bookmark-white")
        //MARK: Setup Event for bookmark
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickImgvBookmark(geture:)))
        imgvFavorite.addGestureRecognizer(tap)
    }
    
    func setBookMark(isBookMark:Bool){
        imgvFavorite.image = isBookMark ? UIImage(named: "bookmarked") : UIImage(named: "bookmark-white")
    }
    //MARK: Event for UI
    @objc func onClickImgvBookmark(geture:UITapGestureRecognizer) {
        delegate?.newRoomCVCellDelegate(cell: self, onClickUIImageView: imgvFavorite,atIndextPath: indexPath)
        
    }
}
