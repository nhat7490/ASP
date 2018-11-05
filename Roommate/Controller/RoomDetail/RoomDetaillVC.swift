//
//  RoomDetailVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class RoomDetailVC:BaseVC,UIScrollViewDelegate,OptionViewDelegate,MembersViewDelegate{
    
    var room:RoomResponseModel!{
        didSet{
            if room.members == nil{
                room.members = []
            }
        }
    }
    
    let scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        return sv
        
        
    }()
    let contentView:UIView={
        let cv = UIView()
        return cv
    }()
    var horizontalImagesView:HorizontalImagesView = {
        let hv:HorizontalImagesView = .fromNib()
        return hv
    }()
    
    var baseInformationView:BaseInformationView = {
        let bv:BaseInformationView = .fromNib()
        return bv
    }()
//
//    var genderView:GenderView = {
//        let gv:GenderView = .fromNib()
//        return gv
//    }()
    
    var membersView:MembersView = {
        let mv:MembersView = .fromNib()
        return mv
    }()
    
    var utilitiesView:UtilitiesView = {
        let uv:UtilitiesView = .fromNib()
        return uv
    }()
    
    
    var descriptionsView:DescriptionView = {
        let dv:DescriptionView = .fromNib()
        return dv
    }()
    
    var optionView:OptionView = {
        let ov:OptionView = .fromNib()
        return ov
    }()
    
    var viewType:ViewType = .detailForOwner
    
    
    //MARK: RoomDetailVC
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDelegateAndDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(scrollView.contentSize)
        print(scrollView.frame)
        print(scrollView.bounds)
    }
    
    
    func setupUI() {
        //Navigation bar
        view.backgroundColor = .white
        let backImage = UIImage(named: "back")
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: backImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(onClickBtnBack))
        navigationItem.leftBarButtonItem?.tintColor = .defaultBlue
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        if #available(iOS 11, *){
            scrollView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        //Caculator height
        let padding:UIEdgeInsets = UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10)
        let membersViewHeight:CGFloat
        if room.members?.count != 0{
            membersViewHeight = Constants.HEIGHT_VIEW_MEMBERS
        }else{
            membersViewHeight = 100.0
            showNoDataView(inView: membersView.tableView, withTitle: "NO_MEMBER_ROOM".localized)
        }
        
        
        let numberOfRow = room.utilities.count%2==0 ? room.utilities.count/2 : room.utilities.count/2+1
        let utilitiesViewHeight =  Constants.HEIGHT_CELL_NEW_UTILITYCV * CGFloat(numberOfRow) + 60.0
        let part1 = Constants.HEIGHT_HORIZONTAL_ROOM_VIEW + Constants.HEIGHT_VIEW_BASE_INFORMATION
        let part2 = membersViewHeight + utilitiesViewHeight
        let part3 = Constants.HEIGHT_VIEW_DESCRIPTION + Constants.HEIGHT_LARGE_SPACE
        let totalContentViewHeight = part1 + part2 + part3
        
        //Add View
        view.addSubview(scrollView)
        view.addSubview(optionView)
        scrollView.addSubview(contentView)
        contentView.addSubview(horizontalImagesView)
        contentView.addSubview(baseInformationView)
//        contentView.addSubview(genderView)
        contentView.addSubview(membersView)
        contentView.addSubview(utilitiesView)
        contentView.addSubview(descriptionsView)
        
        
        
        
        //Add Constaints
        _ = scrollView.anchor(view.topAnchor, view.leftAnchor, view.bottomAnchor, view.rightAnchor)
        scrollView.delegate = self
        scrollView.contentSize.height = totalContentViewHeight
        
        _ = contentView.anchor(scrollView.topAnchor, scrollView.leftAnchor, scrollView.bottomAnchor, scrollView.rightAnchor)
        _ = contentView.anchorWidth(equalTo: scrollView.widthAnchor)
        _ = contentView.anchorHeight(equalToConstrant: CGFloat(totalContentViewHeight))
        
        _ = horizontalImagesView.anchor(contentView.topAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, .zero ,CGSize(width: 0, height: Constants.HEIGHT_CELL_IMAGECV))
        _ = baseInformationView.anchor(horizontalImagesView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: Constants.HEIGHT_VIEW_BASE_INFORMATION))
