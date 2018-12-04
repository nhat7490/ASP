//
//  SingleRateView.swift
//  Roommate
//
//  Created by TrinhHC on 12/2/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import Cosmos
class SingleRateView: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cvRate: CosmosView!
    var singleRateViewType:SingleRateViewType = .security{
        didSet{
            var text  = ""
            switch singleRateViewType{
                case .security:
                    text = "RATE_ROOM_SECURITY"
                case .location:
                    text = "RATE_ROOM_LOCATION"
                case .utility:
                    text = "RATE_ROOM_UTILITY"
                case .behavior:
                    text = "RATE_POST_BEHAVIOR"
                case .lifestyle:
                    text = "RATE_ROOM_LIFESTYLE"
                case .payment:
                    text = "RATE_ROOM_PAYMENT"
            }
            lblTitle.text = text.localized
        }
    }
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
