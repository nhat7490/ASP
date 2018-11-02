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
    @IBOutlet weak var imgvtop: UIImageView!
    @IBOutlet weak var lblInfoTop: UILabel!
    @IBOutlet weak var imgvBottom: UIImageView!
    @IBOutlet weak var lblInfoBottom: UILabel!
    @IBOutlet weak var lblStatusHeightConstraint: NSLayoutConstraint!
    var viewType:ViewType?{
        didSet{
            if viewType == .roomPostDetailForFinder || viewType == .roommatePostDetailForFinder{
                lblStatus.anchorHeight(equalToConstrant: 0)
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblMainTitle.font = .boldMedium
        lblMainTitle.textColor = .red
        lblStatus.font = .smallTitle
        lblMainTitle.lineBreakMode = .byWordWrapping
        lblMainTitle.numberOfLines = 2
        lblSubTitle.font = .smallTitle
        lblInfoTop.font = .small
        lblInfoBottom.font = .small
        imgvtop.image = UIImage(named: "address")
        imgvBottom.image = UIImage(named: "area")
    }

}
