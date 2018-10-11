//
//  Constants.swift
//  Roommate
//
//  Created by TrinhHC on 9/20/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
class Constants{
    //MARK: Base URL
    static let BASE_URL = "http://localhost:8080/"
    //    static let BASE_URL = "https://asp-backend.herokuapp.com/"
    
    //MARK: Constant for Storyboard name
    static let STORYBOARD_MAIN = "Main"
    static let STORYBOARD_HOME = "Home"
    static let STORYBOARD_ALL = "All"
    static let STORYBOARD_NOTIFICATION = "Notification"
    static let STORYBOARD_BOOKMARK = "Bookmark"
    static let STORYBOARD_ACCOUNT = "Account"
    
    //MARK: Constant for VC name
    static let VC_MAIN = "MainVC"
    static let VC_HOME = "HomeVC"
    static let VC_ALL = "AllVC"
    static let VC_NOTIFICATION = "NotificationVC"
    static let VC_BOOKMARK = "BookmarkVC"
    static let VC_ACCOUNT = "AccountVC"
    static let VC_SIGN_IN = "SignInVC"
    static let VC_SIGN_UP = "SignUpVC"
    static let VC_RESET_PASSWORD = "ResetPasswordVC"
    static let VC_FIRST_LAUNCH = "FirstLaunchVC"
    
    //MARK: Constant for Locale
    static let LOCALE_EN = "EN"
    static let LOCALE_VI = "VI"
    
    
    //MARK: Constant for UICollectionViewCell
    static let CELL_NOTIFICATIONCV = "NotificationCVCell"
    static let CELL_ROOMMATECV = "RoommateCVCell"
    static let CELL_ROOMCV = "RoomCVCell"
    static let CELL_ORDERTV = "OrderTVCell"
    static let CELL_NEWUTILITYCV = "NewUtilityCVCell"
    static let CELL_UTILITYCV = "UtilityCVCell"
    static let CELL_IMAGECV = "ImageCVCell"
    
    //MARK: Constant for UITableViewCell
    static let CELL_POPUP_SELECT_LISTTV = "PopupSelectListTVCell"
    static let CELL_MEMBERTVL = "MemberTVCell"
    
    //MARK: Constant for DateFormatter
    static let DD_MM_YY_HH_MM_A = "dd-MM-yyyy HH:mm a"
    
    
    
    //MARK: Constant for Font color
    static let COLOR_SUB_TITLE = "555"
    static let COLOR_MAIN_TITLE = "000"
    static let COLOR_SUB_TITLE_DEFAULT = "00A8B5"
    
    static let MARGIN_5:CGFloat = 5
    static let MARGIN_6:CGFloat = 6
    static let MARGIN_12:CGFloat = 12
    static let MARGIN_10:CGFloat = 10
    
    
    //MARK: Constant for customView and cell
    static let HEIGHT_VIEW_MAX_MEMBER_SELECT:Double = 50.0
    static let HEIGHT_VIEW_GENDER:Double = 50.0
    static let HEIGHT_CELL_MEMBERTV:Double = 50.0
    static let HEIGHT_VIEW_MEMBERS:Double = 200.0
    static let HEIGHT_VIEW_DESCRIPTION:Double = 180.0
    static let HEIGHT_VIEW_BASE_INFORMATION:Double = 180.0
    static let HEIGHT_CELL_IMAGECV:Double = 200.0
    static let HEIGHT_VIEW_HORIZONTAL_IMAGES:Double = 150.0
    static let HEIGHT_VIEW_OPTION:Double = 70.0
    static let HEIGHT_VIEW_DROPDOWN_LIST:Double = 81.0
    static let HEIGHT_VIEW_SLIDER:Double = 90.0
    static let HEIGHT_SPACE:Double = 20.0
    
    //MARK: AlertViewVC
    static let POPUP_SELECT_TABLE_MAX_HEIGHT:Double = 400
    static let POPUP_SELECT_TABLE_DEFATUL_WIDTH:Double = 272.0
    
    //CERoomVC
    static let HEIGHT_UTILITY_INPUT_VIEW:Double = 160.0
    static let HEIGHT_UTILITY_DETAIL_VIEW:Double = 160.0
    static let HEIGHT_INPUT_VIEW:Double = 81.0
    static let HEIGHT_CELL_NEW_UTILITY:Double = 40.0
    static let HEIGHT_ROOM_INFOR_TITLE:Double = 30.0
    static let MAX_MEMBER:Int = 10
    static let MIN_MEMBER:Int = 0
    static let MAX_PRICE:Int = 50_000_000
    static let MIN_PRICE:Int = 100_000
    static let MAX_AREA:Int = 1_000
    static let MIN_AREA:Int = 10
    static let MAX_LENGHT_ADDRESS:Int = 250
    static let MAX_LENGHT_NORMAL_TEXT:Int = 50
    
    //Status code

    
    
    
}
