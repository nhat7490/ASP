//
//  NewInputView.swift
//  Roommate
//
//  Created by TrinhHC on 10/11/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
protocol NewInputViewDelegate:class {
    func newInputViewDelegate(newInputView view:NewInputView,shouldChangeCharactersTo string:String)
}
class NewInputView: UIView,UITextFieldDelegate {
    @IBOutlet weak var tfInput: SkyFloatingLabelTextField!
    weak var delegate:InputViewDelegate?
    
//    var text:String?{
//        get{
//            return self.tfInput.text
//        }
//        set{
//            self.tfInput.text = newValue
//        }
//    }
    var inputViewType:InputViewType?{
        didSet{
            switch self.inputViewType! {
            case .name:
                setupUI(placeholder: "ROOM_NAME_TITLE", title: "ROOM_NAME_TITLE")
//                initData(title: "ROOM_NAME_TITLE", placeHolder: "MAX_CHAR_50")
            case .price:
                tfInput.addToobarButton()
                setupUI(placeholder: "PRICE", title: "PRICE", keyboardType: .numberPad)
//                initData(title: "PRICE", placeHolder: "PLACE_HOLDER_PRICE")
            case .area:
                tfInput.addToobarButton()
                setupUI(placeholder: "ROOM_AREA_TITLE", title: "ROOM_AREA_TITLE", keyboardType: .numberPad)
//                initData(title: "ROOM_AREA_TITLE", placeHolder: "PLACE_HOLDER_AREA")
            case .address:
                setupUI(placeholder: "ROOM_ADDRESS_TITLE", title: "ROOM_ADDRESS_TITLE")
//                initData(title: "ROOM_ADDRESS_TITLE", placeHolder: "PLACE_HOLDER_ADDRESS")
            case .phone:
                tfInput.addToobarButton()
                setupUI(placeholder: "ROOM_PHONE_TITLE", title: "ROOM_PHONE_TITLE", keyboardType: .numberPad)
//                initData(title: "ROOM_PHONE_TITLE", placeHolder: "PLACE_HOLDER_PHONE")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tfInput.delegate = self
        tfInput.returnKeyType = .next
    }
    func initData(title:String,placeHolder:String){
//        lblTitle.text = title.localized
        tfInput.attributedPlaceholder = NSAttributedString(string: placeHolder.localized, attributes: [NSAttributedStringKey.foregroundColor:UIColor.lightSubTitle])
    }
    
    //MARK:UITextfieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let updatedString = (tfInput.text as NSString?)?.replacingCharacters(in: range, with: string){
            switch self.inputViewType! {
        
            case .name:
                if updatedString.count > Constants.MAX_LENGHT_NORMAL_TEXT{
                    tfInput.text = string
                    return false
                }
                if updatedString.isValidUsername(){
                    tfInput.errorMessage = ""
                }else{
                    tfInput.errorMessage = "ERROR_TYPE_USERNAME".localized
                }
            case .price:
                if updatedString.count > Constants.MAX_LENGHT_NORMAL_TEXT{
                    tfInput.text = string
                    return false
                }
                if updatedString.isValidUsername(){
                    tfInput.errorMessage = ""
                }else{
                    tfInput.errorMessage = "ERROR_TYPE_USERNAME".localized
                }
            case .area:
                if updatedString.count > Constants.MAX_LENGHT_NORMAL_TEXT{
                    tfInput.text = string
                    return false
                }
                if updatedString.isValidUsername(){
                    tfInput.errorMessage = ""
                }else{
                    tfInput.errorMessage = "ERROR_TYPE_USERNAME".localized
                }
            case .address:
                if updatedString.count > Constants.MAX_LENGHT_ADDRESS{
                    tfInput.text = string
                    return false
                }
                if updatedString.isValidUsername(){
                    tfInput.errorMessage = ""
                }else{
                    tfInput.errorMessage = "ERROR_TYPE_USERNAME".localized
                }
            case .phone:
                if updatedString.count > Constants.MAX_LENGHT_NORMAL_TEXT{
                    tfInput.text = string
                    return false
                }
                if updatedString.isValidUsername(){
                    tfInput.errorMessage = ""
                }else{
                    tfInput.errorMessage = "ERROR_TYPE_USERNAME".localized
                }
            }
        }
        return true
    }

    func setupUI(placeholder:String,title:String,keyboardType:UIKeyboardType? = .default,returnKeyType:UIReturnKeyType? = .done){
        tfInput.isSecureTextEntry = true
        tfInput.returnKeyType = returnKeyType!
        tfInput.placeholder = placeholder.localized
        tfInput.placeholderColor = .lightGray
        tfInput.keyboardType = keyboardType!
        tfInput.title = title.localized
        tfInput.errorColor = .red
        tfInput.selectedLineColor = .defaultBlue
        tfInput.selectedTitleColor = .defaultBlue//Title color
        tfInput.delegate = self
    }
    
    //MARK: Another
    func becomeFirstResponderTextField(returnKeyType:UIReturnKeyType){
        tfInput.returnKeyType = returnKeyType
        tfInput.becomeFirstResponder()
    }
    func resignFirstResponderTextField(){
        tfInput.resignFirstResponder()
    }
}
