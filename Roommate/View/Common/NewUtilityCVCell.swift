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
            lblTitle.text = DBManager.shared.getRecord(id: (data?.utilityId)!, ofType: UtilityModel.self)?.name
            imgvIcon.image = UIImage(named: "cctv")
        }
    }
    var utilityCVCellType:UtilityCVCellType = .detail
    
    required init?(coder aDecoder: NSCoder) {
        self.isSetSelected = false
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = .boldSmall
        self.layer.backgroundColor = UIColor.white.cgColor
        lblTitle.textColor = .lightSubTitle
        imgvIcon.tintColor = .lightSubTitle
        self.layer.borderColor = UIColor.lightSubTitle.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = CGFloat((Constants.HEIGHT_CELL_NEW_UTILITYCV-5)/2)
        imgvIcon.tintColor = .lightGray
    }
    
    var isSetSelected: Bool{
        didSet{
            if isSetSelected{
                self.layer.backgroundColor = UIColor.defaultBlue.cgColor
                lblTitle.textColor = .white
                imgvIcon.tintColor = .white
                self.layer.borderWidth = 0
                imgvIcon.tintColor = .white
            }else{
                self.layer.backgroundColor = UIColor.white.cgColor
                lblTitle.textColor = .lightSubTitle
                imgvIcon.tintColor = .lightSubTitle
                self.layer.borderColor = UIColor.lightSubTitle.cgColor
                self.layer.borderWidth = 1.0
                imgvIcon.tintColor = .lightGray
            }
        }
    }
}
