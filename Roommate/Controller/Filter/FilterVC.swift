//
//  FilterForRoom.swift
//  Roommate
//
//  Created by TrinhHC on 10/3/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import Alamofire
class FilterVC: BaseVC {
    
    let scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        sv.showsVerticalScrollIndicator  = false
        sv.showsHorizontalScrollIndicator  = false
        return sv
    }()
    let contentView:UIView={
        let cv = UIView()
        return cv
    }()
    
    lazy var cityDropdownListView:DropdownListView = {
        let cv:DropdownListView = .fromNib()
        cv.dropdownListViewType = .city
        return cv
    }()
    lazy var districtDropdownListView:DropdownListView = {
        let dv:DropdownListView = .fromNib()
        return dv
    }()
    
    lazy var priceSliderView:SliderView = {
        let sv:SliderView = .fromNib()
        sv.sliderViewType  = .price
        return sv
    }()
    
    lazy var areaSliderView:SliderView = {
        let sv:SliderView = .fromNib()
        sv.sliderViewType  = .area
        return sv
    }()
    
    lazy var maxMemberSelectView:MaxMemberSelectView = {
        let mv:MaxMemberSelectView = .fromNib()
        return mv
    }()
    
    lazy var genderView:GenderView = {
        let gv:GenderView = .fromNib()
        return gv
    }()
    
    lazy var utilitiesView:UtilitiesView = {
        let uv:UtilitiesView = .fromNib()
        uv.utilityForSC = .filter
        return uv
    }()
    
    lazy var btnSave:UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .defaultBlue
        bt.tintColor = .white
        return bt
    }()
    var filterVCType:FilterVCType!
    
    var utilities = [UtilityModel(utility_id: 1, name: "24-hours", quantity: 15, brand: "Hello", description: "nothing"),UtilityModel(utility_id: 1, name: "parking", quantity: 15, brand: "Hello", description: "nothing"),UtilityModel(utility_id: 1, name: "toilet", quantity: 15, brand: "Hello", description: "nothing"),
                     UtilityModel(utility_id: 2, name: "aircondition", quantity: 15, brand: "Hello", description: "nothing"),
                     UtilityModel(utility_id: 3, name: "cctv", quantity: 15, brand: "Hello", description: "nothing"),
                     UtilityModel(utility_id: 4, name: "cooking", quantity: 15, brand: "Hello", description: "nothing"),
                     UtilityModel(utility_id: 5, name: "fan", quantity: 15, brand: "Hello", description: "nothing")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
    }
    
    func setupUI(){
        view.backgroundColor = .white
        edgesForExtendedLayout = []// view above navigation bar
        automaticallyAdjustsScrollViewInsets = false
        //Create tempview for bottom button
        let bottomView = UIView()

        //Caculate height
        let defaultBottomViewHeight:CGFloat = 60.0
        let defaultPadding = UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10)
//        let numberOfRow = utilities.count%4==0 ? utilities.count/4 : utilities.count/4+1
//        let utilitiesViewWidth = Double((view.frame.size.width-20.0)/8.0 + 40.0)
//        let utilitiesViewHeight =  utilitiesViewWidth * Double(numberOfRow)
        let numberOfRow = utilities.count%2==0 ? utilities.count/2 : utilities.count/2+1
        let utilitiesViewHeight =  Constants.HEIGHT_CELL_NEW_UTILITY * Double(numberOfRow) + 40.0
        let contentViewHeight:CGFloat
        if filterVCType == .room{
            contentViewHeight = CGFloat(Constants.HEIGHT_VIEW_SLIDER*2+Constants.HEIGHT_VIEW_DROPDOWN_LIST*2+Constants.HEIGHT_VIEW_MAX_MEMBER_SELECT+Constants.HEIGHT_VIEW_GENDER+utilitiesViewHeight+Constants.HEIGHT_SPACE)
        }else{
            contentViewHeight = CGFloat(Constants.HEIGHT_VIEW_SLIDER*1+Constants.HEIGHT_VIEW_DROPDOWN_LIST*2+Constants.HEIGHT_VIEW_GENDER+utilitiesViewHeight+Constants.HEIGHT_SPACE)
        }

        //Add View
        view.addSubview(scrollView)
        view.addSubview(bottomView)
        
        
        scrollView.addSubview(contentView)
        bottomView.addSubview(btnSave)
        contentView.addSubview(cityDropdownListView)
        contentView.addSubview(districtDropdownListView)
        contentView.addSubview(priceSliderView)
        contentView.addSubview(genderView)
        contentView.addSubview(utilitiesView)

        if filterVCType == .room{
            contentView.addSubview(areaSliderView)
            contentView.addSubview(maxMemberSelectView)
        }
        
        //Add Constrant
       
        if #available(iOS 11.0, *) {
             _ = scrollView.anchor(view.topAnchor, view.leftAnchor, bottomLayoutGuide.bottomAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: -defaultBottomViewHeight-2*Constants.MARGIN_10, right: -Constants.MARGIN_10))
            _ = bottomView.anchor(scrollView.bottomAnchor, view.leftAnchor, nil, view.rightAnchor,defaultPadding,.init(width: 0, height: defaultBottomViewHeight))
        } else {
            // Fallback on earlier versions
             _ = scrollView.anchor(view.topAnchor, view.leftAnchor, bottomLayoutGuide.bottomAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: -defaultBottomViewHeight, right: -Constants.MARGIN_10))
            _ = bottomView.anchor(scrollView.bottomAnchor, view.leftAnchor,bottomLayoutGuide.bottomAnchor, view.rightAnchor,defaultPadding,.init(width: 0, height: defaultBottomViewHeight))
        }
        
        _ = contentView.anchor(scrollView.topAnchor,scrollView.leftAnchor,scrollView.bottomAnchor,scrollView.rightAnchor)
        _ = contentView.anchorWidth(equalTo: scrollView.widthAnchor)
        _  = contentView.anchorHeight(equalToConstrant: contentViewHeight)

        _ = cityDropdownListView.anchor(contentView.topAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_DROPDOWN_LIST))
        _ = districtDropdownListView.anchor(cityDropdownListView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_DROPDOWN_LIST))
        _ = priceSliderView.anchor(districtDropdownListView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_SLIDER))
        if filterVCType == .room{
            _ = areaSliderView.anchor(priceSliderView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_SLIDER))
            _ = maxMemberSelectView.anchor(areaSliderView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_MAX_MEMBER_SELECT))
            _ = genderView.anchor(maxMemberSelectView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_GENDER))
        }else{
            _ = genderView.anchor(priceSliderView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_GENDER))
        }
        _ = utilitiesView.anchor(genderView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: utilitiesViewHeight))

        _ = btnSave.anchor(view: bottomView,UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0))
        btnSave.layer.cornerRadius = CGFloat(10)
        btnSave.clipsToBounds = true


        
    }

    func setData(){
        navTitle = "FILTER".localized
        btnSave.setTitle("APPLY".localized, for: .normal)
        utilitiesView.utilities = utilities
        Alamofire.request(APIRouter.findById(id: 2)).responseJSON(completionHandler: { response in
//            print(response.)
         })
        

    }
    //MARK: Handler for save button
    @objc  func onClickBtnSave(btnSave:UIButton){
        //handler for save filter
        
    }

}
