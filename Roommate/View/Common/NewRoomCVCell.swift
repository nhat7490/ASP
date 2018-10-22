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
    @IBOutlet weak var imgvBookMark: UIImageView!
    @IBOutlet weak var imgvAvatar: UIImageView!
    @IBOutlet weak var tvNumberOfPatner: UITextView!
    @IBOutlet weak var tvName: UITextView!
    @IBOutlet weak var tvPrice: UITextView!
    @IBOutlet weak var tvAddress: UITextView!
    var delegate:NewRoomCVCellDelegate?
    var room:RoomPostResponseModel?{
        didSet{
            print(room?.imageUrls?.first)
            imgvAvatar.sd_setImage(with: URL(string: (room?.imageUrls?.first)!), placeholderImage: UIImage(named:"default_load_room"), options: [.continueInBackground,.retryFailed]) { (image, error, cacheType, url) in
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
            print("Gender of patner:\(genderOfPatner)")
            imgvBookMark.image = favorite ? UIImage(named: "bookmarked") : UIImage(named: "bookmark")
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
        imgvAvatar.layer.cornerRadius = 10
        imgvAvatar.clipsToBounds  = true
        
        imgvBookMark.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onClickImgvBookmark(geture:)))
        imgvBookMark.addGestureRecognizer(tap)
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
    }
    
    func setBookMark(isBookMark:Bool){
        imgvBookMark.image = isBookMark ? UIImage(named: "bookmarked") : UIImage(named: "bookmark")
    }
    //MARK: Event for UI
    @objc func onClickImgvBookmark(geture:UITapGestureRecognizer) {
        delegate?.newRoomCVCellDelegate(cell: self, onClickUIImageView: imgvBookMark,atIndextPath: indexPath)
        
    }
}
