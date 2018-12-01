//
//  RateCVCell.swift
//  Roommate
//
//  Created by TrinhHC on 11/28/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import Cosmos
class RateCVCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cvRate: CosmosView!
    var didFinishTouchingRateCVCell: ((Double)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.font = .small
        lblTitle.textColor = .red
        
        cvRate.settings.starSize = Double(frame.width/5-5)
        cvRate.settings.starMargin = 5.0
        cvRate.settings.totalStars = 5
        cvRate.rating = 0
        cvRate.settings.fillMode = .half
        cvRate.settings.emptyImage = UIImage(named: "empty-star")?.withRenderingMode(.alwaysOriginal)
        cvRate.settings.filledImage = UIImage(named: "star")?
            .withRenderingMode(.alwaysOriginal)
        
        cvRate.didFinishTouchingCosmos = { (rate) in
            self.didFinishTouchingRateCVCell?(rate)
        }
        
        
    }

}
