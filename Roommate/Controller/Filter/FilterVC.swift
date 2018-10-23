//
//  FilterForRoom.swift
//  Roommate
//
//  Created by TrinhHC on 10/3/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
protocol FilterVCDelegate:class{
    func filterVCDelegate(filterVC:FilterVC,onCompletedWithFilter filter:FilterArgumentModel)
}
class FilterVC: BaseVC ,DropdownListViewDelegate,UtilitiesViewDelegate,GenderViewDelegate,AlertControllerDelegate,SliderViewDelegate{
    
    
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
    lazy var genderView:GenderView = {
        let gv:GenderView = .fromNib()
        return gv
    }()
    
    lazy var utilitiesView:UtilitiesView = {
        let uv:UtilitiesView = .fromNib()
//        uv.utilityForSC = .filter
        return uv
    }()
    
    lazy var btnSave:UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .defaultBlue
        bt.tintColor = .white
        return bt
    }()
//    var filterVCType:FilterVCType!
    var filterArgumentModel:FilterArgumentModel!
    var utilities:[UtilityModel]?
    var districts:[DistrictModel]?
    var cities:[CityModel]?
    var selectedUtilities:List<UtilityModel>?
    var selectedCity:CityModel?
    var selectedDistrict:DistrictModel?
    var selectedGender:GenderSelect?
    var selectedPrice:List<Float>?
    weak var delegate:FilterVCDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        
    }
    func fetchData(){
        if !APIConnection.isConnectedInternet(){
            showErrorView(inView: self.contentView, withTitle: "NETWORK_STATUS_CONNECTED_REQUEST_ERROR_MESSAGE".localized) {
                self.checkAndLoadInitData(inView: self.contentView) { () -> (Void) in
                    DispatchQueue.main.async {
                        self.setupUIAndData()
                    }
                }
            }
        }else{
            self.checkAndLoadInitData(inView: self.contentView) { () -> (Void) in
                DispatchQueue.main.async {
                    self.setupUIAndData()
                }
            }
        }
    }
    func setupUIAndData(){
        self.utilities = (DBManager.shared.getRecords(ofType: UtilityModel.self)?.toArray(type: UtilityModel.self))!
        self.cities = (DBManager.shared.getRecords(ofType: CityModel.self)?.toArray(type: CityModel.self))!
        self.districts = (DBManager.shared.getRecords(ofType: DistrictModel.self)?.toArray(type: DistrictModel.self))!
        setupUI()
        setData()
    }
    
    func setupUI(){
        view.backgroundColor = .white
        edgesForExtendedLayout = .top// view above navigation bar
//        automaticallyAdjustsScrollViewInsets = false
        //Create tempview for bottom button
        let bottomView = UIView()

        //Caculate height
        let defaultBottomViewHeight:CGFloat = 60.0
        let defaultPadding = UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10)
        let numberOfRow =  (utilities?.count)!%2==0 ? (utilities?.count)!/2 : (utilities?.count)!/2+1
        let utilitiesViewHeight =  Constants.HEIGHT_CELL_NEW_UTILITYCV * Double(numberOfRow) + 70.0
        let contentViewHeight:CGFloat
            contentViewHeight = CGFloat(Constants.HEIGHT_VIEW_SLIDER+Constants.HEIGHT_VIEW_DROPDOWN_LIST*2+Constants.HEIGHT_VIEW_GENDER+utilitiesViewHeight+Constants.HEIGHT_LARGE_SPACE)

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
        //Add Constrant
       
        if #available(iOS 11.0, *) {
             _ = scrollView.anchor(view.safeAreaLayoutGuide.topAnchor, view.leftAnchor, view.safeAreaLayoutGuide.bottomAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: -defaultBottomViewHeight-2*Constants.MARGIN_10, right: -Constants.MARGIN_10))
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
        _ = genderView.anchor(priceSliderView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_GENDER))
        _ = utilitiesView.anchor(genderView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: utilitiesViewHeight))

        _ = btnSave.anchor(view: bottomView,UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0))
        btnSave.layer.cornerRadius = CGFloat(10)
        btnSave.clipsToBounds = true
        btnSave.addTarget(self, action: #selector(onClickBtnSave(btnSave:)), for: .touchUpInside)
        
        
    }

    func setData(){
        navTitle = "FILTER".localized
        btnSave.setTitle("APPLY".localized, for: .normal)
        utilitiesView.utilities = utilities
        
        utilitiesView.delegate = self
        districtDropdownListView.delegate = self
        cityDropdownListView.delegate = self
        genderView.delegate = self
        
        cityDropdownListView.lblSelectTitle.text = "LIST_CITY_TITLE".localized
        districtDropdownListView.lblSelectTitle.text = "LIST_DISTRICT_TITLE".localized
//        filterArgumentModel.searchRequestModel?.districts.first.
        selectedCity = CityModel()
        selectedDistrict = DistrictModel()
        selectedUtilities = List<UtilityModel>()
        selectedPrice = List<Float>()
        selectedPrice?.removeAll()
        selectedPrice?.append(1_000_000)
        selectedPrice?.append(40_000_000)
        selectedGender = .none
    }
    
    //MARK: Handler utilitiesViewDelegate
    func utilitiesViewDelegate(utilitiesView view: UtilitiesView, didSelectUtilityAt indexPath: IndexPath) {
        guard let utility = utilities?[indexPath.row] else {
            return
        }
        if (selectedUtilities?.contains(utility))!{
            utilitiesView.setState(isSelected: false, atIndexPath: indexPath)
            let index = selectedUtilities?.index(of: utility)
            selectedUtilities?.remove(at: index!)
        }else{
            utilitiesView.setState(isSelected: true, atIndexPath: indexPath)
            selectedUtilities?.append(utility)
        }
        
    }
    //MARK: Handler dropdownListViewDelegate
    func dropdownListViewDelegate(view dropdownListView: DropdownListView, onClickBtnChangeSelect btnSelect: UIButton) {
        if dropdownListView == cityDropdownListView{
            let alert = AlertController.showAlertList(withTitle: "LIST_CITY_TITLE".localized, andMessage: nil, alertStyle: .alert,alertType: .city, forViewController: self, data: cities?.map({ (city) -> String     in
                city.name!
            }), rhsButtonTitle: "DONE".localized)
            alert.delegate = self
            
        }else{
            
            if self.selectedCity?.cityId != 0{
                let alert = AlertController.showAlertList(withTitle: "LIST_DISTRICT_TITLE".localized, andMessage: nil, alertStyle: .alert,alertType: .district, forViewController: self, data: districts?.filter({ (district) -> Bool in
                    district.cityId == self.selectedCity?.cityId
                }).map({ (district) -> String in
                    district.name!
                }), rhsButtonTitle: "DONE".localized)
                alert.delegate = self
            }
            
        }
    }
    //MARK: Handler genderViewDelegate
    func genderViewDelegate(genderView view: GenderView, onChangeGenderSelect genderSelect: GenderSelect?) {
        
    }
    //MARK: Handler sliderView
    func sliderView(view sliderView: SliderView, didChangeSelectedMinValue selectedMin: Float, andMaxValue selectedMax: Float) {
        selectedPrice?.removeAll()
        selectedPrice?.append(selectedMin)
        selectedPrice?.append(selectedMax)
    }
    //MARK: UIAlertControllerDelegate
    func alertControllerDelegate(ofController: UIAlertController,withAlertType type:AlertType, atIndexPaths indexs: [IndexPath]?) {
        guard let indexs = indexs else {
            return
        }
        if type == AlertType.city{
            guard let city = cities?[(indexs.first?.row)!]  else{
                return
            }
            selectedCity = city
            selectedDistrict? =  DistrictModel()
            self.cityDropdownListView.lblSelectTitle.text = self.selectedCity?.name
            self.districtDropdownListView.lblSelectTitle.text  = "LIST_DISTRICT_TITLE".localized
        }else if type == AlertType.district{
            guard let districtOfCity = districts?.filter({ (district) -> Bool in
                district.cityId == self.selectedCity?.cityId
            }) else{
                return
            }
            districtOfCity.forEach { (d) in
                print(d.name)
                print(d.districtId)
                print(d.cityId)
            }
            let district =  districtOfCity[(indexs.first?.row)!]
            selectedDistrict = district
            self.districtDropdownListView.lblSelectTitle.text  = self.selectedDistrict?.name
        }
    }
    //MARK: Handler for save button
    @objc  func onClickBtnSave(btnSave:UIButton){
        //handler for save filter
        filterArgumentModel.searchRequestModel = SearchRequestModel()
        filterArgumentModel.searchRequestModel?.gender.value = genderView.genderSelect?.rawValue
        filterArgumentModel.searchRequestModel?.price = selectedPrice!
        if selectedCity?.cityId != 0 && selectedDistrict?.districtId != 0{
            let districts = List<Int>()
            districts.append((selectedDistrict?.districtId)!)
            filterArgumentModel.searchRequestModel?.districts = districts
        }
        let utilities = List<Int>()
        selectedUtilities?.forEach({ (utility) in
            utilities.append(utility.utilityId)
        })
        filterArgumentModel.searchRequestModel?.utilities = utilities
        
        self.delegate?.filterVCDelegate(filterVC: self, onCompletedWithFilter: filterArgumentModel)
        self.navigationController?.popViewController(animated: true)
    }

}
