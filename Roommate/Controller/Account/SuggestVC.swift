//
//  SuggestVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//
import UIKit
import SkyFloatingLabelTextField
import MBProgressHUD
class SuggestSettingVC: BaseVC ,DropdownListViewDelegate,UtilitiesViewDelegate,SliderViewDelegate{
    
    lazy var scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        sv.showsVerticalScrollIndicator  = false
        sv.showsHorizontalScrollIndicator  = false
        return sv
    }()
    
    lazy var contentView:UIView={
        let cv = UIView()
        return cv
    }()
    
    lazy var tvSettingDesription:UITextView={
        let tv = UITextView()
        tv.font  = .medium
        tv.textColor = .red
        tv.text = "ROOM_POST_SETTING_TITLE".localized
        tv.isEditable = false
        tv.isUserInteractionEnabled = false
        tv.isScrollEnabled = false
        //        tv.textContainerInset = .zero
        tv.textContainer.lineBreakMode = .byWordWrapping
        
        return tv
    }()
    
    lazy var cityDropdownListView:DropdownListView = {
        let cv:DropdownListView = .fromNib()
        cv.dropdownListViewType = .city
        return cv
    }()
    
    lazy var districtDropdownListView:DropdownListView = {
        let dv:DropdownListView = .fromNib()
        dv.dropdownListViewType = .district
        return dv
    }()
    
    lazy var priceSliderView:SliderView = {
        let sv:SliderView = .fromNib()
        sv.sliderViewType  = .price
        return sv
    }()
    
    lazy var utilitiesView:UtilitiesView = {
        let uv:UtilitiesView = .fromNib()
        //        uv.utilityForSC = .filter
        return uv
    }()
    
    
    
    lazy var tvContactInformations:UITextView={
        let tv = UITextView()
        tv.font  = .medium
        tv.textColor = .red
        tv.text = "ROOM_POST_PHONE_CONTACT".localized
        tv.isEditable = false
        tv.isUserInteractionEnabled = false
        tv.isScrollEnabled = false
        //        tv.textContainerInset = .zero
        tv.textContainer.lineBreakMode = .byWordWrapping
        
        return tv
    }()
    
    lazy var btnSave:UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .defaultBlue
        bt.tintColor = .white
        return bt
    }()
    
    var setting:SettingMappableModel!{
        get{
            return SettingMappableModel(settingModel: DBManager.shared.getSingletonModel(ofType: SettingModel.self)!)
        }
    }
    var suggestSettingMappableModel:SuggestSettingMappableModel?
    var currentUser = UserMappableModel(userModel:DBManager.shared.getSingletonModel(ofType: UserModel.self)!)
    var utilities:[UtilityMappableModel]?
    var districts:[DistrictModel]?
    var cities:[CityModel]?
    var roommatePostRequestModel = RoommatePostRequestModel()
    var selectedUtilities:[Int]?
    var selectedCity:CityModel?
    var selectedDistricts:[DistrictModel]?
    var selectedPrice:[Float]?
    weak var delegate:FilterVCDelegate?
    var cERoommateVCType:CEVCType = .create
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitData()
        setupUI()
        setupDelegateAndDataSource()
        updateUI()
        registerNotificationForKeyboard()
    }
    
    func setupInitData(){
        self.utilities = DBManager.shared.getRecords(ofType: UtilityModel.self)?.compactMap({ (utility) -> UtilityMappableModel? in
            UtilityMappableModel(utilityModel: utility)
        })
        //        self.utilities?.forEach{print($0.name)}
        self.cities = (DBManager.shared.getRecords(ofType: CityModel.self)?.toArray(type: CityModel.self))!
        self.districts = (DBManager.shared.getRecords(ofType: DistrictModel.self)?.toArray(type: DistrictModel.self))!
        if let userModel = DBManager.shared.getUser(), let suggestSettingModel = userModel.suggestSettingModel{
            self.suggestSettingMappableModel = SuggestSettingMappableModel(suggestSettingModel: suggestSettingModel)
        }
        
    }
    
    func setupUI(){
        title = cERoommateVCType == .create ? "CREATE_ROOMMATE_POST".localized : "EDIT_POST".localized
        edgesForExtendedLayout = .top// view above navigation bar
        setBackButtonForNavigationBar()
        //        translateNavigationBarBottomBorder()
        let barButtonItem = UIBarButtonItem(title: "RESET".localized, style: .done, target: self, action: #selector(onClickBtnReset))
        barButtonItem.tintColor  = .defaultBlue
        navigationItem.rightBarButtonItem = barButtonItem
        
        let bottomView = UIView()
        
        //Caculate height
        let defaultBottomViewHeight:CGFloat = 60.0
        let defaultPadding = UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10)
        let numberOfRow =  (utilities?.count)!%2==0 ? (utilities?.count)!/2 : (utilities?.count)!/2+1
        let utilitiesViewHeight:CGFloat =  Constants.HEIGHT_CELL_UTILITYCV * CGFloat(numberOfRow) + 70.0
        //        contentViewHeight = CGFloat(Constants.HEIGHT_VIEW_SLIDER+Constants.HEIGHT_VIEW_DROPDOWN_LIST*2+Constants.HEIGHT_VIEW_GENDER+utilitiesViewHeight+Constants.HEIGHT_LARGE_SPACE)
        let contentViewHeight:CGFloat = Constants.HEIGHT_VIEW_SLIDER+Constants.HEIGHT_VIEW_DROPDOWN_LIST*2+utilitiesViewHeight+Constants.HEIGHT_TITLE+Constants.HEIGHT_LARGE_SPACE+30.0
        
        //Add View
        view.addSubview(scrollView)
        view.addSubview(bottomView)
        
        scrollView.addSubview(contentView)
        bottomView.addSubview(btnSave)
        contentView.addSubview(tvSettingDesription)
        contentView.addSubview(cityDropdownListView)
        contentView.addSubview(districtDropdownListView)
        contentView.addSubview(priceSliderView)
        contentView.addSubview(utilitiesView)
        contentView.addSubview(tvContactInformations)
        //Add Constrant
        
        if #available(iOS 11.0, *) {
            _ = scrollView.anchor(view.safeAreaLayoutGuide.topAnchor, view.leftAnchor, view.safeAreaLayoutGuide.bottomAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: -defaultBottomViewHeight, right: -Constants.MARGIN_10))
            _ = bottomView.anchor(scrollView.bottomAnchor, view.leftAnchor, nil, view.rightAnchor,defaultPadding,.init(width: 0, height: defaultBottomViewHeight))
        } else {
            // Fallback on earlier versions
            _ = scrollView.anchor(view.topAnchor, view.leftAnchor, bottomLayoutGuide.bottomAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: -defaultBottomViewHeight, right: -Constants.MARGIN_10))
            _ = bottomView.anchor(scrollView.bottomAnchor, view.leftAnchor,bottomLayoutGuide.bottomAnchor, view.rightAnchor,defaultPadding,.init(width: 0, height: defaultBottomViewHeight))
        }
        
        _ = contentView.anchor(scrollView.topAnchor,scrollView.leftAnchor,scrollView.bottomAnchor,scrollView.rightAnchor)
        _ = contentView.anchorWidth(equalTo: scrollView.widthAnchor)
        _  = contentView.anchorHeight(equalToConstrant: contentViewHeight)
        
        //Suggest Setting
        _ = tvSettingDesription.anchor(contentView.topAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height:Constants.HEIGHT_TITLE))
        _ = cityDropdownListView.anchor(tvSettingDesription.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_DROPDOWN_LIST))
        _ = districtDropdownListView.anchor(cityDropdownListView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_DROPDOWN_LIST))
        _ = priceSliderView.anchor(districtDropdownListView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_SLIDER))
        _ = utilitiesView.anchor(priceSliderView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: utilitiesViewHeight))
        
        //Contact
        _ = tvContactInformations.anchor(utilitiesView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: 30.0))
        
        _ = btnSave.anchor(view: bottomView,UIEdgeInsets(top: Constants.MARGIN_6, left: 0, bottom: -Constants.MARGIN_6, right: 0))
        btnSave.layer.cornerRadius = CGFloat(10)
        btnSave.clipsToBounds = true
        btnSave.addTarget(self, action: #selector(onClickBtnSave), for: .touchUpInside)
        
        
    }
    func updateUI(){
        
        selectedCity = DBManager.shared.getRecord(id: setting.cityId, ofType: CityModel.self)
        selectedDistricts = []
        selectedUtilities = []
        selectedPrice = []
        selectedPrice?.append(400_000)
        selectedPrice?.append(40_000_000)
        //        selectedGender = .none
        if let setting = setting, let city = DBManager.shared.getRecord(id: setting.cityId, ofType: CityModel.self){
            selectedCity = city
            cityDropdownListView.text = selectedCity?.name
        }
        if cERoommateVCType == .create{
            if let suggestSettingMappableModel = currentUser.suggestSettingMappedModel{
                self.suggestSettingMappableModel = suggestSettingMappableModel
                if let districtId = suggestSettingMappableModel.districts?.first, let cityId = DBManager.shared.getRecord(id: districtId, ofType: DistrictModel.self)?.cityId{
                    selectedCity = DBManager.shared.getRecord(id: cityId, ofType: CityModel.self)
                    if let districts = suggestSettingMappableModel.districts,districts.count != 0{
                        selectedDistricts = districts.map({ (districtId) -> DistrictModel   in
                            DBManager.shared.getRecord(id: districtId, ofType: DistrictModel.self)!
                        })
                        let dictristString = selectedDistricts?.compactMap{$0.name}
                        districtDropdownListView.text = dictristString?.joined(separator: ",")
                    }
                    cityDropdownListView.text = selectedCity?.name
                }
                
                if let utilities = suggestSettingMappableModel.utilities{
                    selectedUtilities = utilities
                }
                if let price = suggestSettingMappableModel.price{
                    selectedPrice = price
                }
            }
        }else{
            if let districtId = roommatePostRequestModel.districtIds?.first, let cityId = DBManager.shared.getRecord(id: districtId, ofType: DistrictModel.self)?.cityId{
                selectedCity = DBManager.shared.getRecord(id: cityId, ofType: CityModel.self)
                if let districts = roommatePostRequestModel.districtIds,districts.count != 0{
                    selectedDistricts = districts.map({ (districtId) -> DistrictModel   in
                        DBManager.shared.getRecord(id: districtId, ofType: DistrictModel.self)!
                    })
                    let dictristString = selectedDistricts?.compactMap{$0.name}
                    districtDropdownListView.text = dictristString?.joined(separator: ",")
                }
                cityDropdownListView.text = selectedCity?.name
            }
            
            if let utilities = roommatePostRequestModel.utilityIds{
                selectedUtilities = utilities
            }
            if let minPrice = roommatePostRequestModel.minPrice,let maxPrice = roommatePostRequestModel.maxPrice{
                selectedPrice = [minPrice,maxPrice]
            }
        }
        
        
        priceSliderView.setSelectedRange(leftSelectedValue: selectedPrice![0], rightSelectedValue: selectedPrice![1])
        utilitiesView.selectedUtilities = selectedUtilities!
        //        genderView.genderSelect = selectedGender
    }
    func setupDelegateAndDataSource(){
        title = "SUGGEST_SETTING".localized
        btnSave.setTitle("APPLY".localized, for: .normal)
        utilitiesView.utilities = utilities
        
        utilitiesView.delegate = self
        districtDropdownListView.delegate = self
        cityDropdownListView.delegate = self
        //        genderView.delegate = self
        priceSliderView.delegate = self
        //        filterArgumentModel.searchRequestModel?.districts.first.
        
    }
    //MARK: Keyboard Notification handler
    override func keyBoard(notification: Notification) {
        super.keyBoard(notification: notification)
        if notification.name == NSNotification.Name.UIKeyboardWillShow{
            let userInfor = notification.userInfo!
            let keyboardFrame:CGRect = (userInfor[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            print(scrollView.contentInset)
            print(scrollView.contentOffset)
            scrollView.contentInset.bottom = keyboardFrame.size.height
            scrollView.scrollIndicatorInsets = scrollView.contentInset
            print(scrollView.contentInset)
            print(scrollView.contentOffset)
        }else if notification.name == NSNotification.Name.UIKeyboardWillHide{
            scrollView.contentInset = .zero
        }
    }
    //MARK: Handler utilitiesViewDelegate
    func utilitiesViewDelegate(utilitiesView view: UtilitiesView, didSelectUtilityAt indexPath: IndexPath) {
        guard let utility = utilities?[indexPath.row] else {
            return
        }
        if (selectedUtilities?.contains(utility.utilityId))!{
            utilitiesView.setState(isSelected: false, atIndexPath: indexPath)
            let index = selectedUtilities?.index(of: utility.utilityId)
            selectedUtilities?.remove(at: index!)
        }else{
            utilitiesView.setState(isSelected: true, atIndexPath: indexPath)
            selectedUtilities?.append(utility.utilityId)
        }
        
    }
    //MARK: Handler dropdownListViewDelegate
    func dropdownListViewDelegate(view dropdownListView: DropdownListView, onClickBtnChangeSelect btnSelect: UIButton) {
        if dropdownListView == cityDropdownListView{
            let data = cities?.map{$0.name!}
            var selectDataIndexs:[Int] = []
            if let city = selectedCity,let name = city.name, let index = data?.index(of: name){
                selectDataIndexs = [index]
            }
            let alert = AlertController.showAlertList(withTitle: "LIST_CITY_TITLE".localized, andMessage: nil, alertStyle: .alert,alertType: .city,forViewController: self, data: data,selectedItemIndex: selectDataIndexs, rhsButtonTitle: "DONE".localized)
            alert.delegate = self
            
        }else{
            if self.selectedCity?.cityId != 0{
                let data = districts?.filter({ (district) -> Bool in
                    district.cityId == self.selectedCity?.cityId
                }).map({ (district) -> String in
                    district.name!
                })
                let selectDataIndexs = selectedDistricts?.compactMap{data?.index(of: $0.name!)}
                let alert = AlertController.showAlertList(withTitle: "LIST_DISTRICT_TITLE".localized, andMessage: nil, alertStyle: .alert,alertType: .district, isMultiSelected:true, forViewController: self, data: data,selectedItemIndex: selectDataIndexs, rhsButtonTitle: "DONE".localized)
                alert.delegate = self
            }
            
        }
    }
    //MARK: Handler sliderView
    func sliderView(view sliderView: SliderView, didChangeSelectedMinValue selectedMin: Float, andMaxValue selectedMax: Float) {
        selectedPrice?.removeAll()
        selectedPrice?.append(selectedMin)
        selectedPrice?.append(selectedMax)
    }
    //MARK: UIAlertControllerDelegate
    override func alertControllerDelegate(alertController: AlertController,withAlertType type:AlertType, onCompleted indexs: [IndexPath]?) {
        guard let indexs = indexs else {
            selectedDistricts =  []
            self.districtDropdownListView.dropdownListViewType = .district
            return
        }
        if type == AlertType.city{
            guard let city = cities?[(indexs.first?.row)!]  else{
                return
            }
            selectedCity = city
            selectedDistricts =  []
            self.cityDropdownListView.text = self.selectedCity?.name
            self.districtDropdownListView.dropdownListViewType = .district
        }else if type == AlertType.district{
            guard let districtOfCity = districts?.filter({ (district) -> Bool in
                district.cityId == self.selectedCity?.cityId
            }) else{
                return
            }
            selectedDistricts?.removeAll()
            indexs.forEach { (index) in
                selectedDistricts?.append(districtOfCity[index.row])
            }
            let dictrictsString = selectedDistricts?.map({ (district) -> String     in
                district.name!
            })
            self.districtDropdownListView.text  = dictrictsString?.joined(separator: ",")
        }
    }
    //MARK: Handler for save button
    @objc  func onClickBtnSave(){
        if checkValidInformation() {
            if suggestSettingMappableModel == nil {
                suggestSettingMappableModel = SuggestSettingMappableModel()
            }
            suggestSettingMappableModel?.districts = selectedDistricts?.compactMap {
                $0.districtId
            }
            suggestSettingMappableModel?.utilities = selectedUtilities
            suggestSettingMappableModel?.price = selectedPrice
            
            
        }
    }
    func requestSaveSuggest(){
        let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
        hub.mode = .indeterminate
        hub.bezelView.backgroundColor = .white
        hub.contentColor = .defaultBlue
        DispatchQueue.global(qos: .background).async {
            APIConnection.request(apiRouter: APIRouter.createSuggestSetting(model: self.suggestSettingMappableModel!),  errorNetworkConnectedHander: {
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
                            self.currentUser.suggestSettingMappedModel = self.suggestSettingMappableModel
                            _ = DBManager.shared.addSingletonModel(ofType: UserModel.self, object: UserModel(userMappedModel: self.currentUser))
                            AlertController.showAlertInfor(withTitle: "INFORMATION".localized, forMessage: "SUGGEST_SETTING_CREATE_SUCCESS".localized, inViewController: self,rhsButtonHandler:{
                                (action) in
                                self.popSelfInNavigationController()
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
    
    //MARK: Handler for reset button
    @objc  func onClickBtnReset(){
        //        filterArgumentModel.filterRequestModel = nil
        updateUI()
        utilitiesView.resetView()
    }
    //MARK: Others method
    func checkValidInformation()->Bool{
        let message = NSMutableAttributedString(string: "")
        
        if selectedDistricts!.isEmpty{
            message.append(NSAttributedString(string: "\("DISTRICT".localized) :  \("ERROR_TYPE_DISTRICT".localized)\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
        }
        
        if selectedUtilities!.count < 5{
            message.append(NSAttributedString(string: "\("UTILITY_TITLE".localized) :  \("ERROR_TYPE_UTILITY".localized)\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
        }
        
        if message.string.isEmpty{
            return true
        }else{
            let title = NSAttributedString(string: "INFORMATION".localized, attributes: [NSAttributedStringKey.font:UIFont.boldMedium,NSAttributedStringKey.foregroundColor:UIColor.defaultBlue])
            AlertController.showAlertInfoWithAttributeString(withTitle: title, forMessage: message, inViewController: self)
        }
        return false
    }
}