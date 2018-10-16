//
//  CreateRoomVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import GooglePlaces
import GoogleMaps
import RealmSwift
class CERoomVC: BaseVC,NewInputViewDelegate,MaxMemberSelectViewDelegate,UtilitiesViewDelegate,DescriptionViewDelegate ,UIPopoverPresentationControllerDelegate,UITableViewDelegate,UITableViewDataSource,DropdownListViewDelegate{
    
    
    let scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        return sv
    }()
    let contentView:UIView={
        let cv = UIView()
        return cv
    }()
    lazy var lblRoomInfor:UILabel = {
        let lbl = UILabel()
        lbl.font = .boldMedium
        lbl.text = "ROOM_INFOR_TITLE".localized
        return lbl
    }()
    lazy var nameInputView:NewInputView = {
        let iv:NewInputView = .fromNib()
        iv.inputViewType = .name
        return iv
    }()
    lazy var priceInputView:NewInputView = {
        let iv:NewInputView = .fromNib()
        iv.inputViewType = .price
        return iv
    }()
    lazy var areaInputView:NewInputView = {
        let iv:NewInputView = .fromNib()
        iv.inputViewType = .area
        return iv
    }()
    
    lazy var cityDropdownListView:DropdownListView = {
        let lv:DropdownListView = .fromNib()
        lv.dropdownListViewType = .city
        return lv
    }()
    
    lazy var districtDropdownListView:DropdownListView = {
        let lv:DropdownListView = .fromNib()
        lv.dropdownListViewType = .district
        return lv
    }()
    
    lazy var addressInputView:NewInputView = {
        let iv:NewInputView = .fromNib()
        iv.inputViewType = .address
        return iv
    }()
    lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.showsVerticalScrollIndicator = false
        //        tv.layer.borderWidth = 1
        //        tv.layer.borderColor = UIColor.defaultBlue.cgColor
        tv.layer.cornerRadius = 10
        tv.clipsToBounds = true
        tv.separatorStyle  = .none
        return tv
    }()
    
    lazy var maxMemberSelectView:MaxMemberSelectView = {
        let mv:MaxMemberSelectView = .fromNib()
        return mv
    }()
    
    lazy var utilitiesView:UtilitiesView = {
        let uv:UtilitiesView = .fromNib()
        uv.utilityForSC = UtilityForSC.create
        return uv
    }()
    
    var descriptionsView:DescriptionView = {
        let dv:DescriptionView = .fromNib()
        return dv
    }()
    
    lazy var btnSubmit:UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .defaultBlue
        bt.tintColor = .white
        return bt
    }()
    
    
    
    var keyboardHeight:CGFloat?
    var tableViewHeightConstaint:NSLayoutConstraint?
    let address:[String] = []
    var utilities:Results<UtilityModel>?
    var cities:Results<CityModel>?
    var districts:Results<DistrictModel>?
    var images = ["https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?cs=srgb&dl=4k-wallpaper-background-beautiful-853199.jpg&fm=jpg","https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?cs=srgb&dl=4k-wallpaper-background-beautiful-853199.jpg&fm=jpg","https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?cs=srgb&dl=4k-wallpaper-background-beautiful-853199.jpg&fm=jpg","https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?cs=srgb&dl=4k-wallpaper-background-beautiful-853199.jpg&fm=jpg","https://images.pexels.com/photos/853199/pexels-photo-853199.jpeg?cs=srgb&dl=4k-wallpaper-background-beautiful-853199.jpg&fm=jpg"]
    
    var cERoomVCType:CERoomVCType = .create
    var newRoomModel:NewRoomModel = NewRoomModel()
    
    var suggestAddress:[GMSAutocompletePrediction]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocalData()
        setupUI()
        setData()
        setNotificationObserver()
    }
    
    func loadLocalData(){
        utilities = DBManager.shared.getRecords(ofType: UtilityModel.self)
        cities = DBManager.shared.getRecords(ofType: CityModel.self)
        districts = DBManager.shared.getRecords(ofType: DistrictModel.self)
    }
    
    func setupUI(){
        
        edgesForExtendedLayout = []// view above navigation bar
        
        //Navigation Item
        let barButton = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target:self, action: #selector(onClickBtnSubmit(btnBack:)))
        barButton.tintColor = .defaultBlue
        navigationController?.navigationItem.backBarButtonItem = barButton
        //Create tempview for bottom button
        let bottomView = UIView()
        
        //Caculate height
        let defaultBottomViewHeight:CGFloat = 60.0
        let defaultPadding = UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10)
        let numberOfRow =  (utilities?.count)!%2==0 ? (utilities?.count)!/2 : (utilities?.count)!/2+1
        let utilitiesViewHeight =  Constants.HEIGHT_CELL_NEW_UTILITY * Double(numberOfRow) + 70.0
        let contentViewHeight = CGFloat(Constants.HEIGHT_ROOM_INFOR_TITLE+Constants.HEIGHT_NEW_INPUT_VIEW*4+Constants.HEIGHT_VIEW_MAX_MEMBER_SELECT+Constants.HEIGHT_VIEW_DROPDOWN_LIST*2+utilitiesViewHeight+Constants.HEIGHT_VIEW_DESCRIPTION+Constants.HEIGHT_SPACE)
        //Add View
        view.addSubview(scrollView)
        view.addSubview(bottomView)
        
        
        scrollView.addSubview(contentView)
        bottomView.addSubview(btnSubmit)
        contentView.addSubview(lblRoomInfor)
        contentView.addSubview(nameInputView)
        contentView.addSubview(priceInputView)
        contentView.addSubview(areaInputView)
        contentView.addSubview(cityDropdownListView)
        contentView.addSubview(districtDropdownListView)
        contentView.addSubview(addressInputView)
        contentView.addSubview(tableView)
        //        contentView.addSubview(phoneInputView)
        contentView.addSubview(maxMemberSelectView)
        //        contentView.addSubview(genderView)
        contentView.addSubview(utilitiesView)
        contentView.addSubview(descriptionsView)
        
        //Add Constrant
        
        if #available(iOS 11.0, *) {
            _ = bottomView.anchor(nil, view.leftAnchor, view.safeAreaLayoutGuide.bottomAnchor, view.rightAnchor,defaultPadding,.init(width: 0, height: defaultBottomViewHeight))
            _ = scrollView.anchor(view.topAnchor, view.leftAnchor, bottomView.topAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10))
            
        } else {
            // Fallback on earlier versions
            _ = bottomView.anchor(nil, view.leftAnchor,view.bottomAnchor, view.rightAnchor,defaultPadding,.init(width: 0, height: defaultBottomViewHeight))
            _ = scrollView.anchor(view.topAnchor, view.leftAnchor, bottomView.topAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10))
            
        }
        
        _ = contentView.anchor(scrollView.topAnchor,scrollView.leftAnchor,scrollView.bottomAnchor,scrollView.rightAnchor)
        _ = contentView.anchorWidth(equalTo: scrollView.widthAnchor)
        _  = contentView.anchorHeight(equalToConstrant: contentViewHeight)
        
        _ = lblRoomInfor.anchor(contentView.topAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_ROOM_INFOR_TITLE))
        _ = nameInputView.anchor(lblRoomInfor.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_NEW_INPUT_VIEW))
        _ = priceInputView.anchor(nameInputView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_NEW_INPUT_VIEW))
        _ = areaInputView.anchor(priceInputView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_NEW_INPUT_VIEW))
        _ = cityDropdownListView.anchor(areaInputView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_DROPDOWN_LIST))
        _ = districtDropdownListView.anchor(cityDropdownListView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_DROPDOWN_LIST))
        
        _ = addressInputView.anchor(districtDropdownListView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_NEW_INPUT_VIEW))
        
        //START For suggest address
        tableViewHeightConstaint = tableView.anchor(addressInputView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, .zero, CGSize(width: 0, height: 0.5))[3]
        contentView.bringSubview(toFront: tableView)
        
        //END
        
        _ = maxMemberSelectView.anchor(addressInputView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_MAX_MEMBER_SELECT))
        _ = utilitiesView.anchor(maxMemberSelectView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: utilitiesViewHeight))
        
        _ = descriptionsView.anchor(utilitiesView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_DESCRIPTION))
        
        _ = btnSubmit.anchor(view: bottomView,UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0))
        btnSubmit.layer.cornerRadius = CGFloat(10)
        btnSubmit.clipsToBounds = true
    }
    //MARK:Delegate and data
    func setData(){
        navTitle = "CREATE_ROOM".localized
        btnSubmit.setTitle("APPLY".localized, for: .normal)
        tableView.register(UINib(nibName: Constants.CELL_ICONTITLETV, bundle: Bundle.main), forCellReuseIdentifier: Constants.CELL_ICONTITLETV)
        suggestAddress = []
        //Delegate
        nameInputView.delegate = self
        priceInputView.delegate = self
        areaInputView.delegate =  self
        addressInputView.delegate  = self
        tableView.delegate = self
        tableView.dataSource = self
        maxMemberSelectView.delegate = self
        cityDropdownListView.delegate = self
        districtDropdownListView.delegate = self
        descriptionsView.delegate = self
        btnSubmit.addTarget(self, action: #selector(onClickBtnSubmit(btnBack:)), for: .touchUpInside)
        utilitiesView.delegate = self
        //Data
        if cERoomVCType == CERoomVCType.edit{
            nameInputView.text = newRoomModel.name
            priceInputView.text = newRoomModel.price.toString
            areaInputView.text = newRoomModel.area.toString
            addressInputView.text = newRoomModel.address
            maxMemberSelectView.text = newRoomModel.maxGuest.toString
            utilitiesView.utilities = Array(newRoomModel.utilities)
            descriptionsView.text = newRoomModel.roomDescription ?? ""
        }else{
            utilitiesView.utilities = Array(utilities!)
            descriptionsView.viewType = ViewType.cEForOwner
            
        }
        
    }
    
    func setNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        
        //Not need from ios 9
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: Handler for Keyboard
    @objc func keyboardWillShow(notification:Notification){
        let userInfor = notification.userInfo!
        let keyboardFrame:CGRect = (userInfor[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        print(scrollView.contentInset)
        print(scrollView.contentOffset)
        scrollView.contentInset.bottom = keyboardFrame.size.height
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        print(scrollView.contentInset)
        print(scrollView.contentOffset)
    }
    @objc func keyboardWillHide(notification:Notification){
        scrollView.contentInset = .zero
    }
    
    
    
    
    //MARK: Delegate for subview
    func descriptionViewDelegate(descriptionView view: DescriptionView, textViewDidEndEditing textView: UITextView) {
        newRoomModel.roomDescription = descriptionsView.text
        descriptionsView.tvContent.resignFirstResponder()
        descriptionsView.tvContent.endEditing(true)
    }
    func descriptionViewDelegate(descriptionView view: DescriptionView, textViewShouldBeginEditing textView: UITextView) {
        scrollView.contentOffset.y = descriptionsView.frame.origin.y
    }
    func utilitiesViewDelegate(utilitiesView view: UtilitiesView, didSelectUtilityAt indexPath: IndexPath) {
        
        
        //        roomRequestModel.description = descriptionsView.text
        //                let vc = UIViewController()
        //                vc.preferredContentSize = CGSize(width: 242, height: 300)
        //                let nav = UINavigationController(rootViewController: vc)
        //                nav.modalPresentationStyle = .overCurrentContext
        //                let popup = nav.popoverPresentationController
        //                popup?.delegate = self
        //                popup?.sourceView = view.collectionView.cellForItem(at: indexPath)?.contentView
        
        let vc = Utilities.vcFromStoryBoard(vcName: Constants.VC_UTILITY_INPUT, sbName: Constants.STORYBOARD_MAIN)
        //                vc.view.backgroundColor = .red
        vc.view.frame.size = CGSize(width: 242,
                                    height:  200)
        vc.definesPresentationContext = true
        
        vc.modalTransitionStyle  = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    
    func maxMemberSelectViewDelegate(view maxMemberSelectView: MaxMemberSelectView, onClickBtnSub btnSub: UIButton) {
        guard let text = maxMemberSelectView.text,let maxMember = Int(text) else {
            return
        }
        newRoomModel.maxGuest = maxMember
    }
    
    func maxMemberSelectViewDelegate(view maxMemberSelectView: MaxMemberSelectView, onClickBtnPlus btnPlus: UIButton) {
        guard let text = maxMemberSelectView.text,let maxMember = Int(text) else {
            return
        }
        newRoomModel.maxGuest = maxMember
    }
    func newInputViewDelegate(newInputView view: NewInputView, shouldChangeCharactersTo string: String) {
        switch view {
        case nameInputView:
            guard let text = view.text else{
                return
            }
            newRoomModel.name = text
        case priceInputView:
            guard let text = view.text, let price = Double(text) else{
                return
            }
            newRoomModel.price = price
        case areaInputView:
            guard let text = view.text, let int = Int(text) else{
                return
            }
            newRoomModel.area = int
        case addressInputView:
            search(text: string)
            guard let text = view.text else{
                return
            }
            newRoomModel.address = text
            view.layoutIfNeeded()
        default:
            break
            
        }
    }
    func dropdownListViewDelegate(view dropdownListView: DropdownListView, onClickBtnChangeSelect btnSelect: UIButton) {
        if dropdownListView == cityDropdownListView{
            let alert = AlertController.showAlertList(withTitle: "LIST_CITY_TITLE".localized, andMessage: nil, alertStyle: .alert, forViewController: self, data: districts?.map({ (district) -> String     in
                district.name!
            }), lhsButtonTitle: "CANCEL".localized, rhsButtonTitle: "OK".localized, lhsButtonHandler: nil, rhsButtonHandler: nil)
            print(alert.tableView.indexPathsForSelectedRows)
        }else{
            
        }
    }
    
    
    //MARK: UITableview Delegate and Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestAddress?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_ICONTITLETV, for: indexPath) as! IconTitleTVCell
        cell.lblTitle.text  = suggestAddress?[indexPath.row].attributedFullText.string
        print("Cell:\(suggestAddress?[indexPath.row].attributedFullText.string)")
        cell.imgvIcon.image = UIImage(named: "address")
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addressInputView.isSelectedFromSuggest = true
        addressInputView.tfInput.text = suggestAddress?[indexPath.row].attributedFullText.string
        print("Did selected text : \(suggestAddress?[indexPath.row])")
        GMSPlacesClient.shared().lookUpPlaceID((suggestAddress?[indexPath.row].placeID)!, callback: { (place, error) in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }else{
                print("Place Component:")
                print(place?.coordinate.longitude)
                print(place?.coordinate.latitude)
                place?.addressComponents?.forEach({ (component) in
                    print(component.type)
                    print(component.name)
                })
            }
        })
        suggestAddress?.removeAll()
        reloadTableViewUI()
    }
    
    func reloadTableViewUI(){
        if suggestAddress!.count>0{
            tableViewHeightConstaint?.constant = 150.0
            tableView.reloadData()
        }else{
            tableViewHeightConstaint?.constant = 0
        }
    }
    
    //MARK: Handler for save button
    @objc  func onClickBtnSubmit(btnBack:UIButton){
        showIndicator()
//        newRoomModel.name = "Phòng số 4"
//        newRoomModel.price = 5000_000
//        newRoomModel.area = 25
//        newRoomModel.cityId = 45
//        newRoomModel.userId = 122
//        newRoomModel.districtId = 493
//        newRoomModel.utilities.removeAll()
//        utilities?.forEach({ (utilityModel) in
//            newRoomModel.utilities.append( utilityModel)
//        })
//        newRoomModel.imageUrls.removeAll()
//        images.forEach { (str) in
//            newRoomModel.imageUrls.append(str)
//        }
//        newRoomModel.roomDescription = "Nothing"
//        newRoomModel.maxGuest = 5
//        newRoomModel.address = "123 Nguyễn Đình Chiểu Phường 6 Quận 3 Hồ Chí Minh, Việt Nam"
//        newRoomModel.longitude = 10.7773007
//        newRoomModel.latitude = 106.6872542
        Alamofire.request(APIRouter.createRoom(model: newRoomModel)).response { (response) in
            self.hideIndicator()
            print(response.response?.statusCode)
        }
        
    }
    
    //MARK: Custom method
    func search(text:String) {
        
        // Set bounds to inner viet nam.
        //        let neBoundsCorner = CLLocationCoordinate2D(latitude: 15.6275655,
        //                                                    longitude: 96.8441401)
        //        let swBoundsCorner = CLLocationCoordinate2D(latitude: 15.6275655,
        //                                                    longitude: 96.8441401)
        //        let bounds = GMSCoordinateBounds(coordinate: neBoundsCorner,
        //                                         coordinate: swBoundsCorner)
        
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        filter.country = "VN"
        //        getCoordinateBounds(latitude: 10.7792897, longitude: 106.6635715,distance:0)
        GMSPlacesClient.shared().autocompleteQuery(text, bounds: nil , filter: filter, callback: {(results, error) -> Void in
            if let results = results , results.count>0{
                self.suggestAddress?.removeAll()
                results.forEach({ (result) in
                    print("Location:\(result.attributedFullText.string.lowercased().contains("quận 3"))")
                    if result.attributedFullText.string.lowercased().contains("quận 3"),result.attributedFullText.string.lowercased().contains("hồ chí minh".lowercased()){
                        self.suggestAddress?.append(result)
                        print("Add :\(result.attributedFullText.string)")
                    }
                })
                self.reloadTableViewUI()
            }
        })
        
        
    }
    func getCoordinateBounds(latitude:CLLocationDegrees ,
                             longitude:CLLocationDegrees,
                             distance:Double = 0.001)->GMSCoordinateBounds{
        let center = CLLocationCoordinate2D(latitude: latitude,
                                            longitude: longitude)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + distance, longitude: center.longitude + distance)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - distance, longitude: center.longitude - distance)
        
        return GMSCoordinateBounds(coordinate: northEast,
                                   coordinate: southWest)
        
    }
    //    func isValidInformation
    
}
