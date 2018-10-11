//
//  APIResponseAlert.swift
//  Roommate
//
//  Created by TrinhHC on 10/10/18.
//  Copyright © 2018 TrinhHC. All rights reserved.
//

import UIKit

class APIResponseAlert {
    static func defaultAPIResponseError(controller:BaseVC,error:ApiResponseErrorType){
        var message:String?
        switch error {
        case .HTTP_ERROR:
            message = "NETWORK_STATUS_CONNECTED_ERROR_MESSAGE"
        case .API_ERROR:
            message = "NETWORK_STATUS_ERROR_MESSAGE"
        case .SERVER_NOT_RESPONSE:
            message = "NETWORK_STATUS_CONNECTED_SERVER_MESSAGE"
        case .PARSE_RESPONSE_FAIL:
            message = ""
        }
        AlertController.showAlertInfor(withTitle: "NETWORK_STATUS_TITLE".localized, forMessage: message?.localized, inViewController: controller)
    }
    static func apiResponseError(controller:BaseVC,type:APIResponseAlertType){
        var message:String?
        switch type {
        case .invalidUsername:
            message = "ALERT_INVALID_USERNAME_MESSAGE"
        case .invalidPassword:
             message = "ALERT_INVALID_PASSWORD_MESSAGE"
        case .internalServerError:
             message = "ALERT_INTERNAL_SERVER_ERROR"
        }
        AlertController.showAlertInfor(withTitle: "NETWORK_STATUS_TITLE".localized, forMessage: message?.localized, inViewController: controller)
    }
}
