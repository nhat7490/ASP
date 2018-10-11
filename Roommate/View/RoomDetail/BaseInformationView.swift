//
//  AddressView.swift
//  Roommate
//
//  Created by TrinhHC on 10/1/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class BaseInformationView: UIView {
    

    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var imgvAddress: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgvArea: UIImageView!
    @IBOutlet weak var lblArea: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblMainTitle.font = .boldMedium
        lblStatus.font = .smallTitle
        lblMainTitle.lineBreakMode = .byWordWrapping
        lblMainTitle.numberOfLines = 2
        lblSubTitle.font = .smallTitle
        lblAddress.font = .small
        lblArea.font = .small
        imgvAddress.image = UIImage(named: "address")
        imgvArea.image = UIImage(named: "area")
    }

}
