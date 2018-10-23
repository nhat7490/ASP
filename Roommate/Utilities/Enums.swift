//
//  Enums.swift
//  Roommate
//
//  Created by TrinhHC on 9/22/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import Foundation
import UIKit
enum CellSide :Int{
    case left,right
}
enum CollectionDisplayDataType :Int{
    case Room,Roommate
}
//
//enum RoomDetailForType{
//    case owner,member
//}

enum OrderType:Int{
    case newest=0,lowToHightPrice,hightToLowPrice
}

enum UtilityForSC{
    case showDetail,filter,edit,create
}

enum GenderSelect:Int{
    case none=0,male,female,both
}

enum SliderViewType{
    case price,area
}

enum BorderSide {
    case Top, Bottom, Left, Right
}

enum SystemAppType {
    case phone, message, email
}
enum ViewType{
    case detailForMaster,detailForMember,cEForOwner,detailForFinder
}
enum DropdownListViewType{
    case city,district
}

enum UtilityCVCellType{
    case detail,interact
}
enum CERoomVCType{
    case create,edit
}
enum AllVCType{
    case all,bookmark,search
}
enum FilterVCType{
    case room,roommate
}

enum HTTPStatusCode: Int {
    // 100 Informational
    case Continue = 100
    case SwitchingProtocols
    case Processing
    // 200 Success
    case OK = 200
    case Created
    case Accepted
    case NonAuthoritativeInformation
    case NoContent
    case ResetContent
    case PartialContent
    case MultiStatus
    case AlreadyReported
    case IMUsed = 226
    // 300 Redirection
    case MultipleChoices = 300
    case MovedPermanently
    case Found
    case SeeOther
    case NotModified
    case UseProxy
    case SwitchProxy
    case TemporaryRedirect
    case PermanentRedirect
    // 400 Client Error
    case BadRequest = 400
    case Unauthorized
    case PaymentRequired
    case Forbidden
    case NotFound
    case MethodNotAllowed
    case NotAcceptable
    case ProxyAuthenticationRequired
    case RequestTimeout
    case Conflict
    case Gone
    case LengthRequired
    case PreconditionFailed
    case PayloadTooLarge
    case URITooLong
    case UnsupportedMediaType
    case RangeNotSatisfiable
    case ExpectationFailed
    case ImATeapot
    case MisdirectedRequest = 421
    case UnprocessableEntity
    case Locked
    case FailedDependency
    case UpgradeRequired = 426
    case PreconditionRequired = 428
    case TooManyRequests
    case RequestHeaderFieldsTooLarge = 431
    case UnavailableForLegalReasons = 451
    // 500 Server Error
    case InternalServerError = 500
    case NotImplemented
    case BadGateway
    case ServiceUnavailable
    case GatewayTimeout
    case HTTPVersionNotSupported
    case VariantAlsoNegotiates
    case InsufficientStorage
    case LoopDetected
    case NotExtended = 510
    case NetworkAuthenticationRequired
}
enum APIResponseAlertType{
    case invalidPassword,invalidUsername,internalServerError
}
enum AlertType{
    case normal,city,district
}

enum VerticalPostViewType{
    case room,roommate
}
