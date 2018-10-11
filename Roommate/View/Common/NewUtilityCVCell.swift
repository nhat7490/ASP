//
//  NewUtilityCVCell.swift
//  Roommate
//
//  Created by TrinhHC on 10/5/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
protocol NewUtilityCVCellDelegate:class {
    func newUtilityCVCellDelegate(newUtilityCVCell cell:NewUtilityCVCell,onSelectedUtility utility:UtilityModel)
    
}
class NewUtilityCVCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgvIcon: UIImageView!
    weak var delegate:NewUtilityCVCellDelegate?
    
    
    var data:UtilityModel?{
        didSet{
            lblTitle.text = data?.name?.localized
            imgvIcon.image = UIImage(named: data!.name!)
        }
    }
    var utilityCVCellType:UtilityCVCellType = .detail
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = .small
        lblTitle.textColor = .lightSubTitle
        imgvIcon.tintColor = .lightSubTitle
        self.layer.borderColor = UIColor.lightSubTitle.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = CGFloat((Constants.HEIGHT_CELL_NEW_UTILITY-5)/2)
        imgvIcon.tintColor = .lightGray
    }
    
    override var isSelected: Bool{
        didSet{
            switch utilityCVCellType {
            case .detail:
                break
                //show alert to show detail here
            case .interact:
                //show alert to input detail here
                break
                
            }
        }
    }
}
