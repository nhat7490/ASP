//
//  RoomDetailVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import MBProgressHUD
class RoomDetailVC:BaseAutoHideNavigationVC,OptionViewDelegate,MembersViewDelegate,UtilitiesViewDelegate,BaseInformationViewDelegate{
    
    
    
    var room: RoomMappableModel!{
        didSet{
            if room.members == nil{
                room.members = []
            }
        }
    }

    lazy var scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.delegate = self
        return sv
        
        
    }()
    lazy var contentView:UIView={
        let cv = UIView()
        return cv
    }()
    
    lazy var horizontalImagesView:HorizontalImagesView = {
        let hv:HorizontalImagesView = .fromNib()
        return hv
    }()
    
    lazy var baseInformationView:BaseInformationView = {
        let bv:BaseInformationView = .fromNib()
        return bv
    }()
//
//    var genderView:GenderView = {
//        let gv:GenderView = .fromNib()
//        return gv
//    }()

    lazy var membersView:MembersView = {
        let mv:MembersView = .fromNib()
        return mv
    }()

    lazy var utilitiesView:UtilitiesView = {
        let uv:UtilitiesView = .fromNib()
        return uv
    }()


    lazy var descriptionsView:DescriptionView = {
        let dv:DescriptionView = .fromNib()
        return dv
    }()

    lazy var optionView:OptionView = {
        let ov:OptionView = .fromNib()
        return ov
    }()

    lazy var viewType:ViewType = .detailForOwner
    var contentViewHeightConstraint:NSLayoutConstraint?
    var membersViewHeightConstraint:NSLayoutConstraint?
    var ulititiesViewHeightConstraint:NSLayoutConstraint?
    var currentRoomOfMember: RoomMappableModel?{
        get{
            if let room = DBManager.shared.getSingletonModel(ofType: RoomModel.self){
                return RoomMappableModel(roomModel: room)
            }else{
                return nil
            }
        }
    }
    //MARK: RoomDetailVC
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDelegateAndDataSource()
        registerNotification()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(scrollView.contentSize)
        print(scrollView.frame)
        print(scrollView.bounds)
    }
    
    
    func setupUI() {
        //Navigation bar
//        title = "ROOM_INFOR_TITLE".localized
        setBackButtonForNavigationBar()
        transparentNavigationBarBottomBorder()
//        let backImage = UIImage(named: "back")
//
//
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.backgroundColor = .clear
        if #available(iOS 11, *){
            scrollView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        //Caculator height
        let padding:UIEdgeInsets = UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10)
        let membersViewHeight:CGFloat
        if room.members?.count == 0{
            membersViewHeight = 100.0
            showNoDataView(inView: membersView.tableView, withTitle: "NO_MEMBER_ROOM".localized)
        }else if room.members!.count<5{
            hideNoDataView(inView: membersView.tableView)
            membersViewHeight = 60.0 + CGFloat(room.members!.count) * Constants.HEIGHT_CELL_MEMBERTVL
            
        }else{
            membersViewHeight =  Constants.HEIGHT_VIEW_MEMBERS
        }
        
        let baseInformationViewHeight:CGFloat = viewType == .detailForMember ? Constants.HEIGHT_VIEW_BASE_INFORMATION-80 : Constants.HEIGHT_VIEW_BASE_INFORMATION
        let numberOfRow = room.utilities.count%2==0 ? room.utilities.count/2 : room.utilities.count/2+1
        let utilitiesViewHeight =  Constants.HEIGHT_CELL_UTILITYCV * CGFloat(numberOfRow) + 60.0
        let part1 = Constants.HEIGHT_HORIZONTAL_ROOM_VIEW + baseInformationViewHeight
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
        contentViewHeightConstraint = contentView.anchorHeight(equalToConstrant: CGFloat(totalContentViewHeight))
        
        _ = horizontalImagesView.anchor(contentView.topAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, .zero ,CGSize(width: 0, height: Constants.HEIGHT_CELL_IMAGECV))
        _ = baseInformationView.anchor(horizontalImagesView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: baseInformationViewHeight))
