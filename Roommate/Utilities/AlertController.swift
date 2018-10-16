//
//  AlertViewController.swift
//  Roommate
//
//  Created by TrinhHC on 9/30/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit
protocol AlertControllerDelegate {
    func selectValue(ofController:UIAlertController,withValue value:String?,atIndex index:Int?)
}
class AlertController: UIAlertController,UITableViewDataSource,UITableViewDelegate  {
    var delegate:AlertControllerDelegate?
    private var listItem:[String]?
    var tableView = UITableView()
    static func showAlertInfor(withTitle title:String?,forMessage message:String?,inViewController controller:UIViewController) {
        let alertController = AlertController(title: title, message: message, preferredStyle: .alert)
        if let _ = title {
            alertController.addAction(UIAlertAction(title: "OK".localized, style: .cancel, handler: {(action) in
                alertController.dismiss(animated: true, completion: nil)
            }))
        }
        controller.present(alertController, animated: true, completion: nil)
//        showAlertConfirm(withTitle: title, andMessage: message, alertStyle: .alert, forViewController: controller, lhsButtonTitle: "OK".localized, rhsButtonTitle: nil, lhsButtonHandler: nil, rhsButtonHandler: nil)
    }
    
    static func showAlertConfirm(withTitle title:String?,andMessage message:String?,alertStyle:UIAlertControllerStyle,forViewController controller:UIViewController,lhsButtonTitle:String?,rhsButtonTitle:String?,lhsButtonHandler:((UIAlertAction)->Void)?,rhsButtonHandler:((UIAlertAction)->Void)?){
        let alertController = AlertController(title: title, message: message, preferredStyle: alertStyle)
        if let _ = lhsButtonTitle {
            alertController.addAction(UIAlertAction(title: lhsButtonTitle, style: .cancel, handler: lhsButtonHandler))
        }
        if let _ = rhsButtonTitle {
            alertController.addAction(UIAlertAction(title: rhsButtonTitle, style: .default, handler: rhsButtonHandler))
        }
        controller.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlertList(withTitle title:String?,andMessage message:String?,alertStyle:UIAlertControllerStyle,forViewController controller:UIViewController,data:[String]?,lhsButtonTitle:String?,rhsButtonTitle:String?,lhsButtonHandler:((UIAlertAction)->Void)?,rhsButtonHandler:((UIAlertAction)->Void)?)->AlertController{
        let alertController = AlertController(title: title, message: message, preferredStyle: alertStyle)
        
        if let _ = lhsButtonTitle {
            alertController.addAction(UIAlertAction(title: lhsButtonTitle, style: .default, handler: lhsButtonHandler))
        }
        if let _ = rhsButtonTitle {
            alertController.addAction(UIAlertAction(title: rhsButtonTitle, style: .default, handler: rhsButtonHandler))
        }
        
        alertController.addTableView(withCellIdentifier: Constants.CELL_POPUP_SELECT_LISTTV)
        controller.present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    static func showAlertInputUtility(withTitle title:String?,andMessage message:String?,alertStyle:UIAlertControllerStyle,forViewController controller:UIViewController,lhsButtonTitle:String?,rhsButtonTitle:String?,lhsButtonHandler:((UIAlertAction)->Void)?,rhsButtonHandler:((UIAlertAction)->Void)?){
        let alertController = AlertController(title: title, message: message, preferredStyle: alertStyle)
        
        if let _ = lhsButtonTitle {
            alertController.addAction(UIAlertAction(title: lhsButtonTitle, style: .default, handler: lhsButtonHandler))
        }
        if let _ = rhsButtonTitle {
            alertController.addAction(UIAlertAction(title: rhsButtonTitle, style: .default, handler: rhsButtonHandler))
        }
        
        let vc = Utilities.vcFromStoryBoard(vcName: Constants.VC_UTILITY_INPUT, sbName: Constants.STORYBOARD_MAIN)
        vc.view.backgroundColor = .red
//        vc.view.frame = alertController.view.frame
//
//        //Size of content in popup viewcontroller
        vc.preferredContentSize  = CGSize(width: 242,
                                          height:  200)
        
//        customView.isUserInteractionEnabled = true
        vc.view.isUserInteractionEnabled = true
        alertController.setValue(vc, forKey: "contentViewController")
        controller.present(alertController, animated: true, completion: nil)
        
    }
    
    func addTableView(withCellIdentifier cellIdentifier:String) {
        //Initial height
        let tableHeight = 50.0 * Double(self.listItem!.count)
        
        //Create View Controller and TableView
        let vc = UIViewController()
        
        //Size of content in popup viewcontroller
        vc.preferredContentSize  = CGSize(width: Constants.POPUP_SELECT_TABLE_DEFATUL_WIDTH,
                                          height:  Constants.POPUP_SELECT_TABLE_MAX_HEIGHT)
        tableView.register(UINib.init(nibName: Constants.CELL_POPUP_SELECT_LISTTV, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.frame = vc.view.frame
        tableView.dataSource = self
        tableView.delegate = self
        vc.view.addSubview(tableView)
        vc.view.bringSubview(toFront: tableView)
        
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = true
        vc.view.isUserInteractionEnabled = true
        self.setValue(vc, forKey: "contentViewController")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItem?.count != nil ? self.listItem!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_POPUP_SELECT_LISTTV) as! PopupSelectListTVCell
        cell.lblTitle.text = self.listItem![indexPath.row]
        print(self.listItem![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectValue(ofController: self, withValue: self.listItem?[indexPath.row], atIndex: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
