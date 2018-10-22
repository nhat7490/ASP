//
//  MemberTVCell.swift
//  Roommate
//
//  Created by TrinhHC on 10/2/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
protocol MemberTVCellDelegate:class{
    func memberTVCellDelegate(cell memberTVCell:MemberTVCell,onClickBtnRemoveMember btnRemoveMember:UIButton,atIndexPath indexPath:IndexPath?)
    func memberTVCellDelegate(cell memberTVCell:MemberTVCell,onClickBtnEditMember btnEditMember:UIButton,atIndexPath indexPath:IndexPath?)
}
class MemberTVCell: UITableViewCell {

    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var btnEditMember: UIButton!
    @IBOutlet weak var btnRemoveMember: UIButton!
    weak var delegate:MemberTVCellDelegate?
    var viewType:ViewType?{
        didSet{
            if  viewType == ViewType.detailForMember || viewType == ViewType.detailForMaster{
                btnEditMember.isHidden = true
                btnRemoveMember.isHidden = true
            }else{
                btnEditMember.isHidden = false
                btnRemoveMember.isHidden = false
            }
        }
    }
    var indexPath:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblMemberName.font = .small
        
        btnEditMember.layer.borderColor = UIColor.defaultBlue.cgColor
        btnEditMember.layer.cornerRadius = btnEditMember.frame.width/2
        btnEditMember.layer.borderWidth = 1.0
        
        btnRemoveMember.layer.borderColor = UIColor.defaultBlue.cgColor
        btnRemoveMember.layer.cornerRadius = btnRemoveMember.frame.width/2
        btnRemoveMember.layer.borderWidth = 1.0
        
        
        
        btnEditMember.setBackgroundImage(UIImage(named: "edit"), for: .normal)
        btnRemoveMember.setBackgroundImage(UIImage(named: "remove"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onClickBtnRemoveMember(_ sender: UIButton) {
        delegate?.memberTVCellDelegate(cell: self, onClickBtnRemoveMember: sender,atIndexPath:indexPath)
    }
    @IBAction func onClickBtnEditMember(_ sender: UIButton) {
        delegate?.memberTVCellDelegate(cell: self, onClickBtnEditMember: sender,atIndexPath:indexPath)
    }
}
