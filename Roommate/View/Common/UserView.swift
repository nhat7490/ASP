//
//  UserView.swift
//  Roommate
//
//  Created by TrinhHC on 11/7/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import SDWebImage
class UserView: UIView {

    @IBOutlet weak var lbltop: UILabel!
    @IBOutlet weak var lblBottom: UILabel!
    @IBOutlet weak var imgvIcon: UIImageView!
    var user:UserModel?{
        didSet{
//            self.imgvIcon.sd_setImage(with: URL(string: user!.imageProfile!), placeholderImage: UIImage(named:"default_load_room"), options: [.continueInBackground,.retryFailed]) { (image, error, cacheType, url) in
//                guard let image = image else{
//                    return
//                }
//                DispatchQueue.main.async {
//                    self.imgvIcon.image = image
//                }
//            }
            lbltop.text = user!.fullname
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbltop.font = .boldMedium
        
        lblBottom.font = .small
        lblBottom.textColor = .lightGray
        lblBottom.text = "TITLE_USER_DETAIL".localized
        imgvIcon.image = UIImage(named: "right-arrow")
    }

}
