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
class CERoomVC: BaseVC,NewInputViewDelegate,MaxMemberSelectViewDelegate,GenderViewDelegate,UtilitiesViewDelegate,DescriptionViewDelegate ,UIPopoverPresentationControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    
    let placesClient = GMSPlacesClient.shared()
    
    
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
    
    lazy var phoneInputView:NewInputView = {
        let iv:NewInputView = .fromNib()
        iv.inputViewType = .phone
        return iv
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
    var tableViewHeightConstaint:NSLayoutConstraint?
    let address:[String] = ["123 nguyen kiem hcm viet name","123 le van sy hcm viet nam","123 le van sy hcm viet nam","123 le van sy hcm viet nam","123 le van sy hcm viet nam"]
    var utilities = [UtilityModel(utility_id: 1, name: "24-hours", quantity: 15, brand: "Hello", description: "nothing"),UtilityModel(utility_id: 1, name: "parking", quantity: 15, brand: "Hello", description: "nothing"),UtilityModel(utility_id: 1, name: "toilet", quantity: 15, brand: "Hello", description: "nothing"),
                     UtilityModel(utility_id: 2, name: "aircondition", quantity: 15, brand: "Hello", description: "nothing"),
                     UtilityModel(utility_id: 3, name: "cctv", quantity: 15, brand: "Hello", description: "nothing"),
                     UtilityModel(utility_id: 4, name: "cooking", quantity: 15, brand: "Hello", description: "nothing"),
                     UtilityModel(utility_id: 5, name: "fan", quantity: 15, brand: "Hello", description: "nothing")]
    
    var cERoomVCType:CERoomVCType = .create
    var roomRequestModel:BaseRoomRequestModel = BaseRoomRequestModel()
    
    var suggestAddress:[GMSAutocompletePrediction]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
        setNotificationObserver()
    }
    //    func getCoordinateBounds(latitude:CLLocationDegrees ,
    //                             longitude:CLLocationDegrees,
    //                             distance:Double = 1)->GMSCoordinateBounds{
    //        let center = CLLocationCoordinate2D(latitude: latitude,
    //                                            longitude: longitude)
    //        let northEast = CLLocationCoordinate2D(latitude: center.latitude + distance, longitude: center.longitude + distance)
    //        let southWest = CLLocationCoordinate2D(latitude: center.latitude - distance, longitude: center.longitude - distance)
    //
    //        return GMSCoordinateBounds(coordinate: northEast,
    //                                   coordinate: southWest)
    //
    //    }
    func setupUI(){
        
        //        getCoordinateBounds(latitude: 10.7553405, longitude: 106.4143401)
        
        
        
        
        edgesForExtendedLayout = []// view above navigation bar
        
        //Navigation Item
        let barButton = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target:self, action: #selector(onClickBtnBack(btnBack:)))
        barButton.tintColor = .defaultBlue
        navigationController?.navigationItem.backBarButtonItem = barButton
        //Create tempview for bottom button
        let bottomView = UIView()
        
        //Caculate height
        let defaultBottomViewHeight:CGFloat = 60.0
        let defaultPadding = UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: 0, right: -Constants.MARGIN_10)
        //        let numberOfRow = utilities.count%4==0 ? utilities.count/4 : utilities.count/4+1
        //        let utilitiesViewHeight =  Constants.HEIGHT_CELL_NEW_UTILITY * Double(numberOfRow) + 40.0
        let numberOfRow = utilities.count%2==0 ? utilities.count/2 : utilities.count/2+1
        let utilitiesViewHeight =  Constants.HEIGHT_CELL_NEW_UTILITY * Double(numberOfRow) + 60.0
        //        let contentViewHeight = CGFloat(Constants.HEIGHT_ROOM_INFOR_TITLE+Constants.HEIGHT_INPUT_VIEW*5+Constants.HEIGHT_VIEW_DROPDOWN_LIST*2+Constants.HEIGHT_VIEW_MAX_MEMBER_SELECT+Constants.HEIGHT_VIEW_GENDER+utilitiesViewHeight+Constants.HEIGHT_VIEW_DESCRIPTION)
        let contentViewHeight = CGFloat(Constants.HEIGHT_ROOM_INFOR_TITLE+Constants.HEIGHT_NEW_INPUT_VIEW*5+Constants.HEIGHT_VIEW_MAX_MEMBER_SELECT+Constants.HEIGHT_VIEW_GENDER+utilitiesViewHeight+Constants.HEIGHT_VIEW_DESCRIPTION+Constants.HEIGHT_SPACE)
        //Add View
        view.addSubview(scrollView)
        view.addSubview(bottomView)
        
        
        scrollView.addSubview(contentView)
        bottomView.addSubview(btnSubmit)
        contentView.addSubview(lblRoomInfor)
        contentView.addSubview(nameInputView)
        contentView.addSubview(priceInputView)
        contentView.addSubview(areaInputView)
        contentView.addSubview(addressInputView)
        contentView.addSubview(tableView)
        contentView.addSubview(phoneInputView)
        contentView.addSubview(maxMemberSelectView)
        contentView.addSubview(genderView)
        contentView.addSubview(utilitiesView)
        contentView.addSubview(descriptionsView)
        
        //Add Constrant
        
        if #available(iOS 11.0, *) {
            _ = scrollView.anchor(view.topAnchor, view.leftAnchor, bottomLayoutGuide.bottomAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: -defaultBottomViewHeight-2*Constants.MARGIN_10, right: -Constants.MARGIN_10))
            _ = bottomView.anchor(scrollView.bottomAnchor, view.leftAnchor, nil, view.rightAnchor,defaultPadding,.init(width: 0, height: defaultBottomViewHeight))
        } else {
            // Fallback on earlier versions
            _ = scrollView.anchor(view.topAnchor, view.leftAnchor, bottomLayoutGuide.bottomAnchor, view.rightAnchor, UIEdgeInsets(top: 0, left: Constants.MARGIN_10, bottom: -defaultBottomViewHeight, right: -Constants.MARGIN_10))
            _ = bottomView.anchor(scrollView.bottomAnchor, view.leftAnchor,view.bottomAnchor, view.rightAnchor,defaultPadding,.init(width: 0, height: defaultBottomViewHeight))
        }
        
        _ = contentView.anchor(scrollView.topAnchor,scrollView.leftAnchor,scrollView.bottomAnchor,scrollView.rightAnchor)
        _ = contentView.anchorWidth(equalTo: scrollView.widthAnchor)
        _  = contentView.anchorHeight(equalToConstrant: contentViewHeight)
        
        _ = lblRoomInfor.anchor(contentView.topAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_ROOM_INFOR_TITLE))
        _ = nameInputView.anchor(lblRoomInfor.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_NEW_INPUT_VIEW))
        _ = priceInputView.anchor(nameInputView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_NEW_INPUT_VIEW))
        _ = areaInputView.anchor(priceInputView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_NEW_INPUT_VIEW))
        _ = addressInputView.anchor(areaInputView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_NEW_INPUT_VIEW))
        
        //START For suggest address
        tableViewHeightConstaint = tableView.anchor(addressInputView.bottomAnchor, contentView.leftAnchor, nil, contentView.rightAnchor, .zero, CGSize(width: 0, height: 0.5))[3]
        contentView.bringSubview(toFront: tableView)
        
        //END
        
        _ = phoneInputView.anchor(addressInputView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_NEW_INPUT_VIEW))
        _ = maxMemberSelectView.anchor(phoneInputView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_MAX_MEMBER_SELECT))
        _ = genderView.anchor(maxMemberSelectView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: Constants.HEIGHT_VIEW_GENDER))
        _ = utilitiesView.anchor(genderView.bottomAnchor,contentView.leftAnchor,nil,contentView.rightAnchor,.zero,.init(width: 0, height: utilitiesViewHeight))
        
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
        phoneInputView.delegate = self
        maxMemberSelectView.delegate = self
        genderView.delegate = self
        //        utilitiesView.delegate = self
        descriptionsView.delegate = self
        btnSubmit.addTarget(self, action: #selector(onClickBtnBack(btnBack:)), for: .touchUpInside)
        //Data
        if cERoomVCType == CERoomVCType.edit{
            nameInputView.text = roomRequestModel.name
            priceInputView.text = roomRequestModel.price?.toString
            areaInputView.text = roomRequestModel.area?.toString
            addressInputView.text = roomRequestModel.address
            phoneInputView.text = roomRequestModel.phone
            maxMemberSelectView.text = roomRequestModel.maxGuest?.toString
            genderView.genderSelect = roomRequestModel.requiredGender == 1 ? GenderSelect.male : roomRequestModel.requiredGender == 2 ? GenderSelect.female : roomRequestModel.requiredGender == 3 ? GenderSelect.both : GenderSelect.none //0 equal none
            utilitiesView.utilities = roomRequestModel.utilities
            descriptionsView.text = roomRequestModel.description ?? ""
        }else{
            genderView.viewType = DetailViewType.cEForOwner
            utilitiesView.utilities = utilities
            descriptionsView.viewType = DetailViewType.cEForOwner
            
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
        print(keyboardFrame)
        print(scrollView.contentInset)
        print(scrollView.contentOffset)
        scrollView.contentInset.bottom = keyboardFrame.size.height
        print(scrollView.contentInset)
        print(scrollView.contentOffset)
    }
    @objc func keyboardWillHide(notification:Notification){
        scrollView.contentInset = .zero
    }
    
    
    //MARK: Handler for save button
    @objc  func onClickBtnBack(btnBack:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Delegate for subview
    func descriptionViewDelegate(descriptionView view: DescriptionView, textViewDidEndEditing textView: UITextView) {
        roomRequestModel.description = descriptionsView.text
        descriptionsView.tvContent.resignFirstResponder()
        descriptionsView.tvContent.endEditing(true)
    }
    
    func utilitiesViewDelegate(utilitiesView view: UtilitiesView, didSelectUtilityAt indexPath: IndexPath) {
        //        roomRequestModel.description = descriptionsView.text
        let vc = Utilities.vcFromStoryBoard(vcName: "popupVC", sbName:"Main")
        vc.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .popover
        let popup = nav.popoverPresentationController
        popup?.delegate = self
        present(nav, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func genderViewDelegate(genderView: GenderView, onChangeGenderSelect genderSelect: GenderSelect?) {
        guard let genderSelect = genderSelect else {
            return
        }
        roomRequestModel.requiredGender = genderSelect.rawValue
    }
    
    func maxMemberSelectViewDelegate(view maxMemberSelectView: MaxMemberSelectView, onClickBtnSub btnSub: UIButton) {
        guard let text = maxMemberSelectView.text,let maxMember = Int(text) else {
            return
        }
        roomRequestModel.maxGuest = maxMember
    }
    
    func maxMemberSelectViewDelegate(view maxMemberSelectView: MaxMemberSelectView, onClickBtnPlus btnPlus: UIButton) {
        guard let text = maxMemberSelectView.text,let maxMember = Int(text) else {
            return
        }
        roomRequestModel.maxGuest = maxMember
    }
    func newInputViewDelegate(newInputView view: NewInputView, shouldChangeCharactersTo string: String) {
        switch view {
        case nameInputView:
            guard let text = view.text else{
                return
            }
            roomRequestModel.name = text
        case priceInputView:
            guard let text = view.text, let float = Float(text) else{
                return
            }
            roomRequestModel.price = float
        case areaInputView:
            guard let text = view.text, let int = Int(text) else{
                return
            }
            roomRequestModel.area = int
        case addressInputView:
            search(text: string)
            guard let text = view.text else{
                return
            }
            roomRequestModel.address = text
            view.layoutIfNeeded()
        case phoneInputView:
            guard let text = view.text else{
                return
            }
            roomRequestModel.phone = text
        default:
            break
            
        }
    }
    
    //    func inputViewDelegate(inputView view: InputView, textFieldDidEndEditing textField: UITextField) {
    //
    //    }
    
    //    func inputViewDelegate(inputView view: InputView, textFieldShouldReturn textField: UITextField) -> Bool {
    //        switch view {
    //        case nameInputView:
    //            priceInputView.becomeFirstResponderTextField(returnKeyType: .next)
    //        case priceInputView:
    //            areaInputView.becomeFirstResponderTextField(returnKeyType: .next)
    //        case areaInputView:
    //            addressInputView.becomeFirstResponderTextField(returnKeyType: .next)
    //        case addressInputView:
    //            phoneInputView.becomeFirstResponderTextField(returnKeyType: .next)
    //        case phoneInputView:
    //            descriptionsView.becomeFirstResponderTextView()
    //        default:
    //            break
    //        }
    //        return false
    //    }
    //
    //    func inputViewDelegate(inputView view: InputView, textFieldShouldBeginEditing textField: UITextField) {
    //        if view == nameInputView{
    //            nameInputView.becomeFirstResponderTextField(returnKeyType: .next)
    //        }else if view == priceInputView{
    //            priceInputView.becomeFirstResponderTextField(returnKeyType: .next)
    //        }else if view == areaInputView{
    //            areaInputView.becomeFirstResponderTextField(returnKeyType: .next)
    //        }else if view == addressInputView{
    //            addressInputView.becomeFirstResponderTextField(returnKeyType: .next)
    //        }else if view == phoneInputView{
    //            phoneInputView.becomeFirstResponderTextField(returnKeyType: .next)
    //        }
    //    }
    
    
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
        placesClient.lookUpPlaceID((suggestAddress?[indexPath.row].placeID)!, callback: { (place, error) in
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
    
    //MARK: Custom method
    func search(text:String) {
        
        // Set bounds to inner viet nam.
        let neBoundsCorner = CLLocationCoordinate2D(latitude: 10.7792897,
                                                    longitude: 106.6635715)
        let swBoundsCorner = CLLocationCoordinate2D(latitude: 10.7792897,
                                                    longitude: 106.6635715)
        let bounds = GMSCoordinateBounds(coordinate: neBoundsCorner,
                                         coordinate: swBoundsCorner)

        let filter = GMSAutocompleteFilter()
        filter.type = .address
        filter.country = "VN"
//        getCoordinateBounds(latitude: 10.7792897, longitude: 106.6635715,distance:0)
        placesClient.autocompleteQuery(text, bounds: bounds , filter: filter, callback: {(results, error) -> Void in
            
            if let results = results , results.count>0{
                self.suggestAddress?.removeAll()
                results.forEach({ (result) in
                    print("Location:\(result.attributedFullText.string.lowercased().contains("quận 3"))")
                    if result.attributedFullText.string.lowercased().contains("quận 3"){
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
}
