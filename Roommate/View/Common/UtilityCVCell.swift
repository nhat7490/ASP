//
//  UtilityCVCellCollectionViewCell.swift
//  Roommate
//
//  Created by TrinhHC on 9/30/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class UtilityCVCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgvIcon: UIImageView!
    @IBOutlet weak var imgvSelected: UIImageView!
    var data:UtilityModel?{
        didSet{
            lblTitle.text = data?.name?.localized
            imgvIcon.image = UIImage(named: data!.name!)
        }
    }
    
//    override var isSelected: Bool{
//        didSet{
//            contentView.backgroundColor = isSelected ? .defaultBlue : .white
//        }
//    }
    
    //storage property
    var isSelectedUtility:Bool?{
        didSet{
            imgvSelected.image =  isSelectedUtility! ? UIImage(named:"selected_circle") : UIImage(named:"select_circle")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = .small
    }
}
