//
//  RoomDetailVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import MBProgressHUD
class PostDetailVC:BaseVC,UIScrollViewDelegate,OptionViewDelegate,UtilitiesViewDelegate{
    var room:RoomPostResponseModel!
    var roommate:RoommatePostResponseModel!
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
    
    var genderView:GenderView = {
        let gv:GenderView = .fromNib()
        return gv
    }()
    
    //    var membersView:MembersView = {
    //        let mv:MembersView = .fromNib()
    //        return mv
    //    }()
    //
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
    
    var viewType:ViewType = .roomPostDetailForFinder
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
        registerNotification()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(scrollView.contentSize)
        print(scrollView.frame)
        print(scrollView.bounds)
    }
    
    
    func setupUI() {
        setBackButtonForNavigationBar()
        transparentNavigationBarBottomBorder()
        if #available(iOS 11, *){
            scrollView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        //Caculator height
        let padding:UIEdgeInsets = UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10)
        let numberOfRow:Int
        if viewType == .roomPostDetailForFinder || viewType == .roomPostDetailForCreatedUser{
            numberOfRow = (room.utilities.count%2==0 ? room.utilities.count/2 : room.utilities.count/2+1)
        }else{
            numberOfRow = (roommate.utilityIds.count%2==0 ? roommate.utilityIds.count/2 : roommate.utilityIds.count/2+1)
        }
        
        let heightBaseInformationView:CGFloat  = ((viewType == .roomPostDetailForFinder || viewType == .roomPostDetailForCreatedUser) ? Constants.HEIGHT_VIEW_BASE_INFORMATION : Constants.HEIGHT_VIEW_BASE_INFORMATION-30.0 )
        let utilitiesViewHeight =  Constants.HEIGHT_CELL_UTILITYCV * CGFloat(numberOfRow) + 60.0
        let totalContentViewHeight = (viewType == .roomPostDetailForFinder || viewType == .roomPostDetailForCreatedUser) ? CGFloat(Constants.HEIGHT_VIEW_HORIZONTAL_IMAGES+heightBaseInformationView+Constants.HEIGHT_VIEW_GENDER + Constants.HEIGHT_VIEW_DESCRIPTION + utilitiesViewHeight+Constants.HEIGHT_LARGE_SPACE) : CGFloat(Constants.HEIGHT_VIEW_HORIZONTAL_IMAGES+Constants.HEIGHT_VIEW_BASE_INFORMATION + utilitiesViewHeight - 30)
        
        //Add View
        view.addSubview(scrollView)
        view.addSubview(optionView)
        scrollView.addSubview(contentView)
        contentView.addSubview(horizontalImagesView)
        contentView.addSubview(baseInformationView)
        contentView.addSubview(utilitiesView)
        if viewType == .roomPostDetailForFinder{
            contentView.addSubview(genderView)
            contentView.addSubview(descriptionsView)
        }
        
        
        
        //Add Constaints
        _ = optionView.anchor(nil, view.leftAnchor, view.bottomAnchor, view.rightAnchor,.zero,CGSize(width: 0, height: Constants.HEIGHT_VIEW_OPTION))
        
        _ = scrollView.anchor(view.topAnchor, view.leftAnchor, optionView.topAnchor,view.rightAnchor)
        
        scrollView.delegate = self
        scrollView.contentSize.height = totalContentViewHeight
        
        _ = contentView.anchor(scrollView.topAnchor, scrollView.leftAnchor, scrollView.bottomAnchor, scrollView.rightAnchor)
        _ = contentView.anchorWidth(equalTo: scrollView.widthAnchor)
        _ = contentView.anchorHeight(equalToConstrant: CGFloat(totalContentViewHeight))
        
        _ = horizontalImagesView.anchor(contentView.topAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, .zero ,CGSize(width: 0, height: Constants.HEIGHT_CELL_IMAGECV))
        _ = baseInformationView.anchor(horizontalImagesView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height:heightBaseInformationView ))
        if viewType == .roomPostDetailForFinder{
            _ = genderView.anchor(baseInformationView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: Constants.HEIGHT_VIEW_GENDER))
            _ = utilitiesView.anchor(genderView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: utilitiesViewHeight))
            _ = descriptionsView.anchor(utilitiesView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: Constants.HEIGHT_VIEW_DESCRIPTION))
        }else{
            _ = utilitiesView.anchor(baseInformationView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: utilitiesViewHeight))
        }
    }
    
    func setData() {
        
        baseInformationView.viewType = viewType
        genderView.viewType = viewType
        if viewType == .roomPostDetailForFinder || viewType == .roomPostDetailForCreatedUser {
            //Data for horizontalImagesView
            
            horizontalImagesView.images = room.imageUrls
            
            //Data for baseInformationView
            //            baseInformationView.lblMainTitle.text = room.name
            //            baseInformationView.lblSubTitle.text = "BASE_INFORMATION".localized
            //            baseInformationView.tvInfoTop.text = room.address
            //            baseInformationView.lblInfoBottom.text = String(format: "AREA".localized,room.area!)
            //            baseInformationView.lblTitleDescription.text  = room.genderPartner == 1 ? String(format: "NUMBER_OF_PERSON".localized,room.genderPartner!,"MALE".localized) :
            //                room.genderPartner == 2 ? String(format: "NUMBER_OF_PERSON".localized,room.numberPartner!,"FEMALE".localized) : String(format: "NUMBER_OF_PERSON".localized,room.numberPartner!,"\("MALE".localized)/\("FEMALE".localized)")
            baseInformationView.roomPost = room
            
            //Data for genderview
            genderView.genderSelect = GenderSelect(rawValue: room.genderPartner!)
            
            //Data for descriptionView
            descriptionsView.viewType = viewType
            descriptionsView.lblTitle.text = "DESCRIPTION".localized
            descriptionsView.tvContent.text = room.postDesription
            
            //Data for utilityView
            utilitiesView.utilities = room.utilities
            
            //Data for optionView
            optionView.tvPrice.text =  String(format: "PRICE_OF_ROOM".localized, room.minPrice!.formatString,"MONTH".localized)
        }else{
            //Data for horizontalImagesView
            horizontalImagesView.images = [(roommate.userResponseModel?.imageProfile ?? "")]
            
            //Data for baseInformationView
            baseInformationView.roommatePost = roommate
            
            //Data for utilityView
            var utilities:[UtilityMappableModel] = []
            roommate.utilityIds.forEach { (utilityId) in
                utilities.append(UtilityMappableModel(utilityModel: DBManager.shared.getRecord(id: utilityId, ofType: UtilityModel.self)!))
            }
            utilitiesView.utilities = utilities
            
            
            //Data for optionView
            optionView.tvPrice.text =  String(format: "PRICE_OF_ROOMMATE".localized, roommate.minPrice.formatString,roommate.maxPrice.formatString,"MONTH".localized)
        }
        
        
        
        
        //Data for utilityView
        utilitiesView.lblTitle.text = "UTILITY_TITLE".localized
        utilitiesView.delegate = self
        
        //Data for optionView
        optionView.viewType = viewType
        optionView.delegate = self
        
        view.layoutIfNeeded()
    }
    
    //MARK: Notification
    func registerNotification(){
        NotificationCenter.default.addObserver(self, selector:#selector(didReceiveEditPostNotification(_:)), name: Constants.NOTIFICATION_EDIT_POST, object: nil)
    }
    
    
    @objc func didReceiveEditPostNotification(_ notification:Notification){
        if notification.object is RoomPostRequestModel {
            guard let model = notification.object as? RoomPostRequestModel else{
                return
            }
            self.room.model = model
            
        }else{
            guard let model = notification.object as? RoommatePostRequestModel else{
                return
            }
            self.roommate.model = model
        }
        setData()
    }
    
    //MARK: OptionViewDelegate
    func optionViewDelegate(view optionView: OptionView, onClickBtnLeft btnLeft: UIButton) {
        //Valid information at time input. So we dont need to valid here
        if viewType == .roomPostDetailForCreatedUser || viewType == .roommatePostDetailForCreatedUser{
            if viewType == .roomPostDetailForCreatedUser{
                let vc = CERoomPostVC()
                vc.cERoomPostVCType = .edit
                vc.roomPostRequestModel = RoomPostRequestModel(model: room)
                presentInNewNavigationController(viewController: vc,flag: false)
            }else{
                let vc = CERoommatePostVC()
                vc.cERoommateVCType = .edit
                vc.roommatePostRequestModel = RoommatePostRequestModel(model: roommate)
                presentInNewNavigationController(viewController: vc,flag: false)
            }
        }else if viewType == .roomPostDetailForFinder || viewType == .roommatePostDetailForFinder{
            AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_MESSAGE_POST_SMS_ALERT".localized, alertStyle: .alert, forViewController: self,  lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_BUTTON_MESSAGE".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
                
                Utilities.openSystemApp(type: .message, forController: self, withContent:self.viewType == .roomPostDetailForFinder ?  self.room.phoneContact : self.roommate.phoneContact, completionHander: nil)
            })
        }
        
    }
    
    func optionViewDelegate(view optionView: OptionView, onClickBtnRight btnRight: UIButton) {
        if viewType == .roomPostDetailForCreatedUser || viewType == .roommatePostDetailForCreatedUser{
            AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_TITLE_DELETE_ROOM".localized, alertStyle: .alert, forViewController: self, lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_DELETE_ROOM_OK".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
                self.requestRemovePost()
            })
        }else if viewType == .roomPostDetailForFinder || viewType == .roommatePostDetailForFinder{
            AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_MESSAGE_POST_CALL_ALERT".localized, alertStyle: .alert, forViewController: self, lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_BUTTON_CALL".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
                
                Utilities.openSystemApp(type: .phone, forController: self, withContent:self.viewType == .roomPostDetailForFinder ?  self.room.phoneContact : self.roommate.phoneContact, completionHander: nil)
            })
        }
    }
    
    //MARK: UtilitiesViewDelegate
    func utilitiesViewDelegate(utilitiesView view: UtilitiesView, didSelectUtilityAt indexPath: IndexPath) {
        if viewType == .roomPostDetailForFinder || viewType == .roomPostDetailForCreatedUser{
            let utility = room.utilities[indexPath.row]
            utility.name = DBManager.shared.getRecord(id: utility.utilityId, ofType: UtilityModel.self)!.name
            let customTitle = NSAttributedString(string: utility.name.localized, attributes: [NSAttributedStringKey.font:UIFont.boldMedium,NSAttributedStringKey.foregroundColor:UIColor.defaultBlue])
            let customMessage = NSMutableAttributedString(string: "\(String(key: "BRAND_TITLE", args:utility.brand))\n", attributes: [NSAttributedStringKey.font:UIFont.small])
            customMessage.append(NSAttributedString(string:"\(String(key: "QUANTITY_TITLE", args:utility.quantity))\n" , attributes: [NSAttributedStringKey.font:UIFont.small]))
            customMessage.append(NSAttributedString(string:"\(String(key: "DESCRIPTION_PLACE_HOLDER", args:utility.utilityDescription))\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
            AlertController.showAlertInfoWithAttributeString(withTitle: customTitle, forMessage: customMessage, inViewController: self)
        }
    }
    //MARK: API Connection
    func requestRemovePost(){
        //        roomFilter.searchRequestModel = nil
        let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
        hub.mode = .indeterminate
        hub.bezelView.backgroundColor = .white
        hub.contentColor = .defaultBlue
        DispatchQueue.global(qos: .background).async {
            APIConnection.request(apiRouter: APIRouter.removePost(postId: self.viewType == .roomPostDetailForCreatedUser ? self.room.postId! : self.roommate.postId!),  errorNetworkConnectedHander: {
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
                            NotificationCenter.default.post(name: Constants.NOTIFICATION_REMOVE_POST, object: self.room)
                            AlertController.showAlertInfor(withTitle: "INFORMATION".localized, forMessage: "POST_REMOVE_SUCCESS".localized, inViewController:self,rhsButtonHandler:{
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
