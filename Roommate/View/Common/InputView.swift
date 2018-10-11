//
//  InputView.swift
//  Roommate
//
//  Created by TrinhHC on 10/6/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
enum InputViewType{
    case name,price,area,address,phone
}
protocol InputViewDelegate:class {
    func inputViewDelegate(inputView view:InputView,textFieldDidEndEditing textField:UITextField)
    func inputViewDelegate(inputView view:InputView,textFieldShouldReturn textField:UITextField) -> Bool
    func inputViewDelegate(inputView view:InputView,textFieldShouldBeginEditing textField:UITextField)
}

class InputView: UIView,UITextFieldDelegate{

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    
    weak var delegate:InputViewDelegate?
    
    var text:String?{
        get{
            return self.tfInput.text
        }
        set{
           self.tfInput.text = newValue
        }
    }
    var inputViewType:InputViewType?{
        didSet{
            switch self.inputViewType! {
            case .name:
                self.tfInput.keyboardType = .default
                initData(title: "ROOM_NAME_TITLE", placeHolder: "MAX_CHAR_50")
            case .price:
                self.tfInput.keyboardType = .numberPad
                tfInput.addToobarButton()
                initData(title: "PRICE", placeHolder: "PLACE_HOLDER_PRICE")
            case .area:
                self.tfInput.keyboardType = .numberPad
                tfInput.addToobarButton()
                initData(title: "ROOM_AREA_TITLE", placeHolder: "PLACE_HOLDER_AREA")
            case .address:
                self.tfInput.keyboardType = .default
                initData(title: "ROOM_ADDRESS_TITLE", placeHolder: "PLACE_HOLDER_ADDRESS")
            case .phone:
                self.tfInput.keyboardType = .numberPad
                tfInput.addToobarButton()
                initData(title: "ROOM_PHONE_TITLE", placeHolder: "PLACE_HOLDER_PHONE")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = .smallTitle
        tfInput.delegate = self
        tfInput.returnKeyType = .next
    }
    func initData(title:String,placeHolder:String){
        lblTitle.text = title.localized
        tfInput.attributedPlaceholder = NSAttributedString(string: placeHolder.localized, attributes: [NSAttributedStringKey.foregroundColor:UIColor.lightSubTitle])
    }
    
    //MARK:UITextfieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.inputViewDelegate(inputView: self, textFieldDidEndEditing: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let delegate = delegate else {
            return true
        }
        return delegate.inputViewDelegate(inputView: self, textFieldShouldReturn: textField)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.inputViewDelegate(inputView: self, textFieldShouldBeginEditing: tfInput)
        return true
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