//        _ = genderView.anchor(baseInformationView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: Constants.HEIGHT_VIEW_GENDER))
        membersViewHeightConstraint = membersView.anchor(baseInformationView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: membersViewHeight))[3]
        ulititiesViewHeightConstraint = utilitiesView.anchor(membersView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: utilitiesViewHeight))[3]
        _ = descriptionsView.anchor(utilitiesView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: Constants.HEIGHT_VIEW_DESCRIPTION))
        _ = optionView.anchor(nil, view.leftAnchor, view.bottomAnchor, view.rightAnchor,.zero,CGSize(width: 0, height: Constants.HEIGHT_VIEW_OPTION))
    }
    
    func updateUI(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        membersView.translatesAutoresizingMaskIntoConstraints = false
        utilitiesView.translatesAutoresizingMaskIntoConstraints = false
        let membersViewHeight:CGFloat
        if room.members?.count == 0{
            membersViewHeight = 100.0
            showNoDataView(inView: membersView.tableView, withTitle: "NO_MEMBER_ROOM".localized)
        }else if room.members!.count<5{
            hideNoDataView(inView: membersView.tableView)
            membersViewHeight = 60.0 + CGFloat(room.members!.count) * Constants.HEIGHT_CELL_MEMBERTVL
            
        }else{
            membersViewHeight =  Constants.HEIGHT_VIEW_MEMBERS
        }
        membersViewHeightConstraint?.constant = membersViewHeight
        let numberOfRow = room.utilities.count%2==0 ? room.utilities.count/2 : room.utilities.count/2+1
        let utilitiesViewHeight =  Constants.HEIGHT_CELL_UTILITYCV * CGFloat(numberOfRow) + 60.0
        
        ulititiesViewHeightConstraint?.constant = utilitiesViewHeight
        let part1 = Constants.HEIGHT_HORIZONTAL_ROOM_VIEW + Constants.HEIGHT_VIEW_BASE_INFORMATION
        let part2 = membersViewHeight + utilitiesViewHeight
        let part3 = Constants.HEIGHT_VIEW_DESCRIPTION + Constants.HEIGHT_LARGE_SPACE
        let totalContentViewHeight = part1 + part2 + part3
        contentViewHeightConstraint?.constant = totalContentViewHeight
        view.layoutIfNeeded()
        
    }
    func setDelegateAndDataSource() {
        //Data for baseInformationView
        horizontalImagesView.images = room.imageUrls
        baseInformationView.viewType = viewType
        baseInformationView.delegate = self
        baseInformationView.room = room
        if viewType == .detailForMember && currentRoomOfMember?.roomId == room.roomId{
            baseInformationView.btnTitle = "RATE_ROOM".localized
        }
        
        membersView.viewType = viewType
        membersView.members = room.members
        membersView.delegate = self
        membersView.lblTitle.text = "ROOM_DETAIL_MEMBER_TITLE".localized
        membersView.lblLeft.text = String(format: "ROOM_DETAIL_MAX_NUMBER_OF_MEMBER".localized,room.maxGuest)
//        membersView.lblCenter.text = String(format: "ROOM_DETAIL_CURRENT_NUMBER_OF_MEMBER".localized,room.currentMember)
        membersView.lblCenter.text = String(format: "ROOM_DETAIL_ADDED_NUMBER_OF_MEMBER".localized,room.members?.count ?? 0)
        
        
        //Data for utilityView
        utilitiesView.lblTitle.text = "UTILITY_TITLE".localized
        utilitiesView.utilities = room.utilities
        utilitiesView.delegate = self
        
        //Data for descriptionView
        descriptionsView.viewType = viewType
        descriptionsView.lblTitle.text = "DESCRIPTION".localized
        descriptionsView.tvContent.text = room.roomDescription
        
        //Data for optionView
        optionView.viewType = viewType
        optionView.delegate = self
        optionView.tvPrice.attributedText = NSAttributedString(string: String(format: "PRICE_OF_ROOM".localized, room.price.formatString,"MONTH".localized), attributes: [NSAttributedStringKey.foregroundColor:UIColor.red])
        optionView.tvDate.attributedText = NSAttributedString(string: String(format: "DATE_CREATED_OF_ROOM".localized, (room.date?.string(Constants.SHOW_DATE_FORMAT))!), attributes: [NSAttributedStringKey.foregroundColor:UIColor.red])
    }
    
    //MARK: Notification
    func registerNotification(){
        NotificationCenter.default.addObserver(self, selector:#selector(didReceiveEditRoomNotification(_:)), name: Constants.NOTIFICATION_EDIT_ROOM, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(didReceiveAcceptRoomNotification(_:)), name: Constants.NOTIFICATION_ACCEPT_ROOM, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(didReceiveDeclineRoomNotification(_:)), name: Constants.NOTIFICATION_DECLINE_ROOM, object: nil)
    }
    
    
    @objc func didReceiveEditRoomNotification(_ notification:Notification){
        DispatchQueue.main.async {
            if notification.object is RoomMappableModel {
                
                guard let room = notification.object as? RoomMappableModel else{
                    return
                }
                self.room = room
                self.updateUI()
                self.setDelegateAndDataSource()
            }
        }
    }
    @objc func didReceiveAcceptRoomNotification(_ notification:Notification){
        DispatchQueue.main.async {
            if notification.object is NotificationMappableModel {
                guard let notification = notification.object as? NotificationMappableModel else{
                    return
                }
                if notification.roomId == self.room.roomId{
                    self.room.statusId = Constants.AUTHORIZED
                    self.setDelegateAndDataSource()
                }
                
            }
        }
        
    }
    
    @objc func didReceiveDeclineRoomNotification(_ notification:Notification){
        DispatchQueue.main.async {
            if notification.object is NotificationMappableModel {
                guard let notification = notification.object as? NotificationMappableModel else{
                    return
                }
                if notification.roomId == self.room.roomId{
                    self.room.statusId = Constants.DECLINED
                    self.setDelegateAndDataSource()
                }
                
            }
        }
    }
    //MARK: BaseInformationViewDelegate
    func baseInformationViewDelegate(baseInformationView: BaseInformationView, onClickBtnViewAll button: UIButton) {
        let vc = RateVC()
        vc.rateVCType = .room
        presentInNewNavigationController(viewController: vc, flag: false)
    }
    
    //MARK: MembersViewDelegate
    func membersViewDelegate(membersView view: MembersView, onClickBtnEdit button:UIButton) {
        if room.statusId == Constants.AUTHORIZED{
            let vc = EditMemberVC()
            vc.room = room
            presentInNewNavigationController(viewController: vc,flag: false)
        }else{
            AlertController.showAlertInfor(withTitle: "INFORMATION".localized, forMessage: "INVALID_ROOM_STATUS".localized, inViewController: self)
        }
        
//        let mainVC = UIViewController()
//        let nv = UINavigationController(rootViewController: mainVC)
//        present(nv, animated: false) {nv.pushViewController(vc, animated: false)}
    }
    
    //MARK: UtilitiesViewDelegate
    func utilitiesViewDelegate(utilitiesView view: UtilitiesView, didSelectUtilityAt indexPath: IndexPath) {
        let utility = room.utilities[indexPath.row]
        utility.name = DBManager.shared.getRecord(id: utility.utilityId, ofType: UtilityModel.self)!.name
        let customTitle = NSAttributedString(string: utility.name, attributes: [NSAttributedStringKey.font:UIFont.boldMedium,NSAttributedStringKey.foregroundColor:UIColor.defaultBlue])
        let customMessage = NSMutableAttributedString(string: "Brand: \(utility.brand)\n", attributes: [NSAttributedStringKey.font:UIFont.small])
        customMessage.append(NSAttributedString(string: "Quantity: \(utility.quantity)\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
        customMessage.append(NSAttributedString(string: "Description: \(utility.utilityDescription)", attributes: [NSAttributedStringKey.font:UIFont.small]))
        AlertController.showAlertInfoWithAttributeString(withTitle: customTitle, forMessage: customMessage, inViewController: self)
    }
    //MARK: OptionViewDelegate
    func optionViewDelegate(view optionView: OptionView, onClickBtnLeft btnLeft: UIButton) {
        //Valid information at time input. So we dont need to valid here
        switch viewType { 
        case .detailForOwner:
            AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_TITLE_EDIT_ROOM".localized, alertStyle: .alert, forViewController: self,  lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_EDIT_ROOM_OK".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
                let vc = CERoomVC()
                vc.roomMappableModel = self.room
                vc.cERoomVCType = .edit
                self.presentInNewNavigationController(viewController: vc,flag: false)
            })
        case .detailForMember:
            AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_MESSAGE_SMS_ALERT".localized, alertStyle: .alert, forViewController: self,  lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_BUTTON_MESSAGE".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
                
                Utilities.openSystemApp(type: .message, forController: self, withContent: self.room.phoneNumber, completionHander: nil)
            })
        default:
            break
        }
    }
    
    func optionViewDelegate(view optionView: OptionView, onClickBtnRight btnRight: UIButton) {
        switch viewType {
        case .detailForOwner:
            AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_TITLE_DELETE_ROOM".localized, alertStyle: .alert, forViewController: self, lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_DELETE_ROOM_OK".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
                self.requestRemove()
            })
        case .detailForMember:
            AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_MESSAGE_CALL_ALERT".localized, alertStyle: .alert, forViewController: self, lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_BUTTON_CALL".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
                
                Utilities.openSystemApp(type: .phone, forController: self, withContent: self.room.phoneNumber, completionHander: nil)
            })
        case .createForOwner:
            break
        default:
            break
        }
        
    }
    
    //MARK: API Connection
    func  requestRemove(){
        //        roomFilter.searchRequestModel = nil
        let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
        hub.mode = .indeterminate
        hub.bezelView.backgroundColor = .white
        hub.contentColor = .defaultBlue
        DispatchQueue.global(qos: .background).async {
            APIConnection.request(apiRouter: APIRouter.removeRoom(roomId: self.room.roomId),  errorNetworkConnectedHander: {
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    APIResponseAlert.defaultAPIResponseError(controller: self, error: .HTTP_ERROR)
                }
            }, completion: { (error, statusCode) -> (Void) in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                if error != nil{
                    DispatchQueue.main.async {
                        APIResponseAlert.defaultAPIResponseError(controller: self, error: .SERVER_NOT_RESPONSE)
                    }
                }else{
                    if statusCode == .OK{
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: Constants.NOTIFICATION_REMOVE_ROOM, object: self.room)
                            AlertController.showAlertInfor(withTitle: "INFORMATION".localized, forMessage: "REMOVE_SUCCESS".localized, inViewController:self,rhsButtonHandler:{
                                (action) in
                                self.dimissEntireNavigationController()
                            })
                            
                            
                            
                        }
                    }else{
                        DispatchQueue.main.async {
                            APIResponseAlert.defaultAPIResponseError(controller: self, error: .PARSE_RESPONSE_FAIL)
                        }
                    }
                }
            })
        }
    }
    
}
