//
//  BaseVC.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class BaseVC:UIViewController{
    var navTitle:String?{
        didSet{
            navigationController?.navigationBar.topItem?.title = navTitle
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditting))
        tap.cancelsTouchesInView = false
            
        view.addGestureRecognizer(tap)
    }
    @objc func endEditting(){
        view.endEditing(true)
    }
    
}
