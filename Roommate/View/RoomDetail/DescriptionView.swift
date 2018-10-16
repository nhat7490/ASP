//
//  DescriptionView.swift
//  Roommate
//
//  Created by TrinhHC on 10/1/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
protocol DescriptionViewDelegate:class{
    func descriptionViewDelegate(descriptionView view:DescriptionView,textViewDidEndEditing textView:UITextView )

}
class DescriptionView: UIView,UITextViewDelegate{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    weak var delegate:DescriptionViewDelegate?
    
    var text:String?{
        get{
            return self.tvContent.text
        }
        set{
            self.tvContent.text = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var viewType:ViewType?{
        didSet{
            if  viewType == ViewType.detailForMember || viewType == ViewType.detailForOwner{
                tvContent.isEditable = false
            }else{
                tvContent.addToobarButton()
                tvContent.isEditable = true
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = .smallTitle
        tvContent.font = .small
        tvContent.layer.borderWidth = 0.5
        tvContent.layer.borderColor = UIColor.lightGray.cgColor
        tvContent.layer.cornerRadius = 5
        tvContent.isEditable = false
        tvContent.delegate = self
        tvContent.returnKeyType = .done
        
        lblTitle.text = "DESCRIPTION".localized
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.descriptionViewDelegate(descriptionView: self, textViewDidEndEditing: textView)
    }
    //MARK: Another
    func becomeFirstResponderTextView(){
        tvContent.addToobarButton()
        tvContent.becomeFirstResponder()
    }
    
}
