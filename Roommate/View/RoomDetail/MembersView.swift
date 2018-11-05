//
//  MemberView.swift
//  Roommate
//
//  Created by TrinhHC on 10/2/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
protocol MembersViewDelegate:class{
    func membersViewDelegate(membersView view:MembersView,onDeleteRecordAtIndexPath indexPath:IndexPath?)
    func membersViewDelegate(membersView view:MembersView,onClickBtnEdit button:UIButton)
}
extension MembersViewDelegate{
    func membersViewDelegate(membersView view:MembersView,onDeleteRecordAtIndexPath indexPath:IndexPath?){}
    func membersViewDelegate(membersView view:MembersView,onClickBtnEdit button:UIButton){}
}
class MembersView: UIView , UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var lblLeft: UILabel!
    @IBOutlet weak var lblCenter: UILabel!
    @IBOutlet weak var lblRight: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblUserGuide: UILabel!
    @IBOutlet weak var vInformationHeightConstraint: NSLayoutConstraint!
    var members:[MemberResponseModel]?{
        didSet{
            tableView.reloadData()
        }
    }
    weak var delegate:MembersViewDelegate?
    
    var viewType:ViewType?{
        didSet{
            if viewType == .detailForOwner {
                tableView.allowsMultipleSelectionDuringEditing = false
//                tableView.allowsSelection = false
//                tableView.isEditing = false
                btnRight.isHidden = false
            }else if viewType == .editForOwner{
                tableView.allowsMultipleSelectionDuringEditing = true
                lblUserGuide.text = "USER_GUIDE_SLIDE_TO_DELETE".localized
                btnRight.isHidden = true
            }else{
                tableView.allowsMultipleSelectionDuringEditing = false
//                tableView.allowsSelection = false
//                tableView.isEditing = false
                btnRight.isHidden = true
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = .smallTitle
        lblTitle.text = "ROOM_DETAIL_MEMBER_TITLE".localized
        lblLeft.font = .small
        lblCenter.font = .small
        lblRight.font = .small
        lblUserGuide.font = .verySmall
        
        lblUserGuide.textColor = .red
        
        btnRight.layer.borderColor = UIColor.defaultBlue.cgColor
        btnRight.layer.cornerRadius = 10.0
        btnRight.backgroundColor = .defaultBlue
//        btnRight.layer.borderWidth = 1.0
        btnRight.setTitle("EDIT".localized, for: .normal)
        btnRight.tintColor = .white
        
        tableView.register(UINib(nibName: Constants.CELL_MEMBERTVL, bundle: Bundle.main), forCellReuseIdentifier: Constants.CELL_MEMBERTVL)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_MEMBERTVL, for: indexPath) as! MemberTVCell
        cell.indexPath = indexPath
        let member = members![indexPath.row]
        if member.roleId == Constants.ROOMMASTER{
            //Master
            let name = NSMutableAttributedString(string:"\(member.username!) ", attributes: [NSAttributedStringKey.foregroundColor:UIColor.red])
            name.append(NSAttributedString(string: "ROOM_MASTER".localized, attributes: [NSAttributedStringKey.font : UIFont.small,NSAttributedStringKey.backgroundColor: UIColor.defaultBlue,NSAttributedStringKey.foregroundColor:UIColor.white]))
            cell.lblMemberName.attributedText = name
        }else{
            cell.lblMemberName.attributedText  =  NSMutableAttributedString(string:"\(member.username!) ", attributes: [NSAttributedStringKey.foregroundColor:UIColor.red])
        }
        if  viewType == ViewType.detailForMember || viewType == ViewType.detailForOwner{
            cell.selectionStyle = .default
        }else{
            cell.selectionStyle = .none
        }
        return cell
    }
    func setUserGuide(text:String){
        lblUserGuide.text = text
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.HEIGHT_CELL_MEMBERTVL
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            delegate?.membersViewDelegate(membersView: self, onDeleteRecordAtIndexPath: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if viewType == .editForOwner{
            return .delete
        }else{
            return .none
        }
    }
    
    @IBAction func onClickBtnEdit(_ sender: Any) {
        delegate?.membersViewDelegate(membersView: self, onClickBtnEdit: sender as! UIButton)
    }
    
    
}
