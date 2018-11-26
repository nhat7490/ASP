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
    @IBOutlet weak var lblTitleDescription: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var imgvtop: UIImageView!
    @IBOutlet weak var tvInfoTop: UITextView!
    @IBOutlet weak var imgvBottom: UIImageView!
    @IBOutlet weak var lblInfoBottom: UILabel!
    @IBOutlet weak var lblTitleDescriptionHeightConstraint: NSLayoutConstraint!
    var viewType:ViewType?{
        didSet{
//            if viewType == .roomPostDetailForFinder || viewType == .roommatePostDetailForFinder{
//                _ = lblStatus.anchorHeight(equalToConstrant: 0)
//            }
            if viewType == .roommatePostDetailForFinder{
                _ = lblTitleDescription.anchorHeight(equalToConstrant: 0)
            }else{
                lblTitleDescription.textColor = .lightGray
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
        lblTitleDescription.font = .smallTitle
        lblMainTitle.lineBreakMode = .byWordWrapping
        
        lblMainTitle.numberOfLines = 2
        lblSubTitle.font = .smallTitle
        tvInfoTop.font = .small
        lblInfoBottom.font = .small
        
        tvInfoTop.isEditable = false
        tvInfoTop.isUserInteractionEnabled = false
        tvInfoTop.textContainer.lineBreakMode = .byWordWrapping
        
        imgvtop.image = UIImage(named: "address")
        imgvBottom.image = UIImage(named: "area")
    }

}
