//
//  MemberView.swift
//  Roommate
//
//  Created by TrinhHC on 10/2/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class MembersView: UIView , UITableViewDelegate,UITableViewDataSource , MemberTVCellDelegate {
    

    @IBOutlet weak var lblNumberOfMaxMember: UILabel!
    @IBOutlet weak var lblNumberOfCurrentMember: UILabel!
    @IBOutlet weak var lblNumberOfMemberAdded: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnAddNewMember: UIButton!
    @IBOutlet weak var tblMembers: UITableView!
    
    var users:[User]?{
        didSet{
            tblMembers.delegate = self
            tblMembers.dataSource = self
            
        }
    }
    
    var viewType:DetailViewType?{
        didSet{
            if  viewType == DetailViewType.detailForMember || viewType == DetailViewType.detailForOwner{
                tblMembers.allowsSelection = false
                btnAddNewMember.isHidden = true
            }else{
                btnAddNewMember.isHidden = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = .smallTitle
        lblNumberOfMaxMember.font = .small
        lblNumberOfCurrentMember.font = .small
        lblNumberOfMemberAdded.font = .small
        
        btnAddNewMember.layer.borderColor = UIColor.defaultBlue.cgColor
        btnAddNewMember.layer.cornerRadius = btnAddNewMember.frame.width/2
        btnAddNewMember.layer.borderWidth = 1.0
        btnAddNewMember.setBackgroundImage(UIImage(named: "add"), for: .normal)
        btnAddNewMember.setTitleColor(UIColor.defaultBlue, for: .normal)
        tblMembers.register(UINib(nibName: Constants.CELL_MEMBERTVL, bundle: Bundle.main), forCellReuseIdentifier: Constants.CELL_MEMBERTVL)
        tblMembers.separatorStyle = .none
        layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_MEMBERTVL, for: indexPath) as! MemberTVCell
        cell.viewType = viewType
        cell.indexPath = indexPath
        let user = users![indexPath.row]
        if user.roleInRom == 1{
            //Master
            let name = NSMutableAttributedString(string: "\(user.name) ", attributes: [:])
            name.append(NSAttributedString(string: "ROOM_MASTER".localized, attributes: [NSAttributedStringKey.font : UIFont.small,NSAttributedStringKey.backgroundColor: UIColor.defaultBlue,NSAttributedStringKey.foregroundColor:UIColor.white]))
            cell.lblMemberName.attributedText = name
        }else{
            cell.lblMemberName.text = user.name
        }
        if  viewType == DetailViewType.detailForMember || viewType == DetailViewType.detailForOwner{
            cell.delegate = self
            cell.selectionStyle = .default
        }else{
            cell.selectionStyle = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
    func memberTVCellDelegate(cell memberTVCell: MemberTVCell, onClickBtnEditMember btnRemoveMember: UIButton, atIndexPath indexPath: IndexPath?) {
        guard let row = indexPath?.row, let user = users?[row] else {
            return
        }
        print("Select user \(user) at row \(row) to edit")
    }
    
    func memberTVCellDelegate(cell memberTVCell: MemberTVCell, onClickBtnRemoveMember btnRemoveMember: UIButton, atIndexPath indexPath: IndexPath?) {
        guard let row = indexPath?.row, let user = users?[row] else {
            return
        }
        print("Select user \(user) at row \(row) to remove")
    }
    
    
    
}