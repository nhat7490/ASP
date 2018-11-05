//
//  MemberTVCell.swift
//  Roommate
//
//  Created by TrinhHC on 10/2/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
class MemberTVCell: UITableViewCell {

    @IBOutlet weak var lblMemberName: UILabel!
    var indexPath:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblMemberName.font = .small
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
