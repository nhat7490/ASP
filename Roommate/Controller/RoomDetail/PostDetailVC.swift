//
//  RoomDetailVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(scrollView.contentSize)
        print(scrollView.frame)
        print(scrollView.bounds)
    }
    
    
    func setupUI() {
        view.backgroundColor = .white
        //Back button
        
        let backImage = UIImage(named: "back")
//
//        self.navigationController?.navigationBar.backIndicatorImage = backImage
//
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
//
        /*** If needed Assign Title Here ***/
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
        let numberOfRow = viewType == .roomPostDetailForFinder ? (room.utilities.count%2==0 ? room.utilities.count/2 : room.utilities.count/2+1) : (roommate.utilityIds.count%2==0 ? roommate.utilityIds.count/2 : roommate.utilityIds.count/2+1)
        let utilitiesViewHeight =  Constants.HEIGHT_CELL_NEW_UTILITYCV * CGFloat(numberOfRow) + 60.0
        let totalContentViewHeight = viewType == .roomPostDetailForFinder ? CGFloat(Constants.HEIGHT_VIEW_HORIZONTAL_IMAGES+Constants.HEIGHT_VIEW_BASE_INFORMATION + Constants.HEIGHT_VIEW_GENDER + Constants.HEIGHT_VIEW_DESCRIPTION + utilitiesViewHeight+Constants.HEIGHT_LARGE_SPACE) : CGFloat(Constants.HEIGHT_VIEW_HORIZONTAL_IMAGES+Constants.HEIGHT_VIEW_BASE_INFORMATION + utilitiesViewHeight - 30)
        
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
        _ = baseInformationView.anchor(horizontalImagesView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: Constants.HEIGHT_VIEW_BASE_INFORMATION-30.0))
        if viewType == .roomPostDetailForFinder{
        _ = genderView.anchor(baseInformationView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: Constants.HEIGHT_VIEW_GENDER))
        _ = utilitiesView.anchor(genderView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: utilitiesViewHeight))
        _ = descriptionsView.anchor(utilitiesView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: Constants.HEIGHT_VIEW_DESCRIPTION))
        }else{
             _ = utilitiesView.anchor(baseInformationView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: utilitiesViewHeight))
        }
    }
    
    func setData() {
        
        baseInformationView.lblStatusHeightConstraint.constant = 0
        if viewType == .roomPostDetailForFinder{
            //Data for horizontalImagesView
            horizontalImagesView.images = room.imageUrls
            
            //Data for baseInformationView
            baseInformationView.lblMainTitle.text = room.name
            baseInformationView.lblSubTitle.text = "BASE_INFORMATION".localized
            baseInformationView.tvInfoTop.text = room.address
            baseInformationView.lblInfoBottom.text = String(format: "AREA".localized,room.area!)
            
            //Data for genderview
            genderView.viewType = viewType
            genderView.genderSelect = room.genderPartner == 1 ? GenderSelect.male : room.genderPartner == 2 ? GenderSelect.male : GenderSelect.both
            genderView.lblTitle.text = "GENDER_ACCEPT".localized
            
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
            horizontalImagesView.images = [roommate.userResponseModel!.imageProfile!]
            
            //Data for baseInformationView
            baseInformationView.lblMainTitle.text = roommate.userResponseModel?.fullname
            let dictrictsString = roommate?.districtIds?.map({ (districtId) -> String in
                (DBManager.shared.getRecord(id: districtId, ofType: DistrictModel.self)?.name)!
            })
            baseInformationView.imgvBottom.image = UIImage(named: "city")
            baseInformationView.lblSubTitle.text = "BASE_INFORMATION".localized
            baseInformationView.tvInfoTop.text = dictrictsString?.joined(separator: ",")
            baseInformationView.lblInfoBottom.text = DBManager.shared.getRecord(id: roommate.cityId, ofType: CityModel.self)!.name
            
            //Data for utilityView
            var utilities:[UtilityModel] = []
            roommate.utilityIds.forEach { (utilityId) in
                utilities.append(DBManager.shared.getRecord(id: utilityId, ofType: UtilityModel.self)!)
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
    
    
    //MARK: OptionViewDelegate
    func optionViewDelegate(view optionView: OptionView, onClickBtnLeft btnLeft: UIButton) {
        //Valid information at time input. So we dont need to valid here
        AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_MESSAGE_POST_SMS_ALERT".localized, alertStyle: .alert, forViewController: self,  lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_BUTTON_MESSAGE".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
            
            Utilities.openSystemApp(type: .message, forController: self, withContent:self.viewType == .roomPostDetailForFinder ?  self.room.phoneContact : self.roommate.phoneContact, completionHander: nil)
        })
    }
    
    func optionViewDelegate(view optionView: OptionView, onClickBtnRight btnRight: UIButton) {
        AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_MESSAGE_POST_CALL_ALERT".localized, alertStyle: .alert, forViewController: self, lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_BUTTON_CALL".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
            
            Utilities.openSystemApp(type: .phone, forController: self, withContent:self.viewType == .roomPostDetailForFinder ?  self.room.phoneContact : self.roommate.phoneContact, completionHander: nil)
        })
    }
    
    //MARK: UtilitiesViewDelegate
    func utilitiesViewDelegate(utilitiesView view: UtilitiesView, didSelectUtilityAt indexPath: IndexPath) {
        if viewType == .roomPostDetailForFinder{
            let utility = room.utilities[indexPath.row]
            utility.name = DBManager.shared.getRecord(id: utility.utilityId, ofType: UtilityModel.self)!.name
            let customTitle = NSAttributedString(string: utility.name, attributes: [NSAttributedStringKey.font:UIFont.boldMedium,NSAttributedStringKey.foregroundColor:UIColor.defaultBlue])
            let customMessage = NSMutableAttributedString(string: "Brand: \(utility.brand)\n", attributes: [NSAttributedStringKey.font:UIFont.small])
            customMessage.append(NSAttributedString(string: "Quantity: \(utility.quantity)\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
            customMessage.append(NSAttributedString(string: "Description: \(utility.utilityDescription)", attributes: [NSAttributedStringKey.font:UIFont.small]))
            AlertController.showAlertInfoWithAttributeString(withTitle: customTitle, forMessage: customMessage, inViewController: self)
        }
    }
    @objc func onClickBtnBack(){
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
