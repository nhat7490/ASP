//
//  UtilityInputVC.swift
//  Roommate
//
//  Created by TrinhHC on 10/16/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
protocol UtilityInputVCDelegate:class{
    func utilityInputVCDelegate(onCompletedInputUtility utility:UtilityModel)
}
class UtilityInputVC: BaseVC ,UITextFieldDelegate,UITextViewDelegate{
    @IBOutlet weak var tfBrand: SkyFloatingLabelTextField!
    @IBOutlet weak var tfQuantity: SkyFloatingLabelTextField!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    var utilityModel = UtilityModel()
    
    var delegate:UtilityInputVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        lblTitle.text = utilityModel.name
        lblDescription.text = "DESCRIPTION".localized
        setupTFUI(tfBrand,placeholder: "BRAND_PLACE_HOLDER", title: "BRAND_PLACE_HOLDER")
        setupTFUI(tfQuantity,placeholder: "QUANTITY_PLACE_HOLDER", title: "QUANTITY_PLACE_HOLDER",keyboardType:UIKeyboardType.numberPad)
        tfQuantity.text =  0.toString
        tvDescription.text = "DESCRIPTION_PLACE_HOLDER".localized
        tvDescription.textColor = .lightGray
        tvDescription.addToobarButton()
        tvDescription.delegate = self
        tfBrand.delegate = self
        tfQuantity.delegate = self
        tvDescription.delegate = self
        btnLeft.setTitle("CANCEL".localized, for: .normal)
        btnRight.setTitle("OK".localized, for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupTFUI(_ tfInput:SkyFloatingLabelTextField,placeholder:String,title:String,keyboardType:UIKeyboardType? = .default,returnKeyType:UIReturnKeyType? = .done){
        //        tfInput.isSecureTextEntry = true
        tfInput.returnKeyType = returnKeyType!
        tfInput.placeholder = placeholder.localized
        tfInput.placeholderColor = .lightGray
        tfInput.titleColor = .defaultBlue
        tfInput.keyboardType = keyboardType!
        tfInput.title = title.localized
        tfInput.errorColor = .red
        tfInput.selectedLineColor = .defaultBlue
        tfInput.selectedTitleColor = .defaultBlue//Title color
        tfInput.delegate = self
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string){
            if textField == tfBrand{
                if updatedString.count > Constants.MAX_LENGHT_NORMAL_TEXT{
                    return false
                }
                if updatedString.isValidBrand(){
                    tfBrand.errorMessage = ""
                    utilityModel.brand = updatedString
                }else{
                    tfBrand.errorMessage = "ERROR_TYPE_BRAND".localized
                }
            }else{
                if updatedString.count > Constants.MAX_LENGHT_NORMAL_TEXT{
                    return false
                }
                if updatedString.isValidQuantity(){
                    tfQuantity.errorMessage = ""
                    utilityModel.brand = updatedString
                }else{
                    tfQuantity.errorMessage = "ERROR_TYPE_QUANTITY".localized
                }
            }
        }
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let updatedString = (textView.text as NSString?)?.replacingCharacters(in: range, with: text){
            if updatedString.count > Constants.MAX_LENGHT_DESCRIPTION{
                return false
            }
            utilityModel.utilityDescription = updatedString
        }
        return true
    }
    
    @IBAction func onclickBtnLeft(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onclickBtnRight(_ sender: Any) {
        self.delegate?.utilityInputVCDelegate(onCompletedInputUtility: utilityModel)
        self.dismiss(animated: true, completion: nil)
    }
}
