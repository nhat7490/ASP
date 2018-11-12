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
import MBProgressHUD
import AVFoundation
import PhotosUI
class CERoomVC: BaseVC,NewInputViewDelegate,MaxMemberSelectViewDelegate,UtilitiesViewDelegate,DescriptionViewDelegate ,UIPopoverPresentationControllerDelegate,UITableViewDelegate,UITableViewDataSource,DropdownListViewDelegate,UtilityInputVCDelegate,UploadImageViewDelegate{
    
    
    
    
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
    lazy var nameInputView:InputView = {
        let iv:InputView = .fromNib()
        iv.inputViewType = .roomName
        return iv
    }()
    lazy var priceInputView:InputView = {
        let iv:InputView = .fromNib()
        iv.inputViewType = .price
        return iv
    }()
    lazy var areaInputView:InputView = {
        let iv:InputView = .fromNib()
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
    
    lazy var addressInputView:InputView = {
        let iv:InputView = .fromNib()
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
        //        uv.utilityForSC = UtilityForSC.create
        return uv
    }()
    
    lazy var descriptionsView:DescriptionView = {
        let dv:DescriptionView = .fromNib()
        return dv
    }()
    
    lazy var uploadImageView:UploadImageView = {
        let uv:UploadImageView = .fromNib()
        return uv
    }()
    
    lazy var btnSubmit:UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .defaultBlue
        bt.tintColor = .white
        return bt
    }()
    var contentViewHeightConstraint:NSLayoutConstraint?
    var uploadImageViewHeightConstraint:NSLayoutConstraint?
    var keyboardHeight:CGFloat?
    var tableViewHeightConstaint:NSLayoutConstraint?
    let address:[String] = []
    var utilities:Results<UtilityModel>?
    var cities:Results<CityModel>?
    var districts:Results<DistrictModel>?
    
