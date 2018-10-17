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
    func utilityInputVCDelegate(onCompletedInputUtility utility:UtilityModel,atIndexPath indexPath:IndexPath?)
    func utilityInputVCDelegate(onDeletedInputUtility utility:UtilityModel,atIndexPath indexPath:IndexPath?)
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
    var indexPath:IndexPath?
    var delegate:UtilityInputVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .clear
        lblTitle.textAlignment = .center
        lblTitle.text = utilityModel.name
        lblDescription.text = "DESCRIPTION".localized
        setupTFUI(tfBrand,placeholder: "BRAND_PLACE_HOLDER", title: "BRAND_PLACE_HOLDER")
        setupTFUI(tfQuantity,placeholder: "QUANTITY_PLACE_HOLDER", title: "QUANTITY_PLACE_HOLDER",keyboardType:UIKeyboardType.numberPad)

        tvDescription.textColor = .black
        tvDescription.addToobarButton()
        tvDescription.layer.borderWidth = 1
        tvDescription.layer.borderColor = UIColor.lightGray.cgColor
        tvDescription.delegate = self
        tfBrand.delegate = self
        tfQuantity.delegate = self
        btnLeft.setTitle("CANCEL".localized, for: .normal)
        btnRight.setTitle("OK".localized, for: .normal)
        
        
        tfBrand.text = utilityModel.brand
        tfQuantity.text =  utilityModel.quantity.toString
        tvDescription.text = utilityModel.utilityDescription
        
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
                    utilityModel.quantity = updatedString.toInt()!
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
                textView.text = text
                return false
            }
            utilityModel.utilityDescription = updatedString
        }
        return true
//        let currentText = textView.text ?? ""
//        guard let stringRange = Range(range, in: currentText) else { return false }
//
//        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
//        if changedText.count > Constants.MAX_LENGHT_DESCRIPTION{
//            return false
//        }
//        utilityModel.utilityDescription = changedText
//        return true
    }
    
    @IBAction func onclickBtnLeft(_ sender: Any) {
        self.delegate?.utilityInputVCDelegate(onDeletedInputUtility: utilityModel,atIndexPath:indexPath)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onclickBtnRight(_ sender: Any) {
        self.delegate?.utilityInputVCDelegate(onCompletedInputUtility: utilityModel,atIndexPath:indexPath)
        self.dismiss(animated: true, completion: nil)
    }
}
