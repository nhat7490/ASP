//
//  RoomDetailVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class RoomDetailVC:BaseVC,UIScrollViewDelegate,OptionViewDelegate{

    
    var room = RoomModel(name: "Tên phòng hiện tại là Thanh xuân -  Dalab Dalab Dalab", price: 500000, area: 50, address: "1B Nguyễn thị Minh Khai", maxGuest: 5, date_create: Date(), current_member: 3, description: "Mình rất yêu căn phòng này nhưng do đi làm xa quá mình cho thuê lại giá 1.7tr, toilet riêng, rửa chén riêng, như hình, có giếng trời mát lắm điện 2.500, xe free ko thêm gì, à quên nước tháng hình như 40k thì phải mình ko Care luôn, bà chủ dễ thương dịu dàng, nhà cực sạch , an ninh, 11h tối đóng cửa, đi khua hơn thì báo tiếng là đc Alo cho mình nha - oanh", status: StatusModel(status: 1, name: "Active"), city: CityModel(id: 1, name: "Hồ chí minh"), district: DistrictModel(district_id: 1, name: "Quận 1",city_id:1), image: [ImageModel(id: 1, link_url: "https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?cs=srgb&dl=4k-wallpaper-background-beautiful-853199.jpg&fm=jpg"),ImageModel(id: 2, link_url: "https://images.pexels.com/photos/534049/pexels-photo-534049.jpeg?cs=srgb&dl=beach-calm-cliffs-534049.jpg&fm=jpg"),ImageModel(id: 2, link_url: "https://images.pexels.com/photos/534049/pexels-photo-534049.jpeg?cs=srgb&dl=beach-calm-cliffs-534049.jpg&fm=jpg")
        ], utilities: [UtilityModel(utility_id: 1, name: "24-hours", quantity: 15, brand: "Hello", description: "nothing"),UtilityModel(utility_id: 1, name: "parking", quantity: 15, brand: "Hello", description: "nothing"),
                       UtilityModel(utility_id: 1, name: "toilet", quantity: 15, brand: "Hello", description: "nothing"),
                       UtilityModel(utility_id: 2, name: "aircondition", quantity: 15, brand: "Hello", description: "nothing"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      UtilityModel(utility_id: 3, name: "cctv", quantity: 15, brand: "Hello", description: "nothing"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      UtilityModel(utility_id: 4, name: "cooking", quantity: 15, brand: "Hello", description: "nothing"),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      UtilityModel(utility_id: 5, name: "fan", quantity: 15, brand: "Hello", description: "nothing")] ,users:[User(id: 1, name: "Ho nguyen hai trieu", imageUrl: "", roleInRom: 1),User(id: 2, name: "Ho nguyen hai trieu", imageUrl: "", roleInRom: 2),User(id: 3, name: "Ho nguyen hai trieu", imageUrl: "", roleInRom:2)], requiredGender: 1)
    
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
    
    var viewType:DetailViewType = .detailForMember
    
    
    
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
        //Navigation bar
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
        let membersViewHeight = room.users?.count != 0 ? Constants.HEIGHT_VIEW_HORIZONTAL_IMAGES : 30.0
        let numberOfRow = room.utilities.count%2==0 ? room.utilities.count/2 : room.utilities.count/2+1
        let utilitiesViewHeight =  Constants.HEIGHT_CELL_NEW_UTILITY * Double(numberOfRow) + 40.0
        let totalContentViewHeight = CGFloat(715 + membersViewHeight + utilitiesViewHeight+Constants.HEIGHT_SPACE)
        
        //Add View
        view.addSubview(scrollView)
        view.addSubview(optionView)
        scrollView.addSubview(contentView)
        contentView.addSubview(horizontalImagesView)
        contentView.addSubview(baseInformationView)
        contentView.addSubview(genderView)
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
        _ = genderView.anchor(baseInformationView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: Constants.HEIGHT_VIEW_GENDER))
        _ = membersView.anchor(genderView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: membersViewHeight))
        _ = utilitiesView.anchor(membersView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: utilitiesViewHeight))
        _ = descriptionsView.anchor(utilitiesView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, padding,CGSize(width: 0, height: Constants.HEIGHT_VIEW_DESCRIPTION))
        _ = optionView.anchor(nil, view.leftAnchor, view.bottomAnchor, view.rightAnchor,.zero,CGSize(width: 0, height: Constants.HEIGHT_VIEW_OPTION))
    }

    func setData() {
        //Delegate , Datasource and other
        let status = NSAttributedString(string: "ROOM_DETAIL_STATUS_CERTIFICATED".localized, attributes: [NSAttributedStringKey.font : UIFont.boldMedium,
                                                                                             NSAttributedStringKey.backgroundColor: UIColor.defaultBlue,
                                                                                             NSAttributedStringKey.foregroundColor:UIColor.white])
        //Data for baseInformationView
        horizontalImagesView.images = room.image
        baseInformationView.lblMainTitle.text = room.name
        baseInformationView.lblStatus.attributedText = status
        baseInformationView.lblSubTitle.text = "BASE_INFORMATION".localized
        baseInformationView.lblAddress.text = room.address
        baseInformationView.lblArea.text = String(format: "AREA".localized,room.area)
        
        //Data for genderview
        genderView.viewType = viewType
        genderView.genderSelect = room.requiredGender == 1 ? GenderSelect.male : room.requiredGender == 2 ? GenderSelect.male : GenderSelect.both
        genderView.lblTitle.text = "GENDER_ACCEPT".localized
        
        //Data for memberview
        membersView.viewType = viewType
        membersView.users = room.users
        membersView.lblTitle.text = "ROOM_DETAIL_MEMBER_TITLE".localized
        membersView.lblNumberOfMaxMember.text = String(format: "ROOM_DETAIL_MAX_NUMBER_OF_MEMBER".localized,room.maxGuest)
        membersView.lblNumberOfCurrentMember.text = String(format: "ROOM_DETAIL_CURRENT_NUMBER_OF_MEMBER".localized,room.currentMember)
        membersView.lblNumberOfMemberAdded.text = String(format: "ROOM_DETAIL_ADDED_NUMBER_OF_MEMBER".localized,room.users?.count ?? 0)
        
        
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
        optionView.lblTop.attributedText = NSAttributedString(string: String(format: "PRICE_OF_ROOM".localized, room.price,"MONTH".localized), attributes: [NSAttributedStringKey.foregroundColor:UIColor.red])
        optionView.lblBottom.attributedText = NSAttributedString(string: String(format: "TIME".localized, room.price,"MONTH".localized), attributes: [NSAttributedStringKey.foregroundColor:UIColor.red])
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
            case .cEForOwner:
                break
        }
    }
    
    func optionViewDelegate(view optionView: OptionView, onClickBtnRight btnRight: UIButton) {
        switch viewType {
        case .detailForOwner:
            print("Need to set to show edit screen here")
        case .detailForMember:
            AlertController.showAlertConfirm(withTitle: "CONFIRM_TITLE".localized, andMessage: "CONFIRM_MESSAGE_SMS_ALERT".localized, alertStyle: .alert, forViewController: self, lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "CONFIRM_TITLE_BUTTON_CALL".localized, lhsButtonHandler: nil, rhsButtonHandler: { (action) in
                
                Utilities.openSystemApp(type: .phone, forController: self, withContent: "0918170105", completionHander: nil)
            })
        case .cEForOwner:
            break
        }
    }
    
}