//        _ = genderView.anchor(baseInformationView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: Constants.HEIGHT_VIEW_GENDER))
        _ = membersView.anchor(baseInformationView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: membersViewHeight))
        _ = utilitiesView.anchor(membersView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: utilitiesViewHeight))
        _ = descriptionsView.anchor(utilitiesView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: Constants.HEIGHT_VIEW_DESCRIPTION))
        _ = optionView.anchor(nil, view.leftAnchor, view.bottomAnchor, view.rightAnchor,.zero,CGSize(width: 0, height: Constants.HEIGHT_VIEW_OPTION))
    }
    
    func setDelegateAndDataSource() {
        //Delegate , Datasource and other
        let status = NSAttributedString(string: "ROOM_DETAIL_STATUS_CERTIFICATED".localized, attributes: [NSAttributedStringKey.font : UIFont.boldMedium,
                                                                                                          NSAttributedStringKey.backgroundColor: UIColor.defaultBlue,
                                                                                                          NSAttributedStringKey.foregroundColor:UIColor.white])
        //Data for baseInformationView
        horizontalImagesView.images = room.imageUrls
        baseInformationView.lblMainTitle.text = room.name
        baseInformationView.lblStatus.attributedText = status
        baseInformationView.lblSubTitle.text = "BASE_INFORMATION".localized
        baseInformationView.tvInfoTop.text = room.address
        baseInformationView.lblInfoBottom.text = String(format: "AREA".localized,room.area)
        
//        //Data for genderview
//        genderView.viewType = viewType
//        genderView.genderSelect = room.requiredGender == 1 ? GenderSelect.male : room.requiredGender == 2 ? GenderSelect.male : GenderSelect.both
//        genderView.lblTitle.text = "GENDER_ACCEPT".localized
        
        //Data for memberview
        membersView.viewType = viewType
        membersView.members = room.members
        membersView.delegate = self
        membersView.lblTitle.text = "ROOM_DETAIL_MEMBER_TITLE".localized
        membersView.lblLeft.text = String(format: "ROOM_DETAIL_MAX_NUMBER_OF_MEMBER".localized,room.maxGuest)
        membersView.lblCenter.text = String(format: "ROOM_DETAIL_CURRENT_NUMBER_OF_MEMBER".localized,room.currentMember)
        membersView.lblRight.text = String(format: "ROOM_DETAIL_ADDED_NUMBER_OF_MEMBER".localized,room.members?.count ?? 0)
        
        
        //Data for utilityView
        utilitiesView.lblTitle.text = "UTILITY_TITLE".localized
        utilitiesView.utilities = room.utilities
        
        //Data for descriptionView
        descriptionsView.viewType = viewType
        descriptionsView.lblTitle.text = "DESCRIPTION".localized
        descriptionsView.tvContent.text = room.description
        
        //Data for optionView
        optionView.viewType = viewType
        optionView.delegate = self
        optionView.tvPrice.attributedText = NSAttributedString(string: String(format: "PRICE_OF_ROOM".localized, room.price.formatString,"MONTH".localized), attributes: [NSAttributedStringKey.foregroundColor:UIColor.red])
//        optionView.lblBottom.attributedText = NSAttributedString(string: String(format: "TIME".localized, room.price,"MONTH".localized), attributes: [NSAttributedStringKey.foregroundColor:UIColor.red])
    }
    //MARK: MembersViewDelegate
    func membersViewDelegate(membersView view: MembersView, onClickBtnEdit button:UIButton) {
        let vc = EditMemberVC()
        vc.room = room
        self.navigationController?.pushViewController(vc, animated: true)
//        let mainVC = UIViewController()
//        let nv = UINavigationController(rootViewController: mainVC)
//        present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
    }
    
    
    //MARK: OptionViewDelegate
    func optionViewDelegate(view optionView: OptionView, onClickBtnLeft btnLeft: UIButton) {
        //Valid information at time input. So we dont need to valid here
        switch viewType { 
        case .detailForOwner:
            print("Need to set to show edit screen here")
        case .detailForMember:
            AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_MESSAGE_SMS_ALERT".localized, alertStyle: .alert, forViewController: self,  lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_BUTTON_MESSAGE".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
                
                Utilities.openSystemApp(type: .message, forController: self, withContent: "0918170105", completionHander: nil)
            })
        default:
            break
        }
    }
    
    func optionViewDelegate(view optionView: OptionView, onClickBtnRight btnRight: UIButton) {
        switch viewType {
        case .detailForOwner:
            AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_TITLE_DELETE_ROOM".localized, alertStyle: .alert, forViewController: self, lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_DELETE_ROOM_OK".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
                
                Utilities.openSystemApp(type: .phone, forController: self, withContent: "0918170105", completionHander: nil)
            })
        case .detailForMember:
            AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_MESSAGE_SMS_ALERT".localized, alertStyle: .alert, forViewController: self, lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_BUTTON_CALL".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
                
                Utilities.openSystemApp(type: .phone, forController: self, withContent: "0918170105", completionHander: nil)
            })
        case .createForOwner:
            break
        default:
            break
        }
        
    }
    //MARK: Back button on navigation bar
    @objc func onClickBtnBack(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
