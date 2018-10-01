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
    private var data:[String]?
    static func showAlert(withTitle title:String?,forMessage message:String?,inViewController controller:UIViewController) {
        let alert = AlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        controller.present(alert, animated: true, completion: nil)
    }
    static func showAlertList(withTitle title:String?,andMessage message:String?,alertStyle:UIAlertControllerStyle,forViewController controller:UIViewController,data:[String]?,lhsButtonTitle:String?,rhsButtonTitle:String?,lhsButtonHandler:((UIAlertAction)->Void)?,rhsButtonHandler:((UIAlertAction)->Void)?){
        let alertController = AlertController(title: title, message: message, preferredStyle: alertStyle)
        
        if let _ = lhsButtonTitle {
            alertController.addAction(UIAlertAction(title: lhsButtonTitle, style: .default, handler: lhsButtonHandler))
        }
        if let _ = rhsButtonTitle {
            alertController.addAction(UIAlertAction(title: rhsButtonTitle, style: .default, handler: rhsButtonHandler))
        }
        //Initial default Data
        alertController.data = data
        alertController.delegate = controller as? AlertControllerDelegate
        let cellIdentifier = "popupSelectListCell"
        //Create View Controller and TableView
        let vc = UIViewController()
        vc.preferredContentSize  = CGSize(width: 272.0, height: 400)
        //        vc.view.backgroundColor = UIColor.red
        
        let tableView = UITableView()
        tableView.register(UINib.init(nibName: "PopupSelectListCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.frame = vc.view.frame
        tableView.dataSource = alertController
        tableView.delegate = alertController
        vc.view.addSubview(tableView)
        vc.view.bringSubview(toFront: tableView)
        
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = true
        
        vc.view.isUserInteractionEnabled = true
        
        
        alertController.setValue(vc, forKey: "contentViewController")
        
        controller.present(alertController, animated: true, completion: nil)
        
    }
    static func showAlertWithCustomView(withTitle title:String?,andMessage message:String?,alertStyle:UIAlertControllerStyle,forViewController controller:UIViewController,customView:UIView,lhsButtonTitle:String?,rhsButtonTitle:String?,lhsButtonHandler:((UIAlertAction)->Void)?,rhsButtonHandler:((UIAlertAction)->Void)?){
        let alertController = AlertController(title: title, message: message, preferredStyle: alertStyle)
        
        if let _ = lhsButtonTitle {
            alertController.addAction(UIAlertAction(title: lhsButtonTitle, style: .default, handler: lhsButtonHandler))
        }
        if let _ = rhsButtonTitle {
            alertController.addAction(UIAlertAction(title: rhsButtonTitle, style: .default, handler: rhsButtonHandler))
        }
       
        customView.frame = CGRect(x:0,y:0,width: 272.0, height: 400.0)
        alertController.view.addSubview(customView)
        alertController.view.bringSubview(toFront: customView)
        alertController.modalPresentationStyle = .overCurrentContext
        alertController.modalTransitionStyle = .crossDissolve
        controller.present(alertController, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.count != nil ? self.data!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popupSelectListCell") as! PopupSelectListCell
        cell.label.text = self.data![indexPath.row]
        print(self.data![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectValue(ofController: self, withValue: self.data?[indexPath.row], atIndex: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