    var cERoomVCType:CERoomVCType = .create
    var newRoomModel:RoomResponseModel = RoomResponseModel()
    var cityName:String = ""
    var districtName:String = ""
    var selectedCity:CityModel?
    var selectedDistrict:DistrictModel?
    var suggestAddress:[[GPPrediction:GPPlaceResult]]?
    var alertController:AlertController?
    var fixSizeHeight:CGFloat = 0
    var imageWith:CGFloat = 0
    var uploadImageModels:[UploadImageModel] = []
    //MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocalData()
        setupUI()
        setData()
//        setNotificationObserver()
        registerNotificationForKeyboard()
    }
    
    func loadLocalData(){
        utilities = DBManager.shared.getRecords(ofType: UtilityModel.self)
        cities = DBManager.shared.getRecords(ofType: CityModel.self)
        districts = DBManager.shared.getRecords(ofType: DistrictModel.self)
    }
    
    func setupUI(){
        title = cERoomVCType == .create ? "CREATE_ROOM".localized : "ROOM_EDIT".localized
        
        setBackButtonForNavigationBar()
        //Create tempview for bottom button
        let bottomView = UIView()
        
        //Caculate height
        let defaultBottomViewHeight:CGFloat = 60.0
        imageWith = ((view.frame.width - Constants.MARGIN_10*2)/3-10)
        let numberOfImageRow =  uploadImageModels.count%3==0 ? uploadImageModels.count/3 : uploadImageModels.count/3+1
        let uploadImageViewHeight:CGFloat = CGFloat(numberOfImageRow) * imageWith  + Constants.HEIGHT_VIEW_UPLOAD_IMAGE_BASE+Constants.HEIGHT_LARGE_SPACE
        let defaultPadding = UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10)
        let numberOfRow =  (utilities?.count)!%2==0 ? (utilities?.count)!/2 : (utilities?.count)!/2+1
        let utilitiesViewHeight:CGFloat =  CGFloat(Constants.HEIGHT_CELL_NEW_UTILITYCV * CGFloat(numberOfRow) + 70.0)
        let part1 = Constants.HEIGHT_ROOM_INFOR_TITLE+Constants.HEIGHT_NEW_INPUT_VIEW*4
        let part2 = Constants.HEIGHT_VIEW_MAX_MEMBER_SELECT+Constants.HEIGHT_VIEW_DROPDOWN_LIST*2
        let part3 = utilitiesViewHeight + Constants.HEIGHT_VIEW_DESCRIPTION + Constants.HEIGHT_LARGE_SPACE
        fixSizeHeight = part1 + part2 + part3
        let contentViewHeight:CGFloat = uploadImageViewHeight + fixSizeHeight
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
        contentView.addSubview(uploadImageView)
        
        //Add Constrant
        
        if #available(iOS 11.0, *) {
            _ = bottomView.anchor(nil, view.leftAnchor, view.safeAreaLayoutGuide.bottomAnchor, view.rightAnchor,defaultPadding,.init(width: 0, height: defaultBottomViewHeight))
            _ = scrollView.anchor(view.topAnchor, view.leftAnchor, bottomView.topAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10))
            
        } else {
            // Fallback on earlier versions
            _ = bottomView.anchor(nil, view.leftAnchor,view.bottomAnchor, view.rightAnchor,defaultPadding,.init(width: 0, height: defaultBottomViewHeight))
            _ = scrollView.anchor(view.topAnchor, view.leftAnchor, bottomView.topAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10))
            
        }
        
        
        contentViewHeightConstraint = contentView.anchor(scrollView.topAnchor,scrollView.leftAnchor,scrollView.bottomAnchor,scrollView.rightAnchor,.zero,CGSize(width: 0, height: contentViewHeight))[4]
        _ = contentView.anchorWidth(equalTo:scrollView.widthAnchor)
        
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
        uploadImageViewHeightConstraint = uploadImageView.anchor(descriptionsView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: uploadImageViewHeight))[3]
        _ = btnSubmit.anchor(view: bottomView,UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0))
        btnSubmit.layer.cornerRadius = CGFloat(10)
        btnSubmit.clipsToBounds = true
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
    }
    //MARK:Delegate and data
    func setData(){
        btnSubmit.setTitle("SAVE".localized, for: .normal)
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
        utilitiesView.delegate = self
        descriptionsView.delegate = self
        uploadImageView.delegate = self
        btnSubmit.addTarget(self, action: #selector(onClickBtnSubmit(btnSubmit:)), for: .touchUpInside)
        
        //Data
        if cERoomVCType == CERoomVCType.edit{
            nameInputView.text = newRoomModel.name
            priceInputView.text = newRoomModel.price.toString
            areaInputView.text = newRoomModel.area.toString
            addressInputView.text = newRoomModel.address
            maxMemberSelectView.text = newRoomModel.maxGuest.toString
            
            cityName = DBManager.shared.getRecord(id: newRoomModel.cityId, ofType: CityModel.self)?.name ?? ""
            cityDropdownListView.text = cityName
            
            districtName = DBManager.shared.getRecord(id: newRoomModel.districtId, ofType: DistrictModel.self)?.name ?? ""
            districtDropdownListView.text = districtName
            
            addressInputView.isSelectedFromSuggest = true
            utilitiesView.selectedUtilities = Array(newRoomModel.utilities).map{$0.utilityId}
            utilitiesView.utilities = Array(utilities!)
            descriptionsView.text = newRoomModel.roomDescription ?? ""
            descriptionsView.viewType = ViewType.editForOwner
            uploadImageModels = newRoomModel.imageUrls.compactMap{UploadImageModel(name: URL(string: $0)?.lastPathComponent, linkUrl: $0)}
            calculatorHeight()
        }else{
            utilitiesView.utilities = Array(utilities!)
            descriptionsView.viewType = ViewType.createForOwner
        }
        uploadImageView.images = uploadImageModels
        
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
//    func setNotificationObserver(){
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//    }
//
//    deinit {
//
//        //Not need from ios 9
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//    }
//
//    //MARK: Handler for Keyboard
//    @objc func keyboardWillShow(notification:Notification){
//        let userInfor = notification.userInfo!
//        let keyboardFrame:CGRect = (userInfor[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
//        print(scrollView.contentInset)
//        print(scrollView.contentOffset)
//        scrollView.contentInset.bottom = keyboardFrame.size.height
//        scrollView.scrollIndicatorInsets = scrollView.contentInset
//        print(scrollView.contentInset)
//        print(scrollView.contentOffset)
//    }
//    @objc func keyboardWillHide(notification:Notification){
//        scrollView.contentInset = .zero
//    }
    
    
    
    
    //MARK: Delegate for subview
    func descriptionViewDelegate(descriptionView view: DescriptionView, textViewDidEndEditing textView: UITextView) {
        newRoomModel.roomDescription = descriptionsView.text!
        descriptionsView.tvContent.resignFirstResponder()
        descriptionsView.tvContent.endEditing(true)
    }
    func descriptionViewDelegate(descriptionView view: DescriptionView, textViewShouldBeginEditing textView: UITextView) {
        scrollView.contentOffset.y = descriptionsView.frame.origin.y
    }
    func utilitiesViewDelegate(utilitiesView view: UtilitiesView, didSelectUtilityAt indexPath: IndexPath) {
        
        let vc = Utilities.vcFromStoryBoard(vcName: Constants.VC_UTILITY_INPUT, sbName: Constants.STORYBOARD_MAIN) as! UtilityInputVC
        vc.utilityModel = utilities![indexPath.row].copy(with: nil) as! UtilityModel
        vc.indexPath = indexPath
        vc.view.frame.size = CGSize(width: 242,
                                    height:  200)
        vc.delegate = self
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
    func newInputViewDelegate(newInputView view: InputView, shouldChangeCharactersTo string: String) -> Bool{
        switch view {
        case nameInputView:
            newRoomModel.name = string
        case priceInputView:
            if string.isEmpty{return true}
            guard let price = Int(string) else{
                return false
            }
            newRoomModel.price = price
        case areaInputView:
            if string.isEmpty{return true}
            guard let int = Int(string) else{
                return false
            }
            newRoomModel.area = int
        case addressInputView:
            if newRoomModel.districtId == 0{
                addressInputView.tfInput.setupUI(placeholder: "ROOM_ADDRESS_TITLE_REQUIRED_DISTRICT", title: "ROOM_ADDRESS_TITLE", delegate: addressInputView)
                return false
            }else{
                addressInputView.isSelectedFromSuggest = false
                addressInputView.tfInput.setupUI(placeholder: "ROOM_ADDRESS_TITLE", title: "ROOM_ADDRESS_TITLE", delegate: addressInputView)
                search(text: string)
//                newRoomModel.address = string
//                view.layoutIfNeeded()
            }
        default:
            break
            
        }
        return true
    }
    func dropdownListViewDelegate(view dropdownListView: DropdownListView, onClickBtnChangeSelect btnSelect: UIButton) {
        if dropdownListView == cityDropdownListView{
            let alert = AlertController.showAlertList(withTitle: "LIST_CITY_TITLE".localized, andMessage: nil, alertStyle: .alert,alertType: .city, forViewController: self, data: cities?.map{$0.name!}, rhsButtonTitle: "OK".localized)
            alert.delegate = self
        }else{
            
            if newRoomModel.cityId != 0{
                let alert = AlertController.showAlertList(withTitle: "LIST_DISTRICT_TITLE".localized, andMessage: nil, alertStyle: .alert,alertType: .district, forViewController: self, data: districts?.filter({ (district) -> Bool in
                    district.cityId == self.newRoomModel.cityId
                }).map({ $0.name!
                }), rhsButtonTitle: "OK".localized)
                alert.delegate = self
            }
            
        }
        self.addressInputView.text = ""
    }
    //MARK: UIAlertControllerDelegate
    override func alertControllerDelegate(alertController: AlertController,withAlertType type:AlertType, onCompleted indexs: [IndexPath]?) {
        guard let indexs = indexs else {
            return
        }
        if cERoomVCType == CERoomVCType.create{
            if type == AlertType.city{
                guard let city = cities?[(indexs.first?.row)!]  else{
                    return
                }
                newRoomModel.cityId = city.cityId
                cityName = city.name!
                newRoomModel.districtId = 0
                addressInputView.isSelectedFromSuggest = false
                self.cityDropdownListView.text = self.cityName
                self.districtDropdownListView.dropdownListViewType = .district
            }else if type == AlertType.district{
                guard let districtOfCity = districts?.filter({ (district) -> Bool in
                    district.cityId == self.newRoomModel.cityId
                }) else{
                    return
                }
                districtOfCity.forEach { (d) in
                    print(d.districtId)
                    print(d.cityId)
                }
                let district = Array(districtOfCity)[(indexs.first?.row)!]
                addressInputView.isSelectedFromSuggest = false
                newRoomModel.districtId = district.districtId
                self.districtName = district.name!
                self.cityDropdownListView.text = self.cityName
                self.districtDropdownListView.text = self.districtName
            }
        }
    }
    
    override func alertControllerDelegate(alertController: AlertController, onSelected selectedIndexs: [IndexPath]?) {
        
        guard let index = selectedIndexs?.first else {
            return
        }
        if self.alertController == alertController{
            alertController.dismiss(animated: true, completion: nil)
            if index.row == 0{
                checkPermission(type: .camera)
            }else{
                checkPermission(type: .photoLibrary)
            }
        }
    }
    //MARK: UtilityInputVCDelegate
    func utilityInputVCDelegate(onCompletedInputUtility utility:UtilityModel,atIndexPath indexPath:IndexPath?) {
        newRoomModel.utilities.append(utility)
        utilitiesView.setState(isSelected: true, atIndexPath: indexPath!)
    }
    func utilityInputVCDelegate(onDeletedInputUtility utility:UtilityModel,atIndexPath indexPath:IndexPath?){
        guard let index = newRoomModel.utilities.index(where: { (record) -> Bool in
            utility.utilityId == record.utilityId
        }) else {
            return
        }
        newRoomModel.utilities.remove(at: index)
        utilitiesView.setState(isSelected: false, atIndexPath: indexPath!)
    }
    
    //MARK: UITableview Delegate and Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestAddress?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_ICONTITLETV, for: indexPath) as! IconTitleTVCell
        let selectedRecord = suggestAddress?[indexPath.row]
        cell.lblTitle.text  =  selectedRecord?.keys.first?.address
        cell.imgvIcon.image = UIImage(named: "address")
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (suggestAddress?.count)! > 0{
            guard let selectedRecord = suggestAddress?[indexPath.row] else{
                return
            }
            addressInputView.isSelectedFromSuggest = true
            self.newRoomModel.address = selectedRecord.keys.first!.address
            self.newRoomModel.latitude = selectedRecord.values.first!.lat
            self.newRoomModel.longitude = selectedRecord.values.first!.lng
            addressInputView.tfInput.text = selectedRecord.keys.first?.address
            suggestAddress?.removeAll()
            reloadTableViewUI()
        }
        
    }
    
    func reloadTableViewUI(){
        if !addressInputView.isSelectedFromSuggest{
            tableViewHeightConstaint?.constant = 150.0
            tableView.reloadData()
        }else{
            tableViewHeightConstaint?.constant = 0
        }
    }
    
    
    //MARK: UploadImageViewDelegate
    func uploadImageViewDelegate(uploadImageView view: UploadImageView, onClickBtnSelectImage button: UIButton) {
        if uploadImageModels.count<=12{
            alertController = AlertController.showAlertList(withTitle: "ROOM_UPLOAD_SELECT".localized, andMessage: nil, alertStyle: .alert, forViewController: self, data: ["CAMERA".localized,"PHOTO".localized], rhsButtonTitle: nil)
            alertController?.delegate = self
        }else{
            AlertController.showAlertInfor(withTitle: "INFORMATION".localized, forMessage: "ROOM_UPLOAD_MAX".localized, inViewController: self)
        }
        
    }
    func uploadImageViewDelegate(uploadImageView view: UploadImageView, removeCellAtIndextPath indexPath: IndexPath?) {
        guard let row = indexPath?.row else {
            return
        }
//        images.remove(at: row)
//        uploadImageView.images = uploadImageFiles
//        self.uploadImageFiles.remove(at:row)
        self.uploadImageModels.remove(at: row)
        self.calculatorHeight()
    }
    //MARK: UIImagePickerControllerDelegate
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true) {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
                self.uploadImageModels.append(UploadImageModel(name: self.generateImageName(), image: image))
                self.calculatorHeight()
            }
        }
    }
    
    //MARK: Handler for save button
    @objc  func onClickBtnSubmit(btnSubmit:UIButton){
        saveRoom()
    }
    
    //MARK: Custom method
    func search(text:String) {
        APIConnection.requestObject(apiRouter: APIRouter.search(input:text), errorNetworkConnectedHander: nil, returnType: GPAutocompletePrediction.self) { (predictions, error, statusCode) -> (Void) in
            if predictions?.status == "OK",let predictions = predictions?.predictions,predictions.count>0{
                self.suggestAddress?.removeAll()
                predictions.forEach({ (prediction) in
                    if prediction.address.lowercased().contains(self.districtName.lowercased()),
                        prediction.address.lowercased().contains(self.cityName.lowercased()){
                        print("Add :\(prediction.address)")
                        APIConnection.requestObject(apiRouter: APIRouter.placeDetail(id:prediction.place_id), errorNetworkConnectedHander: nil, returnType: GPPlaceResult.self) { (place, error, statusCode) -> (Void) in
                            if place?.status == "OK",let place = place{
                                self.suggestAddress?.append([prediction:place])
                                self.reloadTableViewUI()
                            }
                        }
                    }
                })
            }
            
        }
    }
    
    
    //}
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
    func checkValidInformation()->Bool{
        let message = NSMutableAttributedString(string: "")
        
        if !newRoomModel.name.isValidName(){
            message.append(NSAttributedString(string: "\("ROOM_NAME_TITLE".localized) :  \("ERROR_TYPE_NAME_MAX_CHAR_50".localized)\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
        }
        
        if !newRoomModel.price.toString.isValidPrice(){
            message.append(NSAttributedString(string: "\("PRICE".localized) :  \("ERROR_TYPE_PRICE".localized)\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
        }
        if !newRoomModel.area.toString.isValidArea(){
            message.append(NSAttributedString(string: "\("AREA_TITLE".localized) :  \("ERROR_TYPE_AREA".localized)\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
        }
        if newRoomModel.cityId == 0 {
            message.append(NSAttributedString(string: "\("CITY".localized) :  \("ERROR_TYPE_CITY".localized)\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
        }
        if newRoomModel.districtId == 0{
            message.append(NSAttributedString(string: "\("AREA_TITLE".localized) :  \("ERROR_TYPE_DISTRICT".localized)\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
        }
        if !addressInputView.isSelectedFromSuggest || newRoomModel.longitude == 0 || newRoomModel.latitude == 0{
            message.append(NSAttributedString(string: "\("ROOM_ADDRESS_TITLE".localized) :  \("ERROR_TYPE_ADDRESS_SUGGEST".localized)\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
            
        }
        if newRoomModel.utilities.count<5{
            message.append(NSAttributedString(string: "\("UTILITY_TITLE".localized) :  \("ERROR_TYPE_UTILITY".localized)\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
        }
        if uploadImageModels.count<2{
            message.append(NSAttributedString(string: "\("ROOM_UPLOAD_IMAGE_TITLE".localized) :  \("ROOM_UPLOAD_LIMIT".localized)\n", attributes: [NSAttributedStringKey.font:UIFont.small]))
        }
        
        if message.string.isEmpty{
            return true
        }else{
            let title = NSAttributedString(string: "INFORMATION".localized, attributes: [NSAttributedStringKey.font:UIFont.boldMedium,NSAttributedStringKey.foregroundColor:UIColor.defaultBlue])
            AlertController.showAlertInfoWithAttributeString(withTitle: title, forMessage: message, inViewController: self)
        }
        return false
    }
    
    func saveRoom(){
        newRoomModel.userId = DBManager.shared.getUser()!.userId
        if checkValidInformation(){
            
            let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
            hub.mode = .indeterminate
            hub.bezelView.backgroundColor = .white
            hub.contentColor = .defaultBlue
            hub.label.text = "MB_LOAD_UPLOAD_IMAGE".localized
            DispatchQueue.global(qos: .userInteractive).async {
                
                self.uploadImageModels.filter{$0.linkUrl==nil}.forEach({ (model) in
                    self.group.enter()
                    self.uploadImage(model)
                    self.group.wait()
                })
                DispatchQueue.main.async {
                    hub.label.text = self.cERoomVCType == .create ?  "MB_LOAD_CREATE_ROOM".localized : "MB_LOAD_EDIT_ROOM".localized
                }
                if (self.uploadImageModels.filter{$0.linkUrl==nil}).count == 0{
                    self.newRoomModel.imageUrls = self.uploadImageModels.compactMap{$0.linkUrl}
                    APIConnection.request(apiRouter: self.cERoomVCType == .create ? APIRouter.createRoom(model: self.newRoomModel) : APIRouter.updateRoom(model: self.newRoomModel),  errorNetworkConnectedHander: {
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
                                    MBProgressHUD.hide(for: self.view, animated: true)
                                    NotificationCenter.default.post(name: Constants.NOTIFICATION_EDIT_ROOM, object: self.newRoomModel)
                                    AlertController.showAlertInfor(withTitle: "INFORMATION".localized, forMessage:  self.cERoomVCType == .create ? "ROOM_CREATE_SUCCESS".localized : "EDIT_ROOM_SUCCESS".localized, inViewController: self,rhsButtonHandler: {
                                        (action) in
                                        self.navigationController?.dismiss(animated: true, completion:nil)
                                    })
                                    
                                    
                                }
                            }else{
                                DispatchQueue.main.async {
                                    APIResponseAlert.defaultAPIResponseError(controller: self, error: .PARSE_RESPONSE_FAIL)
                                }
                            }
                        }
                    })
                }else{
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                    
                    AlertController.showAlertInfor(withTitle: "INFORMATION".localized, forMessage: "ROOM_UPLOAD_ERROR".localized, inViewController: self)
                }
            }
        }
    }
    func uploadImage(_ uploadImageModel:UploadImageModel){
        var urlRequest = try! URLRequest(url: URL(string: "\(Constants.BASE_URL_API)image/upload")!, method: .post, headers:nil)
        urlRequest.timeoutInterval = 60
        let data:Data = UIImageJPEGRepresentation(uploadImageModel.image!, 0.1)!
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: "image", fileName: uploadImageModel.name!, mimeType: "image/jpg")
        }, with: urlRequest) { (result) in
            switch result{
            case .failure(let error):
                print(error)
                self.group.leave()
                break
            case .success(let request, let fromDisk, let url):
                request.responseObject(completionHandler: { (response:DataResponse<UploadImageResponseModel>) in
                    if response.error != nil{
                        self.group.leave()
                    }else{
                        guard let uploadImageResponseModel = response.result.value else{
                            self.group.leave()
                            return
                        }
                        print("Upload image url :\(uploadImageResponseModel.imageUrl)")
                        uploadImageModel.linkUrl = uploadImageResponseModel.imageUrl
                        self.group.leave()
                    }
                })
                
            }
        }
    }
    func calculatorHeight(){
        let numberOfImageRow =  self.uploadImageModels.count%3==0 ? self.uploadImageModels.count/3 : self.uploadImageModels.count/3+1
        let uploadImageViewHeight:CGFloat = CGFloat(numberOfImageRow) * self.imageWith  + Constants.HEIGHT_VIEW_UPLOAD_IMAGE_BASE+Constants.HEIGHT_LARGE_SPACE
        let contentViewHeight:CGFloat = uploadImageViewHeight + self.fixSizeHeight
        self.contentViewHeightConstraint?.constant = contentViewHeight
        self.uploadImageViewHeightConstraint?.constant = uploadImageViewHeight
        self.uploadImageView.images = self.uploadImageModels
        let bottomOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height + self.scrollView.contentInset.bottom)
        if(bottomOffset.y > 0) {
            self.scrollView.setContentOffset(bottomOffset, animated: true)
        }
        self.view.layoutIfNeeded()
    }
}