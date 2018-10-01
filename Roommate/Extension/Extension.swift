//
//  Extension.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit

//MARK: Extension UIView
extension UIView{
    
    class func fromNib<T:UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as! T
    }
    
    //For localization
    func onUpdateLocale(){
        for subview in self.subviews {
            subview.onUpdateLocale()
        }
    }
    //Function to calculate height for label based on text
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    //For autolayout
    func anchorCenterXAndY(_ centerX:NSLayoutXAxisAnchor?,_ centerY:NSLayoutYAxisAnchor?,
                           _ widthConstant:CGFloat = 0,_ heightConstant:CGFloat = 0) -> [NSLayoutConstraint]{
        return anchor( centerX,  centerY,
                       nil,  nil,
                       nil,  nil,
                       nil, nil,
                       0,  0,
                       0,  0,
                       widthConstant,  heightConstant)
    }
    
    func anchorTopLeft(_ top:NSLayoutYAxisAnchor?,_ left:NSLayoutXAxisAnchor?,
                       _ topConstant:CGFloat = 0,_ leftConstant:CGFloat = 0,
                       _ widthConstant:CGFloat = 0,_ heightConstant:CGFloat = 0) -> [NSLayoutConstraint]{
        return anchor(nil , nil,
                      top,  left,
                      nil,  nil,
                      nil,nil,
                      topConstant,  leftConstant,
                      0,  0,
                      widthConstant,  heightConstant)
    }
    
    func anchorTopLeft(_ top:NSLayoutYAxisAnchor?,_ left:NSLayoutXAxisAnchor?,
                       _ widthConstant:CGFloat,_ heightConstant:CGFloat) -> [NSLayoutConstraint]{
        return anchor( nil ,  nil,
                       top,  left,
                       nil,  nil,
                       nil, nil,
                       0,  0,
                       0,  0,
                       widthConstant,  heightConstant)
    }
    
    func anchorTopLeft(_ top:NSLayoutYAxisAnchor?,_ left:NSLayoutXAxisAnchor?,
                       _ width:NSLayoutDimension,_ heightConstant:CGFloat) -> [NSLayoutConstraint]{
        return anchor( nil ,  nil,
                       top,  left,
                       nil,  nil,
                       width, nil,
                       0,  0,
                       0,  0,
                       0,  heightConstant)
    }
    
    func anchorTopLeft(_ top:NSLayoutYAxisAnchor?,_ left:NSLayoutXAxisAnchor?,
                       _ width:NSLayoutDimension?,_ height:NSLayoutDimension?) -> [NSLayoutConstraint]{
        return anchor( nil ,  nil,
                       top, left,
                       nil,nil,
                       width, height,
                       0, 0,
                       0, 0,
                       0, 0)
    }
    func anchorTopRight(_ top:NSLayoutYAxisAnchor?,_ right:NSLayoutXAxisAnchor?,
                        _ topConstant:CGFloat,_ rightConstant:CGFloat,
                        _ widthConstant:CGFloat,_ heightConstant:CGFloat) -> [NSLayoutConstraint]{
        return anchor( nil ,  nil,
                       top, nil,
                       nil,right,
                       nil, nil,
                       topConstant, 0,
                       0, rightConstant,
                       widthConstant, heightConstant)
    }
    
    func anchorTopRight(_ top:NSLayoutYAxisAnchor?,_ right:NSLayoutXAxisAnchor?,
                        _ widthConstant:CGFloat,_ heightConstant:CGFloat) -> [NSLayoutConstraint]{
        return anchor( nil ,  nil,
                       top, nil,
                       nil,right,
                       nil, nil,
                       0, 0,
                       0, 0,
                       widthConstant, heightConstant)
    }
    
    func anchorBottomRight(_ bottom:NSLayoutYAxisAnchor?,_ right:NSLayoutXAxisAnchor?,
                           _ bottomConstant:CGFloat = 0,_ rightConstant:CGFloat = 0,
                           _ widthConstant:CGFloat,_ heightConstant:CGFloat) -> [NSLayoutConstraint]{
        return anchor( nil ,  nil,
                       nil, nil,
                       bottom,right,
                       nil, nil,
                       0, 0,
                       bottomConstant, rightConstant,
                       widthConstant, heightConstant)
    }
    func anchorEntire(view:UIView) -> [NSLayoutConstraint]{
        return anchor( nil ,  nil,
                       view.topAnchor, view.leftAnchor,
                       view.bottomAnchor,view.rightAnchor,
                       nil, nil,
                       0, 0,
                       0, 0,
                       0, 0)
    }
    func anchorEntire(_ top:NSLayoutYAxisAnchor?,_ left:NSLayoutXAxisAnchor?,
                      _ bottom:NSLayoutYAxisAnchor?,_ right:NSLayoutXAxisAnchor?) -> [NSLayoutConstraint]{
        return anchor( nil ,  nil,
                       top, left,
                       bottom,right,
                       nil, nil,
                       0, 0,
                       0, 0,
                       0, 0)
    }
    func anchorEntire(_ centerX:NSLayoutXAxisAnchor?,_ centerY:NSLayoutYAxisAnchor?,
                      _ top:NSLayoutYAxisAnchor?,_ left:NSLayoutXAxisAnchor?,
                      _ bottom:NSLayoutYAxisAnchor?,_ right:NSLayoutXAxisAnchor?) -> [NSLayoutConstraint]{
        return anchor( centerX ,centerY,
                       top, left,
                       bottom,right,
                       nil, nil,
                       0, 0,
                       0, 0,
                       0, 0)
    }
    
    func anchor(_ centerX:NSLayoutXAxisAnchor?,_ centerY:NSLayoutYAxisAnchor?,
                _ top:NSLayoutYAxisAnchor?,_ left:NSLayoutXAxisAnchor?,
                _ bottom:NSLayoutYAxisAnchor?,_ right:NSLayoutXAxisAnchor?,
                _ width:NSLayoutDimension?,_ height:NSLayoutDimension?,
                _ topConstant:CGFloat = 0,_ leftConstant:CGFloat = 0,
                _ bottomConstant:CGFloat = 0,_ rightConstant:CGFloat = 0,
                _ widthConstant:CGFloat = 0,_ heightConstant:CGFloat = 0) -> [NSLayoutConstraint] {
        
        var anchor = [NSLayoutConstraint]()
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX{
            anchor.append(centerXAnchor.constraint(equalTo: centerX))
        }
        
        if let centerY = centerY{
            anchor.append(centerYAnchor.constraint(equalTo: centerY))
        }
        
        if let top = top{
            anchor.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left{
            anchor.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom{
            anchor.append(bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant))
        }
        
        if let right = right{
            anchor.append(rightAnchor.constraint(equalTo: right, constant: rightConstant))
        }
        
        if let width = width{
            anchor.append(widthAnchor.constraint(equalTo: width))
        }
        
        if let height = height{
            anchor.append(heightAnchor.constraint(equalTo: height))
        }
        
        if widthConstant>0{
            anchor.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant>0{
            anchor.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchor.forEach({$0.isActive=true})
        
        return anchor
    }
    
}

//MARK: Extension UIViewController
//Extension for add and remove childViewController from parent controller
extension UIViewController{
    
    //Ex : parentVC.add(childVC)
    func add(_ child:UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        didMove(toParentViewController: self)
    }
    
    func add(_ child:UIView) {
        view.addSubview(view)
    }
    //Ex : childVC.remove()
    func remove() {
        guard let _ = parent else {
            return
        }
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
        
    }
}

//MARK: Extension String
extension String{
    //Ex : "KEY_IN_LOCALE_STRING_FILE".localized
    var localized:String{
        let currentLocale = LocalizationPreferences.shared.currentLocale()
        guard let bundlePath = Bundle.main.path(forResource: currentLocale, ofType: ".lproj"),
            let bundle = Bundle(path: bundlePath) else {
                return self
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
//MARK: Extension Date
extension Date{
    func string(_ format:String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
}

//MARK: Extension Color
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    static let lightSubTitle:UIColor!  = UIColor(hexString: "555")
    static let normalTitle:UIColor!  = UIColor(hexString: "000")
    static let defaultBlue:UIColor!  = UIColor(hexString: "00A8B5")
}

extension CGFloat{
    static let verySmall:CGFloat = UIScreen.main.bounds.width > 768 ? 11 : 9
    static let  small:CGFloat  = UIScreen.main.bounds.width > 768 ? 13 : 11
    static let medium:CGFloat  = UIScreen.main.bounds.width > 768 ? 16 : 14
    static let large:CGFloat  = UIScreen.main.bounds.width > 768 ? 25 : 23
    static let extraLarge:CGFloat  = 28
    static let subtitle:CGFloat  = UIScreen.main.bounds.width > 768 ? 15 : 13
}
