//
//  ImageCVCell.swift
//  Roommate
//
//  Created by TrinhHC on 10/1/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
class ImageCVCell:UICollectionViewCell {
    
    @IBOutlet weak var imgvRoom: UIImageView!
    var link_url:String?{
        didSet{
            sd_showActivityIndicatorView()
            sd_setIndicatorStyle(.gray)
            imgvRoom.sd_setImage(with: URL(string: link_url!), placeholderImage: UIImage(named: "default_load_room"), options: [.continueInBackground,.retryFailed]) { [weak self] (image, error, cacheType, url) in
                guard let _ = error else{
                    return
                }
                self?.imgvRoom.image = image
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
